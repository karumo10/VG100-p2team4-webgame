module Rules exposing (..)

import Dict exposing (Dict)
import NarrativeEngine.Core.Rules as Rules
import NarrativeEngine.Core.WorldModel as WorldModel
import NarrativeEngine.Debug
import NarrativeEngine.Syntax.EntityParser as EntityParser
import NarrativeEngine.Syntax.Helpers as SyntaxHelpers
import NarrativeEngine.Syntax.NarrativeParser as NarrativeParser
import NarrativeEngine.Syntax.RuleParser as RuleParser

type alias ExtraFields =
    NamedComponent {}

type alias NamedComponent a =
    { a
        | name : String
        , description : String
    }

type alias MyEntity =
    WorldModel.NarrativeComponent ExtraFields

type alias MyWorldModel =
    Dict WorldModel.ID MyEntity

entity : String -> String -> String -> ( String, ExtraFields )
entity entityString name description =
    ( entityString, { name = name, description = description } )

initialWorldModelSpec : List ( String, ExtraFields )
initialWorldModelSpec =
    [ -- characters
      entity "PLAYER.current_location=POLICEOFFICE.day1"
        "The player"
        ""
    , entity "LEEPOLICEOFFICE.npc.day=1.trigger=0"
        "Lee"
        "Well, Allen seems to have something assigned to you. Let's go and solve the case."
    , entity "BOBPOLICEOFFICE.npc.day=1.trigger=0"
        "Bob"
        "Don't disturb me. I'm reading something critical."
    , entity "ALLENPOLICEOFFICE.npc.day=1.trigger=0"
        "Allen"
        "A man who loves reading novels."
    , entity "ALLENPARK.npc.day=1.trigger=0"
        "Allen"
        "A man who loves reading novels."
    , entity "LEEPARK.npc.day=1.trigger=0"
        "Lee"
        "A man who loves coffee"

    -- items
    , entity "POLICEOFFICEDOOR.entrance"
        "The gate of police office."
        -- notice that this description uses the cycling narrative syntax, in this
        -- case to only show the first part once.
        "Where do you want to go?"

    -- choices
    , entity "YES.bobtalk.choices=0"
        "Yes"
        ""
    , entity "NO.bobtalk.choices=0"
        "No"
        ""
    , entity "DOESNTMATTER.leetalk.choices=0"
        "It doesn't matter. 'Almost' late is not late."
        ""
    , entity "PAYATTENTION.leetalk.choices=0"
        "Oh, I'll pay attention to that next time."
        ""
    ]

type alias MyRule =
    Rules.Rule {}

type alias Rules =
    Dict String MyRule

type alias RulesSpec =
    Dict Rules.RuleID ( String, {} )

rule_______________________ : String -> String -> RulesSpec -> RulesSpec
rule_______________________ k v dict =
    Dict.insert k ( v, {} ) dict

rulesSpec : RulesSpec
rulesSpec =
    Dict.empty
        |> rule_______________________ "talk with bob"
            """
            ON: BOBPOLICEOFFICE
            IF: BOBPOLICEOFFICE.trigger=0
            DO: YES.bobtalk.choices=1
                NO.bobtalk.choices=1
            """
        |> rule_______________________ "yes"
            """
            ON: YES.bobtalk
            DO: BOBPOLICEOFFICE.trigger=1
                YES.bobtalk.choices=0
                NO.bobtalk.choices=0
            """
        |> rule_______________________ "no"
            """
            ON: NO.bobtalk
            DO: BOBPOLICEOFFICE.trigger=1
                YES.bobtalk.choices=0
                NO.bobtalk.choices=0
            """
        |> rule_______________________ "talk with lee"
            """
            ON: LEEPOLICEOFFICE.npc.day=1
            IF: LEEPOLICEOFFICE.npc.day=1.trigger=0
            DO: DOESNTMATTER.leetalk.choices=1
                PAYATTENTION.leetalk.choices=1
            """
        |> rule_______________________ "that doesn't matter"
            """
            ON: DOESNTMATTER.leetalk
            DO: LEEPOLICEOFFICE.trigger=1
                DOESNTMATTER.leetalk.choices=0
                PAYATTENTION.leetalk.choices=0
            """
        |> rule_______________________ "pay attention next time"
            """
            ON: PAYATTENTION.leetalk
            DO: LEEPOLICEOFFICE.trigger=1
                DOESNTMATTER.leetalk.choices=0
                PAYATTENTION.leetalk.choices=0
            """
        |> rule_______________________ "talk with allen 1"
            """
            ON: ALLENPOLICEOFFICE.day=1
            DO: ALLENPOLICEOFFICE.trigger=1
                BOBPOLICEOFFICE.trigger=1
                LEEPOLICEOFFICE.trigger=1
                YES.bobtalk.choices=0
                NO.bobtalk.choices=0
                DOESNTMATTER.leetalk.choices=0
                PAYATTENTION.leetalk.choices=0
            """
        |> rule_______________________ "talk with allen park"
            """
            ON: ALLENPARK.day=1
            DO: ALLENPARK.trigger=1
            """
        |> rule_______________________ "talk with lee park"
            """
            ON: LEEPARK.day=1
            DO: LEEPARK.trigger=1
            """

