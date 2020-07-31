module NPC exposing (..)
import MapAttr exposing (..)
import Areas exposing (..)
import MapAttr exposing (..)
import Items exposing (..)

type NPCType
    = Bob
    | Lee
    | Allen
    | Adkins
    | Catherine
    | Jonathon
    | JournalistBody
    | JonaliEvi
    | NightBody
    | Phone
    | Phone_Daniel
    | Daniel_People
    | CoffeeMachine
    | Paper
    | Bank
    | Key_Jonathon
    | FakeMemCard
    | Staff
    | Table
    | Closet
    | None
    | PoliceX
    | Judge



type alias NPC =
    { itemType : NPCType
    , area : Area
    , interacttrue : Bool
    , description : String
    , place : Scene
    , isFinished : Bool --which means he is finished
    , name : String
    }

emptyNPC : NPC
emptyNPC =
    { itemType = None
    , area =
        { x = 4000
        , y = 2700
        , wid = 20
        , hei = 60
        }
    , interacttrue = False
    , description = ""
    , place = ( Switching, Nowhere )
    , isFinished = True
    , name = ""
    }

cLee_day1 : NPC
cLee_day1 =
    { itemType = Lee
    , area =
        { x = 375
        , y = 270
        , wid = 20
        , hei = 60
        }
    , interacttrue = False
    , description = "LEEPOLICEOFFICE.npc.day=1"
    , place = ( PoliceOffice , Day1 )
    , isFinished = False
    , name = "LEE"
    }

cLee_day2 : NPC --he is not here at the first of day2
cLee_day2 =
    { itemType = Lee
    , area =
        { x = 1000
        , y = 1000
        , wid = 0
        , hei = 0
        }
    , interacttrue = False
    , description = "LEEPOLICEOFFICE.npc.day=1"
    , place = ( PoliceOffice , Day2 )
    , isFinished = False
    , name = "LEE"
    }

cLee_day2_finished : NPC
cLee_day2_finished =
    { itemType = Lee
    , area =
        { x = 375
        , y = 270
        , wid = 20
        , hei = 60
        }
    , interacttrue = False
    , description = "LEE_POLICEOFFICE_DAY2.npc.day2"
    , place = ( PoliceOffice , Day2_Finished )
    , isFinished = False
    , name = "LEE"
    }

cLee_day2_night : NPC --he is not here at the first of day2
cLee_day2_night =
    { itemType = Lee
    , area =
        { x = 375
        , y = 270
        , wid = 20
        , hei = 60
        }
    , interacttrue = False
    , description = "LEE_DAY2NIGHT.npc.day2night"
    , place = ( PoliceOffice , Day2_Night )
    , isFinished = False
    , name = "LEE"
    }

cLee_day4 : NPC --he is not here at the first of day2
cLee_day4 =
    { itemType = Lee
    , area =
        { x = 375
        , y = 270
        , wid = 20
        , hei = 60
        }
    , interacttrue = False
    , description = "LEE_DAY4"
    , place = ( PoliceOffice , Day4 )
    , isFinished = False
    , name = "LEE"
    }


cBob_day1 : NPC
cBob_day1 =
    { itemType = Bob
    , area =
        { x = 460
        , y = 520
        , wid = 20
        , hei = 60
        }
    , interacttrue = False
    , description = "BOBPOLICEOFFICE.npc.day=1"
    , place = ( PoliceOffice , Day1 )
    , isFinished = False
    , name = "BOB"
    }

cBob_day2 : NPC
cBob_day2 =
    { itemType = Bob
    , area =
        { x = 450
        , y = 520
        , wid = 20
        , hei = 60
        }
    , interacttrue = False
    , description = "BOBPOLICEOFFICE.npc.day=1"
    , place = ( PoliceOffice , Day2 )
    , isFinished = False
    , name = "BOB"
    }

cBob_day2_finished : NPC
cBob_day2_finished =
    { itemType = Bob
    , area =
        { x = 450
        , y = 520
        , wid = 20
        , hei = 60
        }
    , interacttrue = False
    , description = "POLICEMEN_DAY2.npcs.day=2"
    , place = ( PoliceOffice , Day2_Finished )
    , isFinished = False
    , name = "BOB"
    }

