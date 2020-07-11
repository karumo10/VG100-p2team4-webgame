port module Update exposing (update)

import Message exposing (Msg(..))
import Model exposing (..)
import Items exposing ( .. )
import List exposing ( filter , length , head , map )
import Maybe exposing (withDefault )
import Rules exposing (..)
import Dict exposing (Dict)
import NarrativeEngine.Core.Rules as Rules
import NarrativeEngine.Core.WorldModel as WorldModel
import NarrativeEngine.Debug
import NarrativeEngine.Syntax.NarrativeParser as NarrativeParser


port save : String -> Cmd msg

stride = 5          -- distance travelled by one press. If stuck in, the depth is smaller than this length


saveToStorage : Model -> ( Model, Cmd Msg )
saveToStorage model =
    ( model, save (Model.encode 2 model) )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Resize width height ->
            ( { model | size = ( toFloat width, toFloat height ) }
            , Cmd.none
            )

        GetViewport { viewport } ->
            ( { model
                | size =
                    ( viewport.width
                    , viewport.height
                    )
              }
            , Cmd.none
            )

        Start ->
            ( { model
                | state = Playing
              }
            , Cmd.none
            )

        Pause ->
            saveToStorage { model | state = Paused }

        Resume ->
            ( { model | state = Playing }
            , Cmd.none
            )

        MoveLeft on ->
            ( startMove { model | heroMoveLeft = on }
            , Cmd.none
            )

        MoveRight on ->
            ( startMove { model | heroMoveRight = on }
            , Cmd.none
            )

        MoveUp on ->
            ( startMove { model | heroMoveUp = on }
            , Cmd.none
            )

        MoveDown on ->
            ( startMove { model | heroMoveDown = on }
            , Cmd.none
            )


        Tick time ->
            model
                |> animate (min time 25)
                |> saveToStorage

        ToPoliceOffice ->
            ( mapSwitch PoliceOffice model
            , Cmd.none
            )



        ToPark ->
            ( mapSwitch Park model
            , Cmd.none
            )

        PickUp on->
            ( pickUp { model | heroPickUp= on }
            , Cmd.none
            )

        ElevateTo1 ->
            ( teleportHero ( 695, 520 ) model
            , Cmd.none
            )

        ElevateTo2 ->
            ( teleportHero ( 695, 290 ) model
            , Cmd.none
            )

        ElevateTo3 ->
            ( teleportHero ( 695, 60 ) model
            , Cmd.none
            )



        EnterVehicle on ->
            case on of
                True ->
                    ( enterElevators model, Cmd.none)
                False ->
                    ( model, Cmd.none )


        Noop ->
            ( model, Cmd.none )

        InteractWith trigger ->
                    -- we need to check if any rule matched
            case Rules.findMatchingRule trigger parsedData model.worldModel of
                Just ( matchedRuleID, { changes } ) ->
                    ({ model
                    | worldModel = WorldModel.applyChanges changes trigger model.worldModel
                    , story =
                                    -- get the story from narrative content (we also need to
                                    -- parse it)
                    Dict.get matchedRuleID narrative_content
                        |> Maybe.withDefault ("ERROR finding narrative content for " ++ matchedRuleID)
                        |> NarrativeParser.parse (makeConfig trigger matchedRuleID model)
                                        -- The parser can break up a narrative into chunks
                                        -- (for pagination for example), but in our case we
                                        -- use the whole thing, so we just take the head.
                        |> List.head
                        |> Maybe.withDefault ("ERROR parsing narrative content for " ++ matchedRuleID)
                    , ruleCounts = Dict.update matchedRuleID (Maybe.map ((+) 1) >> Maybe.withDefault 1 >> Just) model.ruleCounts
                    , debug = model.debug
                                  |> NarrativeEngine.Debug.setLastMatchedRuleId matchedRuleID
                                  |> NarrativeEngine.Debug.setLastInteractionId trigger
                    }, Cmd.none)

                Nothing ->
                            -- no rule matched, so lets just show the description of the
                            -- entity that the player interacted with
                    ({ model
                    | story = getDescription (makeConfig trigger trigger model) trigger model.worldModel
                    , ruleCounts = Dict.update trigger (Maybe.map ((+) 1) >> Maybe.withDefault 1 >> Just) model.ruleCounts
                    , debug = model.debug
                                  |> NarrativeEngine.Debug.setLastMatchedRuleId trigger
                                  |> NarrativeEngine.Debug.setLastInteractionId trigger
                    }, Cmd.none)

        UpdateDebugSearchText searchText ->
                    ({ model | debug = NarrativeEngine.Debug.updateSearch searchText model.debug }, Cmd.none)




