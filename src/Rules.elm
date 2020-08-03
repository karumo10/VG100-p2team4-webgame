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
    , entity "DAGGER.trigger=1"
        "dagger"
        "A dagger with weird letters on it. It seems that it is part of some couple souvenir as it seems that letters on it are only part of some complete patterns."
    , entity "TRUE_MEM_CARD.trigger=1"
        "true memory card"
        "You remember the evil sentences on the card: \"1. The password is 4 capital English letters. 2. When you input a 4-length string, the password test will start automatically. 3. If the code is not correct, the self-destruct sequence will be initialized.\""
    , entity "TRUE_MEM_CARD_CONTENT.trigger=0"
        "content of true card"
        "Photos of Jonathon's receiving bribe from the owner of Paradise\n[shot on June 28th]"
    , entity "KEY_EVI.trigger=0"
        "key to jonathon evidence"
        "A key found in Daniel's department. Where can it be used?"
    , entity "PAPER_EVI.trigger=2"
        "paper evidence"
        "Though he is the darkest part in our city, he loves the feeling of being the only light in the darkness. What he needs is true love, but this goes against his dream of being the \"darkness\" in our city. Why he doesn't tell me about the reason of his weird dream?"
    , entity "BANK_EVI.trigger=1"
        "bank account statement evidence"
        "Three weeks ago. 150000 from Ann\nTwo weeks ago. 10000000 from Stallworth\nOne week ago. 9000000 to John's Company(the company who develops this department)"
    , entity "FALSE_MEM_CARD_CONTENT.trigger=4"
        "false mem card"
        "Hey, it's all about me! Who shot all these...? Bad feeling..."
    , entity "BANK_CARD_EVI.trigger=0"
        "bankcard"
        "A bank card with the name of the holder is Stallworth. It is a fairly new card with card number 1000001. It is a diamond card."
    , entity "DAGGER2_EVI.trigger=1"
        "dagger2"
        "A dagger with weird letters on it. It seems that it is part of some couple souvenir."
    , entity "LETTER_EVI.trigger=5"
        "letter"
        "I know you have seen the photos through some media before. I will give you the memory card of those photos to you. Just forgive my sister.\n-- Daniel"
    , entity "DOCUMENTS_EVI.trigger=1"
        "documents"
        "1. Approval of setting up a nightclub in the CBD of City;\n2. Approval of the expansion of nightclub Paradise.\n3. Unqualified security condition check result of nightclub Dream in the CBD.\n4. Approval of \"Paradise\" as a legal food"

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
    , entity "CODE_DAGGER.choices=0"
        "Put them together!"
        ""
    , entity "CODE_DAGGER2.choices=0"
        "Put them together!"
        ""
    ---- choices
    , entity "YES"
        "Yes"
        ""
    , entity "NO"
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
    , entity "COFFEE_NORMAL.trigger=0"
        "coffee machine normal"
        "You have a cup of coffee. Frankly speaking, you think the coffee offered here is too bitter. But you never tell anybody."
    , entity "COFFEE_NORMAL_NO_CARD.trigger=0"
        "coffe machine taken card"
        "You have a cup of coffee. Frankly speaking, you think the coffee offered here is too bitter. But you never tell anybody."
    , entity "JONATHON_DAY4.trigger=1"
        "jonathon"
        "..."
    , entity "FAKE_MEM_CARD.trigger=1"
        "fake card"
        "This place has been examined yet."
    , entity "KEY_JONATHON.trigger=1"
        "key"
        "This place has been examined yet."
    , entity "BANK.trigger=1"
        "bank statement"
        "This place has been examined yet."
    , entity "PAPER.trigger=1"
        "A paper with customer's favor"
        "This place has been examined yet."
    , entity "PHONE_DAY4.trigger=0"
        "phone jonathon"
        "Kay, I'm Jonathon. Have you finished your inspection? I think you should have been prepared to give me a conclusion yet. Come back to my office."
    , entity "JONATHON_DAY4_NEW.trigger=3"
        "jonathon in day4 new"
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
    , entity "ACCIDENT.choices=0"
        "An accident"
        ""
    , entity "MURDER.choices=0"
        "Someone murdered the woman"
        ""
    , entity "ITS_YOU.choices=0"
        "It's you, Jonathon"
        ""
    , entity "PARADISE_OWNER.choices=0"
        "The owner of the paradise"
        ""
----day5
    , entity "STAFF.trigger=2"
        "staff of paradise"
        "Welcome to PARADISE! The highest unconscious, the highest joy!"
    , entity "DANGER.trigger=2"
        "danger in dark"
        "..."
    , entity "CLOSET.trigger=1"
        "jonathon closet"
        "This place has been searched already."
    , entity "TABLE.trigger=1"
        "jonathon table"
        "This place has been searched already."
---day5choices
    , entity "YES_NIGHT.choices=0"
        "Yes!"
        ""
    , entity "NO_NIGHT.choices=0"
        "No..."
        ""
    , entity "MOVEF.choices=0"
        "Still move forward"
        ""
    , entity "EXIT.choices=0"
        "Exit"
        ""
    , entity "ESCAPE.choices=0"
        "...Run!"
        ""
    , entity "HEAR.choices=0"
        "Jonathon..."
        ""
-- day6
    , entity "POLICEXPHONE.day6.trigger=1"
        "Phone rings"
        "No phone calls now."
    , entity "COURT.day6.trigger=1"
        "..."
        ""
    , entity "HAVING_KEY.trigger=1"
        "[Speaker] I think it's enough to judge him as “strongly suspicious”. According to the law, you should stay in prison before further investigation."
        ""
    , entity "HAVING_FAKE.trigger=1"
        "[Speaker] I think it's enough to judge him as “strongly suspicious”. According to the law, you should stay in prison before further investigation."
        ""
    , entity "GOOD_COURT.trigger=1"
        "..."
        ""
-- day6choices
    , entity "POLICEXPHONEANSWER1.day6.choices=0"
        "What trouble?"
        ""
    , entity "POLICEXPHONEANSWER2.day6.choices=0"
         "No, the evidence can lie. My friend."
         ""
    , entity "POLICEXPHONEANSWER3.day6.choices=0"
        "*Sound from outside*"
        ""
    , entity "POLICEXPHONEANSWER4.day6.choices=0"
        "Go to City Council"
        ""
    , entity "COURTANSWER1.day6.choices=0"
        "......"
        ""
    , entity "COURTANSWER2.day6.choices=0"
        "......"
        ""
    , entity "COURTANSWER3.day6.choices=0"
        "It's a logic fallacy."
        ""
    , entity "COURTANSWER4.day6.choices=0"
        "But it was an arranged vacation plan by Jonathon"
        ""
    , entity "COURTANSWER5.day6.choices=0"
        "Yes."
        ""
    , entity "COURTANSWER6.day6.choices=0"
        "I go out for some personal affairs. But I don't go there."
        ""
    , entity "COURTANSWER7.day6.choices=0"
        "......"
        ""
    , entity "COURTANSWER8.choices=0"
        "..."
        ""
    , entity "KEY_RESP.choices=0"
        "But, wait..."
        ""
    , entity "KEY_END.choices=0"
        "..."
        ""
    , entity "FAKE_RESP.choices=0"
        "But, wait..."
        ""
    , entity "FAKE_END.choices=0"
        "..."
        ""
    , entity "NOCAUGHT_RESP.choices=0"
        "..."
        ""
    , entity "NOCAUGHT_GO.choices=0"
        "Leave there"
        ""
---- day7
    , entity "PHONE_DAY7.trigger=0"
        "phone council"
        "It's night now. The game is afoot!"
    , entity "LOCK.trigger=0"
        "lock jonathon"
        "The lock is unlocked!"
    , entity "CLOSET_7.trigger=1"
        "closet day7"
        "This place has been examined."
    , entity "TABLE_7.trigger=1"
        "table day7"
        "This place has been examined."
    , entity "LEE7.trigger=0"
        "lee day7"
        "Wish you good luck, Kay! Goodbye!"
