module Model exposing (..)
import Json.Decode as Decode
import Json.Encode as Encode
import Items exposing (..)
import Rules exposing (..)
import Dict exposing (Dict)
import NarrativeEngine.Core.Rules as Rules
import NarrativeEngine.Core.WorldModel as WorldModel
import NarrativeEngine.Debug
import NarrativeEngine.Syntax.NarrativeParser as NarrativeParser
import NarrativeEngine.Syntax.RuleParser as RuleParser
import Html exposing (Html, button, div, text, li, h3, ul, em)
import Html.Attributes exposing (style)
import Html.Events exposing (on, onClick, onMouseDown, onMouseUp)
import Json.Decode as Json
import Message exposing (Msg(..))
import Svg exposing (image, rect, svg)
import Svg.Attributes exposing (x,y,width,height,viewBox,fill,stroke,strokeWidth)
import Rules exposing (..)
import Areas exposing (..)

type Mode
    = CollisionTest
    | GettingCoordinates
    | Game
    | TotalTest
gameMode______ : Mode
gameMode______ = Game


type State
    = Paused
    | Playing
    | Stopped

type PlayerDoing
    = MakingChoices
    | AbleToWalk -- you cant walk when making choices! also here can add some other states when it's needed

type VehicleType
    = Elevator
    | Bed
    | Car

type alias Scene = ( Map, Day )
type alias Vehicle =
    { area : Area
    , which : VehicleType
    }

type alias Hint =
    { area : Area
    , content : String
    }

type alias MapAttr = -- things determined by map.
    { exit : Area
    , heroIni : Hero
    , barrier : List Area
    , hint : List Hint
    , vehicle : List Vehicle
    , story : String
    , scene : Scene
    , isFinished : Bool
    }


policeOfficeBarrier : List Area
policeOfficeBarrier =
    case gameMode______ of
        GettingCoordinates ->
            [ ]
        _ -> policeBarrierList

homeBarrier : List Area
homeBarrier =
    case gameMode______ of
        GettingCoordinates ->
            [ ]
        _ -> homeBarrierList

journalistBarrier : List Area
journalistBarrier =
    case gameMode______ of
        GettingCoordinates ->
            [ ]
        _ -> journalistBarrierList


maze1Barrier : List Area
maze1Barrier =
    case gameMode______ of
        GettingCoordinates ->
            [ ]
        _ -> mazeList

nightClubBarrier : List Area
nightClubBarrier =
    case gameMode______ of
        GettingCoordinates ->
            [ ]
        _ -> nightClubBarrierList

policeOfficeVehicle : List Vehicle
policeOfficeVehicle =
    [ { area = { x = 820, y = 430, wid = 115, hei = 110 }, which = Elevator }
    , { area = { x = 835, y = 195, wid = 100, hei = 110 }, which = Elevator }
    , { area = { x = 820, y = 0, wid = 115, hei = 85 }, which = Elevator } ]

homeVehicle : List Vehicle
homeVehicle =
    [ { area = { x = 1050, y = 430, wid = 115, hei = 110 }, which = Elevator }
    , { area = { x = 1065, y = 195, wid = 100, hei = 110 }, which = Elevator }
    , { area = { x = 1050, y = 80, wid = 115, hei = 85 }, which = Elevator }
    , { area = { x = 855, y = 65, wid = 55, hei = 85 }, which = Bed } ]

nightClubVehicle : List Vehicle
nightClubVehicle =
    [ { area = { x = 1050, y = 430, wid = 115, hei = 110 }, which = Elevator }
    , { area = { x = 1050, y = 195, wid = 100, hei = 110 }, which = Elevator } ]


policeOfficeAttr_day1 : MapAttr
policeOfficeAttr_day1 =
    { exit = { x = 165, y = 480 , wid = 70, hei = 120 }
    , heroIni = { x = 300, y = 520, width = 20, height = 60 }
    , barrier = policeOfficeBarrier
    , hint = []
    , vehicle = policeOfficeVehicle
    , story = "Another day at work, another boring day. But I need to avoid being killed."
    , scene = ( PoliceOffice, Day1 )
    , isFinished = False
    }

