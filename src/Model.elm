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
import Rules exposing (..)
import MapAttr exposing (..)
import NPC exposing (..)



type State
    = Paused
    | Playing
    | Stopped

type PlayerDoing
    = MakingChoices
    | NotMakingChoices -- you can't walk/interacting when making choices! also here can add some other states when it's needed.

type Quest -- if not 'NoQuest', should not move.
    = ElevatorQuest
    | BedQuest
    | NoQuest



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
    , heroimage : String
    , step : Int
    , isEnd : Bool
    , endingTimeAccum : Float
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
    , evidence_all : List Evidence
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
    , chosenChoices : List WorldModel.ID
    , codeContent : String
    , codeReached : Bool
    , isTeleportedToCouncil : Bool
    }

initial : Model
initial =
    { hero = heroIni
    , heroDir = ( Nothing, Nothing )
    , heroMoveLeft = False
    , heroMoveRight = False
    , heroMoveUp = False
    , heroMoveDown = False
    , heroimage = "./heror.png"
    , step = 0
    , isEnd = False
    , endingTimeAccum = 0
    , heroPickUp = False
    , heroInteractWithNpc = False
    , state = Playing
    , size = ( 900, 600 )
    , day = 6
    , dayState = Day6
    , map = StarterPage -- door at police office
    , mapAttr = policeOfficeAttr_day6
    --, mapAttr = nightClubAttr_day5
    , bag = bagIni
    , items = [  ]
    , worldModel = initialWorldModel
    , story = "I'm a novelist who travels to his own book. Yes, I think no better explanation can make the current condition clear. I'm now 'Kay', a policeman, and I know that I'll be killed by the police chief, Jonathon, because I know his scandal. I need to avoid being killed."
    , ruleCounts = Dict.empty
    , debug = NarrativeEngine.Debug.init
    , npcs_curr = List.filter (\a -> a.place == (PoliceOffice, Day6)) allNPCs
    , npcs_all = allNPCs
    , evidence_all = allEvidence
    , mapAttr_all = allMapAttrs
    , interacttrue = False
    , energy = 300
    , energy_Full = 300
    , energy_Cost_pickup = 25
    , energy_Cost_interact = 5
    , quests = NoQuest
    , correctsolved = 0
    , conclusion = 1
    , portrait = ""
    , havegonehome = False
    , playerDoing = NotMakingChoices
    , isBagOpen = False
    , whichGridIsOpen = 0
    , chosenChoices = []
    , codeContent = ""
    , codeReached = False
    , isTeleportedToCouncil = False
    --, park_is_exited
    }



heroIni : Hero
heroIni =
    { x = 300
    , y = 520
    , width = 20
    , height = 60
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

-- characters


query : String -> MyWorldModel -> List ( WorldModel.ID, MyEntity ) --id is the capital name
query q worldModel =
    RuleParser.parseMatcher q
        |> Result.map (\parsedMatcher -> WorldModel.query parsedMatcher worldModel)
        |> Result.withDefault []



isItemAtMap : Model -> Item -> Bool
isItemAtMap model item =
    if model.map == item.scene then
    True
    else
    False





