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
        "Go to ask them about this case. Lee has told me that Brennan died about 9 p.m. yesterday."
    , entity "LEEPARK.npc.day=1.trigger=0"
        "Lee"
        "Do you find anything? Allen is over there and you can talk with him."
    , entity "CATHERINE.npc.day=1.trigger=0.suspect=0"
        "Catherine"
        "Please do find out the truth... I can't take it. We were about to get engaged and then he died suddenly..."
    , entity "ADKINS.npc.day=1.trigger=0.suspect=0"
        "Adkins"
        "Our dream hasn't come true yet... You are so talented, but why is fate so unfair?"

    -- items
    , entity "BODYPARKSHOES.choices=0"
        "The shoes of Brennan."
        "A very clean pair of designer shoes. Carefully maintained, even the shoe sole."
    , entity "SCARONNECK.choices=0"
        "The scar of Brennan on his neck."
        "There are obvious signs of strangulation."
    , entity "BELONGINGS.choices=0"
        "The belongings of Brennan."
        "Nothing is left."

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
    , entity "NOTHING.allentalkpark.choices=0"
        "Nothing."
        ""
    , entity "SHOE.allentalkpark.choices=0"
        "The shoes look strange."
        ""
    , entity "WEAPON.allentalkpark.choices=0"
        "What the murderer used to strangle him is strange."
        ""
    , entity "ADKINSALIBI.choices=0"
        "Where were you last night, Adkins? Was there anyone with you?"
        ""
    , entity "CATHERINEALIBI.choices=0"
        "Where were you last night, Catherine? Was there anyone with you?"
        ""
    , entity "ADKINSASK.choices=0"
        "When did you see Brennan last time? Do you know why he came here last night?"
        ""
    , entity "CATHERINEASK.choices=0"
        "When did you see Brennan last time? Do you know why he came here last night?"
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
            IF: ALLENPARK.trigger=0
            DO: NOTHING.allentalkpark.choices=1
                SHOE.allentalkpark.choices=1
                WEAPON.allentalkpark.choices=1
                ALLENPARK.trigger=1
                BODYPARKSHOES.choices=0
                SCARONNECK.choices=0
                BELONGINGS.choices=0
                CATHERINEASK.choices=0
                CATHERINEALIBI.choices=0
                ADKINSASK.choices=0
                ADKINSALIBI.choices=0
            """
        |> rule_______________________ "nothing"
            """
            ON: NOTHING.allentalkpark
            DO: ALLENPARK.trigger=1
                NOTHING.allentalkpark.choices=0
                SHOE.allentalkpark.choices=0
                WEAPON.allentalkpark.choices=0
            """
        |> rule_______________________ "shoes"
            """
            ON: SHOE.allentalkpark
            DO: ALLENPARK.trigger=1
                NOTHING.allentalkpark.choices=0
                SHOE.allentalkpark.choices=0
                WEAPON.allentalkpark.choices=0
                CATHERINE.suspect=1
                ADKINS.suspect=1
            """
        |> rule_______________________ "weapon"
            """
            ON: WEAPON.allentalkpark
            DO: ALLENPARK.trigger=1
                NOTHING.allentalkpark.choices=0
                SHOE.allentalkpark.choices=0
                WEAPON.allentalkpark.choices=0
            """
        |> rule_______________________ "talk with lee park"
            """
            ON: LEEPARK.day=1
            IF: LEEPARK.trigger=0
            DO: LEEPARK.trigger=1
                BODYPARKSHOES.choices=1
                SCARONNECK.choices=1
                BELONGINGS.choices=1
                CATHERINEASK.choices=0
                CATHERINEALIBI.choices=0
                ADKINSASK.choices=0
                ADKINSALIBI.choices=0
                NOTHING.allentalkpark.choices=0
                SHOE.allentalkpark.choices=0
                WEAPON.allentalkpark.choices=0
            """
        |> rule_______________________ "invest shoes"
            """
            ON: BODYPARKSHOES.choices=1
            DO: LEEPARK.trigger=1
                BODYPARKSHOES.choices=0
            """
        |> rule_______________________ "invest scar"
            """
            ON: SCARONNECK.choices=1
            DO: LEEPARK.trigger=1
                SCARONNECK.choices=0
            """
        |> rule_______________________ "invest belongings"
            """
            ON: BELONGINGS.choices=1
            DO: LEEPARK.trigger=1
                BELONGINGS.choices=0
            """
        |> rule_______________________ "talk with adkins"
            """
            ON: ADKINS.day=1
            IF: ADKINS.trigger=0
            DO: ADKINS.trigger=1
                ADKINSALIBI.choices=1
                BODYPARKSHOES.choices=0
                SCARONNECK.choices=0
                BELONGINGS.choices=0
                CATHERINEASK.choices=0
                CATHERINEALIBI.choices=0
                ADKINSASK.choices=0
                NOTHING.allentalkpark.choices=0
                SHOE.allentalkpark.choices=0
                WEAPON.allentalkpark.choices=0
            """
        |> rule_______________________ "ask adkins alibi"
            """
            ON: ADKINSALIBI.choices=1
            DO: ADKINSALIBI.choices=0
                ADKINSASK.choices=1
                BODYPARKSHOES.choices=0
                SCARONNECK.choices=0
                BELONGINGS.choices=0
                CATHERINEASK.choices=0
                CATHERINEALIBI.choices=0
                NOTHING.allentalkpark.choices=0
                SHOE.allentalkpark.choices=0
                WEAPON.allentalkpark.choices=0
            """
        |> rule_______________________ "ask adkins alibi2"
            """
            ON: ADKINSASK.choices=1
            DO: ADKINSASK.choices=0
                ALLENPARK.day=1.trigger=2
                BODYPARKSHOES.choices=0
                SCARONNECK.choices=0
                BELONGINGS.choices=0
                CATHERINEASK.choices=0
                CATHERINEALIBI.choices=0
                ADKINSALIBI.choices=0
                NOTHING.allentalkpark.choices=0
                SHOE.allentalkpark.choices=0
                WEAPON.allentalkpark.choices=0
            """
        |> rule_______________________ "talk with catherine"
            """
            ON: CATHERINE.day=1
            IF: CATHERINE.trigger=0
            DO: CATHERINE.trigger=1
                CATHERINEALIBI.choices=1
                BODYPARKSHOES.choices=0
                SCARONNECK.choices=0
                BELONGINGS.choices=0
                CATHERINEASK.choices=0
                ADKINSASK.choices=0
                ADKINSALIBI.choices=0
                NOTHING.allentalkpark.choices=0
                SHOE.allentalkpark.choices=0
                WEAPON.allentalkpark.choices=0
            """
        |> rule_______________________ "ask catherine alibi"
            """
            ON: CATHERINEALIBI.choices=1
            DO: CATHERINEALIBI.choices=0
                CATHERINEASK.choices=1
                BODYPARKSHOES.choices=0
                SCARONNECK.choices=0
                BELONGINGS.choices=0
                ADKINSASK.choices=0
                ADKINSALIBI.choices=0
                NOTHING.allentalkpark.choices=0
                SHOE.allentalkpark.choices=0
                WEAPON.allentalkpark.choices=0
            """
        |> rule_______________________ "ask catherine alibi2"
            """
            ON: CATHERINEASK.choices=1
            DO: CATHERINEASK.choices=0
                ALLENPARK.day=1.trigger=2
                BODYPARKSHOES.choices=0
                SCARONNECK.choices=0
                BELONGINGS.choices=0
                CATHERINEALIBI.choices=0
                ADKINSASK.choices=0
                ADKINSALIBI.choices=0
                NOTHING.allentalkpark.choices=0
                SHOE.allentalkpark.choices=0
                WEAPON.allentalkpark.choices=0
            """
        |> rule_______________________ "talk with allen park 2"
            """
            ON: ALLENPARK.day=1.trigger=2
            DO: ALLENPARK.trigger=3
                BODYPARKSHOES.choices=0
                SCARONNECK.choices=0
                BELONGINGS.choices=0
                CATHERINEASK.choices=0
                CATHERINEALIBI.choices=0
                ADKINSASK.choices=0
                ADKINSALIBI.choices=0
                NOTHING.allentalkpark.choices=0
                SHOE.allentalkpark.choices=0
                WEAPON.allentalkpark.choices=0
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
            "{ALLENPARK.trigger=1? Go to ask them about this case. Lee has told me that Brennan died about 9 p.m. yesterday. | What do you think about this? What looks suspicious?}"
        |> content__________________________________ "nothing"
            "Em, you think that this is a simple robbery? Fair enough, but let's ask Catherine and Adkins for their alibi from last night."
        |> content__________________________________ "shoes"
            "You mean that his shoe sole is too clean, but it's almost impossible to keep it clean when walking on the messy grassland. So he is likely to be dumped here. Go to ask Catherine and Adkins! They are criminal suspects."
        |> content__________________________________ "weapon"
            "The weapon? It's just an ordinary rope. Nothing strange. Maybe it's just a simple robbery, but let's ask Catherine and Adkins for their alibi from last night."
        |> content__________________________________ "talk with lee park"
            "{LEEPARK.trigger=1? Do you find anything? Allen is over there and you can talk with him.| I'll assist the medical examiner in obtaining autopsy results. Can you investigate the body first?}"
        |> content__________________________________ "invest shoes"
            "A very clean pair of designer shoes. Carefully maintained, even the shoe sole."
        |> content__________________________________ "invest scar"
            "There are obvious signs of strangulation."
        |> content__________________________________ "invest belongings"
            "Nothing is left."
        |> content__________________________________ "talk with adkins"
            "Morning, officer. Yes, I'm Adkins. I grew up with him together and we are like brothers... He has few friends but we've always had a good relationship. Who would have thought such a thing could happen!"
        |> content__________________________________ "ask adkins alibi"
            "I'm a lawyer and yesterday I work overtime with my colleagues at my own firm. I didn't leave my firm until 11 p.m."
        |> content__________________________________ "talk with catherine"
            "Yes, I found his body... I received his message last night at 10 p.m., and he asked me to meet here this morning. When I arrived, I only saw his body... That's so strange! He never had any enemies!"
        |> content__________________________________ "ask catherine alibi"
            "I was reading at home last night, but I ordered a night snack at 9:30."
        |> content__________________________________ "talk with allen park 2"
            "Do you think there's anything questionable about them? Let me know if you come to a conclusion on this case, and we trust your judgment, Kay.(Click the 'Conclusion' button to solve the case.)"
        |> content__________________________________ "ask catherine alibi2"
            "Yesterday we had lunch together and then watched a movie. I haven't seen him since we parted at 3 p.m. yesterday. We didn't live together because we haven't got married yet. I don't know why he must go such a stark place at night. He never told me that."
        |> content__________________________________ "ask adkins alibi2"
            "Actually... Please don't tell Catherine this; I'm afraid she can't take it. Brennan told me he wanted to propose to her today, and he asked me how to give her a surprise. I met him at my office at 8 p.m. last night, and talked for...about 20 minutes? I suggested him to propose to her in this park because here is a peaceful place. Then he left my office... Maybe he wanted to find a good place here, but..."

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