policeOfficeAttr_day2 : MapAttr
policeOfficeAttr_day2 =
    { exit = { x = 165, y = 480 , wid = 70, hei = 120 }
    , heroIni = { x = 300, y = 520, width = 20, height = 60 }
    , barrier = policeOfficeBarrier
    , hint = []
    , vehicle = policeOfficeVehicle
    , story = "Another day at work, another boring day. But I need to avoid being killed."
    , scene = ( PoliceOffice, Day2 )
    , isFinished = False
    }
policeOfficeAttr_day2_finished : MapAttr
policeOfficeAttr_day2_finished =
    { exit = { x = 165, y = 480 , wid = 70, hei = 120 }
    , heroIni = { x = 300, y = 520, width = 20, height = 60 }
    , barrier = policeOfficeBarrier
    , hint = []
    , vehicle = policeOfficeVehicle
    , story = "I'm back to the police office."
    , scene = ( PoliceOffice, Day2_Finished )
    , isFinished = False -- this map is not finished
    }

parkAttr_day1 : MapAttr
parkAttr_day1 =
    { exit = { x = 915, y = 190 , wid = 225, hei = 75 }
    , heroIni = { x = 500, y = 250, width = 50, height = 180 }
    , barrier = []
    , hint = []
    , vehicle = []
    , story = "I arrive at the park. This is a desolate place."
    , scene = ( Park, Day1 )
    , isFinished = False
    }

parkAttr_day2 : MapAttr
parkAttr_day2 =
    { exit = { x = 915, y = 190 , wid = 225, hei = 75 }
    , heroIni = { x = 500, y = 250, width = 50, height = 180 }
    , barrier = []
    , hint = []
    , vehicle = []
    , story = "I arrive at the park. This is a desolate place."
    , scene = ( Park, Day2 )
    , isFinished = False
    }


homeAttr_day1 : MapAttr
homeAttr_day1 =
    { exit = { x = 610, y = 450 , wid = 20, hei = 150 }
    , heroIni = { x = 665, y = 520, width = 20, height = 60 }
    , barrier = homeBarrier
    , hint = []
    , vehicle = homeVehicle
    , story = "Home, sweet home."
    , scene = ( Home, Day1 )
    , isFinished = False

    }

homeAttr_day2 : MapAttr
homeAttr_day2 =
    { exit = { x = 610, y = 450 , wid = 20, hei = 150 }
    , heroIni = { x = 665, y = 520, width = 20, height = 60 }
    , barrier = homeBarrier
    , hint = []
    , vehicle = homeVehicle
    , story = "Home, sweet home."
    , scene = ( Home, Day2 )
    , isFinished = False
    }

homeAttr_day2_finished : MapAttr
homeAttr_day2_finished =
    { exit = { x = 610, y = 450 , wid = 20, hei = 150 }
    , heroIni = { x = 665, y = 520, width = 20, height = 60 }
    , barrier = homeBarrier
    , hint = []
    , vehicle = homeVehicle
    , story = "What a tired day!"
    , scene = ( Home, Day2_Finished )
    , isFinished = False
    }

journalistAttr_day1 : MapAttr
journalistAttr_day1 =
    { exit = { x = 130, y = 205 , wid = 20, hei = 250 }
    , heroIni = { x = 205, y = 335, width = 60, height = 180 }
    , barrier = journalistBarrier
    , hint = []
    , vehicle = []
    , story = "Nasty Smell... How long hasn't this guy cleaned his home?"
    , scene = ( Journalist, Day1 )
    , isFinished = False

    }


journalistAttr_day2 : MapAttr
journalistAttr_day2 =
    { exit = { x = 130, y = 205 , wid = 20, hei = 250 }
    , heroIni = { x = 205, y = 335, width = 60, height = 180 }
    , barrier = journalistBarrier
    , hint = []
    , vehicle = []
    , story = "Nasty Smell... How long hasn't this guy cleaned his home?"
    , scene = ( Journalist, Day2 )
    , isFinished = False

    }