cBob_day2_night : NPC
cBob_day2_night =
    { itemType = Bob
    , area =
        { x = 450
        , y = 520
        , wid = 20
        , hei = 60
        }
    , interacttrue = False
    , description = "BOB_CALLING.npc.day2night"
    , place = ( PoliceOffice , Day2_Night )
    , isFinished = False
    , name = "BOB"
    }

cBob_day4 : NPC
cBob_day4 =
    { itemType = Bob
    , area =
        { x = 450
        , y = 520
        , wid = 20
        , hei = 60
        }
    , interacttrue = False
    , description = "BOB_DAY4"
    , place = ( PoliceOffice , Day4 )
    , isFinished = False
    , name = "BOB"
    }



cAllen_day1 : NPC
cAllen_day1 =
    { itemType = Allen
        , area =
        { x = 600
        , y = 270
        , wid = 20
        , hei = 60
        }
    , interacttrue = False
    , description = "ALLENPOLICEOFFICE.npc.day=1"
    , place = ( PoliceOffice , Day1 )
    , isFinished = False
    , name = "ALLEN"
    }

cAllen_day2 : NPC
cAllen_day2 =
    { itemType = Allen
        , area =
        { x = 600
        , y = 270
        , wid = 20
        , hei = 60
        }
    , interacttrue = False
    , description = "ALLENPOLICEOFFICEDAY2.npc.day=2"
    , place = ( PoliceOffice , Day2 )
    , isFinished = False
    , name = "ALLEN"
    }

cAllen_day2_finished : NPC
cAllen_day2_finished =
    { itemType = Allen
        , area =
        { x = 600
        , y = 270
        , wid = 20
        , hei = 60
        }
    , interacttrue = False
    , description = "POLICEMEN_DAY2.npcs.day=2"
    , place = ( PoliceOffice , Day2_Finished )
    , isFinished = False
    , name = "ALLEN"
    }

cAllen_day2_night : NPC
cAllen_day2_night =
    { itemType = Allen
        , area =
        { x = 600
        , y = 270
        , wid = 20
        , hei = 60
        }
    , interacttrue = False
    , description = "ALLEN_DAY2NIGHT.npc.day2night"
    , place = ( PoliceOffice , Day2_Night )
    , isFinished = False
    , name = "ALLEN"
    }

cAllen_day4 : NPC
cAllen_day4 =
    { itemType = Allen
        , area =
        { x = 600
        , y = 270
        , wid = 20
        , hei = 60
        }
    , interacttrue = False
    , description = "ALLEN_DAY4"
    , place = ( PoliceOffice , Day4 )
    , isFinished = False
    , name = "ALLEN"
    }

cCoffeeMachine_day1 : NPC
cCoffeeMachine_day1 =
    { itemType = CoffeeMachine
        , area =
        { x = 650
        , y = 280
        , wid = 25
        , hei = 5
        }
    , interacttrue = False
    , description = "COFFEE_NORMAL"
    , place = ( PoliceOffice , Day1 )
    , isFinished = False
    , name = ""
    }

cCoffeeMachine_day2 : NPC
cCoffeeMachine_day2 =
    { itemType = CoffeeMachine
        , area =
        { x = 650
        , y = 280
        , wid = 25
        , hei = 5
        }
    , interacttrue = False
    , description = "COFFEE_NORMAL"
    , place = ( PoliceOffice , Day2 )
    , isFinished = False
    , name = ""
    }

cCoffeeMachine_day2_finished : NPC
cCoffeeMachine_day2_finished =
    { itemType = CoffeeMachine
        , area =
        { x = 650
        , y = 280
        , wid = 25
        , hei = 5
        }
    , interacttrue = False
    , description = "COFFEE_NORMAL"
    , place = ( PoliceOffice , Day2_Finished )
    , isFinished = False
    , name = ""
    }

cCoffeeMachine_day2_night : NPC
cCoffeeMachine_day2_night =
    { itemType = CoffeeMachine
        , area =
        { x = 650
        , y = 280
        , wid = 25
        , hei = 5
        }
    , interacttrue = False
    , description = "COFFEE_NORMAL"
    , place = ( PoliceOffice , Day2_Night )
    , isFinished = False
    , name = ""
    }

cCoffeeMachine_day3 : NPC
cCoffeeMachine_day3 =
    { itemType = CoffeeMachine
        , area =
        { x = 650
        , y = 280
        , wid = 25
        , hei = 5
        }
    , interacttrue = False
    , description = "COFFEE_NORMAL"
    , place = ( PoliceOffice , Day3 )
    , isFinished = False
    , name = ""
    }

