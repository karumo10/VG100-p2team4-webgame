module Model exposing (..)
import Json.Decode as Decode
import Json.Encode as Encode


type State
    = Paused
    | Playing
    | Stopped

type Map
    = PoliceOffice
    | Park
    | Switching -- an interface allowing player to choose where to go, also can be design as dialog box

type alias MapAttr = -- things determined by map.
    { exit : Area
    , heroIni : Hero
    }

policeOfficeAttr : MapAttr
policeOfficeAttr =
    { exit = { x = 150, y = 480 , wid = 70, hei = 120 }
    , heroIni = { x = 300, y = 520, width = 20, height = 60 }
    }

parkAttr : MapAttr
parkAttr =
    { exit = { x = 620, y = 250 , wid = 200, hei = 90 }
    , heroIni = { x = 500, y = 250, width = 30, height = 90 }
    }

switchingAttr : MapAttr
switchingAttr =
    { exit = { x = 0, y = 0 , wid = 0, hei = 0 }
    , heroIni = { x = 6000, y = 6000, width = 20, height = 60 }
    }


type alias Area =
    { x : Float
    , y : Float
    , wid : Float
    , hei : Float
    } -- a general type for object interaction (like, with door, so you can exit the police office)


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
    }


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
