---- day7 choices
    , entity "PHONE_ANS1.choices=0"
        "I want to report Jonathon!"
        ""
    , entity "PHONE_ANS2.choices=0"
        "Yeah, I'm sure."
        ""
    , entity "PHONE_ANS3.choices=0"
        "Okay. Thank you."
        ""
    , entity "PHONE_ANS4.choices=0"
        "Wait until night"
        ""
    , entity "PASSWORD1.choices=0"
        "AJNN"
        ""
    , entity "PASSWORD2.choices=0"
        "ASWN"
        ""
    , entity "PASSWORD3.choices=0"
        "AWNS"
        ""
    , entity "PASSWORD4.choices=0"
        "ANNJ"
        ""
    , entity "LEEANS1.choices=0"
        "I'm collecting evidence"
        ""
    , entity "LEEANS2.choices=0"
        "It's my mission"
        ""
    , entity "LEEANS3.choices=0"
        "It's the last chance for us to defend the slim light of our city."
        ""
    , entity "LEEANS4.choices=0"
        "Can you kindly compare these two kinds of pills?"
        ""
    , entity "LEEANS5.choices=0"
        "The same to you, Lee!"
        ""
---last four items
    , entity "BANK2.trigger=0"
        "another bank account"
        ""
    , entity "PLAN.trigger=0"
        "plan document"
        ""
    , entity "PILLS_JO.trigger=0"
        "another bottle of pills"
        "A plain bottle of pills. The most popular \"food\" in this city, Paradise."
    , entity "CUSTOM.trigger=0"
        "custom contract"
        ""
---day8
    , entity "SOUND.trigger=0"
        "sound out"
        "You should go to the city council, together with the police."
    , entity "COURT8.trigger=0"
        "court final"
        "We will inspect them carefully, as Jonathon's former accusation has been judged as highly suspicious by our secret discussion. Jonathon, you have to stay here for some time. For the last accusation, we will inspect in the following days. Here comes the end of the hearing."
    , entity "COURT_FAIL.trigger=0"
        "fail!!!"
        "[Speaker] That’s the end of this hearing. We will take your evidence and discuss before final decision."

---day8 choices
    , entity "GO_COURT.choices=0"
        "Go to city council"
        ""
    , entity "BANKACC_CARD8.choices=0" --
        "Show the another bank account statements and bank card"
        ""
    , entity "PAPER8.choices=0"
        "Show a paper with customer's favor"
        ""
    , entity "LETTER8.choices=0"
        "Show the letter"
        ""
    , entity "LETTER8_.choices=0"
        "Show the letter again"
        ""
    , entity "MEMCARD8.choices=0"
        "Show the memory card"
        ""
    , entity "CONTRACT8.choices=0"
        "Show the contract"
        ""
    , entity "CALL_LEE.choices=0"
        "Call Lee"
        ""
    , entity "BANKACC2_8.choices"
        "Show another bank account statement"
        ""
    , entity "SUB_DOCUMENT8.choices"
        "Submit Documents"
        ""
    , entity "SUB_PLAN8.choices"
        "Submit Plan document"
        ""
    , entity "SUB_CARD_ACC8.choices"
        "Submit Bank Card and Bank account statements"
        ""
    , entity "LEAVE8_F.choices=0"
        "Leave here..."
        ""
    , entity "LEAVE8.choices=0"
        "Leave here."
        ""
----day9
    , entity "MIND.trigger=0"
        "mind in home day9"
        "..."
    , entity "STREET.trigger=0"
        "street dialogs"
        "..."
