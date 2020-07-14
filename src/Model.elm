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

type alias Area =
    { x : Float
    , y : Float
    , wid : Float
    , hei : Float
    } -- a general type for object interaction (like, with door, so you can exit the police office)
type VehicleType
    = Elevator
    | Car
type alias Vehicle =
    { area : Area
    , which : VehicleType
    }
type alias MapAttr = -- things determined by map.
    { exit : Area
    , heroIni : Hero
    , barrier : List Area
    , elevator : List Vehicle
    , npcs : List NPC
    , story : String
    }

policeOfficeAttr : MapAttr
policeOfficeAttr =
    { exit = { x = 150, y = 480 , wid = 70, hei = 120 }
    , heroIni = { x = 300, y = 520, width = 20, height = 60 }
    , barrier = policeOfficeBarrier
    , elevator = policeOfficeElevator
    , npcs = [cAllen, cBob, cLee]
    , story = "Another day at work, another boring day. But I need to avoid being killed."
    }

policeOfficeBarrier : List Area
policeOfficeBarrier =
    case gameMode______ of
        GettingCoordinates ->
            [ ]
        _ ->
            [ { x = 230, y = 500 , wid = 575, hei = 20 } -- f1.ceiling (every floor 230)
            , { x = 205, y = 260 , wid = 610, hei = 20 } -- f2.ceiling
            , { x = 205, y = 40 , wid = 610, hei = 20 } -- f3.ceiling
            , { x = 370, y = 500 , wid = 120, hei = 30 } -- f1.reception desk
            , { x = 290, y = 280 , wid = 110, hei = 20 } -- f2.left desk
            , { x = 465, y = 280 , wid = 135, hei = 20 } -- f1.right desk
            , { x = 645, y = 280 , wid = 30, hei = 20 } -- f2.elevator wall
            , { x = 205, y = 280, wid = 55, hei = 20 } -- f2.bookshelf.up
            , { x = 205, y = 300, wid = 30, hei = 20} -- f2.bookshelf.left
            , { x = 805, y = 420 , wid = 20, hei = 180 } -- f1.right wall
            , { x = 805, y = 190 , wid = 20, hei = 180 } -- f2.right wall
            , { x = 805, y = -40 , wid = 20, hei = 180 } -- f3.right wall
            , { x = 185, y = 420 , wid = 20, hei = 180 } -- f1.left wall
            , { x = 185, y = 190 , wid = 20, hei = 180 } -- f2.left wall
            , { x = 185, y = -40 , wid = 20, hei = 180 } -- f3.left wall
            , { x = 205, y = 600 , wid = 600, hei = 20 } -- f1.floor
            , { x = 205, y = 370 , wid = 600, hei = 20 } -- f2.floor
            , { x = 205, y = 140 , wid = 600, hei = 20 } -- f3.floor
            ]

homeBarrier : List Area
homeBarrier =
    case gameMode______ of
        GettingCoordinates ->
            [ ]
        _ ->
            [ { x = 290, y = 500 , wid = 575, hei = 20 } -- f1.ceiling (every floor 230)
            , { x = 205, y = 260 , wid = 650, hei = 20 } -- f2.ceiling
            , { x = 265, y = 45 , wid = 610, hei = 20 } -- f3.ceiling
            , { x = 475, y = 280 , wid = 45, hei = 20 } -- f2.door
            , { x = 695, y = 520 , wid = 45, hei = 20 } -- f1.door
            , { x = 205, y = 300, wid = 30, hei = 20} -- f2.bookshelf.left
            , { x = 235, y = 275, wid = 50, hei = 20} --f2.left corner
            , { x = 590, y = 60, wid = 30, hei = 20 } --f3.bedside lap
            , { x = 570, y = 65, wid = 20, hei = 80 } -- f3.bedwall
            , { x = 655, y = 60, wid = 95, hei = 20 } -- f3.shelf
            , { x = 825, y = 520 , wid = 20, hei = 80 } -- f1.right wall
            , { x = 825, y = 280 , wid = 20, hei = 80 } -- f2.right wall
            , { x = 835, y = 65 , wid = 20, hei = 80 } -- f3.right wall
            , { x = 185, y = 420 , wid = 20, hei = 180 } -- f1.left wall
            , { x = 185, y = 190 , wid = 20, hei = 180 } -- f2.left wall
            , { x = 185, y = -40 , wid = 20, hei = 180 } -- f3.left wall
            , { x = 205, y = 600 , wid = 660, hei = 20 } -- f1.floor
            , { x = 205, y = 360 , wid = 660, hei = 20 } -- f2.floor
            , { x = 205, y = 145 , wid = 660, hei = 20 } -- f3.floor
            ]

policeOfficeElevator : List Vehicle
policeOfficeElevator =
    [ { area = { x = 660, y = 430, wid = 115, hei = 110 }, which = Elevator }
    , { area = { x = 675, y = 195, wid = 100, hei = 110 }, which = Elevator }
    , { area = { x = 660, y = 0, wid = 115, hei = 85 }, which = Elevator } ]

homeElevator : List Vehicle
homeElevator =
    [ { area = { x = 760, y = 430, wid = 115, hei = 110 }, which = Elevator }
    , { area = { x = 775, y = 195, wid = 100, hei = 110 }, which = Elevator }
    , { area = { x = 760, y = 0, wid = 115, hei = 85 }, which = Elevator } ]

parkAttr : MapAttr
parkAttr =
    { exit = { x = 620, y = 250 , wid = 200, hei = 90 }
    , heroIni = { x = 500, y = 250, width = 30, height = 90 }
    , barrier = []
    , elevator = []
    , npcs = [pAllen, pLee, pAdkins, pCatherine]
    , story = "I arrive at the park. This is a desolate place."
    }

homeAttr : MapAttr
homeAttr =
    { exit = { x = 345, y = 450 , wid = 20, hei = 150 }
    , heroIni = { x = 400, y = 520, width = 20, height = 60 }
    , barrier = homeBarrier
    , elevator = homeElevator
    , npcs = []
    , story = ""
    }

switchingAttr : MapAttr
switchingAttr =
    { exit = { x = 0, y = 0 , wid = 0, hei = 0 }
    , heroIni = { x = 6000, y = 6000, width = 20, height = 60 }
    , barrier = []
    , elevator = []
    , npcs = []
    , story = ""
    }



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
    , energy = 60
    , energy_Full = 100
    , energy_Cost_pickup = 25
    , energy_Cost_interact = 5
    , quests = NoQuest
    , correctsolved = 0
    , conclusion = 1
    }

type Quest
    = ElevatorQuest
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
        { x = 400
        , y = 270
        , wid = 20
        , hei = 60
        }
    , interacttrue = False
    , description = "LEEPARK.npc.day=1"
    }

pAllen : NPC
pAllen =
    { itemType = Allen
    , area =
        { x = 300
        , y = 500
        , wid = 20
        , hei = 60
        }
    , interacttrue = False
    , description = "ALLENPARK.npc.day=1"
    }

pAdkins : NPC
pAdkins =
    { itemType = Adkins
    , area =
        { x = 450
        , y = 400
        , wid = 20
        , hei = 60
        }
    , interacttrue = False
    , description = "ADKINS.npc.day=1"
    }

pCatherine : NPC
pCatherine =
    { itemType = Catherine
    , area =
        { x = 400
        , y = 400
        , wid = 20
        , hei = 60
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