nightClubAttr_day1 : MapAttr
nightClubAttr_day1 =
    { exit = { x = 125, y = 385 , wid = 20, hei = 215  }
    , heroIni = { x = 150, y = 475, width = 40, height = 120 }
    , barrier = nightClubBarrier
    , hint = []
    , vehicle = nightClubVehicle
    , story = "It's the place where lust and alcoholism intertwined."
    , scene = ( NightClub, Day1 )
    , isFinished = False
    }

nightClubAttr_day2 : MapAttr
nightClubAttr_day2 =
    { exit = { x = 125, y = 385 , wid = 20, hei = 215  }
    , heroIni = { x = 150, y = 475, width = 40, height = 120 }
    , barrier = nightClubBarrier
    , hint = []
    , vehicle = nightClubVehicle
    , story = "It's the place where lust and alcoholism intertwined."
    , scene = ( NightClub, Day2 )
    , isFinished = False
    }

nightClubAttr_day3 : MapAttr
nightClubAttr_day3 =
    { exit = { x = 125, y = 385 , wid = 20, hei = 215  }
    , heroIni = { x = 150, y = 475, width = 40, height = 120 }
    , barrier = nightClubBarrier
    , hint = []
    , vehicle = nightClubVehicle
    , story = "It's the place where lust and alcoholism intertwined; but now only sin reigns."
    , scene = ( NightClub, Day3 )
    , isFinished = False
    }




switchingAttr : MapAttr
switchingAttr =
    { exit = { x = 0, y = 0 , wid = 0, hei = 0 }
    , heroIni = { x = 6000, y = 6000, width = 20, height = 60 }
    , barrier = []
    , hint = []
    , vehicle = []
    , story = "Where to go?"
    , scene = ( Switching, Nowhere )
    , isFinished = False

    }

--energyDrainAttr : MapAttr
--energyDrainAttr =
--    { exit = { x = 0, y = 0 , wid = 0, hei = 0 }
--    , heroIni = { x = 6000, y = 6000, width = 20, height = 60 }
--    , barrier = []
--    , hint = []
--    , vehicle = []
--    , story = "I'm tired...all I desire is somewhere to take a nap."
--    , scene = ( Switching, Nowhere )
--    , isFinished = False
--
--    }



dreamMazeAttr_day1 : MapAttr
dreamMazeAttr_day1 =
    { exit = { x = 470, y = 575 , wid = 20, hei = 20 }
    , heroIni = { x = 415 , y = 15, width = 20, height = 20 } --judge box
    , barrier = maze1Barrier
    , hint = hintsMaze1
    , vehicle = []
    , story = "Where is here...?"
    , scene = ( DreamMaze, Day1 )
    , isFinished = False
    }

dreamMazeAttr_day2 : MapAttr
dreamMazeAttr_day2 =
    { exit = { x = 470, y = 575 , wid = 20, hei = 20 }
    , heroIni = { x = 415 , y = 15, width = 20, height = 20 } --judge box
    , barrier = maze1Barrier
    , hint = hintsMaze1
    , vehicle = []
    , story = "Maze again? Really odd... "
    , scene = ( DreamMaze, Day2 )
    , isFinished = False
    }

dreamMazeAttr_day2_finished : MapAttr
dreamMazeAttr_day2_finished =
    { exit = { x = 470, y = 575 , wid = 20, hei = 20 }
    , heroIni = { x = 415 , y = 15, width = 20, height = 20 } --judge box
    , barrier = maze1Barrier
    , hint = hintsMaze2
    , vehicle = []
    , story = "Maze again? Really odd... "
    , scene = ( DreamMaze, Day2_Finished )
    , isFinished = False
    }


