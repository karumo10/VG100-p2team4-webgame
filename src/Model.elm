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
gameMode______ = GettingCoordinates

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
    , npcs = [callen, cbob, clee]
    , story = "Another day at work, another boring day. But I need to avoid being killed."
    }

policeOfficeBarrier : List Area
policeOfficeBarrier =
    case gameMode______ of
        GettingCoordinates ->
            [ ]

        _ ->
            [ { x = 230, y = 500 , wid = 575, hei = 20 } -- f1.ceiling
            , { x = 370, y = 500 , wid = 120, hei = 30 } -- f1.reception desk
            , { x = 805, y = 420 , wid = 20, hei = 180 } -- f1.rightwall
            , { x = 230, y = 600 , wid = 575, hei = 20 } -- f1.floor
            ]



policeOfficeElevator : List Vehicle
policeOfficeElevator =
    [ { area = { x = 660, y = 430, wid = 115, hei = 110 }, which = Elevator }
    , { area = { x = 675, y = 195, wid = 100, hei = 110 }, which = Elevator }
    , { area = { x = 660, y = 0, wid = 115, hei = 85 }, which = Elevator } ]

parkAttr : MapAttr
parkAttr =
    { exit = { x = 620, y = 250 , wid = 200, hei = 90 }
    , heroIni = { x = 500, y = 250, width = 30, height = 90 }
    , barrier = []
    , elevator = []
    , npcs = [pallen, plee]
    , story = "I arrive at the park. This is a desolate place."
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
    , quests : Quest
    }

initial : Model
initial =
    { hero = heroIni
    , heroDir = ( Nothing, Nothing )
    , heroMoveLeft = False
    , heroMoveRight = False
    , heroMoveUp = False
    , heroMoveDown = False
    , state = Playing
    , size = ( 1500, 800 )
    , map = PoliceOffice -- door at police office
    , mapAttr = policeOfficeAttr
    , bag = bagIni
    , items = [ gunIni , bulletProofIni ]
    , worldModel = initialWorldModel
    , story = "Another day at work, another boring day. But I need to avoid being killed."
    , ruleCounts = Dict.empty
    , debug = NarrativeEngine.Debug.init
    , npcs = [callen, cbob, clee]
    , interacttrue = False
    , quests = NoQuest
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
query q worldModel=
    RuleParser.parseMatcher q
        |> Result.map (\parsedMatcher -> WorldModel.query parsedMatcher worldModel)
        |> Result.withDefault []

entityViewBob : (( WorldModel.ID, MyEntity ), Model) ->  Svg.Svg Msg
entityViewBob ((id, { name }), model) =
    let
        msg =
            case model.interacttrue of
                True ->
                    InteractWith id
                _ ->
                    Noop
    in
        rect
        [ x "450", y "520", width "20", height "60"
        , strokeWidth "5px", stroke "#191970"
        , onClick (msg)
        ]
        []

entityViewLee : (( WorldModel.ID, MyEntity ), Model) ->  Svg.Svg Msg
entityViewLee ((id, { name }), model) =
    let
        msg =
            case model.interacttrue of
                True ->
                    InteractWith id
                _ ->
                    Noop
    in
        rect
        [ x "400", y "270", width "20", height "60"
        , strokeWidth "5px", stroke "#191970"
        , onClick (msg)
        ]
        []

entityViewAllen : (( WorldModel.ID, MyEntity ), Model) ->  Svg.Svg Msg
entityViewAllen ((id, { name }), model) =
    let
        msg =
            case model.interacttrue of
                True ->
                    InteractWith id
                _ ->
                    Noop
    in
        rect
        [ x "600", y "270", width "20", height "60"
        , strokeWidth "5px", stroke "#191970"
        , onClick (msg)
        ]
        []

entityViewAllenPark : (( WorldModel.ID, MyEntity ), Model) ->  Svg.Svg Msg
entityViewAllenPark ((id, { name }), model) =
    let
        msg =
            case model.interacttrue of
                True ->
                    InteractWith id
                _ ->
                    Noop
    in
        rect
        [ x "300", y "500", width "20", height "60"
        , strokeWidth "5px", stroke "#191970"
        , onClick (msg)
        ]
        []

entityViewLeePark : (( WorldModel.ID, MyEntity ), Model) ->  Svg.Svg Msg
entityViewLeePark ((id, { name }), model) =
    let
        msg =
            case model.interacttrue of
                True ->
                    InteractWith id
                _ ->
                    Noop
    in
        rect
        [ x "400", y "270", width "20", height "60"
        , strokeWidth "5px", stroke "#191970"
        , onClick (msg)
        ]
        []

entityViewchoices : ( WorldModel.ID, MyEntity ) -> Html Msg
entityViewchoices ( id, { name } ) =
    li [ onClick <| InteractWith id, style "cursor" "pointer" ] [ text name ]

bob model = List.map entityViewBob (List.map2 Tuple.pair (query "BOBPOLICEOFFICE.npc.day=1" model.worldModel) [model])

lee model = List.map entityViewLee (List.map2 Tuple.pair (query "LEEPOLICEOFFICE.npc.day=1" model.worldModel) [model])

allen model = List.map entityViewAllen (List.map2 Tuple.pair (query "ALLENPOLICEOFFICE.npc.day=1" model.worldModel) [model])

allenpark model = List.map entityViewAllenPark (List.map2 Tuple.pair (query "ALLENPARK.npc.day=1" model.worldModel) [model])

leepark model = List.map entityViewLeePark (List.map2 Tuple.pair (query "LEEPARK.npc.day=1" model.worldModel) [model])

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
    , x : Int
    , y : Int
    , interacttrue : Bool
    }

clee : NPC
clee =
    { itemType = Lee
    , x = 400
    , y = 270
    , interacttrue = False
    }

cbob : NPC
cbob =
    { itemType = Bob
    , x = 450
    , y = 520
    , interacttrue = False
    }

callen : NPC
callen =
    { itemType = Allen
    , x = 600
    , y = 270
    , interacttrue = False
    }

plee : NPC
plee =
    { itemType = Lee
    , x = 400
    , y = 270
    , interacttrue = False
    }

pallen : NPC
pallen =
    { itemType = Allen
    , x = 600
    , y = 270
    , interacttrue = False
    }