animate : Float -> Model -> Model
animate elapsed model =
    model
        |> moveHeroLR elapsed
        |> moveHeroUD elapsed
        |> goToSwitching
        |> judgeInteract
        |> interactable

teleportHero : ( Int, Int ) -> Model -> Model
teleportHero ( x, y ) model =
    let
        hero = model.hero
        hero_ = { hero | x = x, y = y }
    in
    { model | hero = hero_ }



directionLR : Model -> Int
directionLR { heroMoveLeft, heroMoveRight } =
    case ( heroMoveLeft, heroMoveRight ) of
        ( True, False ) ->
            -1

        ( False, True ) ->
            1

        _ ->
            0

directionUD : Model -> Int
directionUD { heroMoveUp, heroMoveDown } =
    case ( heroMoveUp, heroMoveDown ) of
        ( True, False ) ->
            -1

        ( False, True ) ->
            1

        _ ->
            0



startMove : Model -> Model
startMove model =
    if directionLR model /= 0 && directionUD model /= 0 then
        { model | heroDir = ( Just { active = True, elapsed = 0 }, Just { active = True, elapsed = 0 }) }
    else if directionLR model /= 0 && directionUD model == 0 then
        { model | heroDir = ( Just { active = True, elapsed = 0 }, Nothing ) }
    else if directionLR model == 0 && directionUD model /= 0 then
        { model | heroDir = ( Nothing, Just { active = True, elapsed = 0 } ) }
    else
        { model | heroDir = ( Nothing, Nothing ) }


activateButton : Float -> Float -> { a | active : Bool, elapsed : Float } -> { a | active : Bool, elapsed : Float } -- to ban pressing one button to make the hero move too fast
activateButton interval elapsed state =
    let
        elapsed_ =
            state.elapsed + elapsed
    in
    if elapsed_ > interval then
        { state | active = True, elapsed = elapsed_ - interval }

    else
        { state | active = False, elapsed = elapsed_ }


moveHeroLR : Float -> Model -> Model
moveHeroLR elapsed model =
    let
        lrState = model.heroDir |> Tuple.first
        udState = model.heroDir |> Tuple.second
    in

    case lrState of
        Just state ->
            { model | heroDir = ( Just (activateButton 50 elapsed state), udState ) }
                |> (if state.active then
                        moveHeroLR_ (directionLR model)

                    else
                        identity
                   )

        Nothing ->
            model

moveHeroLR_ : Int -> Model -> Model
moveHeroLR_ dx model =
    let
        ( x, y ) = ( model.hero.x, model.hero.y )
        overlapAreas = List.filter (judgeAreaOverlap model) model.mapAttr.barrier
        x_ =
            if List.length overlapAreas == 0 then
                x + dx * stride -- maybe stuck. caution!
            else if (List.filter (\a -> isStuck model a == LeftSide) overlapAreas |> List.length) /= 0 then
                if dx > 0 then x
                else x + dx * stride
            else if (List.filter (\a -> isStuck model a == RightSide) overlapAreas |> List.length) /= 0 then
                if dx < 0 then x
                else x + dx * stride
            else
                x + dx * stride
        hero = model.hero
        hero_ = { hero | x = x_ }
    in
    { model | hero = hero_ }

