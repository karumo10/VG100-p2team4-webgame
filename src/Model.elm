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
    = Test
    | GettingCoordinates
    | Game
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
    , npcs : List NPC
    , story : String
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

maze1Barrier : List Area
maze1Barrier =
    case gameMode______ of
        GettingCoordinates ->
            [ ]
        _ -> mazeList

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

policeOfficeAttr : MapAttr
policeOfficeAttr =
    { exit = { x = 165, y = 480 , wid = 70, hei = 120 }
    , heroIni = { x = 300, y = 520, width = 20, height = 60 }
    , barrier = policeOfficeBarrier
    , hint = []
    , vehicle = policeOfficeVehicle
    , npcs = [cAllen, cBob, cLee]
    , story = "Another day at work, another boring day. But I need to avoid being killed."
    }

parkAttr : MapAttr
parkAttr =
    { exit = { x = 915, y = 190 , wid = 225, hei = 75 }
    , heroIni = { x = 500, y = 250, width = 60, height = 180 }
    , barrier = []
    , hint = []
    , vehicle = []
    , npcs = [pAllen, pLee, pAdkins, pCatherine]
    , story = "I arrive at the park. This is a desolate place."
    }

homeAttr : MapAttr
homeAttr =
    { exit = { x = 610, y = 450 , wid = 20, hei = 150 }
    , heroIni = { x = 665, y = 520, width = 20, height = 60 }
    , barrier = homeBarrier
    , hint = []
    , vehicle = homeVehicle
    , npcs = []
    , story = "Home, sweet home."
    }

switchingAttr : MapAttr
switchingAttr =
    { exit = { x = 0, y = 0 , wid = 0, hei = 0 }
    , heroIni = { x = 6000, y = 6000, width = 20, height = 60 }
    , barrier = []
    , hint = []
    , vehicle = []
    , npcs = []
    , story = "Where to go?"
    }
energyDrainAttr : MapAttr
energyDrainAttr =
    { exit = { x = 0, y = 0 , wid = 0, hei = 0 }
    , heroIni = { x = 6000, y = 6000, width = 20, height = 60 }
    , barrier = []
    , hint = []
    , vehicle = []
    , npcs = []
    , story = "I'm tired...all I desire is somewhere to take a nap."
    }



dreamMazeAttr : MapAttr
dreamMazeAttr =
    { exit = { x = 470, y = 575 , wid = 20, hei = 20 }
    , heroIni = { x = 415 , y = 15, width = 20, height = 20 } --judge box
    , barrier = maze1Barrier
    , hint = hintsMaze1
    , vehicle = []
    , npcs = []
    , story = "Where is here...?"
    }

hintsMaze1 : List Hint
hintsMaze1 =
    [ { area = { x = 185, y = 135, wid = 20, hei = 20 }, content = "hint1" }
    , { area = { x = 360, y = 320, wid = 20, hei = 20 }, content = "hint2" }
    , { area = { x = 360, y = 435, wid = 20, hei = 20 }, content = "hint3" }
    , { area = { x = 530, y = 240, wid = 20, hei = 20 }, content = "hint4" } ]



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
    , map : Map
    , mapAttr : MapAttr
    , bag : Bag
    , items : List Item
    , worldModel : MyWorldModel
    , story : String
    , ruleCounts : Dict String Int
    , debug : NarrativeEngine.Debug.State
    , npcs : List NPC
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
    , day = 1
    , map = PoliceOffice -- door at police office
    , mapAttr = policeOfficeAttr
    , bag = bagIni
    , items = [ gunIni , bulletProofIni ]
    , worldModel = initialWorldModel
    , story = "I'm a novelist who travels to his own book. Yes, I think no better explanation can make the current condition clear. I'm now 'Kay', a policeman, and I know that I'll be killed by the police chief, Jonathon, because I know his scandal. I need to avoid being killed."
    , ruleCounts = Dict.empty
    , debug = NarrativeEngine.Debug.init
    , npcs = [cAllen, cBob, cLee]
    , interacttrue = False
    , energy = 50
    , energy_Full = 100
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
    | None

type alias NPC =
    { itemType : NPCType
    , area : Area
    , interacttrue : Bool
    , description : String
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
    }

cLee : NPC
cLee =
    { itemType = Lee
    , area =
        { x = 400
        , y = 270
        , wid = 20
        , hei = 60
        }
    , interacttrue = False
    , description = "LEEPOLICEOFFICE.npc.day=1"
    }

cBob : NPC
cBob =
    { itemType = Bob
    , area =
        { x = 450
        , y = 520
        , wid = 20
        , hei = 60
        }
    , interacttrue = False
    , description = "BOBPOLICEOFFICE.npc.day=1"
    }

cAllen : NPC
cAllen =
    { itemType = Allen
        , area =
        { x = 600
        , y = 270
        , wid = 20
        , hei = 60
        }
    , interacttrue = False
    , description = "ALLENPOLICEOFFICE.npc.day=1"
    }

pLee : NPC
pLee =
    { itemType = Lee
    , area =
        { x = 810
        , y = 120
        , wid = 60
        , hei = 180
        }
    , interacttrue = False
    , description = "LEEPARK.npc.day=1"
    }

pAllen : NPC
pAllen =
    { itemType = Allen
    , area =
        { x = 405
        , y = 295
        , wid = 60
        , hei = 180
        }
    , interacttrue = False
    , description = "ALLENPARK.npc.day=1"
    }

pAdkins : NPC
pAdkins =
    { itemType = Adkins
    , area =
        { x = 870
        , y = 405
        , wid = 60
        , hei = 180
        }
    , interacttrue = False
    , description = "ADKINS.npc.day=1"
    }

pCatherine : NPC
pCatherine =
    { itemType = Catherine
    , area =
        { x = 725
        , y = 345
        , wid = 60
        , hei = 180
        }
    , interacttrue = False
    , description = "CATHERINE.npc.day=1"
    }

isItemAtMap : Model -> Item -> Bool
isItemAtMap model item =
    if model.map == item.scene then
    True
    else
    False