---day9 choices
    , entity "FEEL.choices=0"
        "A strange feeling"
        ""
    , entity "LOOK_NEWS.choices=0"
        "Look at the newspaper"
        ""
    , entity "WHISPER.choices=0"
        "A whisper from your brain..."
        ""
    , entity "TP_STREET.choices=0"
        "Go to backstreet"
        ""
    , entity "SHOOT1.choices=0"
        "Shoot"
        ""
    , entity "WAIT1.choices=0"
        "Wait"
        ""
    , entity "SHOOT2.choices=0"
        "Shoot"
        ""
    , entity "WAIT2.choices=0"
        "Wait"
        ""
    , entity "SHOOT3.choices=0"
        "Shoot"
        ""
    , entity "WAIT3.choices=0"
        "Wait"
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
            ON: SHOE
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
            ON: ALLENPARK.trigger=2
            IF: CATHERINE.trigger=1
                ADKINS.trigger=1
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
            DO: TAKE_PILL.choices=-1
                NOT_TAKE_PILL.choices=0
                PILLS.trigger=0
            """
        |> rule_______________________ "forget it"
            """
            ON: NOT_TAKE_PILL
            DO: TAKE_PILL.choices=0
                NOT_TAKE_PILL.choices=-1
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
        |> rule_______________________ "fake memory card"
            """
            ON: FAKE_MEM_CARD
            IF: FAKE_MEM_CARD.trigger=1
            DO: FAKE_MEM_CARD.trigger=0.choices=-1
            """
        |> rule_______________________ "key jonathon"
            """
            ON: KEY_JONATHON
            IF: KEY_JONATHON.trigger=1
            DO: KEY_JONATHON.trigger=0.choices=-1
            """
        |> rule_______________________ "bank daniel"
            """
            ON: BANK
            IF: BANK.trigger=1
            DO: BANK.trigger=0.choices=-1
            """
        |> rule_______________________ "paper daniel"
            """
            ON: PAPER
            IF: PAPER.trigger=1
            DO: PAPER.trigger=0.choices=-1
            """
        |> rule_______________________ "jonathon ask your opinion"
            """
            ON: JONATHON_DAY4_NEW
            IF: JONATHON_DAY4_NEW.trigger=3
            DO: ACCIDENT.choices=1
                MURDER.choices=1
            """
        |> rule_______________________ "sir, i dont find"
            """
            ON: ACCIDENT
            DO: ACCIDENT.choices=-1
                MURDER.choices=0
            """
        |> rule_______________________ "alright, I agree with"
            """
            ON: JONATHON_DAY4_NEW
            IF: ACCIDENT.choices=-1
                JONATHON_DAY4_NEW.trigger=3
            DO: JONATHON_DAY4_NEW.trigger=0
            """
        |> rule_______________________ "sir, I think this case is quite weird"
            """
            ON: MURDER
            DO: ACCIDENT.choices=0
                MURDER.choices=-1
            """
        |> rule_______________________ "interesting, kay"
            """
            ON: JONATHON_DAY4_NEW
            IF: JONATHON_DAY4_NEW.trigger=3
                MURDER.choices=-1
            DO: JONATHON_DAY4_NEW.trigger=2
                ITS_YOU.choices=1
                PARADISE_OWNER.choices=1
            """
        |> rule_______________________ "ha my dear master"
            """
            ON: ITS_YOU
            DO: ITS_YOU.choices=-1
                PARADISE_OWNER.choices=0
                JONATHON_DAY4_NEW.trigger=1
            """
        |> rule_______________________ "You are still so naive."
            """
            ON: JONATHON_DAY4_NEW
            IF: JONATHON_DAY4_NEW.trigger=1
                ITS_YOU.choices=-1
            DO: JONATHON_DAY4_NEW.trigger=-2
            """ --BADEND: TOO EAGER
        |> rule_______________________ "I think the owner of"
            """
            ON: PARADISE_OWNER
            DO: PARADISE_OWNER.choices=-1
                JONATHON_DAY4_NEW.trigger=1
                ITS_YOU.choices=0
            """
        |> rule_______________________ "crazy assumption"
            """
            ON: JONATHON_DAY4_NEW
            IF: JONATHON_DAY4_NEW.trigger=1
                PARADISE_OWNER.choices=-1
            DO: JONATHON_DAY4_NEW.trigger=-3
            """ --BADEND: lost in paradise
        |> rule_______________________ "input code for true"
            """
            ON: TRUE_MEM_CARD
            IF: TRUE_MEM_CARD.trigger=1
            DO: TRUE_MEM_CARD.trigger=0
            """

        |> rule_______________________ "jonathon, the chief police"
            """
            ON: PAPER_EVI
            IF: PAPER_EVI.trigger=2
            DO: PAPER_EVI.trigger=1
            """
        |> rule_______________________ "instead of a mere customer"
            """
            ON: PAPER_EVI
            IF: PAPER_EVI.trigger=1
            DO: PAPER_EVI.trigger=0
            """
        |> rule_______________________ "first three lines"
            """
            ON: BANK_EVI
            IF: BANK_EVI.trigger=1
            DO: BANK_EVI.trigger=0
            """
        |> rule_______________________ "first kay photo"
            """
            ON: FALSE_MEM_CARD_CONTENT
            IF: FALSE_MEM_CARD_CONTENT.trigger=4
            DO: FALSE_MEM_CARD_CONTENT.trigger=3
            """
        |> rule_______________________ "second kay photo"
            """
            ON: FALSE_MEM_CARD_CONTENT
            IF: FALSE_MEM_CARD_CONTENT.trigger=3
            DO: FALSE_MEM_CARD_CONTENT.trigger=2
            """
        |> rule_______________________ "last kay photo"
            """
            ON: FALSE_MEM_CARD_CONTENT
            IF: FALSE_MEM_CARD_CONTENT.trigger=2
            DO: FALSE_MEM_CARD_CONTENT.trigger=1
            """
        |> rule_______________________ "sir do you want fun"
            """
            ON: STAFF
            IF: STAFF.trigger=2
                YES_NIGHT.choices=0
                NO_NIGHT.choices=0
            DO: YES_NIGHT.choices=1
                NO_NIGHT.choices=1
            """
        |> rule_______________________ "yes-you spend"
            """
            ON: YES_NIGHT
            DO: YES_NIGHT.choices=-1
                NO_NIGHT.choices=0
                STAFF.trigger=1
            """
        |> rule_______________________ "no-please leave"
            """
            ON: NO_NIGHT
            DO: NO_NIGHT.choices=-1
                YES_NIGHT.choices=0
                STAFF.trigger=1
            """
        |> rule_______________________ "yes ending"
            """
            ON: STAFF
            IF: STAFF.trigger=1
                YES_NIGHT.choices=-1
            DO: STAFF.trigger=1
            """
        |> rule_______________________ "no ending"
            """
            ON: STAFF
            IF: STAFF.trigger=1
                NO_NIGHT.choices=-1
            DO: STAFF.trigger=1
            """
        |> rule_______________________ "give two choices"
            """
            ON: DANGER
            IF: DANGER.trigger=2
            DO: DANGER.trigger=1
                MOVEF.choices=1
                EXIT.choices=1
            """
        |> rule_______________________ "still move"
            """
            ON: MOVEF
            DO: MOVEF.choices=-1
                EXIT.choices=0
                ESCAPE.choices=1
            """
        |> rule_______________________ "exit"
            """
            ON: EXIT
            DO: EXIT.choices=-1
                MOVEF.choices=0
            """
        |> rule_______________________ "escape-you try to"
            """
            ON: ESCAPE
            DO: ESCAPE.choices=-1
                HEAR.choices=1
            """
        |> rule_______________________ "hear-bad end"
            """
            ON: HEAR
            DO: HEAR.choices=-1
            """
        |> rule_______________________ "find in jonathon table"
            """
            ON: TABLE
            IF: TABLE.trigger=1
            DO: TABLE.trigger=0.choices=-1
            """
        |> rule_______________________ "find in jonathon closet"
            """
            ON: CLOSET
            IF: CLOSET.trigger=1
            DO: CLOSET.trigger=0.choices=-1
            """
        |> rule_______________________ "dagger 1 description"
            """
            ON: DAGGER
            IF: DAGGER.trigger=1
            DO: DAGGER.trigger=0
            """
        |> rule_______________________ "dagger 2 description"
            """
            ON: DAGGER2_EVI
            IF: DAGGER2_EVI.trigger=1
            DO: DAGGER2_EVI.trigger=0
            """
        |> rule_______________________ "dagger 1 code"
            """
            ON: DAGGER
            IF: DAGGER.trigger=0
                DAGGER2_EVI.trigger=0
            DO: CODE_DAGGER.choices=1
            """
        |> rule_______________________ "dagger 2 code"
            """
            ON: DAGGER2_EVI
            IF: DAGGER2_EVI.trigger=0
                DAGGER.trigger=0
            DO: CODE_DAGGER2.choices=1
            """
        |> rule_______________________ "dagger 1 put together"
            """
            ON: CODE_DAGGER
            DO: CODE_DAGGER.choices=0

            """
        |> rule_______________________ "dagger 2 put together"
            """
            ON: CODE_DAGGER2
            DO: CODE_DAGGER2.choices=0
            """
        |> rule_______________________ "several documents with"
            """
            ON: DOCUMENTS_EVI
            IF: DOCUMENTS_EVI.trigger=1
            DO: DOCUMENTS_EVI.trigger=0
            """
        |> rule_______________________ "letter1"
            """
            ON: LETTER_EVI
            IF: LETTER_EVI.trigger=5
            DO: LETTER_EVI.trigger=4
            """
        |> rule_______________________ "letter2"
             """
             ON: LETTER_EVI
             IF: LETTER_EVI.trigger=4
             DO: LETTER_EVI.trigger=3
             """
        |> rule_______________________ "letter3"
            """
            ON: LETTER_EVI
            IF: LETTER_EVI.trigger=3
            DO: LETTER_EVI.trigger=2
            """
        |> rule_______________________ "letter4"
            """
            ON: LETTER_EVI
            IF: LETTER_EVI.trigger=2
            DO: LETTER_EVI.trigger=1
            """
        |> rule_______________________ "letter5"
            """
            ON: LETTER_EVI
            IF: LETTER_EVI.trigger=1
            DO: LETTER_EVI.trigger=0
            """
        |> rule_______________________ "letter6"
            """
            ON: LETTER_EVI
            IF: LETTER_EVI.trigger=0
            DO: LETTER_EVI.trigger=5
            """
        |> rule_______________________ "kay, you are"
           """
           ON: POLICEXPHONE
           IF: POLICEXPHONE.day6.trigger=1
           DO: POLICEXPHONEANSWER1.day6.choices=1
           """
        |> rule_______________________ "what trouble--daniel"
           """
           ON: POLICEXPHONEANSWER1
           DO: POLICEXPHONEANSWER1.day6.choices=0
               POLICEXPHONEANSWER2.day6.choices=1
           """
        |> rule_______________________ "no the evidence--ha who"
           """
           ON: POLICEXPHONEANSWER2
           DO: POLICEXPHONEANSWER2.day6.choices=0
               POLICEXPHONEANSWER3.day6.choices=1
           """
        |> rule_______________________ "sound--kay, you are"
           """
           ON: POLICEXPHONEANSWER3
           DO: POLICEXPHONEANSWER3.day6.choices=0
               POLICEXPHONEANSWER4.day6.choices=1
           """
        |> rule_______________________ "go to city council"
           """
           ON: POLICEXPHONEANSWER4
           DO: POLICEXPHONEANSWER4.day6.choices=-1
               POLICEXPHONE.day6.trigger=0
           """
        |> rule_______________________ "court1"
           """
           ON: COURT
           IF: COURT.day6.trigger=1
           DO: COURTANSWER1.day6.choices=1
           """
        |> rule_______________________ "court2"
           """
           ON: COURTANSWER1
           DO: COURTANSWER1.day6.choices=0
               COURT.trigger=2
           """
        |> rule_______________________ "court3"
           """
           ON: COURT
           IF: COURT.trigger=2
           DO: COURTANSWER2.day6.choices=1
           """
        |> rule_______________________ "court4"
           """
           ON: COURTANSWER2
           DO: COURTANSWER2.day6.choices=0
               COURT.trigger=3
           """
        |> rule_______________________ "court5"
                   """
                   ON: COURT
                   IF: COURT.trigger=3
                   DO: COURTANSWER3.day6.choices=1
                   """
        |> rule_______________________ "court6"
                   """
                   ON: COURTANSWER3
                   DO: COURTANSWER3.day6.choices=0
                       COURT.trigger=4
                   """
        |> rule_______________________ "court7"
                   """
                   ON: COURT
                   IF: COURT.trigger=4
                   DO: COURTANSWER4.day6.choices=1
                   """
        |> rule_______________________ "court8"
                   """
                   ON: COURTANSWER4
                   DO: COURTANSWER4.day6.choices=0
                       COURT.trigger=5
                   """
        |> rule_______________________ "court9"
                   """
                   ON: COURT
                   IF: COURT.trigger=5
                   DO: COURTANSWER5.day6.choices=1
                   """
        |> rule_______________________ "court10"
                   """
                   ON: COURTANSWER5
                   DO: COURTANSWER5.day6.choices=0
                       COURT.trigger=6
                   """
        |> rule_______________________ "court11"
                   """
                   ON: COURT
                   IF: COURT.trigger=6
                   DO: COURTANSWER6.day6.choices=1
                   """
        |> rule_______________________ "court12"
                   """
                   ON: COURTANSWER6
                   DO: COURTANSWER6.day6.choices=0
                       COURT.trigger=7
                   """
        |> rule_______________________ "court13"
                   """
                   ON: COURT
                   IF: COURT.trigger=7
                   DO: COURTANSWER7.day6.choices=1
                   """
        |> rule_______________________ "court14"
                   """
                   ON: COURTANSWER7
                   DO: COURTANSWER7.day6.choices=0
                       COURT.trigger=8
                   """
        |> rule_______________________ "court15"
                   """
                   ON: COURT
                   IF: COURT.trigger=8
                   DO: COURTANSWER8.day6.choices=1
                   """
        |> rule_______________________ "court16"
            """
            ON: COURTANSWER8
            DO: COURTANSWER8.choices=-1
            """
        |> rule_______________________ "key1"
            """
            ON: HAVING_KEY
            IF: HAVING_KEY.trigger=1
            DO: KEY_RESP.choices=1
            """
        |> rule_______________________ "key2"
            """
            ON: KEY_RESP
            DO: KEY_RESP.choices=0
                HAVING_KEY.trigger=0
            """
        |> rule_______________________ "key3"
            """
            ON: HAVING_KEY
            IF: HAVING_KEY.trigger=0
            DO: KEY_END.choices=1
            """
        |> rule_______________________ "key4"
            """
            ON: KEY_END
            DO: KEY_END.choices=-1
            """
        |> rule_______________________ "fake1"
            """
            ON: HAVING_FAKE
            IF: HAVING_FAKE.trigger=1
            DO: FAKE_RESP.choices=1
            """
        |> rule_______________________ "fake2"
            """
            ON: FAKE_RESP
            DO: FAKE_RESP.choices=0
                HAVING_FAKE.trigger=0
            """
        |> rule_______________________ "fake3"
            """
            ON: HAVING_FAKE
            IF: HAVING_FAKE.trigger=0
            DO: FAKE_END.choices=1
            """
        |> rule_______________________ "fake4"
            """
            ON: FAKE_END
            DO: FAKE_END.choices=-1
            """

        |> rule_______________________ "leave1"
            """
            ON: GOOD_COURT
            IF: GOOD_COURT.trigger=1
            DO: NOCAUGHT_RESP.choices=1
            """
        |> rule_______________________ "leave2"
            """
            ON: NOCAUGHT_RESP
            DO: NOCAUGHT_RESP.choices=0
                GOOD_COURT.trigger=0
            """
        |> rule_______________________ "leave3"
            """
            ON: GOOD_COURT
            IF: GOOD_COURT.trigger=0
            DO: NOCAUGHT_GO.choices=1
            """
        |> rule_______________________ "leave4"
            """
            ON: NOCAUGHT_GO
            DO: NOCAUGHT_GO.choices=-1
            """
        |> rule_______________________ "phone c1"
            """
            ON: PHONE_DAY7
            IF: PHONE_DAY7.trigger=0
            DO: PHONE_ANS1.choices=1
            """
        |> rule_______________________ "phone c2"
            """
            ON: PHONE_ANS1
            DO: PHONE_ANS1.choices=0
                PHONE_DAY7.trigger=1
            """
        |> rule_______________________ "phone c3"
            """
            ON: PHONE_DAY7
            IF: PHONE_DAY7.trigger=1
            DO: PHONE_ANS2.choices=1
            """
        |> rule_______________________ "phone c4"
            """
            ON: PHONE_ANS2
            DO: PHONE_ANS2.choices=0
                PHONE_DAY7.trigger=2
            """
        |> rule_______________________ "phone c5"
            """
            ON: PHONE_DAY7
            IF: PHONE_DAY7.trigger=2
            DO: PHONE_ANS3.choices=1
            """
        |> rule_______________________ "phone c6"
            """
            ON: PHONE_ANS3
            DO: PHONE_ANS3.choices=0
                PHONE_DAY7.trigger=3
            """
        |> rule_______________________ "wait_1"
            """
            ON: PHONE_DAY7
            IF: PHONE_DAY7.trigger=3
            DO: PHONE_ANS4.choices=1
            """
        |> rule_______________________ "wait_2"
            """
            ON: PHONE_ANS4
            DO: PHONE_ANS4.choices=0
                PHONE_DAY7.trigger=4
            """
        |> rule_______________________ "waiting1"
            """
            ON: PHONE_DAY7.trigger=4
            DO: PHONE_DAY7.trigger=5
            """
        |> rule_______________________ "waiting2"
            """
            ON: PHONE_DAY7.trigger=5
            DO: PHONE_DAY7.trigger=6
            """
        |> rule_______________________ "waiting3"
            """
            ON: PHONE_DAY7.trigger=6
            DO: PHONE_DAY7.trigger=7
            """
        |> rule_______________________ "lock1"
            """
            ON: LOCK
            IF: LOCK.trigger=0
            DO: PASSWORD1.choices=1
                PASSWORD2.choices=1
                PASSWORD3.choices=1
                PASSWORD4.choices=1
            """
        |> rule_______________________ "right1"
            """
            ON: PASSWORD2
            DO: PASSWORD1.choices=0
                PASSWORD2.choices=-1
                PASSWORD3.choices=0
                PASSWORD4.choices=0
            """
        |> rule_______________________ "wrong1"
            """
            ON: PASSWORD1
            DO: PASSWORD1.choices=-1
                PASSWORD2.choices=0
                PASSWORD3.choices=0
                PASSWORD4.choices=0
            """
        |> rule_______________________ "wrong2"
            """
            ON: PASSWORD3
            DO: PASSWORD1.choices=0
                PASSWORD2.choices=0
                PASSWORD3.choices=-1
                PASSWORD4.choices=0
            """
        |> rule_______________________ "wrong3"
            """
            ON: PASSWORD4
            DO: PASSWORD1.choices=0
                PASSWORD2.choices=0
                PASSWORD3.choices=0
                PASSWORD4.choices=-1
            """
        |> rule_______________________ "closet day7"
            """
            ON: CLOSET_7
            IF: CLOSET_7.trigger=1
            DO: CLOSET_7.trigger=0.choices=-1
            """
        |> rule_______________________ "table day7"
            """
            ON: TABLE_7
            IF: TABLE_7.trigger=1
            DO: TABLE_7.trigger=0.choices=-1
            """
        |> rule_______________________ "bank2_1"
            """
            ON: BANK2
            IF: BANK2.trigger=0
            DO: BANK2.trigger=1
            """
        |> rule_______________________ "bank2_2"
            """
            ON: BANK2
            IF: BANK2.trigger=1
            DO: BANK2.trigger=2
            """
        |> rule_______________________ "bank2_3"
            """
            ON: BANK2
            IF: BANK2.trigger=2
            DO: BANK2.trigger=0
            """
        |> rule_______________________ "plan1"
            """
            ON: PLAN
            IF: PLAN.trigger=0
            DO: PLAN.trigger=1
            """
        |> rule_______________________ "plan2"
            """
            ON: PLAN
            IF: PLAN.trigger=1
            DO: PLAN.trigger=2
            """
        |> rule_______________________ "plan3"
            """
            ON: PLAN
            IF: PLAN.trigger=2
            DO: PLAN.trigger=3
            """
        |> rule_______________________ "plan4"
            """
            ON: PLAN
            IF: PLAN.trigger=3
            DO: PLAN.trigger=0
            """
        |> rule_______________________ "custom1"
            """
            ON: CUSTOM
            IF: CUSTOM.trigger=0
            DO: CUSTOM.trigger=1
            """
        |> rule_______________________ "custom2"
            """
            ON: CUSTOM
            IF: CUSTOM.trigger=1
            DO: CUSTOM.trigger=2
            """
        |> rule_______________________ "custom3"
            """
            ON: CUSTOM
            IF: CUSTOM.trigger=2
            DO: CUSTOM.trigger=3
            """
        |> rule_______________________ "custom4"
            """
            ON: CUSTOM
            IF: CUSTOM.trigger=3
            DO: CUSTOM.trigger=4
            """
        |> rule_______________________ "custom5"
            """
            ON: CUSTOM
            IF: CUSTOM.trigger=4
            DO: CUSTOM.trigger=5
            """
        |> rule_______________________ "custom6"
            """
            ON: CUSTOM
            IF: CUSTOM.trigger=5
            DO: CUSTOM.trigger=0
            """
        |> rule_______________________ "lee7_1"
            """
            ON: LEE7
            IF: LEE7.trigger=0
            DO: LEEANS1.choices=1
            """
        |> rule_______________________ "lee7_2"
            """
            ON: LEEANS1
            DO: LEE7.trigger=1
                LEEANS1.choices=0
            """
        |> rule_______________________ "lee7_3"
            """
            ON: LEE7
            IF: LEE7.trigger=1
            DO: LEEANS2.choices=1
            """
        |> rule_______________________ "lee7_4"
            """
            ON: LEEANS2
            DO: LEE7.trigger=2
                LEEANS2.choices=0
            """
        |> rule_______________________ "lee7_5"
            """
            ON: LEE7
            IF: LEE7.trigger=2
            DO: LEEANS3.choices=1
            """
        |> rule_______________________ "lee7_6"
            """
            ON: LEEANS3
            DO: LEE7.trigger=3
                LEEANS3.choices=0
            """
        |> rule_______________________ "lee7_7"
            """
            ON: LEE7
            IF: LEE7.trigger=3
            DO: LEEANS4.choices=1
            """
        |> rule_______________________ "lee7_8"
            """
            ON: LEEANS4
            DO: LEE7.trigger=4
                LEEANS4.choices=0
            """
        |> rule_______________________ "lee7_9"
            """
            ON: LEE7
            IF: LEE7.trigger=4
            DO: LEEANS5.choices=1
            """
        |> rule_______________________ "lee7_10"
            """
            ON: LEEANS5
            DO: LEE7.trigger=5
                LEEANS5.choices=-1
            """
        |> rule_______________________ "home8_1"
            """
            ON: SOUND
            IF: SOUND.trigger=0
            DO: GO_COURT.choices=1
            """
        |> rule_______________________ "home8_2"
            """
            ON: GO_COURT
            DO: GO_COURT.choices=-1
                SOUND.trigger=1
            """
        |> rule_______________________ "court8_1"
            """
            ON: COURT8
            IF: COURT8.trigger=0
            DO: BANKACC_CARD8.choices=1
            """
        |> rule_______________________ "court8_2"
            """
            ON: BANKACC_CARD8
            DO: BANKACC_CARD8.choices=-1
                COURT8.trigger=1
            """
        |> rule_______________________ "court8_3"
            """
            ON: COURT8
            IF: COURT8.trigger=1
            DO: PAPER8.choices=1
            """
        |> rule_______________________ "court8_4"
            """
            ON: PAPER8
            DO: PAPER8.choices=-1
                COURT8.trigger=2
            """
        |> rule_______________________ "court8_5"
            """
            ON: COURT8
            IF: COURT8.trigger=2
            DO: LETTER8.choices=1
            """
        |> rule_______________________ "court8_6"
            """
            ON: LETTER8
            DO: COURT8.trigger=3
                LETTER8.choices=-1
            """
        |> rule_______________________ "court8_7"
            """
            ON: COURT8
            IF: COURT8.trigger=3
            DO: LETTER8_.choices=1
            """
        |> rule_______________________ "court8_8"
            """
            ON: LETTER8_
            DO: LETTER8_.choices=-1
                COURT8.trigger=4
            """
        |> rule_______________________ "court8_9"
            """
            ON: COURT8
            IF: COURT8.trigger=4
            DO: MEMCARD8.choices=1
            """
        |> rule_______________________ "court8_10"
            """
            ON: MEMCARD8
            DO: MEMCARD8.choices=-1
                COURT8.trigger=5
            """
        |> rule_______________________ "court8_11"
            """
            ON: COURT8
            IF: COURT8.trigger=5
            DO: CONTRACT8.choices=1
            """
        |> rule_______________________ "court8_12"
            """
            ON: CONTRACT8
            DO: CONTRACT8.choices=-1
                COURT8.trigger=10
            """
        |> rule_______________________ "court8_add1"
            """
            ON: COURT8
            IF: COURT8.trigger=10
            DO: CALL_LEE.choices=1
            """
        |> rule_______________________ "court8_13"
            """
            ON: CALL_LEE
            DO: CALL_LEE.choices=-1
                COURT8.trigger=11
            """
        |> rule_______________________ "court8_add2"
            """
            ON: COURT8
            IF: COURT8.trigger=11
            DO: BANKACC2_8.choices=1
            """
        |> rule_______________________ "court8_14"
            """
            ON: BANKACC2_8
            DO: BANKACC2_8.choices=-1
                COURT8.trigger=6
            """
        |> rule_______________________ "court8_15"
            """
            ON: COURT8
            IF: COURT8.trigger=6
            DO: SUB_DOCUMENT8.choices=1
                SUB_PLAN8.choices=1
                SUB_CARD_ACC8.choices=1
            """
        |> rule_______________________ "sub_doc"
            """
            ON: SUB_DOCUMENT8
            DO: SUB_DOCUMENT8.choices=-1
            """
        |> rule_______________________ "sub_plan"
            """
            ON: SUB_PLAN8
            DO: SUB_PLAN8.choices=-1
            """
        |> rule_______________________ "sub_bank"
            """
            ON: SUB_CARD_ACC8
            DO: SUB_CARD_ACC8.choices=-1
            """
        |> rule_______________________ "court_final"
            """
            ON: COURT8
            IF: SUB_DOCUMENT8.choices=-1
                SUB_PLAN8.choices=-1
                SUB_CARD_ACC8.choices=-1
                COURT8.trigger=6
            DO: LEAVE8.choices=1
            """
        |> rule_______________________ "win_leave"
            """
            ON: LEAVE8
            DO: LEAVE8.choices=-1
                COURT8.trigger=7
            """
        |> rule_______________________ "fail8_1"
            """
            ON: COURT_FAIL
            IF: COURT_FAIL.trigger=0
            DO: LEAVE8_F.choices=1
            """
        |> rule_______________________ "fail8_2"
            """
            ON: LEAVE8_F
            DO: LEAVE8_F.choices=-1
                COURT_FAIL.trigger=1
            """
        |> rule_______________________ "mind1"
            """
            ON: MIND
            IF: MIND.trigger=0
            DO: FEEL.choices=1
            """
        |> rule_______________________ "mind2"
            """
            ON: FEEL
            DO: FEEL.choices=0
                LOOK_NEWS.choices=1
            """
        |> rule_______________________ "mind3"
            """
            ON: LOOK_NEWS
            DO: LOOK_NEWS.choices=0
                WHISPER.choices=1
            """
        |> rule_______________________ "mind4"
            """
            ON: WHISPER
            DO: WHISPER.choices=0
                TP_STREET.choices=1
            """
        |> rule_______________________ "mind5"
            """
            ON: TP_STREET
            DO: MIND.trigger=1
                TP_STREET.choices=-1
            """
        |> rule_______________________ "street1"
            """
            ON: STREET
            IF: STREET.trigger=0
            DO: SHOOT1.choices=1
                WAIT1.choices=1
            """
        |> rule_______________________ "shoot1"
            """
            ON: SHOOT1
            DO: SHOOT1.choices=-1
                WAIT1.choices=0
            """
        |> rule_______________________ "wait1"
            """
            ON: WAIT1
            DO: SHOOT1.choices=0
                WAIT1.choices=-1
                STREET.trigger=1
            """
        |> rule_______________________ "street2"
            """
            ON: STREET
            IF: STREET.trigger=1
            DO: SHOOT2.choices=1
                WAIT2.choices=1
            """
        |> rule_______________________ "shoot2"
            """
            ON: SHOOT2
            DO: SHOOT2.choices=-1
                WAIT2.choices=0
            """
        |> rule_______________________ "wait2"
            """
            ON: WAIT2
            DO: SHOOT2.choices=0
                WAIT2.choices=-1
                STREET.trigger=2
            """
        |> rule_______________________ "street3"
            """
            ON: STREET
            IF: STREET.trigger=2
            DO: SHOOT3.choices=1
                WAIT3.choices=1
            """
        |> rule_______________________ "shoot3"
            """
            ON: SHOOT3
            DO: SHOOT3.choices=-1
                WAIT3.choices=0
            """
        |> rule_______________________ "wait3"
            """
            ON: WAIT3
            DO: WAIT3.choices=-1
                SHOOT3.choices=0
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
            "Hahaha, still caught in a memory lost, ain't you? Never mind. A living stupid Kay is always better than a dead clever Kay! ……It's that missing reporter Yuuki. You have seen this reporter before; he had come to office to find you on the day that you were seriously injured in the car accident."
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
            "You took the disk. Somehow a feeling comes up in your brain: you know the code of this hard disk."
        |> content__________________________________ "take note"
            "A plain note with some text on it... No time to see what's on that."
        |> content__________________________________ "lee explain suicide"
            "Ugh, Jonathon said that according to the report of the autopsy, it can be judged as a suicide accident with no advanced evidence."
        |> content__________________________________ "lee explain jonathan"
            "Nope. You also forgot Jonathon's rule after that accident, huh? Each time a case is considered as solved by him, all relative evidence will be locked. Don't, challenge, Jonathon's, authority. And the stabbed-death, well, maybe just the Identification guys found out heroine in his body? Never understand poor guys like him. "
        |> content__________________________________ "not suicide"
            "What? Why someone will carry out suicide in such a cruel way? And why the conclusion is made so hurriedly? Can I have a look at the report of the autopsy?"
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
            "You don't know why you input the correct password without much thinking. The computer read: \"Owner confirmed. Reporter Yuuki.\""
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
            "Reveal of the darkness of our city\nReporter: Yuuki"
        |> content__________________________________ "our city"
            "Our city, or in other words, the city of criminal, is known for the increasing rate of criminals in recent years. The reason behind this is because of our master of the police office Jonathon. Thanks to the evidence provided by anonymous police, a light can be shed through the darkness of our city."
        |> content__________________________________ "jonathon keeps"
            "Jonathon keeps an abnormal relationship with many people including both women and men.\nJonathon receives bribes from the owner of the biggest nightclub \"Paradise\" in our city and provides protection for it to help it become large overnight.\nJonathon has a secret personal police team which helps him."
        |> content__________________________________ "what it is highly"
            "What, it is highly similar to the plot in my novel ...... And that dream...... That is to say, I'm not a novelist, I should be the reporter?"
        |> content__________________________________ "description"
            "The pills are in a small bottle, on which a tag saying \"Διόνυσος\", the next line is \"PARADISE Co.Ltd\".You have learned some Greek letters: that is \"Dionysus\", the god of wine."
        |> content__________________________________ "greek letters"
            "Maybe pills used for indulge people into joy, sold by Paradise...? An idea of investing Paradise again as a customer come up in your mind. By taking those pills, maybe you can get adapted in that environment then investigate smoothly...?"
        |> content__________________________________ "take the pills"
            "You were thinking you've made a great decision until the scene before your eyes start to blur and distort. You struggle to induce vomiting, but it's too late."
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
            "[Bad End: Meaningless Lie] Jonathon just nodded. After that, nothing important happened. The whole world had been in peace until the day you were knock over on the street..."
        |> content__________________________________ "tell truth"
            "Sir, as you may have known that the woman has a brother Daniel, and I have just talked to him about this case yet. And he told me that he guessed his sister's carelessly intake of too much drug may contribute to her death and this can be supported by the report of the autopsy."
        |> content__________________________________ "jonathon's reply to truth"
            "But you know that it's just one version of explanations. An advice for you is to go to inspect his home today. According to my report, Daniel won't be home today. Go, now."
        |> content__________________________________ "fake memory card"
            "You find a memory card, seems used on cameras."
        |> content__________________________________ "key jonathon"
            "You find a key stuck into the keyhole, seems to be forcibly inserted. You pull it out. It took a lot of effort..."
        |> content__________________________________ "bank daniel"
            "Here is a bank account statement."
        |> content__________________________________ "paper daniel"
            "You found a piece of paper in the drawer of the cabinet. With the first line written, Jonathon, the chief police of this city."
        |> content__________________________________ "jonathon ask your opinion"
            "So, Kay, what's your opinion towards this case?"
        |> content__________________________________ "sir, i dont find"
            "Sir, I don't find other extra useful information in Daniel's home and I think it is just an accident."
        |> content__________________________________ "alright, I agree with"
            "Alright, I agree with you. Investigating two cases in a row must be a great work for you as you just recover from the accident. You can have a two-day rest. Have a good rest at home. Bye."
        |> content__________________________________ "sir, I think this case is quite weird"
            "Sir, I think this case is quite weird that as you can see in the report of the autopsy, the \"medicine\" cannot be analyzed by us. How can a weak woman afford to purchase such mysterious medicine by herself after buying a new department? Or in other words, the one who supports her to purchase the medicine is the murderer."
        |> content__________________________________ "interesting, kay"
            "Interesting, Kay. And who do you think will be the murderer?"
        |> content__________________________________ "ha my dear master"
            "Ha, my dear master. All evidence points to you. Your car appeared the night Ann dead. You told me to inspect the Paradise the day I happened to be enrolled in a car accident. You are the regular customer of that nightclub, or in other words, Ann. Besides, I have other evidence to show your crime. The dark in our city, Jonathon."
        |> content__________________________________ "You are still so naive."
            "Ha, Kay. You are still so naive. Ok, you can leave now. I'm looking forward to your performance.\n"
        |> content__________________________________ "I think the owner of"
            "I think the owner of the nightclub is most possible as he knows a lot about Ann and he is most possible to provide weird medicine to Ann to achieve a better business effect. And this can explain why paradise becomes the best nightclub in our city overnight."
        |> content__________________________________ "crazy assumption"
            "Crazy assumption, Kay. To support your investigation, I will give you seven-day rest to search for clues in Paradise. You should go there every day in the next week. Oh, this is a VIP card of Paradise. En--joy--yourself, Kay."
        |> content__________________________________ "input code for true"
            "A memory card used for cameras. You linked it onto your computer, but somehow it requires password."
        |> content__________________________________ "first three lines"
            "Two months ago. 150000 from Ann\nOne month ago. 3000 from government relief\nOne month ago 100000 to John's Renting Company"
        |> content__________________________________ "jonathon, the chief police"
            "Name: Jonathon, the chief police of this city"
        |> content__________________________________ "instead of a mere customer"
            "Instead of a mere customer, he is my chosen one, the one who is destined to break and reconstruct my life.\nHe loves the effect of pill named \"Paradise\" produced by the owner of Paradise."
        |> content__________________________________ "first kay photo"
            "Kay's standing outside the Daniel's department. [shot on July 10th]"
        |> content__________________________________ "second kay photo"
            "Kay's photo of eating the dinner near Daniel's department. [shot on July 10th]"
        |> content__________________________________ "last kay photo"
            "Kay's getting inside Daniel's department. [shot on July 11th]"
        |> content__________________________________ "sir do you want fun"
            "Welcome to Paradise, Sir~~!! Do you come for fun tonight?"
        |> content__________________________________ "yes-you spend"
            "You are totally exhausted now. You spend your night in the nightclub to experience why Paradise is favored by so many officials..."
        |> content__________________________________ "no-please leave"
            "Em, Sir. Tonight is the night for joy here. If you don't have much interest, please leave."
        |> content__________________________________ "yes ending"
            "Sir, isn't our service extraordinarily fantastic?"
        |> content__________________________________ "no ending"
            "Sir, please leave here, since you seem not interested in our services...?"
        |> content__________________________________ "give two choices"
            "The park is in darkness this night. And you see a crowd wearing weird uniforms are wandering. Do you still want to enter? Hint: Police is not allowed to be equipped with a gun during vacation."
        |> content__________________________________ "still move"
            "The moment you enter the park, they turn back and stare at you immediately. You can feel a strange and aggressive atmosphere is spreading in the park. You want to take out your weapon but you suddenly remember that your gun was left in the office because of vacation."
        |> content__________________________________ "escape-you try to"
            "You try to escape but a familiar voice sound. It's Jonathon."
        |> content__________________________________ "hear-bad end"
            "My dear Kay, it seems that I have done a lot of useless work before. It never occurs to me that you will be so easy to deal with as you have been acting wisely until last month. Goodbye."
        |> content__________________________________ "exit"
            "You're finding the road to exit the park anxiously..."
        |> content__________________________________ "find in jonathon closet"
            "You open the cabinet door, and search thoroughly. You found a few documents and a letter."
        |> content__________________________________ "find in jonathon table"
            "You take the bank card and the dagger from Jonathon's table."
        |> content__________________________________ "dagger 1 description"
            "A dagger with weird letters on it. It seems that it is part of some couple souvenir as it seems that letters on it are only part of some complete patterns."
        |> content__________________________________ "dagger 2 description"
            "A dagger with weird letters on it. It seems that it is part of some couple souvenir."
        |> content__________________________________ "dagger 1 code"
            "It seems that another dagger can be put together with this one...?"
        |> content__________________________________ "dagger 2 code"
            "It seems that another dagger can be put together with this one...?"
        |> content__________________________________ "dagger 1 put together"
            "You put them together! You can now recognize the characters above: that is \"ASWN\"."
        |> content__________________________________ "dagger 2 put together"
            "You put them together! You can now recognize the characters above: that is \"ASWN\"."
        |> content__________________________________ "several documents with"
            "Several documents with the following titles:"
        |> content__________________________________ "letter1"
            "A letter from Daniel\nDear Captain Jonathon:\nPlease stop your continuous inspection on us. I have been fired by five companies in the last months. I will tell you everything I know about my sister to you."
        |> content__________________________________ "letter2"
            "You may not know the endings of my sister's ex-boyfriend. He was obsessed with the joy in the night club and spent all his money and my sister's money on one girl in the night club. As a result, my sister hates the night club a lot. But due to the economic pressure, she has no choice but to work here. But she always dislikes people there."
        |> content__________________________________ "letter3"
            "It's you that change her opinion towards night club customers. The first time she meets you, she didn't know your identity and behaved in a rude manner. You didn't behave angrily but comfort her kindly. You behaved in a gentle manner to her. And that's why she is willing to have a trial on the \"Paradise\" for you as you love it a lot."
        |> content__________________________________ "letter4"
            "But she happened to see your trade with the owner of Paradise. That night, she rushed home and said to me \"Daniel, Stallworth received the bribe from the bad boss. It will cause a lot of trouble for him if he was caught by the city council\". How she cares about you!"
        |> content__________________________________ "letter5"
            "Even after she knows that you dream of being the darkness of our city, she still loves you and decides to turn you back to the light. So she filmed your trade with the owner of Paradise, your secret training of an armed team with the hope of threatening you back. How stupid she is?"
        |> content__________________________________ "letter6"
            "I know you have seen the photos through some media before. I will give you the memory card of those photos to you. Just forgive my sister.\n -- Daniel"
        |> content__________________________________ "kay, you are"
            "kay, you are in great trouble!"
        |> content__________________________________ "what trouble--daniel"
            "Daniel was found dead in his department. And according to the early investigation, you are the most possible murderer. Though I trust you won't do such thing, the evidence doesn't lie, Kay."
        |> content__________________________________ "no the evidence--ha who"
            "Ha, who knows? But thanks to the attention of the city council, this case will be discussed in the city council. I think they are coming to pick you up."
        |> content__________________________________ "sound--kay, you are"
            "Kay, you are accused of killing Mr. Daniel. The city council is calling you to receive an inquiry to roughly decide whether you should be responsible for that. And we will hold an inspection of your home."
        |> content__________________________________ "go to city council"
            "[Speaker] Welcome the arrival of the protagonist of today. Kay, you are accused of killing Daniel. Do you want to say anything first?"
        |> content__________________________________ "court1"
            "[Speaker] Welcome the arrival of the protagonist of today. Kay, you are accused of killing Daniel. Do you want to say anything first?"
        |> content__________________________________ "court2"
            "..."
        |> content__________________________________ "court3"
            "[Speaker] Okay, you are allowed to keep silent. And now, it goes into the inquiry part. Welcome the police to show their evidence."
        |> content__________________________________ "court4"
            "..."
        |> content__________________________________ "court5"
             "[Police] First, Jonathon assigned you to solve the case of the death of Ann, Daniel's sister. This case is reporting as solved without any evidence and now Daniel is died, too. You are the most suspicious one."
        |> content__________________________________ "court6"
             "But it only proves contiguity, right? Contiguity cannot derive to causation, right?"
        |> content__________________________________ "court7"
             "[Police] Well. Among the police who have investigated this case, only you were on vacation during the day that Daniel was killed. It provided him with conditions to carry out the case."
        |> content__________________________________ "court8"
             "But it was an arranged vacation plan by Jonathon"
        |> content__________________________________ "court9"
             "[Police] You were not at home that night. Is it right?"
        |> content__________________________________ "court10"
             "...Yes. I was not at home."
        |> content__________________________________ "court11"
             "[Police] And according to the report of the autopsy, Daniel died about the night of your first vacation day. Do you have any explanation for your action that night?"
        |> content__________________________________ "court12"
             "I went out for some personal affairs. But I did not go there."
        |> content__________________________________ "court13"
             "[Police] But the monitoring cameras at that region happen to be disconnected. It's quite interesting, right?"
        |> content__________________________________ "court14"
             "But you have no evidence to show that I have gone there, too! Right?"
        |> content__________________________________ "court15"
             "[Speaker] Sorry for interrupting. Time for the inquiry has been out. Here goes to the time for material evidence."
        |> content__________________________________ "court16"
            "..."
        |> content__________________________________ "key1"
            "[Police] One key for Daniel's home is found in Kay's Home. Why inspecting a home requires key? Or you want to do something else?"
        |> content__________________________________ "key2"
            "But, wait, that's not the case! That key is just inserted into one side-door in Daniel's room, it is strange so I took it as an..."
        |> content__________________________________ "key3"
            "[Speaker] Silence! It's enough to judge you as \"strongly suspicious\". According to the law, you should stay in prison before further investigation."
        |> content__________________________________ "key4"
            "..."
        |> content__________________________________ "fake1"
            "[Police] One memory card is found in Kay's Home. The content of it is photos of Kay's investigating around Daniel's house filmed by the monitoring cameras."
        |> content__________________________________ "fake2"
            "But, wait, that's not the case! I was sent by Jonathon there to investigate, that is just the evidence for Ann's case!..."
        |> content__________________________________ "fake3"
            "[Speaker] Silence! More likely to be for *your* case. It's enough to judge you as \"strongly suspicious\". According to the law, you should stay in prison before further investigation."
        |> content__________________________________ "fake4"
            "..."
        |> content__________________________________ "leave1"
            "[Police] Sorry, Sir Speaker. We haven't found any material evidence yet."
        |> content__________________________________ "leave2"
            "..."
        |> content__________________________________ "leave3"
            "[Speaker] Well. Then according to our law, Kay can only be viewed as \"slightly suspicious\". He will remain free until you can prove the causation instead of contiguity. You can go home now, Kay."
        |> content__________________________________ "leave4"
            "..."
        |> content__________________________________ "phone c1"
            "This is the city council. What can I do for you?"
        |> content__________________________________ "phone c2"
            "I, Kay, want to report the master of our police office Jonathon for scandal and murder."
        |> content__________________________________ "phone c3"
            "Kay? You are the \"slightly suspicious\" people. Do you have enough evidence to support your tip-off? Or otherwise, you will be sent to jail directly."
        |> content__________________________________ "phone c4"
            "Yeah, I'm sure."
        |> content__________________________________ "phone c5"
            "Okay, an inquiry regarding your tip-off will be held tomorrow. Please be well prepared."
        |> content__________________________________ "phone c6"
            "Okay. Thank you."
        |> content__________________________________ "wait_1"
            "Hmm, there exists some critical evidence loss. Maybe tonight I should pay another visit to Jonathan's office."
        |> content__________________________________ "wait_2"
            "You are waiting until night. Press X to play the most popular video game *Exocist: Haunted Gifts* to kill time. "
        |> content__________________________________ "waiting1"
            "Playing..."
        |> content__________________________________ "waiting2"
            "Playing......"
        |> content__________________________________ "waiting3"
            "It's night now. The game is afoot!"
        |> content__________________________________ "lock1"
            "The third floor is locked. A password is needed to unlock. Hint: Think about Jonathon's love with Ann."
        |> content__________________________________ "right1"
            "The door opens."
        |> content__________________________________ "wrong1"
            "The alarm rang. And an armed team came to the police office."
        |> content__________________________________ "wrong2"
            "The alarm rang. And an armed team came to the police office."
        |> content__________________________________ "wrong3"
            "The alarm rang. And an armed team came to the police office."
        |> content__________________________________ "closet day7"
            "You find lots of paper documents, including a bank account statement, a plan document and a custom contract. You put them into your bag."
        |> content__________________________________ "table day7"
            "You find another bottle of pills on Jonathon's desk."
        |> content__________________________________ "bank2_1"
            "BANK CARD NUMBER 1000001"
        |> content__________________________________ "bank2_2"
            "Three weeks ago. 150000 To Ann\nTwo weeks ago. 10000000 To Daniel\nTen days ago. 60000 To Weapon maker"
        |> content__________________________________ "bank2_3"
            "One week ago. 500000 To Aurora Pharmaceutical Company\nOne week ago. 200000 To Paradise Night Club"
        |> content__________________________________ "plan1"
            "--TOP SECRET--\nRoad to Darkness"
        |> content__________________________________ "plan2"
            "Become the leader police of city police office ☑\nOwn or support a night club in CBD area ☑\nEdit the law of medicine custom ☑"
        |> content__________________________________ "plan3"
            "Make night club as the main entertainment option in the city ☑\nMake the night club as the biggest night club ☑\nOwn an armed personal troop ☑"
        |> content__________________________________ "plan4"
            "Become the speaker of the city council □\nBecome the owner of the city □\nBecome *the Darkness* □"
        |> content__________________________________ "custom1"
            "Contract of custom \"food\"\nThe Buyer: Stallworth\nBank Card Number: 1000001\nThe Seller: Aurora Pharmaceutical Company"
        |> content__________________________________ "custom2"
            "Content and reason for customization:\nBased on the Paradise pill, add customized chemical elements to optimize the power of analyzing equipment of the police office."
        |> content__________________________________ "custom3"
            "Feature of the customized elements added:\nCannot be analyzed by current analyzing equipment of the police office\nHave same appearance and similar physical properties as Paradise"
        |> content__________________________________ "custom4"
            "Warning:\nAdded elements can be toxic, buyer should obey the local law of customing medicine and strictly obey the reason for customization."
        |> content__________________________________ "custom5"
            "Price: \n350000 For customization; 100000 For tax;\n30000 For product; 15000 For secret-keeping;\n5000 For service"
        |> content__________________________________ "custom6"
            "Signature:\nBuyer: Jonathon\nSeller: Aurora Pharmaceutical Company"
        |> content__________________________________ "lee7_1"
            "Hey, Kay. Jonathon told me to inspect you. Where did you go tonight?"
        |> content__________________________________ "lee7_2"
            "I'm collecting evidence to report Jonathon's crime to the city council."
        |> content__________________________________ "lee7_3"
            "Are you crazy, Kay? Why do you keep fighting against Jonathan? You know that makes no sense!"
        |> content__________________________________ "lee7_4"
            "Ha, it's my mission. My rebirth is just for completing the remaining mission."
        |> content__________________________________ "lee7_5"
            "What are you saying, Kay? You know that Jonathon will sooner or later be the speaker of the city council and then become the owner of the city gradually."
        |> content__________________________________ "lee7_6"
            "It's the last chance for us to defend the slim light of our city. This city should belong to everyone living here not the group of some people or even one person. Can you do me a favor?"
        |> content__________________________________ "lee7_7"
            "(Long time thinking... sigh) Okay. Hey, listen, bro. In fact I felt Jonathon weird as well, but I just...I just dare not to fight against him. This time I will stand by your side and do my best. What can I do?"
        |> content__________________________________ "lee7_8"
            "Can you kindly compare these two kinds of pills? And report them to the Speaker in tomorrow's inquiry?"
        |> content__________________________________ "lee7_9"
            "You even apply for an inquiry tomorrow? Okay, I will analyze them this night. Wish you good luck, Kay."
        |> content__________________________________ "lee7_10"
            "The same to you, Lee, my best brother! (hug)"
        |> content__________________________________ "home8_1"
            "Kay, here is the city council. The hearing of your tip-off on Jonathon's crimes will be held today. City council pays so special attention to your tip-off that special security measures are taken. Please go with us. "
        |> content__________________________________ "home8_2"
            "You go to the city council."
        |> content__________________________________ "court8_1"
            "Citizens, welcome to the hearing on the master of our police office. As this is a special hearing, we will jump to the material evidence showing directly. Your first accusation of Jonathon is that he keeps an abnormal relationship with Ann, a nightclub worker."
        |> content__________________________________ "court8_2"
            "This bank account statement is correspondent to the bank card found in Jonathon's office. From this, you can see that Jonathon does support Daniel and Ann."
        |> content__________________________________ "court8_3"
            "The court is in silence. Everyone is listening to you. \nIt's still your time to present evidence! Press X to show more evidence."
        |> content__________________________________ "court8_4"
            "From this paper written by Ann, we can see that Jonathon does have a special meaning for Ann and he loves the food Paradise."
        |> content__________________________________ "court8_5"
            "The court is in silence. Everyone is listening to you. \nIt's still your time to present evidence! Press X to show more evidence."
        |> content__________________________________ "court8_6"
            "From this letter, the special relationship between Jonathon and Ann can be fully verified. I think up to here, Jonathon's relationship with Ann can be confirmed."
        |> content__________________________________ "court8_7"
            "[Speaker] Based on the material you show, we will consider carefully. Then please show material evidence for your second accusation -- He kills Ann."
        |> content__________________________________ "court8_8"
            "Again, from this letter, we know that due to her love for Jonathon, Ann got into the habit of taking Paradise and tried to stop Jonathon from bad behaviors. But, by threatening Daniel, Jonathon got the memory card."
        |> content__________________________________ "court8_9"
            "The court is in silence. Everyone is listening to you. \nIt's still your time to present evidence! Press X to show more evidence."
        |> content__________________________________ "court8_10"
            "And here, this memory card contains Ann's filming of Jonathon's receiving bribe. This can be the reason for Jonathon's killing."
        |> content__________________________________ "court8_11"
            "[Jonathon] Ha, interesting slander. How can you prove that I kill Ann, my lover, as you say? How can I have the willingness to kill her?"
        |> content__________________________________ "court8_12"
            "Don't be impatient, My dear boss. Here is a contract found in your office. This shows that you customize a special version of Paradise and I want to call my friend."
        |> content__________________________________ "court8_add1"
            "Calling Lee..."
        |> content__________________________________ "court8_13"
            "I'm Lee. This special version does can cheat the analyzing equipment of the police office. But this is a report from Middle Chemistry Lab which shows that the version of Ann's Paradise taking that night added special elements used in war equipment which is also found in the Paradise in your office."
        |> content__________________________________ "court8_add2"
            "The court falls in deathly silence. Everyone is listening to you. \nIt's still your time to present evidence."
        |> content__________________________________ "court8_14"
            "This bank account statement also shows that your trade with Weapon maker, a famous chemical weapon maker. "
        |> content__________________________________ "court8_15"
            "[Speaker] Time for material evidence shown has been due. Now comes to the part that you say that Jonathon is planning to overturn the political order of our city. This causes the high attention of the city council. Please submit your evidence for this part."
        |> content__________________________________ "sub_doc"
            "You submit the documents."
        |> content__________________________________ "sub_plan"
            "You submit plan document."
        |> content__________________________________ "sub_bank"
            "You submit bank card and the bank account statements."
        |> content__________________________________ "court_final"
            "We will inspect them carefully, as Jonathon's former accusation has been judged as highly suspicious by our secret discussion. Jonathon, you have to stay here for some time. For the last accusation, we will inspect in the following days. Here comes the end of the hearing."
        |> content__________________________________ "fail8_1"
            "The speaker does not admit this evidence.\n You start to blame yourself. Why don't you take this evidence together with you? Why don't you examine this evidence thoroughly before?..."
        |> content__________________________________ "fail8_2"
            "You leave the court."
        |> content__________________________________ "win_leave"
            "You leave the court."
        |> content__________________________________ "mind1"
            "That voice comes again..."
        |> content__________________________________ "mind2"
            "You feel a weird obsession haunting you these days…… The whole day, the only thing you are thinking of is killing Jonathon. Besides, you haven’t entered the dream maze for several nights."
        |> content__________________________________ "mind3"
            "Report: Chief Police Jonathon is going to inspect the backstreet area this morning."
        |> content__________________________________ "mind4"
            "Backstreet? The most chaotic area in our city It’s the best chance to kill Jonathan! Yuuki, don’t waste time."
        |> content__________________________________ "mind5"
            "You go to the Backstreet."
        |> content__________________________________ "street1"
            " You see a group of people is walking towards with weapons equipped. But you cannot see where Jonathon is."
        |> content__________________________________ "shoot1"
            "A missing shoot! And the group of people fires in the place you hide at the same time. It’s the gang in this area."
        |> content__________________________________ "wait1"
            "You decide to wait for a while. The group of people disappears in the darkness... "
        |> content__________________________________ "street2"
            "Later, another group of people appears, they wear the uniform of police office."
        |> content__________________________________ "shoot2"
            "A precise shoot! A policeman fell down. But your place is exposed too. The police surround this area quickly and you are captured. It is the patrol of this area..."
        |> content__________________________________ "wait2"
            "They pass through you and you notice that they are patrol of this area. Someone in the patrol tells you that they are clearing the way for the coming of Jonathon."
        |> content__________________________________ "street3"
            "The patrol disappears. One hour later, in the protection of a group of people with deep dark uniform, your target, Jonathon appears."
        |> content__________________________________ "shoot3"
            "You decide to have a sudden attack to get the grasp of the battlefield. But you are too naïve, the well-trained personal troop of Jonathon notice you soon and they let you taste the feel of suppressive fire."
        |> content__________________________________ "wait3"
            "Area clear, Sir. You hear the sounds. And you know that it’s time to attack!"








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