moveHeroUD : Float -> Model -> Model
moveHeroUD elapsed model =
    let
        lrState = model.heroDir |> Tuple.first
        udState = model.heroDir |> Tuple.second
    in
    case udState of
        Just state ->
            { model | heroDir = ( lrState, Just (activateButton 50 elapsed state) ) }
                |> (if state.active then
                        moveHeroUD_ (directionUD model)

                    else
                        identity
                   )

        Nothing ->
            model

moveHeroUD_ : Int -> Model -> Model
moveHeroUD_ dy model =
    let
        ( x, y ) = ( model.hero.x, model.hero.y )
        overlapAreas = List.filter (judgeAreaOverlap model) model.mapAttr.barrier
        y_ =
            if List.length overlapAreas == 0 then
                y + dy * stride
            else if (List.filter (\a -> isStuck model a == UpSide) overlapAreas |> List.length) /= 0 then
                if dy > 0 then y
                else y + dy * stride
            else if (List.filter (\a -> isStuck model a == DownSide) overlapAreas |> List.length) /= 0 then
                if dy < 0 then y
                else y + dy * stride
            else
                y + dy * stride
        hero = model.hero
        hero_ = { hero | y = y_ }
    in
    { model | hero = hero_ }



judgeExit : Model -> Bool
judgeExit model =
    let
        exit = model.mapAttr.exit
    in
    judgeAreaOverlap model exit


judgeAreaOverlap : Model -> Area -> Bool -- hero overlap with some area. widely applicable
judgeAreaOverlap model area =
    let
        ( x1, y1 ) = ( toFloat model.hero.x, toFloat model.hero.y )
        ( x2, y2 ) = ( area.x, area.y )
        ( w1, h1 ) = ( model.hero.width, model.hero.height )
        ( w2, h2 ) = ( area.wid, area.hei )
    in
    if x2 - w1 <= x1 && x1 <= x2 + w2 && y2 - h1 <= y1 && y1 <= y2 + h2 then True
    else False

type StuckStateMachine
    = UpSide
    | DownSide
    | LeftSide
    | RightSide
    | NoStuck
    | Err


isStuck : Model -> Area -> StuckStateMachine
isStuck model area =
    let
        ( x1, y1 ) = ( toFloat model.hero.x, toFloat model.hero.y )
        ( x2, y2 ) = ( area.x, area.y )
        ( w1, h1 ) = ( model.hero.width, model.hero.height )
        ( w2, h2 ) = ( area.wid, area.hei )
        ( yu, yd ) = ( y2 - h1, y2 + h2 )
        ( xl, xr ) = ( x2 - w1, x2 + w2 )
        leftSide = x1 >= xl && x1 <= xl + stride
        rightSide = x1 >= xr - stride && x1 <= xr
        upSide = y1 <= yu + stride && y1 >= yu
        downSide = y1 <= yd && y1 >= yd - stride
        corner = ( leftSide || rightSide ) && ( upSide || downSide )
    in
    if corner || not (judgeAreaOverlap model area) then NoStuck
    else if leftSide then LeftSide
    else if rightSide then RightSide
    else if upSide then UpSide
    else if downSide then DownSide
    else Err

judgeWhichVehicle :  Model -> Vehicle -> Bool
judgeWhichVehicle model vehicle=
    case vehicle.which of
        Elevator -> elevateQuestOut vehicle model
        Car -> False -- not implemented now.


enterElevators : Model -> Model
enterElevators model =
    let
        elevators = model.mapAttr.elevator
        --elevatorAreas = List.map (\a -> a.area) elevators
        isNearList = List.map (judgeWhichVehicle model) elevators
        isNear = List.foldl (||) False isNearList
        questCurr = model.quests
    in
    if (isNear) then
        case questCurr of
            ElevatorQuest ->
                { model | quests = NoQuest }
            NoQuest ->
                { model | quests = ElevatorQuest }
    else model