cCoffeeMachine_day4 : NPC
cCoffeeMachine_day4 =
    { itemType = CoffeeMachine
        , area =
        { x = 650
        , y = 280
        , wid = 25
        , hei = 5
        }
    , interacttrue = False
    , description = "COFFEE_NORMAL"
    , place = ( PoliceOffice , Day4 )
    , isFinished = False
    , name = ""
    }

cJonathon_day4 : NPC --he is not here at the first of day2
cJonathon_day4 =
    { itemType = Jonathon
    , area =
        { x = 375
        , y = 40
        , wid = 20
        , hei = 60
        }
    , interacttrue = False
    , description = "JONATHON_DAY4"
    , place = ( PoliceOffice , Day4 )
    , isFinished = False
    , name = "Jonathon"
    }


pLee : NPC
pLee =
    { itemType = Lee
    , area =
        { x = 180
        , y = 410
        , wid = 60
        , hei = 180
        }
    , interacttrue = False
    , description = "LEEPARK.npc.day=1"
    , place = ( Park , Day1 )
    , isFinished = False
    , name = "LEE"
    }

pAllen : NPC
pAllen =
    { itemType = Allen
    , area =
        { x = 390
        , y = 320
        , wid = 60
        , hei = 240
        }
    , interacttrue = False
    , description = "ALLENPARK.npc.day=1"
    , place = ( Park , Day1 )
    , isFinished = False
    , name = "ALLEN"
    }

pAdkins : NPC
pAdkins =
    { itemType = Adkins
    , area =
        { x = 660
        , y = 100
        , wid = 40
        , hei = 180
        }
    , interacttrue = False
    , description = "ADKINS.npc.day=1"
    , place = ( Park , Day1 )
    , isFinished = False
    , name = "ADKINS"
    }

pCatherine : NPC
pCatherine =
    { itemType = Catherine
    , area =
        { x = 600
        , y = 100
        , wid = 40
        , hei = 180
        }
    , interacttrue = False
    , description = "CATHERINE.npc.day=1"
    , place = ( Park , Day1 )
    , isFinished = False
    , name = "CATHERINE"
    }

jonaliLee : NPC
jonaliLee =
    { itemType = Lee
    , area =
        { x = 520
        , y = 345
        , wid = 70
        , hei = 180
        }
    , interacttrue = False
    , description = "LEEJOURNALISTHOMEDAY2.npc.day=2"
    , place = ( Journalist, Day2 )
    , isFinished = False
    , name = "LEE"
    }

jonaliBody : NPC
jonaliBody =
    { itemType = JournalistBody
    , area =
        { x = 425
        , y = 400
        , wid = 30
        , hei = 60
        }
    , interacttrue = False
    , description = "JOURNALISTBODYDAY2.npc.day=2"
    , place = ( Journalist, Day2 )
    , isFinished = False
    , name = ""
    }

jonaliEvidence : NPC
jonaliEvidence =
    { itemType = JonaliEvi
    , area =
        { x = 300
        , y = 350
        , wid = 100
        , hei = 40
        }
    , interacttrue = False
    , description = "EVIDENCEJONALI.evidence.day=2"
    , place = ( Journalist, Day2 )
    , isFinished = False
    , name = ""
    }

nightBody : NPC
nightBody =
    { itemType = NightBody
    , area =
        { x = 555
        , y = 200
        , wid = 260
        , hei = 20
        }
    , interacttrue = False
    , description = "ANN_BODY_CLUB.npc.day2night"
    , place = ( NightClub, Day2_Night )
    , isFinished = False
    , name = ""
    }

homePhone : NPC
homePhone =
     { itemType = Phone
     , area =
         { x = 0
         , y = 0
         , wid = 1200
         , hei = 600
         }
     , interacttrue = False
     , description = "PHONE_ANSWER.day3"
     , place = ( Home, Day3 )
     , isFinished = False
     , name = ""
     }

policeXPhone_day6 : NPC
policeXPhone_day6 =
    { itemType = Phone
    , area =
        { x = 0
        , y = 0
        , wid = 1200
        , hei = 600
        }
    , interacttrue = False
    , description = "POLICEXPHONE.day6"
    , place = ( Home, Day6 )
    , isFinished = False
    , name = ""
    }

