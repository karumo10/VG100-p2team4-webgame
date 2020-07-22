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
    | None



type alias NPC =
    { itemType : NPCType
    , area : Area
    , interacttrue : Bool
    , description : String
    , place : Scene
    , isFinished : Bool --which means he is finished
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
    }

cLee_day2_finished : NPC
cLee_day2_finished =
    { itemType = Lee
    , area =
        { x = 300
        , y = 500
        , wid = 20
        , hei = 60
        }
    , interacttrue = False
    , description = "LEE_POLICEOFFICE_DAY2.npc.day2"
    , place = ( PoliceOffice , Day2_Finished )
    , isFinished = False
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
    }

cAllen_day2 : NPC
cAllen_day2 =
    { itemType = Allen
        , area =
        { x = 600
        , y = 500
        , wid = 20
        , hei = 60
        }
    , interacttrue = False
    , description = "ALLENPOLICEOFFICEDAY2.npc.day=2"
    , place = ( PoliceOffice , Day2 )
    , isFinished = False
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

    }

jonaliLee : NPC
jonaliLee =
    { itemType = Lee
    , area =
        { x = 900
        , y = 345
        , wid = 60
        , hei = 180
        }
    , interacttrue = False
    , description = "LEEJOURNALISTHOMEDAY2.npc.day=2"
    , place = ( Journalist, Day2 )
    , isFinished = False

    }

jonaliBody : NPC
jonaliBody =
    { itemType = JournalistBody
    , area =
        { x = 600
        , y = 400
        , wid = 180
        , hei = 60
        }
    , interacttrue = False
    , description = "JOURNALISTBODYDAY2.npc.day=2"
    , place = ( Journalist, Day2 )
    , isFinished = False
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
    }

--type alias Scene_Finished =
--    { scene : Scene
--    , isFinished :
--    }


allMapAttrs : List MapAttr
allMapAttrs =
    [ dreamMazeAttr_day1, dreamMazeAttr_day2, dreamMazeAttr_day2_finished
    , homeAttr_day1, homeAttr_day2, homeAttr_day2_finished
    , parkAttr_day1, parkAttr_day2
    , journalistAttr_day1, journalistAttr_day2
    , policeOfficeAttr_day1, policeOfficeAttr_day2, policeOfficeAttr_day2_finished
    , nightClubAttr_day1, nightClubAttr_day2, nightClubAttr_day3
    , switchingAttr ]


allNPCs: List NPC
allNPCs =
    [ cLee_day1, cLee_day2, cLee_day2_finished
    , cBob_day1, cBob_day2, cBob_day2_finished
    , cAllen_day1, cAllen_day2, cAllen_day2_finished
    , pLee, pAllen, pAdkins, pCatherine
    , jonaliLee, jonaliEvidence, jonaliBody ]