elevateQuestOut : Vehicle -> Model -> Bool --call out the choice to which floor
elevateQuestOut elevator model =
    let
        isNear = judgeAreaOverlap model elevator.area
    in
    isNear


goToSwitching : Model -> Model -- when at exit, go to switching interface
goToSwitching model =
    if judgeExit model then
        mapSwitch Switching model
    else model

mapSwitch : Map -> Model -> Model
mapSwitch newMap model =
    let
        mapAttr =
            case newMap of
                PoliceOffice -> policeOfficeAttr
                Park -> parkAttr
                Switching -> switchingAttr
        hero = mapAttr.heroIni
        npcs = mapAttr.npcs
        story = mapAttr.story
    in
    { model | hero = hero, mapAttr = mapAttr, map = newMap, npcs = npcs, story = story }

canPickUp : Model -> Item -> Bool
canPickUp model item=
    let
        distance = ( model.hero.x - item.x)^2 + ( model.hero.y - item.y)^2
    in
    if distance > 50 then
    False
    else
    True

itemPickUp : Model -> Item -> Item
itemPickUp model item =
    if canPickUp model item == True then
    { item | isPick = True }
    else
    item

canpickUp_energy : Model-> Bool
canpickUp_energy model =
    let
        energy = model.energy
        energy_Cost = model.energy_Cost
    in
    if (energy - energy_Cost)>=0 then
    True
    else
    False