homePhone_day7 : NPC
homePhone_day7 =
     { itemType = Phone
     , area =
         { x = 0
         , y = 0
         , wid = 1200
         , hei = 600
         }
     , interacttrue = False
     , description = "PHONE_DAY7"
     , place = ( Home, Day7 )
     , isFinished = False
     , name = ""
     }

courtSpeaker : NPC
courtSpeaker =
    { itemType = Phone
    , area =
        { x = 3000
        , y = 3000
        , wid = 100
        , hei = 100
        }
    , interacttrue = False
    , description = "COURT.day6"
    , place = ( CityCouncil , Day6 )
    , isFinished = False
    , name = ""
    }

danielDaniel : NPC
danielDaniel =
     { itemType = Daniel_People
     , area =
         { x = 300
         , y = 400
         , wid = 40
         , hei = 120
         }
     , interacttrue = False
     , description = "DANIEL.day3"
     , place = ( Daniel, Day3 )
     , isFinished = False
     , name = "DANIEL"
     }

danielMemCard : NPC
danielMemCard =
     { itemType = FakeMemCard
     , area =
         { x = 320
         , y = 460
         , wid = 145
         , hei = 5
         }
     , interacttrue = False
     , description = "FAKE_MEM_CARD"
     , place = ( Daniel, Day4 )
     , isFinished = False
     , name = ""
     }

danielKey : NPC
danielKey =
     { itemType = Key_Jonathon
     , area =
         { x = 795
         , y = 440
         , wid = 60
         , hei = 5
         }
     , interacttrue = False
     , description = "KEY_JONATHON"
     , place = ( Daniel, Day4 )
     , isFinished = False
     , name = ""
     }

danielBank : NPC
danielBank =
     { itemType = Bank
     , area =
         { x = 740
         , y = 135
         , wid = 95
         , hei = 5
         }
     , interacttrue = False
     , description = "BANK"
     , place = ( Daniel, Day4 )
     , isFinished = False
     , name = ""
     }

danielPaper : NPC
danielPaper =
     { itemType = Paper
     , area =
         { x = 330
         , y = 145
         , wid = 45
         , hei = 5
         }
     , interacttrue = False
     , description = "PAPER"
     , place = ( Daniel, Day4 )
     , isFinished = False
     , name = ""
     }


danielPhone : NPC
danielPhone =
     { itemType = Phone_Daniel
     , area =
         { x = 0
         , y = 0
         , wid = 1200
         , hei = 600
         }
     , interacttrue = False
     , description = "PHONE_DAY4"
     , place = ( Daniel, Nowhere ) -- will be changed to day4 after the search.
     , isFinished = False
     , name = ""
     }

staffNightClub : NPC
staffNightClub =
    { itemType = Staff
     , area =
         { x = 355
         , y = 475
         , wid = 40
         , hei = 120
         }
     , interacttrue = False
     , description = "STAFF"
     , place = ( NightClub, Day5 )
     , isFinished = False
     , name = "JOHN"
     }

dangerPark : NPC
dangerPark =
    { itemType = Staff
     , area =
         { x = 0
         , y = 0
         , wid = 5000
         , hei = 5000
         }
     , interacttrue = False
     , description = "DANGER"
     , place = ( Park, Day5 )
     , isFinished = False
     , name = ""
     }

jonathonCloset : NPC
jonathonCloset =
    { itemType = Closet
     , area =
         { x = 500
         , y = 55
         , wid = 75
         , hei = 10
         }
     , interacttrue = False
     , description = "CLOSET"
     , place = ( PoliceOffice, Day5 )
     , isFinished = False
     , name = ""
     }

jonathonTable : NPC
jonathonTable =
    { itemType = Table
     , area =
         { x = 340
         , y = 60
         , wid = 40
         , hei = 70
         }
     , interacttrue = False
     , description = "TABLE"
     , place = ( PoliceOffice, Day5 )
     , isFinished = False
     , name = ""
     }