hintsMaze1 : List Hint
hintsMaze1 =
    [ { area = { x = 185, y = 135, wid = 20, hei = 20 }, content = "hint1" }
    , { area = { x = 360, y = 320, wid = 20, hei = 20 }, content = "hint2" }
    , { area = { x = 360, y = 435, wid = 20, hei = 20 }, content = "hint3" }
    , { area = { x = 530, y = 240, wid = 20, hei = 20 }, content = "hint4" } ]

hintsMaze2 : List Hint
hintsMaze2 =
    [ { area = { x = 185, y = 135, wid = 20, hei = 20 }, content = "...It's quite interesting: now, you are me, I am you... You know that Jonathon is a bad guy as you write it in your novel? Even more interesting..." }
    , { area = { x = 360, y = 320, wid = 20, hei = 20 }, content = "Ah, it seems that you have lost some memory, my friends. I can tell you something. It's quite weird that the day we planned to meet in the office, I was called to help inspect a night club. Do you think so? Who will inspect a night club at morning?..." }
    , { area = { x = 360, y = 435, wid = 20, hei = 20 }, content = "The suicide case? Oh, I have gone to the scene, too. But I don’t know which evidence you take in \"your\" home. They are both useful but you should pay attention how to use them properly, my dear friend..." }
    , { area = { x = 530, y = 240, wid = 20, hei = 20 }, content = "...Listen! What is whirring and whizzing? Double, double! Toil and trouble; fire burn and cauldron bubble! ..." } ]



decodeState : String -> State
decodeState string =
    case string of
        "paused" ->
            Paused

        "playing" ->
            Playing

        _ ->
            Stopped


encodeState : State -> String
encodeState state =
    case state of
        Paused ->
            "paused"

        Playing ->
            "playing"

        Stopped ->
            "stopped"

type alias AnimationState =
    Maybe
        { active : Bool
        , elapsed : Float
        }


type alias Model =
    { hero : Hero
    , heroDir : ( AnimationState, AnimationState ) -- first controls left/right, second controls up/down
    , heroMoveLeft : Bool
    , heroMoveRight : Bool
    , heroMoveUp : Bool
    , heroMoveDown : Bool
    , heroPickUp : Bool
    , heroInteractWithNpc : Bool
    , state : State
    , size : ( Float, Float )
    , day : Int
    , dayState : Day
    , map : Map
    , mapAttr : MapAttr
    , bag : Bag
    , items : List Item
    , worldModel : MyWorldModel
    , story : String
    , ruleCounts : Dict String Int
    , debug : NarrativeEngine.Debug.State
    , npcs_curr : List NPC
    , npcs_all : List NPC
    , mapAttr_all : List MapAttr
    , interacttrue : Bool
    , energy : Int
    , energy_Full : Int
    , energy_Cost_pickup : Int
    , energy_Cost_interact : Int
    , quests : Quest
    , correctsolved : Int
    , conclusion : Float
    , portrait : String
    , havegonehome : Bool --should be initialized every single day ; Update:I have given up usage of this, if it is not used in alpha version,it can be deleted
    , playerDoing : PlayerDoing
    , isBagOpen : Bool --When should the bag be presented
    , whichGridIsOpen : Int
    }

initial : Model
initial =
    { hero = heroIni
    , heroDir = ( Nothing, Nothing )
    , heroMoveLeft = False
    , heroMoveRight = False
    , heroMoveUp = False
    , heroMoveDown = False
    , heroPickUp = False
    , heroInteractWithNpc = False
    , state = Playing
    , size = ( 900, 600 )
    , day = 2
    , dayState = Day2
    , map = StarterPage -- door at police office
    , mapAttr = policeOfficeAttr_day1
    , bag = bagIni
    , items = [ gunIni , bulletProofIni ]
    , worldModel = initialWorldModel
    , story = "I'm a novelist who travels to his own book. Yes, I think no better explanation can make the current condition clear. I'm now 'Kay', a policeman, and I know that I'll be killed by the police chief, Jonathon, because I know his scandal. I need to avoid being killed."
    , ruleCounts = Dict.empty
    , debug = NarrativeEngine.Debug.init
    , npcs_curr = List.filter (\a -> a.place == (PoliceOffice, Day1)) allNPCs
    , npcs_all = allNPCs
    , mapAttr_all = allMapAttrs
    , interacttrue = False
    , energy = 150
    , energy_Full = 150
    , energy_Cost_pickup = 25
    , energy_Cost_interact = 5
    , quests = NoQuest
    , correctsolved = 0
    , conclusion = 1
    , portrait = ""
    , havegonehome = False
    , playerDoing = AbleToWalk
    , isBagOpen = False
    , whichGridIsOpen = 0
    }