pickUp : Model -> Model
pickUp model =
    let
        isPickUp = model.heroPickUp --is player doing pick up commands
        isThereAny = List.length ableToPick
        ableToPick = List.filter (canPickUp model) model.items --depends on distance
        abletoPick2 =canpickUp_energy model --depends on energy
        item = withDefault gunIni (head ableToPick)
        itemsLeft = map (itemPickUp model) model.items
        g1 = model.bag.grid1
        g2 = model.bag.grid2
        g3 = model.bag.grid3
        g4 = model.bag.grid4
        g5 = model.bag.grid5
        g6 = model.bag.grid6
        g7 = model.bag.grid7
        g8 = model.bag.grid8
        g9 = model.bag.grid9
        g10 = model.bag.grid10
        t1 = model.bag.grid1.itemType
        t2 = model.bag.grid2.itemType
        t3 = model.bag.grid3.itemType
        t4 = model.bag.grid4.itemType
        t5 = model.bag.grid5.itemType
        t6 = model.bag.grid6.itemType
        t7 = model.bag.grid7.itemType
        t8 = model.bag.grid8.itemType
        t9 = model.bag.grid9.itemType
        t10 = model.bag.grid10.itemType
        energy = model.energy
        energy_ = energy - model.energy_Cost

    in
    if isThereAny == 0 || not abletoPick2 || not isPickUp then
    model
    else if isThereAny == 1 && t1 == Empty && abletoPick2 && isPickUp then
    { model | bag = { grid1 = item , grid2 = g2 , grid3 = g3 , grid4 = g4 , grid5 = g5 , grid6 = g6 , grid7 = g7 , grid8 = g8 , grid9 = g9 , grid10 = g10 } , items = itemsLeft , energy=energy_ }
    else if isThereAny == 1 && t1 /= Empty && t2 == Empty && abletoPick2 && isPickUp then
    { model | bag = { grid1 = g1 , grid2 = item , grid3 = g3 , grid4 = g4 , grid5 = g5 , grid6 = g6 , grid7 = g7 , grid8 = g8 , grid9 = g9 , grid10 = g10 } , items = itemsLeft , energy=energy_}
    else if isThereAny == 1 && t1 /= Empty && t2 /= Empty && t3 == Empty && abletoPick2 && isPickUp then
    { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = item , grid4 = g4 , grid5 = g5 , grid6 = g6 , grid7 = g7 , grid8 = g8 , grid9 = g9 , grid10 = g10 } , items = itemsLeft , energy=energy_}
    else if isThereAny == 1 && t1 /= Empty && t2 /= Empty && t3 /= Empty && t4 == Empty && abletoPick2 && isPickUp then
    { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = g3 , grid4 = item , grid5 = g5 , grid6 = g6 , grid7 = g7 , grid8 = g8 , grid9 = g9 , grid10 = g10 } , items = itemsLeft , energy=energy_}
    else if isThereAny == 1 && t1 /= Empty && t2 /= Empty && t3 /= Empty && t4 /= Empty && t5 == Empty && abletoPick2 && isPickUp then
    { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = g3 , grid4 = g4 , grid5 = item , grid6 = g6 , grid7 = g7 , grid8 = g8 , grid9 = g9 , grid10 = g10 } , items = itemsLeft , energy=energy_}
    else if isThereAny == 1 && t1 /= Empty && t2 /= Empty && t3 /= Empty && t4 /= Empty && t5 /= Empty && t6 == Empty && abletoPick2 && isPickUp then
    { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = g3 , grid4 = g4 , grid5 = g5 , grid6 = item , grid7 = g7 , grid8 = g8 , grid9 = g9 , grid10 = g10 } , items = itemsLeft , energy=energy_}
    else if isThereAny == 1 && t1 /= Empty && t2 /= Empty && t3 /= Empty && t4 /= Empty && t5 /= Empty && t6 /= Empty && t7 == Empty && abletoPick2 && isPickUp then
    { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = g3 , grid4 = g4 , grid5 = g5 , grid6 = g6 , grid7 = item , grid8 = g8 , grid9 = g9 , grid10 = g10 } , items = itemsLeft , energy=energy_}
    else if isThereAny == 1 && t1 /= Empty && t2 /= Empty && t3 /= Empty && t4 /= Empty && t5 /= Empty && t6 /= Empty && t7 /= Empty && t8 == Empty && abletoPick2 && isPickUp then
    { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = g3 , grid4 = g4 , grid5 = g5 , grid6 = g6 , grid7 = g7 , grid8 = item , grid9 = g9 , grid10 = g10 } , items = itemsLeft , energy=energy_}
    else if isThereAny == 1 && t1 /= Empty && t2 /= Empty && t3 /= Empty && t4 /= Empty && t5 /= Empty && t6 /= Empty && t7 /= Empty && t8 /= Empty && t9 == Empty && abletoPick2 && isPickUp then
    { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = g3 , grid4 = g4 , grid5 = g5 , grid6 = g6 , grid7 = g7 , grid8 = g8 , grid9 = item , grid10 = g10 } , items = itemsLeft , energy=energy_}
    else if isThereAny == 1 && t1 /= Empty && t2 /= Empty && t3 /= Empty && t4 /= Empty && t5 /= Empty && t6 /= Empty && t7 /= Empty && t8 /= Empty && t9 /= Empty && t10 == Empty && abletoPick2 && isPickUp then
    { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = g3 , grid4 = g4 , grid5 = g5 , grid6 = g6 , grid7 = g7 , grid8 = g8 , grid9 = g9 , grid10 = item } , items = itemsLeft , energy=energy_}
    else
    model

canInteract : Model -> NPC ->  Bool
canInteract model npc  =
    judgeAreaOverlap model npc.area

interact : Model -> NPC -> NPC
interact model npc =
    if canInteract model npc == True then
    { npc | interacttrue = True }
    else
    { npc | interacttrue = False }

interactable model = {model|npcs=List.map (interact model) model.npcs}

judgeinteract npc=
    case npc.interacttrue of
        True -> True
        _ -> False

judgeInteract model =
    { model|interacttrue = (List.member True (List.map judgeinteract model.npcs)) }