allNPCs: List NPC
allNPCs =
    [ cLee_day1, cLee_day2, cLee_day2_finished, cLee_day2_night, cLee_day4
    , cBob_day1, cBob_day2, cBob_day2_finished, cBob_day2_night, cBob_day4
    , cAllen_day1, cAllen_day2, cAllen_day2_finished, cAllen_day2_night, cAllen_day4
    , cJonathon_day4
    , cCoffeeMachine_day1, cCoffeeMachine_day2, cCoffeeMachine_day2_finished, cCoffeeMachine_day2_night, cCoffeeMachine_day3, cCoffeeMachine_day4
    , pLee, pAllen, pAdkins, pCatherine
    , jonaliLee, jonaliEvidence, jonaliBody
    , nightBody
    , homePhone, danielPhone, homePhone_day7, policeXPhone_day6
    , danielDaniel
    , danielPaper, danielKey, danielMemCard, danielBank
    , staffNightClub
    , dangerPark
    , jonathonTable, jonathonCloset
    , courtSpeaker
    ]



type alias Evidence =
    { eviType : EvidenceType
    , description : String
    , usedPlace : Map -- at home.
    , isExamined : Bool -- used for the final day, to check which information are well-collected-and-examined
    }


type EvidenceType -- one type, one evidence! THAT'S IMPORTANT for the update of isExamined.
    = Disk
    | Note
    | Pill
    | Dagger
    | TrueMemCard
    | TrueMemCardContent
    | KeyEvi
    | FalseMemCardContent
    | BankAccountEvi
    | PaperEvi
    | LetterEvi
    | DocumentsEvi
    | Dagger2Evi
    | BankCardEvi
    | NoEvi

disk_evi : Evidence
disk_evi =
    { eviType = Disk
    , description = "DISK"
    , usedPlace = Home
    , isExamined = False
    }

note_evi : Evidence
note_evi =
    { eviType = Note
    , description = "NOTE"
    , usedPlace = Home
    , isExamined = False
    }

pill_evi : Evidence
pill_evi =
    { eviType = Pill
    , description = "PILLS"
    , usedPlace = Home
    , isExamined = False
    }

dagger_evi : Evidence
dagger_evi =
    { eviType = Dagger
    , description = "DAGGER"
    , usedPlace = Home
    , isExamined = False
    }

trueMemCard_evi : Evidence
trueMemCard_evi =
    { eviType = TrueMemCard
    , description = "TRUE_MEM_CARD"
    , usedPlace = Home
    , isExamined = False
    }

trueMemCardContent_evi : Evidence
trueMemCardContent_evi =
    { eviType = TrueMemCardContent
    , description = "TRUE_MEM_CARD_CONTENT"
    , usedPlace = Home
    , isExamined = False
    }

fakeMemCardContent_evi : Evidence
fakeMemCardContent_evi =
    { eviType = FalseMemCardContent
    , description = "FALSE_MEM_CARD_CONTENT"
    , usedPlace = Home
    , isExamined = False
    }

key_evi : Evidence
key_evi =
    { eviType = KeyEvi
    , description = "KEY_EVI"
    , usedPlace = Home
    , isExamined = False
    }

paper_evi : Evidence
paper_evi =
    { eviType = PaperEvi
    , description = "PAPER_EVI"
    , usedPlace = Home
    , isExamined = False
    }

bank_account_evi : Evidence
bank_account_evi =
    { eviType = BankAccountEvi
    , description = "BANK_EVI"
    , usedPlace = Home
    , isExamined = False
    }

bank_card_evi : Evidence
bank_card_evi =
    { eviType = BankCardEvi
    , description = "BANK_CARD_EVI"
    , usedPlace = Home
    , isExamined = False
    }

dagger2_evi : Evidence
dagger2_evi =
    { eviType = Dagger2Evi
    , description = "DAGGER2_EVI"
    , usedPlace = Home
    , isExamined = False
    }
documents_evi : Evidence
documents_evi =
    { eviType = DocumentsEvi
    , description = "DOCUMENTS_EVI"
    , usedPlace = Home
    , isExamined = False
    }
letter_evi : Evidence
letter_evi =
    { eviType = LetterEvi
    , description = "LETTER_EVI"
    , usedPlace = Home
    , isExamined = False
    }


empty_evi : Evidence
empty_evi =
    { eviType = NoEvi
    , description = "nothing"
    , usedPlace = Home
    , isExamined = False
    }



allEvidence : List Evidence
allEvidence =
    [ disk_evi, note_evi, pill_evi, dagger_evi
    , trueMemCard_evi, trueMemCardContent_evi
    , key_evi, bank_account_evi, paper_evi
    , fakeMemCardContent_evi, documents_evi
    , bank_card_evi, letter_evi, dagger2_evi
    ]







