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
    [ ---- characters
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
    , entity "ALLENPOLICEOFFICEDAY2.npc.day=2.trigger=3"
        "Allen"
        "What are you waiting for? Go ahead to the reporter's house!"
    , entity "JOURNALISTBODYDAY2.npc.day=2.trigger=0"
        "JournalistBody"
        "No... I dare not look at that pairs of eyes again. That pairs of eerie pallor seems gazing at me, though I'm quite sure that a dead never hurts people."
    , entity "LEEJOURNALISTHOMEDAY2.npc.day=2.trigger=2"
        "Lee"
        "Well, It seems that we should wait for forensic for further report about his death and before that, let us discover whether there exists other evidence in his home. You know, the instructions from above, Mr. Boss."
    , entity "EVIDENCEJONALI.evidence.day=2.trigger=2"
        "Evidence on journalist's desk"
        "\"Hurry up, bro! Let's back to the office!\" Lee is calling you. Alas, you can't take more, or your behaviour will be exposed."
    , entity "POLICEMEN_DAY2.npcs.day=2.trigger=0"
        "other police"
        "Talk with Lee, he has something to talk with you."
    , entity "LEE_POLICEOFFICE_DAY2.npc.day2.trigger=2"
        "lee day2"
        "Don't pay too much attention on this case! It's time to go to home, Kay."
    -- day2night
    , entity "BOB_CALLING.npc.day2night.trigger=1"
        "Bob day2night calling"
        "Ann? I've heard of that name... Why so many people are killed these days?"
    , entity "ALLEN_DAY2NIGHT.npc.day2night.trigger=0"
        "allen day2night"
        "This type of tea comes from Far East. Tea can keep your brain clearer, when you're facing with such a complex case; it is more refreshing, if compared with coffee. Which do you prefer, Kay?"
    , entity "LEE_DAY2NIGHT.npc.day2night.trigger=0"
        "lee day2night"
        "...Goodness, these cases are almost tearing my mind off... wait, is that the phone on floor 1? If that's another murder, could you please go to the scene alone first? "
    , entity "ANN_BODY_CLUB.npc.day2night.trigger=1"
        "ann body"
        "\"Maybe... 've taken too many drugs? Or... No matter what. Go home rather than thinking of it; Jonathan and his forensic group are the truth, anyway!\" You sneered. "
    -- day3
    , entity "PHONE_ANSWER.day3.trigger=1"
        "phone calling"
        "Now it's time to go to Daniel's home."
    , entity "DANIEL.day3.trigger=5"
        "daniel"
        "How unlucky my dear sister is... She wouldn't die if I had persuaded her a little bit more... "

    ---- items
    , entity "BODYPARKSHOES.choices=0"
        "The shoes of Brennan."
        "A very clean pair of designer shoes. Carefully maintained, even the shoe sole."
    , entity "SCARONNECK.choices=0"
        "The scar of Brennan on his neck."
        "There are obvious signs of strangulation."
    , entity "BELONGINGS.choices=0"
        "The belongings of Brennan."
        "Nothing is left."

    ---- evidences
    , entity "DISK.trigger=2"
        "the disk"
        "You had examined it yet. Now your memory recovered; you were that reporter, who was murdered by Jonathan, and now you're in Kay's body through some supernatural mechanism. That car crash happened on Kay must be Jonathan's plan, too. You had to beat Jonathon. Your intuition told you the very day of dual will come soon."
    , entity "NOTE.trigger=5"
        "the note"
        "You had examined it yet. Now your memory recovered; you were that reporter, who was murdered by Jonathan, and now you're in Kay's body through some supernatural mechanism. That car crash happened on Kay must be Jonathan's plan, too. You had to beat Jonathon. Your intuition told you the very day of dual will come soon."
    , entity "PILLS.trigger=2"
        "pills"
        "The pills are in a small bottle, on which a tag saying \"Διόνυσος\", the next line is \"PARADISE Co.Ltd\"."
    , entity "DAGGER.trigger=0"
        "dagger"
        "A dagger with weird letters on it. It seems that it is part of some couple souvenir as it seems that letters on it are only part of some complete patterns."

    ---- evidence choices
    , entity "INPUT.choices=0"
        "Input"
        ""
    , entity "CHECK_THE_DISK.choices=0"
        "Check the disk"
        ""
    , entity "FILE1_EGG.choices=0"
        "Exocist: Haunted Gifts"
        ""
    , entity "FILE2_REPORT.choices=0"
        "Report about Jonathon"
        ""
    , entity "CLEAR_LOOK.choices=0"
        "Have a clear look at the note"
        ""
    , entity "TAKE_PILL.choices=0"
        "Take one pill."
        ""
    , entity "NOT_TAKE_PILL.choices=0"
        "...forget it."
        ""

    ---- choices
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

    -- day2
    , entity "FORGOT1.allentalkoffice.choices=0"
        "Umm which case?"
        ""
    , entity "FORGOT2.allentalkoffice.choices=0"
        "Sorry Sir, I can't recall that... "
        ""
    , entity "ASKALLENABOUTREPORTER.allentalkoffice.choices=0"
        "Ah... So what happens?"
        ""
    , entity "HEADACHE1DAY2.choices=0"
        "!!!"
        ""
    , entity "HEADACHE2DAY2.choices=0"
        "Take a breath."
        ""
    , entity "HEADACHE3DAY2.choices=0"
        "... Take a DEEP breath. "
        ""
    , entity "DISGUISEFEAR.day2.choices=0"
        "( You are too shocked to utter a word; but you cannot tell why. ) "
        ""
    , entity "CHOOSEWHICHTAKEDISK.day2.choices=0"
        "Take the hard disk."
        ""
    , entity "CHOOSEWHICHTAKENOTE.day2.choices=0"
        "Take the note."
        ""
    , entity "ASK_LEE_WHY.day2.choices=0"
        "What? Why someone will carry out a suicide in such cruel way? And why the conclusion is made so hurriedly? Can I have a look at the report of the autopsy?"
        ""
    --- day2night
    , entity "PICK_UP.day2night.choices=0"
        "Hello?"
        ""
    , entity "CHECK_WOMAN.day2night.choices=0"
        "Check the body."
        ""
    , entity "SEARCH_SOFA.day2night.choices=0"
        "Search the sofa."
        ""
    , entity "SEARCH_TABLE.day2night.choices=0"
        "Search the table."
        ""
    -- day3
    , entity "PICK_UP_CELLPHONE.day3.choices=0"
        "Hello?"
        ""
    , entity "HUNG_UP_CELLPHONE.day3.choices=0"
        "'ve got it. Thanks. (Hang up)"
        ""
    , entity "GOOD_MORNING.day3.choices=0"
        "I'm coming to ask you something about your sister."
        ""
    , entity "ASK_WHY_ANN_WORK.day3.choices=0"
        "Ask about why Ann works at the night club."
        ""
    , entity "ASK_OPINION_ABOUT_DEATH.day3.choices=0"
        "Ask about what do you think about your sister's death."
        ""
    , entity "ASK_LIFE.day3.choices=0"
        "Ask about their current life"
        ""

    ------
    --- day4
    -- npcs
    , entity "BOB_DAY4.trigger=1"
        "bob day4"
        "What? If you ask me, that is there's nothing critical on today's newspaper! Only damn showbiz gossips. Don't forget Jonathan!"
    , entity "LEE_DAY4.trigger=1"
        "lee day4"
        "Nah. Well, that's the general reply but if we get more detailed, today Allen's temper is worse than any day before."
    , entity "ALLEN_DAY4.trigger=1"
        "allen day4"
        "But why always asking? That f***ing coffee machine is broken, and my Far East tea is used up, that's all! Go to Jonathon with four jet engines on your butt, or he will fire you at once!"
    , entity "COFFEE.trigger=1"
        "coffee machine"
        "Now the coffee machine is fixed!"
    , entity "JONATHON_DAY4.trigger=1"
        "jonathon"
        "..."

    -- choices
    , entity "ASK_BOB.choices=0"
        "Ask Bob about weird things happened today."
        ""
    , entity "ASK_LEE.choices=0"
        "Ask Lee about weird things happened today."
        ""
    , entity "ASK_ALLEN.choices=0"
        "Ask Allen about weird things happened today."
        ""
    , entity "OPEN_COFFEE_MACHINE.choices=0"
        "Open it to check what is stuck inside..."
        ""
    , entity "BAD_LIE.choices=0"
        "I have only investigated the nightclub yet, Sir"
        ""
    , entity "HAVE_INVEST.choices=0"
        "I have talked about Daniel yet, Sir."
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
        |> rule_______________________ "yes" --the choice player has chosen is -1.
            """
            ON: YES.bobtalk
            DO: BOBPOLICEOFFICE.trigger=1
                YES.bobtalk.choices=-1
                NO.bobtalk.choices=0
            """
        |> rule_______________________ "no"
            """
            ON: NO.bobtalk
            DO: BOBPOLICEOFFICE.trigger=1
                YES.bobtalk.choices=0
                NO.bobtalk.choices=-1
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
            ON: CATHERINE.trigger=1
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
        |> rule_______________________ "park default"  -- To fix the bug of choices
            """
            ON: ALLENPARK.day=1.trigger=2
            IF: ADKINS.trigger=1
            DO: BODYPARKSHOES.choices=0
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
        |> rule_______________________ "allen is impatient"
            """
            ON: ALLENPOLICEOFFICEDAY2.npc.day=2
            IF: ALLENPOLICEOFFICEDAY2.npc.day=2.trigger=3
            DO: FORGOT1.allentalkoffice.choices=1
                FORGOT2.allentalkoffice.choices=1
            """
        |> rule_______________________ "forgot 1"
            """
            ON: FORGOT1.allentalkoffice
            DO: FORGOT1.allentalkoffice.choices=-1
                FORGOT2.allentalkoffice.choices=0
                ALLENPOLICEOFFICEDAY2.npc.day=2.trigger=2
            """
        |> rule_______________________ "forgot 2"
            """
            ON: FORGOT2.allentalkoffice
            DO: FORGOT1.allentalkoffice.choices=0
                FORGOT2.allentalkoffice.choices=-1
                ALLENPOLICEOFFICEDAY2.npc.day=2.trigger=2
            """
        |> rule_______________________ "allen laugh"
            """
            ON: ALLENPOLICEOFFICEDAY2.npc.day=2
            IF: ALLENPOLICEOFFICEDAY2.npc.day=2.trigger=2
            DO: ASKALLENABOUTREPORTER.allentalkoffice.choices=1
            """
        |> rule_______________________ "ask allen about reporter"
            """
            ON: ASKALLENABOUTREPORTER.allentalkoffice
            IF: ASKALLENABOUTREPORTER.allentalkoffice.choices=1
            DO: ASKALLENABOUTREPORTER.allentalkoffice.choices=0
                ALLENPOLICEOFFICEDAY2.npc.day=2.trigger=1
            """

        |> rule_______________________ "allen tells the case"
            """
            ON: ALLENPOLICEOFFICEDAY2.npc.day=2
            IF: ALLENPOLICEOFFICEDAY2.npc.day=2.trigger=1
            DO: ALLENPOLICEOFFICEDAY2.npc.day=2.trigger=0
            """

        |> rule_______________________ "lee order you check body"
            """
            ON: LEEJOURNALISTHOMEDAY2.npc.day=2
            IF: JOURNALISTBODYDAY2.npc.day=2.trigger=0
                LEEJOURNALISTHOMEDAY2.npc.day=2.trigger=2
            DO: LEEJOURNALISTHOMEDAY2.npc.day=2.trigger=2
            """
        |> rule_______________________ "glance at body"
            """
            ON: JOURNALISTBODYDAY2.npc.day=2
            IF: JOURNALISTBODYDAY2.npc.day=2.trigger=0
            DO: HEADACHE1DAY2.choices=1
            """
        |> rule_______________________ "headache1"
            """
            ON: HEADACHE1DAY2
            IF: HEADACHE1DAY2.choices=1
            DO: HEADACHE1DAY2.choices=0
                HEADACHE2DAY2.choices=1
                JOURNALISTBODYDAY2.npc.day=2.trigger=1
            """
        |> rule_______________________ "headache2"
            """
            ON: HEADACHE2DAY2
            IF: HEADACHE2DAY2.choices=1
            DO: HEADACHE2DAY2.choices=0
                HEADACHE3DAY2.choices=1
            """
        |> rule_______________________ "headache3"
            """
            ON: HEADACHE3DAY2
            IF: HEADACHE3DAY2.choices=1
            DO: HEADACHE3DAY2.choices=0
                JOURNALISTBODYDAY2.npc.day=2.trigger=1
            """
        |> rule_______________________ "comfort by lee"
            """
            ON: LEEJOURNALISTHOMEDAY2.npc.day=2
            IF: LEEJOURNALISTHOMEDAY2.npc.day=2.trigger=2
                JOURNALISTBODYDAY2.npc.day=2.trigger=1
            DO: DISGUISEFEAR.day2.choices=1
            """
        |> rule_______________________ "ok to lee"
            """
            ON: DISGUISEFEAR.day2
            IF: DISGUISEFEAR.day2.choices=1
            DO: DISGUISEFEAR.day2.choices=0
                LEEJOURNALISTHOMEDAY2.npc.day=2.trigger=1
            """
        |> rule_______________________ "lee's contempt"
            """
            ON: LEEJOURNALISTHOMEDAY2.npc.day=2
            IF: LEEJOURNALISTHOMEDAY2.npc.day=2.trigger=1
            DO: LEEJOURNALISTHOMEDAY2.npc.day=2.trigger=0
            """
        |> rule_______________________ "check the evidences but failed"
            """
            ON: EVIDENCEJONALI.evidence.day=2
            IF: LEEJOURNALISTHOMEDAY2.npc.day=2.!trigger=0
            DO: EVIDENCEJONALI.evidence.day=2.trigger=2
            """
        |> rule_______________________ "check the evidences and succeeded"
            """
            ON: EVIDENCEJONALI.evidence.day=2
            IF: LEEJOURNALISTHOMEDAY2.npc.day=2.trigger=0
                EVIDENCEJONALI.evidence.day=2.trigger=2
            DO: EVIDENCEJONALI.evidence.day=2.trigger=1
                CHOOSEWHICHTAKEDISK.day2.choices=1
                CHOOSEWHICHTAKENOTE.day2.choices=1
            """
        |> rule_______________________ "take disk"
            """
            ON: CHOOSEWHICHTAKEDISK.day2
            DO: CHOOSEWHICHTAKEDISK.day2.choices=-1
                CHOOSEWHICHTAKENOTE.day2.choices=0
                EVIDENCEJONALI.evidence.day=2.trigger=0
            """
        |> rule_______________________ "take note"
            """
            ON: CHOOSEWHICHTAKENOTE.day2
            DO: CHOOSEWHICHTAKEDISK.day2.choices=0
                CHOOSEWHICHTAKENOTE.day2.choices=-1
                EVIDENCEJONALI.evidence.day=2.trigger=0
            """
        |> rule_______________________ "lee explain suicide"
            """
            ON: LEE_POLICEOFFICE_DAY2.npc.day2
            IF: LEE_POLICEOFFICE_DAY2.npc.day2.trigger=2
            DO: LEE_POLICEOFFICE_DAY2.npc.day2.trigger=1
                ASK_LEE_WHY.day2.choices=1
            """
        |> rule_______________________ "not suicide"
            """
            ON: ASK_LEE_WHY.day2
            IF: ASK_LEE_WHY.day2.choices=1
            DO: ASK_LEE_WHY.day2.choices=0
                LEE_POLICEOFFICE_DAY2.npc.day2.trigger=1
            """
        |> rule_______________________ "lee explain jonathan"
            """
            ON: LEE_POLICEOFFICE_DAY2.npc.day2
            IF: LEE_POLICEOFFICE_DAY2.npc.day2.trigger=1
            DO: LEE_POLICEOFFICE_DAY2.npc.day2.trigger=3
            """
        -- day2night
        |> rule_______________________ "bob call"
            """
            ON: BOB_CALLING.npc.day2night
            IF: BOB_CALLING.npc.day2night.trigger=1
            DO: BOB_CALLING.npc.day2night.trigger=0
                PICK_UP.day2night.choices=1
            """
        |> rule_______________________ "calling"
            """
            ON: PICK_UP.day2night
            IF: PICK_UP.day2night.choices=1
            DO: PICK_UP.day2night.choices=0
            """
        |> rule_______________________ "find woman body"
            """
            ON: ANN_BODY_CLUB.npc.day2night
            IF: ANN_BODY_CLUB.npc.day2night.trigger=1
            DO: CHECK_WOMAN.day2night.choices=1
                SEARCH_SOFA.day2night.choices=1
                SEARCH_TABLE.day2night.choices=1
            """
        |> rule_______________________ "check woman"
            """
            ON: CHECK_WOMAN.day2night
            IF: CHECK_WOMAN.day2night.choices=1
            DO: CHECK_WOMAN.day2night.choices=-1
            """
        |> rule_______________________ "search sofa"
            """
            ON: SEARCH_SOFA.day2night
            IF: SEARCH_SOFA.day2night.choices=1
            DO: SEARCH_SOFA.day2night.choices=-1
            """
        |> rule_______________________ "search table"
            """
            ON: SEARCH_TABLE.day2night
            IF: SEARCH_TABLE.day2night.choices=1
            DO: SEARCH_TABLE.day2night.choices=-1
            """
        |> rule_______________________ "call the office"
            """
            ON: ANN_BODY_CLUB.npc.day2night
            IF: ANN_BODY_CLUB.npc.day2night.trigger=1
                SEARCH_TABLE.day2night.choices=-1
                SEARCH_SOFA.day2night.choices=-1
                CHECK_WOMAN.day2night.choices=-1
            DO: ANN_BODY_CLUB.npc.day2night.trigger=0
            """
        -- day3
        |> rule_______________________ "pick up cellphone"
            """
            ON: PHONE_ANSWER.day3
            IF: PHONE_ANSWER.day3.trigger=1
            DO: PHONE_ANSWER.day3.trigger=0
                PICK_UP_CELLPHONE.day3.choices=1
            """
        |> rule_______________________ "talking office about forensic"
            """
            ON: PICK_UP_CELLPHONE.day3
            IF: PICK_UP_CELLPHONE.day3.choices=1
            DO: PICK_UP_CELLPHONE.day3.choices=0
                HUNG_UP_CELLPHONE.day3.choices=1
            """
        |> rule_______________________ "hung up"
            """
            ON: HUNG_UP_CELLPHONE.day3
            IF: HUNG_UP_CELLPHONE.day3.choices=1
            DO: HUNG_UP_CELLPHONE.day3.choices=0
            """
        |> rule_______________________ "meet daniel"
            """
            ON: DANIEL.day3
            IF: DANIEL.day3.trigger=5
            DO: DANIEL.day3.trigger=4
            """
        |> rule_______________________ "pre ask" -- Daniel: Hi, Sir. Good morning. What's up?
            """
            ON: DANIEL.day3
            IF: DANIEL.day3.trigger=4
            DO: DANIEL.day3.trigger=3
                GOOD_MORNING.day3.choices=1
            """
        |> rule_______________________ "i'm asking you"
            """
            ON: GOOD_MORNING.day3
            IF: GOOD_MORNING.day3.choices=1
            DO: GOOD_MORNING.day3.choices=-1
            """
        |> rule_______________________ "sure, sir"
            """
            ON: DANIEL.day3
            IF: GOOD_MORNING.day3.choices=-1
                DANIEL.day3.trigger=3
            DO: DANIEL.day3.trigger=2
                ASK_LIFE.day3.choices=1
                ASK_WHY_ANN_WORK.day3.choices=1
                ASK_OPINION_ABOUT_DEATH.day3.choices=1
            """
        |> rule_______________________ "asking life"
            """
            ON: ASK_LIFE.day3
            DO: ASK_LIFE.day3.choices=-1
                DANIEL.day3.trigger=0
            """
        |> rule_______________________ "asking why ann work like that"
            """
            ON: ASK_WHY_ANN_WORK.day3
            DO: ASK_WHY_ANN_WORK.day3.choices=-1
                DANIEL.day3.trigger=0
            """
        |> rule_______________________ "asking opinion about ann's death"
            """
            ON: ASK_OPINION_ABOUT_DEATH.day3
            IF: ASK_WHY_ANN_WORK.day3.choices=-1
            DO: ASK_OPINION_ABOUT_DEATH.day3.choices=-1
                DANIEL.day3.trigger=0
            """
        |> rule_______________________ "asking opinion about ann's death: not asked"
            """
            ON: ASK_OPINION_ABOUT_DEATH.day3
            IF: ASK_WHY_ANN_WORK.day3.!choices=-1
            DO: ASK_OPINION_ABOUT_DEATH.day3.choices=-1
                DANIEL.day3.trigger=0
            """
        |> rule_______________________ "connect computer"
            """
            ON: DISK
            IF: DISK.trigger=2
            DO: INPUT.choices=1
            """
        |> rule_______________________ "input-you don't"
            """
            ON: INPUT
            DO: INPUT.choices=0
                DISK.trigger=1
            """
        |> rule_______________________ "it is my disk"
            """
            ON: DISK
            IF: DISK.trigger=1
                FILE1_EGG.choices=0
                FILE2_REPORT.choices=0
            DO: CHECK_THE_DISK.choices=1
            """
        |> rule_______________________ "check the disk-there are two"
            """
            ON: CHECK_THE_DISK
            DO: FILE1_EGG.choices=1
                FILE2_REPORT.choices=1
                CHECK_THE_DISK.choices=0
            """
        |> rule_______________________ "file1"
            """
            ON: FILE1_EGG
            DO: FILE1_EGG.choices=-1
            """
        |> rule_______________________ "file2"
            """
            ON: FILE2_REPORT
            DO: FILE2_REPORT.choices=-1
            """
        |> rule_______________________ "The author of"
            """
            ON: NOTE
            IF: NOTE.trigger=5
            DO: NOTE.trigger=4
            """
        |> rule_______________________ "what this handwriting"
            """
            ON: NOTE
            IF: NOTE.trigger=4
            DO: CLEAR_LOOK.choices=1
            """
        |> rule_______________________ "have a clear-you read"
            """
            ON: CLEAR_LOOK
            DO: NOTE.trigger=3
                CLEAR_LOOK.choices=0
            """
        |> rule_______________________ "reveal of the"
            """
            ON: NOTE
            IF: NOTE.trigger=3
            DO: NOTE.trigger=2
            """
        |> rule_______________________ "our city"
            """
            ON: NOTE
            IF: NOTE.trigger=2
            DO: NOTE.trigger=1
            """
        |> rule_______________________ "jonathon keeps"
            """
            ON: NOTE
            IF: NOTE.trigger=1
            DO: NOTE.trigger=0
            """
        |> rule_______________________ "what it is highly"
            """
            ON: NOTE
            IF: NOTE.trigger=0
            DO: NOTE.trigger=-1
            """
        |> rule_______________________ "description"
            """
            ON: PILLS
            IF: PILLS.trigger=2
            DO: PILLS.trigger=1
            """
        |> rule_______________________ "greek letters"
            """
            ON: PILLS
            IF: PILLS.trigger=1
            DO: TAKE_PILL.choices=1
                NOT_TAKE_PILL.choices=1
            """
        |> rule_______________________ "take the pills"
            """
            ON: TAKE_PILL
            DO: TAKE_PILL.choices=0
                NOT_TAKE_PILL.choices=0
                PILLS.trigger=0
            """
        |> rule_______________________ "forget it"
            """
            ON: NOT_TAKE_PILL
            DO: TAKE_PILL.choices=0
                NOT_TAKE_PILL.choices=0
                PILLS.trigger=0
            """
        |> rule_______________________ "good morning, kay"
            """
            ON: BOB_DAY4
            IF: BOB_DAY4.trigger=1
            DO: ASK_BOB.choices=1
            """
        |> rule_______________________ "bob's answer"
            """
            ON: ASK_BOB
            DO: ASK_BOB.choices=-1
                BOB_DAY4.trigger=0
            """
        |> rule_______________________ "kay, jonathon calls"
            """
            ON: LEE_DAY4
            IF: LEE_DAY4.trigger=1
            DO: ASK_LEE.choices=1
            """
        |> rule_______________________ "lee's answer"
            """
            ON: ASK_LEE
            DO: ASK_LEE.choices=-1
                LEE_DAY4.trigger=0
            """
        |> rule_______________________ "big jonathon is"
            """
            ON: ALLEN_DAY4
            IF: ALLEN_DAY4.trigger=1
            DO: ASK_ALLEN.choices=1
            """
        |> rule_______________________ "allen's answer"
            """
            ON: ASK_ALLEN
            DO: ASK_ALLEN.choices=-1
                ALLEN_DAY4.trigger=0
            """
        |> rule_______________________ "coffee machine"
            """
            ON: COFFEE
            IF: COFFEE.trigger=1
            DO: OPEN_COFFEE_MACHINE.choices=1
            """
        |> rule_______________________ "find memory card"
            """
            ON: OPEN_COFFEE_MACHINE
            DO: OPEN_COFFEE_MACHINE.choices=-1
                COFFEE.trigger=0
            """
        |> rule_______________________ "jonathon good morning"
            """
            ON: JONATHON_DAY4
            IF: JONATHON_DAY4.trigger=1
                HAVE_INVEST.choices=0
                BAD_LIE.choices=0
            DO: HAVE_INVEST.choices=1
                BAD_LIE.choices=1
            """
        |> rule_______________________ "bad lie"
            """
            ON: BAD_LIE
            DO: HAVE_INVEST.choices=0
                BAD_LIE.choices=-1
                JONATHON_DAY4.trigger=2
            """
        |> rule_______________________ "jonathon's reply to bad lie"
            """
            ON: JONATHON_DAY4
            IF: JONATHON_DAY4.trigger=2
                BAD_LIE.choices=-1
            DO: JONATHON_DAY4.trigger=0
            """
        |> rule_______________________ "tell truth"
            """
            ON: HAVE_INVEST
            DO: HAVE_INVEST.choices=-1
                BAD_LIE.choices=0
                JONATHON_DAY4.trigger=2
            """
        |> rule_______________________ "jonathon's reply to truth"
            """
            ON: JONATHON_DAY4
            IF: JONATHON_DAY4.trigger=2
                HAVE_INVEST.choices=-1
            DO: JONATHON_DAY4.trigger=0
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
        |> content__________________________________ "allen is impatient"
            "Morning Kay. Do you remember the case I told you the first day you come to office after you have recovered from car accident? "
        |> content__________________________________ "allen laugh"
            "Hahaha, still caught in a memory lost, ain't you? Never mind. A living stupid Kay is always better than a dead clever Kay! ……It's that missing reporter. You have seen this reporter before; he had come to office to find you at the day that you were seriously injured in the car accident."
        |> content__________________________________ "forgot 1"
            "Umm... which case?"
        |> content__________________________________ "forgot 2"
            "Sorry Sir, I can't recall that... "
        |> content__________________________________ "ask allen about reporter"
            "So what happens to him?"
        |> content__________________________________ "allen tells the case"
            "He was founded dead in his home this morning; it seems that he had been staying at home for a long time. Mr.Jonathan told me that you should go to investigate the scene with Lee."
        |> content__________________________________ "lee order you check body"
            "Oh, Kay, you arrived! The body is there, you can check it."
        |> content__________________________________ "glance at body"
            "The poor journalist lied on his bed, with a knife stabbed into his chest. Damn it, maggots! Clearly he had died for days..."
        |> content__________________________________ "headache1"
            "ARRRRAGH!!!! (HEADCHE...) Why this guy looks so ……? (DIZZY, SEVERE HEADACHE)"
        |> content__________________________________ "headache2"
            "......"
        |> content__________________________________ "headache3"
            "Well, now calm down a little anyway."
        |> content__________________________________ "comfort by lee"
            "Hey bro! Are you OK? Your face looks so pale."
        |> content__________________________________ "ok to lee"
            "... (slightly nod)"
        |> content__________________________________ "lee's contempt"
            "Hhh, being afraid of, (laugh) maggots after that? (coughs to disguise laugh) Rrrrelax, bro! They will not eat you."
        |> content__________________________________ "check the evidences but failed"
            "A hard disk and a piece of note. It's not the proper time to check them now."
        |> content__________________________________ "check the evidences and succeeded"
            "This disk... note... they seems... A glut of sense of curiosity grasped you. Who am I? This question was lingering in your mind. You decide to break the rule of the Office, and try to bring these evidence.  "
        |> content__________________________________ "take disk"
            "You took the disk. Somehow a feeling come up in your brain: you know the code of this hard disk."
        |> content__________________________________ "take note"
            "A plain note with some text on it... No time to see what's on that."
        |> content__________________________________ "lee explain suicide"
            "Ugh, Jonathon said that according to the report of autopsy, it can be judged as a suicide accident with no advanced evidence."
        |> content__________________________________ "lee explain jonathan"
            "Nope. You also forgot Jonathon's rule after that accident, huh? Each time a case is considered as solved by him, all relative evidence will be locked. Don't, challenge, Jonathon's, authority. And the stabbed-death, well, maybe just the Identification guys found out heroine in his body? Never understand poor guys like him. "
        |> content__________________________________ "not suicide"
            "What? Why someone will carry out a suicide in such cruel way? And why the conclusion is made so hurriedly? Can I have a look at the report of the autopsy?"
        |> content__________________________________ "bob call"
            "Hey, Kay! You've come. Here is a call... here you are. "
        |> content__________________________________ "calling"
            "Sir! A woman died in our nightclub, you know, Paradise. She was a servant for our nightclub and her name is Ann. She lived in her brother Daniel's new home. She was founded died in the room which she was in charge of. We are waiting for you on the second floor of our nightclub."
        |> content__________________________________ "find woman body"
            "A Paradise staff led you here to check the crime scene. You crowded down, and were going to check..."
        |> content__________________________________ "check woman"
            "There is no obvious external wound. Besides, her clothes were inside out."
        |> content__________________________________ "search sofa"
            "You find a dagger with some weird numbers on it."
        |> content__________________________________ "search table"
            "You find some weird pills."
        |> content__________________________________ "call the office"
            "You call the office and inform them of the details at the scene, and the Office said they will take over for further investigation. \n Now it's time to go home. "
        |> content__________________________________ "pick up cellphone"
            "You pick up your phone."
        |> content__________________________________ "talking office about forensic"
            "Hi, Kay. This is the department of forensic. According to our autopsy, the woman was dead of the side effect of the drug. However, this drug does not exist in our data library, and its detailed components still remain unknown. We have reported it to Mr. Jonathon. If there are any new progress we will announce you as soon as possible. "
        |> content__________________________________ "hung up"
            "Quite weird report again... Maybe today I should go to Ann's brother —— Daniel's home to see whether I can get some useful information from him."
        |> content__________________________________ "meet daniel"
            "Are you Daniel? This is police."
        |> content__________________________________ "pre ask"
            "Hi, Sir. Good morning. What's up?"
        |> content__________________________________ "i'm asking you"
            "Good morning. I'm sorry about your sister's death. Can I ask you something about your sister?"
        |> content__________________________________ "sure, sir"
            "Sure, sir. What do you want to ask about?"
        |> content__________________________________ "asking life"
            "Sir, my sister earns a lot in last months that we can afford for a new department. You know that Paradise suddenly become the best night club several months before. (Sigh) We have just moved here and she met with an accident. How unlucky my dear sister is..."
        |> content__________________________________ "asking why ann work like that"
            "The reason for this is that my sister has a quite bad experience of love in the past. She spent all her money and emotion on him but received nothing. After that, for money, she had no choice but to work for Paradise. You know that Paradise offers great salary for their staffs."
        |> content__________________________________ "asking opinion about ann's death"
            "As you know, Sir, she worked there not purely for money. She has told me that she doesn't get adapted to the atmosphere of night club several times. To work, she has to take some medicine to get adapt to the atmosphere. It maybe that yesterday, she drunk too much alcohol and then happened to take too much medicine."
        |> content__________________________________ "asking opinion about ann's death: not asked"
            "It's hard to say, Sir. My sister doesn't get adapted to the atmosphere of nightclub and has to take medicine to adapt that. It maybe that yesterday, she drunk too much alcohol and then happened to take too much medicine."

        |> content__________________________________ "connect computer"
            "You connect your computer with the hard disk. A message prompt you to key the code."
        |> content__________________________________ "input-you don't"
            "You don't know why you input the correct password without much thinking. The computer read: \"Owner confirmed. Reporter [Player's name].\""
        |> content__________________________________ "it is my disk"
            "? It is my disk? In that reporter's home? And that dream......? That is to say, I'm not a novelist, I should be that reporter?"
        |> content__________________________________ "check the disk-there are two"
            "There are two directories."
        |> content__________________________________ "file1"
            "This is an extraordinary action game about a brave man using wand to purify crazy ghosts. You spent almost an hour to finish it."
        |> content__________________________________ "file2"
            "A .md file jumped out. It read: \"According to evidence provided by Police Kay, Jonathon receives bibles from the owner of the biggest nightclub \"Paradise\" and keeps an abnormal relationship with the staff of that nightclub. Besides, he seems to have noticed us. We should be careful.\""
        |> content__________________________________ "The author of"
            "The author of this note seems to have near unrecognizable handwriting."
        |> content__________________________________ "what this handwriting"
            "\"?!! What? This handwriting is just the handwriting I have in the real world. How can that be......?\""
        |> content__________________________________ "have a clear-you read"
            "You read the note out:"
        |> content__________________________________ "reveal of the"
            "Reveal of the darkness of our city\nReporter: [Player's name]"
        |> content__________________________________ "our city"
            "Our city, or in other words, the city of criminal, is known for the increasing rate of criminals in recent years. The reason behind this is because of our master of the police office Jonathon. Thanks to the evidence provided by anonymous police, a light can be shed through the darkness of our city."
        |> content__________________________________ "jonathon keeps"
            "Jonathon keeps an abnormal relationship with many people including both women and men.\nJonathon receives bibles from the owner of the biggest nightclub \"Paradise\" in our city and provides protection for it to help it become large overnight.\nJonathon has a secret personal police team which helps him"
        |> content__________________________________ "what it is highly"
            "What, it is highly similar to the plot in my novel ...... And that dream...... That is to say, I'm not a novelist, I should be the reporter?"
        |> content__________________________________ "description"
            "The pills are in a small bottle, on which a tag saying \"Διόνυσος\", the next line is \"PARADISE Co.Ltd\".You have learned some Greek letters: that is \"Dionysus\", the god of wine."
        |> content__________________________________ "greek letters"
            "Maybe pills used for indulge people into joy, sold by Paradise...? An idea of investing Paradise again as a customer come up in your mind. By taking those pills, maybe you can get adapted in that environment then investigate smoothly...?"
        |> content__________________________________ "take the pills"
            "You thought you've made a great decision until the scene before your eyes started to blur and distort. You struggle to induce vomiting, but it's too late."
        |> content__________________________________ "forget it"
            "This is too dangerous and risky after all, you comforted yourself."
        |> content__________________________________ "good morning, kay"
            "Good morning, Kay. Jonathon says that he is waiting for you at his office."
        |> content__________________________________ "bob's answer"
            "Hi, Bob. Umm, is there anything abnormal happened today in police office?"
        |> content__________________________________ "kay, jonathon calls"
            "Kay, Jonathon is calling you to discuss the case of Paradise with him. Be careful. Jonathon is a regular customer of Paradise. (Whispering) I told you that because I'm your friend! "
        |> content__________________________________ "lee's answer"
            "Yeah, bro. By the way, is there any special, or strange thing happened today, in the Office?"
        |> content__________________________________ "big jonathon is"
            "Good morning. Big Jonathon is calling you. Wish you good luck, Kay."
        |> content__________________________________ "allen's answer"
            "OK, I'll go there later. May I ask you a question? Is there anything different from that in the other days in police office?"
        |> content__________________________________ "coffee machine"
            "You turn on the coffee machine. The coffee is dropping down very slowly."
        |> content__________________________________ "find memory card"
            "You open the lid of the coffee machine, remove the filter element. A memory card is stuck in the water outlet."
        |> content__________________________________ "jonathon good morning"
            "Good morning, Kay. We haven't been meeting with each other since your research of nightclub Paradise weeks ago. I hear that you are in charge of an urgent case yesterday, how is the case going on?"
        |> content__________________________________ "bad lie"
            "Sir, I only have time to investigate the nightclub yet. And I found nothing useful there. Currently, I have no idea what can be the potential reason for death."
        |> content__________________________________ "jonathon's reply to bad lie"
            "[Bad End: Meaningless Lie]\nJonathon just nodded. After that, nothing important happened. The whole world had been in peace until the day you were knock over on the street..."
        |> content__________________________________ "tell truth"
            "Sir, as you may have known that the woman has a brother Daniel, and I have just talked to him about this case yet. And he told me that he guessed his sister’s carelessly intake of too much drug may contribute to her death and this can be supported by the report of the autopsy."
        |> content__________________________________ "jonathon's reply to truth"
            "But you know that it's just one version of explanations. An advice for you is to go to inspect his home today. According to my report, Daniel won't be home today. Go, now."

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