type Quest -- if not 'NoQuest', should not move.
    = ElevatorQuest
    | BedQuest
    | NoQuest

type alias Hero =
    { x : Int
    , y : Int
    , width : Float
    , height: Float
    }

heroIni : Hero
heroIni =
    { x = 300
    , y = 520
    , width = 20
    , height = 60
    }

getDescription : NarrativeParser.Config MyEntity -> WorldModel.ID -> MyWorldModel -> String
getDescription config entityID worldModel_ =
    Dict.get entityID worldModel_
        |> Maybe.map .description
        |> Maybe.withDefault ("ERROR can't find entity " ++ entityID)
        |> NarrativeParser.parse config
        -- The parser can break up a narrative into chunks (for pagination for
        -- example), but in our case we use the whole thing, so we just take the
        -- head.
        |> List.head
        |> Maybe.withDefault ("ERROR parsing narrative content for " ++ entityID)

getName : WorldModel.ID -> MyWorldModel -> String
getName entityID worldModel_ =
    Dict.get entityID worldModel_
        |> Maybe.map .name
        |> Maybe.withDefault ("ERROR can't find entity " ++ entityID)

makeConfig : WorldModel.ID -> Rules.RuleID -> Model -> NarrativeParser.Config MyEntity
makeConfig trigger matchedRule model =
    { cycleIndex = Dict.get matchedRule model.ruleCounts |> Maybe.withDefault 0
    , propKeywords = Dict.singleton "name" (\id -> Ok <| getName id model.worldModel)
    , worldModel = model.worldModel
    , trigger = trigger
    }

decode : Decode.Decoder Model
decode =
    Decode.map3
        (\state heroX heroY ->
            { initial
                | state = state
                , hero =
                    { x = heroX
                    , y = heroY
                    , width = 20
                    , height = 60
                }
            }
        )
        (Decode.field "state" (Decode.map decodeState Decode.string))
        (Decode.field "positionX" Decode.int)
        (Decode.field "positionY" Decode.int)


encode : Int -> Model -> String
encode indent model =
    Encode.encode
        indent
        (Encode.object
            [ ( "state", Encode.string (encodeState model.state) )
            , ( "positionX", Encode.int (model.hero.x) )
            , ( "positionY", Encode.int (model.hero.y) )
            ]
        )

-- characters

query : String -> MyWorldModel -> List ( WorldModel.ID, MyEntity )
query q worldModel =
    RuleParser.parseMatcher q
        |> Result.map (\parsedMatcher -> WorldModel.query parsedMatcher worldModel)
        |> Result.withDefault []

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

type Day
    = Day1
    | Day2
    | Day2_Finished
    | Day3
    | Nowhere
    | TooBigOrSmall


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
    , switchingAttr]


allNPCs: List NPC
allNPCs =
    [ cLee_day1, cLee_day2, cLee_day2_finished
    , cBob_day1, cBob_day2, cBob_day2_finished
    , cAllen_day1, cAllen_day2, cAllen_day2_finished
    , pLee, pAllen, pAdkins, pCatherine
    , jonaliLee, jonaliEvidence, jonaliBody]

type alias MapState =
    { scene : Scene
    , isFinished : Bool
    }




isItemAtMap : Model -> Item -> Bool
isItemAtMap model item =
    if model.map == item.scene then
    True
    else
    False