content__________________________________ : String -> String -> Dict String String -> Dict String String
content__________________________________ =
    Dict.insert

narrative_content : Dict String String
narrative_content =
    Dict.empty
        |> content__________________________________ "talk with bob"
            "{BOBPOLICEOFFICE.trigger=1? Don't disturb me.| Good morning. What can I do for you?}"
        |> content__________________________________ "yes"
            "Don't kid me, Kay."
        |> content__________________________________ "no"
            "You'll be late, Kay."
        |> content__________________________________ "talk with lee"
            "{LEEPOLICEOFFICE.trigger=1? Well, Allen seems to have something assigned to you.| Hey, Kay. You are almost late at work.}"
        |> content__________________________________ "that doesn't matter"
            "That's what you will say. But beware of Allen scolding you."
        |> content__________________________________ "pay attention next time"
            "Kay? That's not like you."
        |> content__________________________________ "talk with allen 1"
            "{ALLENPOLICEOFFICE.trigger=1? What are you waiting for? Go to the park!(Go to the gate to go to other places.)| Kay, you are almost late! Now go with me at once, a body is found in the park.}"
        |> content__________________________________ "talk with allen park"
            "{ALLENPARK.trigger=1? Go to ask Adkins about his alibi.| Kay, what do you think about this?}"
        |> content__________________________________ "talk with lee park"
            "{LEEPARK.trigger=1? What a pity! He died here when he knew he had a great future.| I'll assist the medical examiner in obtaining autopsy results. Can you go to help Allen?}"

parsedData =
    let
            -- This is how we "merge" our extra fields into the entity record.
            addExtraEntityFields { name, description } { tags, stats, links } =
                { tags = tags
                , stats = stats
                , links = links
                , name = name
                , description = description
                }

            addExtraRuleFields extraFields rule =
                -- no extra fields, so this is just a pass-through
                rule
            parsedData_ = Result.map3 (\parsedInitialWorldModel narrative parsedRules -> ( parsedInitialWorldModel, parsedRules ))
                                         (EntityParser.parseMany addExtraEntityFields initialWorldModelSpec)
                                         (NarrativeParser.parseMany narrative_content)
                                         (RuleParser.parseRules addExtraRuleFields rulesSpec)
    in
            parsedData_
                |> Result.map Tuple.second
                |> Result.withDefault Dict.empty

initialWorldModel =
    let
            -- This is how we "merge" our extra fields into the entity record.
            addExtraEntityFields { name, description } { tags, stats, links } =
                { tags = tags
                , stats = stats
                , links = links
                , name = name
                , description = description
                }

            addExtraRuleFields extraFields rule =
                -- no extra fields, so this is just a pass-through
                rule
            parsedData_ = Result.map3 (\parsedInitialWorldModel narrative parsedRules -> ( parsedInitialWorldModel, parsedRules ))
                                         (EntityParser.parseMany addExtraEntityFields initialWorldModelSpec)
                                         (NarrativeParser.parseMany narrative_content)
                                         (RuleParser.parseRules addExtraRuleFields rulesSpec)
    in
            parsedData_
                |> Result.map Tuple.first
                |> Result.withDefault Dict.empty