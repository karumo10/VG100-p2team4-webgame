port module Update exposing (update)

import Message exposing (Msg(..))
import Model exposing (..)
import Items exposing (..)
import List exposing ( filter , length , head , map )
import Maybe exposing (withDefault )
import Rules exposing (..)
import Dict exposing (Dict)
import NarrativeEngine.Core.Rules as Rules
import NarrativeEngine.Core.WorldModel as WorldModel
import NarrativeEngine.Debug
import NarrativeEngine.Syntax.NarrativeParser as NarrativeParser
import Tosvg exposing (..)
import Areas exposing (..)
import MapAttr exposing (..)
import NPC exposing (..)


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
        ToHome ->
            ( mapSwitch Home model
            , Cmd.none
            )
        ToJournalist ->
            ( mapSwitch Journalist model
            , Cmd.none
            )
        ToNightClub ->
            ( mapSwitch NightClub model
            , Cmd.none
            )
        ToDaniel ->
            ( mapSwitch Daniel model
            , Cmd.none
            )




        PickUp on->
            ( pickUp { model | heroPickUp= on }
            , Cmd.none
            )

        ElevateTo1 ->
            case model.map of
                PoliceOffice ->
                    ( teleportHero ( 865, 520 ) model
                    , Cmd.none
                    )
                Home ->
                     ( teleportHero ( 1070, 520 ) model
                     , Cmd.none
                     )
                NightClub ->
                     ( teleportHero ( 1015, 470 ) model
                     , Cmd.none
                     )
                Daniel ->
                    ( teleportHero ( 910, 465 ) model
                    , Cmd.none
                    )

                _ -> (model,Cmd.none)


        ElevateTo2 ->
            case model.map of
                PoliceOffice ->
                    ( teleportHero ( 865, 290 ) model
                    , Cmd.none
                    )
                Home ->
                     ( teleportHero ( 1065, 290 ) model
                     , Cmd.none
                     )

                NightClub ->
                     ( teleportHero ( 1015, 150 ) model
                     , Cmd.none
                     )
                Daniel ->
                    ( teleportHero ( 910, 145 ) model
                    , Cmd.none
                    )

                _ -> (model,Cmd.none)

        ElevateTo3 ->
            case model.map of
                PoliceOffice ->
                    ( teleportHero ( 865, 60 ) model
                    , Cmd.none
                    )
                Home ->
                     ( teleportHero ( 1050, 80 ) model
                     , Cmd.none
                     )
                _ -> (model,Cmd.none)



        EnterVehicle on ->
            case on of
                True ->
                    ( model
                    |> enterBed
                    |> enterElevators
                    , Cmd.none )
                False ->
                    ( model, Cmd.none )
        Sleep choice ->
            case choice of
                True ->
                    let
                        model_ = mapSwitch DreamMaze model
                    in
                    ( { model_ | quests = NoQuest }, Cmd.none )
                False ->
                    ( { model | quests = NoQuest }, Cmd.none )

        Noop ->
            ( model, Cmd.none )

        InteractByKey on ->
            case on of
                True ->
                    let
                        model_={model|heroInteractWithNpc=True} --If there is no farther use, I will delete this.
                    in
                    case model.interacttrue of
                        True ->
                            ( interactByKey model_, Cmd.none )
                        _ ->
                            ( model_, Cmd.none )
                False ->
                    ( model, Cmd.none )


        InteractWith trigger ->
            interactWith__core trigger model

        UpdateDebugSearchText searchText ->
            ({ model | debug = NarrativeEngine.Debug.updateSearch searchText model.debug }, Cmd.none)

        Adkinscatch ->
            ({ model | correctsolved = (model.correctsolved + 1), conclusion = 0
                     , story = "I think Adkins's alibi is not always valid since he has his own office. He was the boss, so no one would disturb him and he could go out without anyone noticing. I told this to Allen, and he got the monitoring of Adkins's firm and found Brennan entered the firm without coming out. Then Adkins admitted that he killed Brennan because he was compared to Brennan from an early age. Everyone knew Brennan but no one heard him. Even Catherine was attracted only to Brennan. This is a tragedy of envy." }
            , Cmd.none)

        Catherinecatch ->
            ({ model | conclusion = 0, story = "I think Catherine's alibi is not always valid. We had her in custody, but we cannot found the key evidence. Catherine was devastated and refused to admit she had killed Brennan. We had to release her in the end, but everyone around him was talking about her..." }
            , Cmd.none)

        Robbery ->
            ({ model | conclusion = 0, story = "I think this is just a robbery, though the message sent to Catherine was very strange. We comforted the two people who had lost important people, and issued an arrest warrant, but nothing came of it..." }
            , Cmd.none)



        RenderGrid1Detail ->
            if model.whichGridIsOpen /= 1 then
            ({ model | whichGridIsOpen = 1 }
            , Cmd.none)
            else
            ({ model | whichGridIsOpen = 0 }
            , Cmd.none)

        RenderGrid2Detail ->
            if model.whichGridIsOpen /= 2 then
            ({ model | whichGridIsOpen = 2 }
            , Cmd.none)
            else
            ({ model | whichGridIsOpen = 0 }
            , Cmd.none)

        RenderGrid3Detail ->
            if model.whichGridIsOpen /= 3 then
            ({ model | whichGridIsOpen = 3 }
            , Cmd.none)
            else
            ({ model | whichGridIsOpen = 0 }
            , Cmd.none)

        RenderGrid4Detail ->
            if model.whichGridIsOpen /= 4 then
            ({ model | whichGridIsOpen = 4 }
            , Cmd.none)
            else
            ({ model | whichGridIsOpen = 0 }
            , Cmd.none)

        RenderGrid5Detail ->
            if model.whichGridIsOpen /= 5 then
            ({ model | whichGridIsOpen = 5 }
            , Cmd.none)
            else
            ({ model | whichGridIsOpen = 0 }
            , Cmd.none)

        RenderGrid6Detail ->
            if model.whichGridIsOpen /= 6 then
            ({ model | whichGridIsOpen = 6 }
            , Cmd.none)
            else
            ({ model | whichGridIsOpen = 0 }
            , Cmd.none)

        RenderGrid7Detail ->
            if model.whichGridIsOpen /= 7 then
            ({ model | whichGridIsOpen = 7 }
            , Cmd.none)
            else
            ({ model | whichGridIsOpen = 0 }
            , Cmd.none)

        RenderGrid8Detail ->
            if model.whichGridIsOpen /= 8 then
            ({ model | whichGridIsOpen = 8 }
            , Cmd.none)
            else
            ({ model | whichGridIsOpen = 0 }
            , Cmd.none)

        RenderGrid9Detail ->
            if model.whichGridIsOpen /= 9 then
            ({ model | whichGridIsOpen = 9 }
            , Cmd.none)
            else
            ({ model | whichGridIsOpen = 0 }
            , Cmd.none)

        RenderGrid10Detail ->
            if model.whichGridIsOpen /= 10 then
            ({ model | whichGridIsOpen = 10 }
            , Cmd.none)
            else
            ({ model | whichGridIsOpen = 0 }
            , Cmd.none)

        StartGame ->
            ({ model | map = PoliceOffice }
            , Cmd.none)

        ViewAboutUs ->
            ({ model | map = AboutUs }
            , Cmd.none)

        ViewStory ->
            ({ model | map = Story }
            , Cmd.none)

        BackToStarter ->
            ({ model | map = StarterPage }
            , Cmd.none)

        ExamineItemsInBag whichGrid ->
            let
                currItem =
                    case whichGrid of
                        1 -> model.bag.grid1
                        2 -> model.bag.grid2
                        3 -> model.bag.grid3
                        4 -> model.bag.grid4
                        5 -> model.bag.grid5
                        6 -> model.bag.grid6
                        7 -> model.bag.grid7
                        8 -> model.bag.grid8
                        9 -> model.bag.grid9
                        10 -> model.bag.grid10
                        _ -> emptyIni
                currEvi =
                    if currItem == noteIni then note_evi
                    else if currItem == diskIni then disk_evi
                    else if currItem == pillIni then pill_evi
                    else if currItem == daggerIni then dagger_evi
                    else if currItem == trueMemCardIni && not model.codeReached then trueMemCard_evi
                    else if currItem == trueMemCardIni && model.codeReached then trueMemCardContent_evi
                    else if currItem == keyIni then key_evi
                    else if currItem == paperIni then paper_evi
                    else if currItem == bankIni then bank_account_evi
                    else empty_evi
            in
            ( examineEvidence currEvi model, Cmd.none )

        ChangeCodeText code ->
            ( { model | codeContent = code }, Cmd.none )









animate : Float -> Model -> Model
animate elapsed model =
    model
        |> moveHeroLR elapsed
        |> moveHeroUD elapsed
        |> normalUpdates
        |> specialUpdates
        |> hintTrigger
        |> goToSwitching
        |> judgeInteract
        |> interactable
        |> myItem
        |> judgeIsMakingChoices
        |> pickUpWithEngine
        |> dirhero
        |> badEndsClear
        |> badEndsStory elapsed


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

dirhero : Model -> Model
dirhero model =
    let
        n = modBy 24 model.step
        dir =
            case ( model.heroMoveLeft, model.heroMoveRight ) of
                ( True, False ) ->
                    if 0 < n && n <= 1 then
                    "./hero_1.png"
                    else if 1 < n && n <= 7 then
                    "./hero.png"
                    else if 13 < n && n <= 19 then
                    "./hero_3.png"
                    else if 19 < n && n <= 24 then
                    "./hero.png"
                    else "./hero.png"

                ( False, True ) ->
                    if 0 < n && n <= 1 then
                    "./heror_1.png"
                    else if 1 < n && n <= 7 then
                    "./heror.png"
                    else if 13 < n && n <= 19 then
                    "./heror_3.png"
                    else if 19 < n && n <= 24 then
                    "./heror.png"
                    else "./heror.png"

                _ ->
                    if model.heroimage == "./hero.png"||model.heroimage == "./hero_1.png"||model.heroimage == "./hero_2.png" then
                        "./hero.png"
                    else
                        "./heror.png"
    in
        {model|heroimage = dir}

startMove : Model -> Model
startMove model =
    let
        dir =
                if directionLR model /= 0 && directionUD model /= 0 then
                    ( Just { active = True, elapsed = 0 }, Just { active = True, elapsed = 0 })
                else if directionLR model /= 0 && directionUD model == 0 then
                    ( Just { active = True, elapsed = 0 }, Nothing )
                else if directionLR model == 0 && directionUD model /= 0 then
                    ( Nothing, Just { active = True, elapsed = 0 } )
                else
                    ( Nothing, Nothing )
        step_ =
            if directionLR model /= 0 then
                if (model.step + 1) >= 24 then
                    0
                else (model.step + 1)
            else 0
    in
        { model | heroDir = dir, step = step_ }


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
            case gameMode______ of
                TotalTest -> x + dx * stride
                _ ->
                    case model.playerDoing of
                        NotMakingChoices ->
                            if List.length overlapAreas == 0 then
                                x + dx * stride
                            else if not (List.isEmpty (List.filter (\a -> isStuck model a == LeftSide) overlapAreas)) && not (List.isEmpty (List.filter(\a -> isStuck model a == RightSide) overlapAreas)) then
                                x
                            else if (List.filter (\a -> isStuck model a == LeftSide) overlapAreas |> List.length) /= 0 then
                                if dx > 0 then x
                                else x + dx * stride
                            else if (List.filter (\a -> isStuck model a == RightSide) overlapAreas |> List.length) /= 0 then
                                if dx < 0 then x
                                else x + dx * stride
                            else
                                x + dx * stride
                        MakingChoices ->
                            x
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
            case gameMode______ of
                TotalTest -> y + dy * stride
                _ ->
                    case model.playerDoing of
                        NotMakingChoices ->
                            if List.length overlapAreas == 0 then
                                y + dy * stride
                            else if not (List.isEmpty (List.filter (\a -> isStuck model a == UpSide) overlapAreas)) && not (List.isEmpty (List.filter(\a -> isStuck model a == DownSide) overlapAreas)) then
                                y
                            else if (List.filter (\a -> isStuck model a == UpSide) overlapAreas |> List.length) /= 0 then
                                if dy > 0 then y
                                else y + dy * stride
                            else if (List.filter (\a -> isStuck model a == DownSide) overlapAreas |> List.length) /= 0 then
                                if dy < 0 then y
                                else y + dy * stride
                            else
                                y + dy * stride
                        MakingChoices ->
                            y
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
        leftSide = x1 >= xl && x1 < xl + stride
        rightSide = x1 > xr - stride && x1 <= xr
        upSide = y1 < yu + stride && y1 >= yu
        downSide = y1 <= yd && y1 > yd - stride
        corner = ( leftSide || rightSide ) && ( upSide || downSide )
    in
    if corner || not (judgeAreaOverlap model area) then NoStuck
    else if leftSide then LeftSide
    else if rightSide then RightSide
    else if upSide then UpSide
    else if downSide then DownSide
    else Err



enterBed : Model -> Model
enterBed model =
    let
        beds = List.filter (\a -> a.which == Bed) model.mapAttr.vehicle
        isNearList = List.map (isVehicleNearBy model) beds
        isNear = List.foldl (||) False isNearList
        questCurr = model.quests
    in
    if (isNear) then
        case questCurr of
            BedQuest ->
                { model | quests = NoQuest }
            _ ->
                { model | quests = BedQuest }
    else model



enterElevators : Model -> Model
enterElevators model =
    let
        elevators = List.filter (\a -> a.which == Elevator) model.mapAttr.vehicle
        --elevatorAreas = List.map (\a -> a.area) elevators
        isNearList = List.map (isVehicleNearBy model) elevators
        isNear = List.foldl (||) False isNearList
        questCurr = model.quests
    in
    if (isNear) then
        case questCurr of
            ElevatorQuest ->
                { model | quests = NoQuest }
            _ ->
                { model | quests = ElevatorQuest }
    else model


isVehicleNearBy : Model -> Vehicle -> Bool
isVehicleNearBy model vehicle =
    let
        isNear = judgeAreaOverlap model vehicle.area
    in
    isNear


goToSwitching : Model -> Model -- when at exit, go to switching interface
goToSwitching model =
    let
        currMapAttr = model.mapAttr
        currMap = model.map
        currDayState = model.dayState
        currScene = ( currMap, currDayState )
        day2_night_story = "The phone is ringing. You know, this night must be tiring... you choose to go back."
        day5_home_story = "It's day time. I should take this weird but precious vacation to have a deeper reflection on the current evidence and think about what to do next, instead of go out."
        policeOfficeAttr_day2_night_ =
            List.filter (\a -> a.scene == ( currMap, currDayState )) model.mapAttr_all
            |> List.head |> withDefault policeOfficeAttr_day2_night
        itemsCheckedList =
            List.map (\a -> a.isExamined) model.evidence_all
        howMany = List.length (List.filter (\a -> a == True) itemsCheckedList)
    in
    if judgeExit model then
    if currScene == ( PoliceOffice, Day2_Night ) && (policeOfficeAttr_day2_night_.isFinished == False) then --at day2 night, restrict the player from going outside the office.
        { model
        | story = day2_night_story }
        |> teleportHero (currMapAttr.heroIni.x, currMapAttr.heroIni.y)
    else if currScene == ( Home, Day5 ) && howMany < 3 then
        { model
        | story = day5_home_story }
        |> teleportHero (currMapAttr.heroIni.x, currMapAttr.heroIni.y)
    else
        if model.map /= DreamMaze then
            if model.energy > 0 then
                mapSwitch Switching model
            else
                mapSwitch EnergyDrain model
            else
                wakeUp model
    else model


wakeUp : Model -> Model
wakeUp model =
    let
        day = model.day + 1
        dayState =
            case day of
                1 -> Day1
                2 -> Day2
                3 -> Day3
                4 -> Day4
                5 -> Day5
                _ -> TooBigOrSmall
        model_ = sceneSwitch Home dayState model |> teleportHero ( 840, 100 ) -- bed side
        story =
            if day == 3 || day == 5 then
                model_.story
            else
            "It's time to get up... Uhh, indeed a weird dream."
        isAPlayBoy = findCertainQuestion model "YES_NIGHT"
        energy_Full =
            if day == 6 && isAPlayBoy then model_.energy_Full // 2
            else if day == 7 && isAPlayBoy then model_.energy_Full * 2
            else model_.energy_Full
        energy = model_.energy_Full
    in
    { model_ | story = story, day = day, energy = energy, dayState = dayState, energy_Full = energy_Full }


mapSwitch : Map -> Model -> Model
mapSwitch newMap model =
    let
        dayState = model.dayState
        scene = ( newMap, dayState )
        mapAttr
            =
            case newMap of
                Switching -> switchingAttr -- including drainenergy, switching & start page
                _ ->
                    List.filter (\a -> a.scene == scene) model.mapAttr_all
                    |> List.head
                    |> withDefault switchingAttr
        hero = mapAttr.heroIni
        npcs = List.filter (\a -> a.place == mapAttr.scene) model.npcs_all --or allNPCs??
        story = mapAttr.story
    in
    { model | hero = hero, mapAttr = mapAttr, map = newMap, npcs_curr = npcs, story = story }

sceneSwitch : Map -> Day -> Model -> Model -- also change the day state
sceneSwitch newMap newDayState model =
    let
        dayState = newDayState
        scene = ( newMap, dayState )
        mapAttr
            =
            case newMap of
                Switching -> switchingAttr -- including drainenergy, switching & start page
                _ ->
                    List.filter (\a -> a.scene == scene) model.mapAttr_all
                    |> List.head
                    |> withDefault switchingAttr
        hero = mapAttr.heroIni
        npcs = List.filter (\a -> a.place == mapAttr.scene) allNPCs
        story = mapAttr.story
    in
    { model | hero = hero, mapAttr = mapAttr, map = newMap, npcs_curr = npcs, story = story }


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
    if canPickUp model item && isEnergyEnoughPickUp model && model.heroPickUp &&(item.isPick ==False) then
    { item | isPick = True }
    else
    item

isEnergyEnoughPickUp: Model-> Bool
isEnergyEnoughPickUp model =
    let
        energy = model.energy
        energy_Cost = model.energy_Cost_pickup
    in
    if (energy - energy_Cost)>=0 then
    True
    else
    False

filter_picked_item : Item-> Bool
filter_picked_item item=
    if item.isPick ==True then
    False
    else
    True
pickUp : Model -> Model
pickUp model =
    let
        isPickUp = model.heroPickUp --is player doing pick up commands
        ableToPick = List.filter (canPickUp model) model.items --depends on distance
        isThereAny = List.length ableToPick
        abletoPick2 =isEnergyEnoughPickUp model --depends on energy
        item = withDefault gunIni (head ableToPick)
        carry_out_pick_up = List.map (itemPickUp model) model.items ---this step just change the property but not filter
        itemsLeft = List.filter filter_picked_item carry_out_pick_up
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
        energy_ = energy - model.energy_Cost_pickup

    in
    if not isPickUp then
    model
    else if isThereAny == 1 && t1 == Empty && abletoPick2 && isPickUp then
    { model | bag = { grid1 = item , grid2 = g2 , grid3 = g3 , grid4 = g4 , grid5 = g5 , grid6 = g6 , grid7 = g7 , grid8 = g8 , grid9 = g9 , grid10 = g10 } , items = itemsLeft , energy=energy_ ,story="get it" }
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
    else if isThereAny == 0 then
    {model| story="Nothing to pick up！"}
    else if not abletoPick2 then
    {model|story="Energy is not enough!"}
    else
    model

isEnergyEnoughInteract: Model-> Bool -- I will see whether this function is still needed as I have changed the way to judge whether can interact
isEnergyEnoughInteract model =
    let
        energy = model.energy
        energy_Cost = model.energy_Cost_interact
    in
    if (energy - energy_Cost)>=0 then
    True
    else
    False

type Interact
     =Okay
     |TooFar

canInteract : Model -> NPC -> Interact
canInteract model npc  =
    if (judgeAreaOverlap model npc.area == True) then
    Okay
    else
    TooFar


interact : Model -> NPC -> NPC
interact model npc =
    if canInteract model npc == Okay then
    { npc | interacttrue = True }
    else
    { npc | interacttrue = False }


boolToint: Bool-> Int
boolToint bool =
    case bool of
        True ->1
        False -> 0

interactable : Model-> Model
interactable model =
    let
      interacted_npcs= List.map (interact model) model.npcs_curr
      --bool_of_interacted_npcs=(not (List.isEmpty(List.filter (canInteract model) model.npcs)))&&model.heroInteractWithNpc
      --energy_left=model.energy - boolToint(bool_of_interacted_npcs) * model.energy_Cost
    in
      {model|npcs_curr=interacted_npcs}--,energy=energy_left}

judgeinteract npc=
    case npc.interacttrue of
        True -> True
        _ -> False

judgeInteract : Model -> Model
judgeInteract model =
    { model|interacttrue = (List.member True (List.map judgeinteract model.npcs_curr)) }

interactWith__core : WorldModel.ID -> Model -> ( Model, Cmd Msg )
interactWith__core trigger model =
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
                    , energy = model.energy - model.energy_Cost_interact
                    }, Cmd.none)

                Nothing ->
                            -- no rule matched, so lets just show the description of the
                            -- entity that the player interacted with
                            -- ***
                            -- (by Yuxiang Zhou: this just means this NPC will not say anything new!
                            -- So we can use this to mark certain NPC as "finished".
                            -- This will be helpful for us to pass the information out of the engine.
                            -- **important** : Nothing means trigger = 0. Take comparision,
                            -- for choices, choice = 1 means it will jump out, and I implemented -1 for "it's chosen" so 0 means "it's finished but not chosen"
                    ({ model
                    | story = getDescription (makeConfig trigger trigger model) trigger model.worldModel
                    , ruleCounts = Dict.update trigger (Maybe.map ((+) 1) >> Maybe.withDefault 1 >> Just) model.ruleCounts
                    , debug = model.debug
                                  |> NarrativeEngine.Debug.setLastMatchedRuleId trigger
                                  |> NarrativeEngine.Debug.setLastInteractionId trigger
                    }, Cmd.none)



examineEvidence : Evidence -> Model -> Model
examineEvidence evi model =
    let
        currEvi = evi
        currTrigger
            = query currEvi.description model.worldModel
            |> List.map Tuple.first -- get List ID
            |> List.head -- get first (suppose only one ID for one NPC. Is it true????)
            |> withDefault "$my$own$error$msg$: no such evidence. please contact with group4"
        model_ = interactWith__core currTrigger model |> Tuple.first
        energy = model.energy
        energy_ = energy - model.energy_Cost_interact

        currEviInModel_list = List.filter (\a -> a.eviType == currEvi.eviType) model.evidence_all
        currEviInModel = currEviInModel_list
            |> List.head
            |> withDefault empty_evi
        restEviInModel = List.filter (\a -> a.eviType /= currEvi.eviType) model.evidence_all
        currEviInModel_ = { currEviInModel | isExamined = True } -----------------------------------------------------------now it is ok.
        eviInModel = [currEviInModel_] ++ restEviInModel

        model__ = { model_ | evidence_all = eviInModel }

    in
    if model.playerDoing == MakingChoices then
        model
    else if energy_ < 0 then
        {model| story = "Ah.... Why am I feel so tired, I should go home for a sleep......"}
    else if model.map /= evi.usedPlace then
        { model | story = "It's not the proper place to examine it." }
    else
        model__




interactByKey : Model -> Model
interactByKey model =
    let
        trueNPCs = List.filter (\a -> a.interacttrue == True) model.npcs_curr
        currNPC = withDefault emptyNPC (List.head trueNPCs) -- only one NPC is interacting
        currTrigger
            = query currNPC.description model.worldModel
            |> List.map Tuple.first -- get List ID
            |> List.head -- get first (suppose only one ID for one NPC. Is it true????)
            |> withDefault "$my$own$error$msg$: no such npc, in interact by X please contact with group4"
        model_ = interactWith__core currTrigger model |> Tuple.first
        energy = model.energy
        energy_ = energy - model.energy_Cost_interact
    in
    if List.isEmpty trueNPCs || model.playerDoing == MakingChoices then
        model
    else if energy_ < 0 then
        {model| story = "Ah.... Why am I feel so tired, I should go home for a sleep......"}
    else
        model_

myItem : Model -> Model
myItem model = {model | portrait = (Maybe.withDefault "" (List.head (getdescription model)))}


judgeIsMakingChoices : Model -> Model
judgeIsMakingChoices model =
    let
        isMakingChoices = query "*.choices=1" model.worldModel /= []
        playerState =
            case isMakingChoices of
                True ->
                    MakingChoices
                False ->
                    NotMakingChoices
    in
    { model | playerDoing = playerState }

hintTrigger : Model -> Model
hintTrigger model =
    let
        hints = model.mapAttr.hint
        story = model.story
        hintsAvailable = List.filter (\a -> judgeAreaOverlap model a.area) hints
        story_ = hintsAvailable
            |> List.map (\a -> a.content)
            |> List.head
            |> withDefault story

    in
    { model | story = story_ }




normalUpdates : Model -> Model
normalUpdates model =
    model
    |> npcsFinishedUpdate
    |> mapsFinishedUpdate
    |> chosenChoicesUpdate
    |> codeReachedUpdate




codeReachedUpdate : Model -> Model
codeReachedUpdate model =
    let
        len = model.codeContent |> String.length

    in
    if model.codeReached == False then
        if len == 4 then
        { model | codeReached = True }
        else model
    else model



singleNpcFinishedUpdate : Model -> NPC -> NPC
singleNpcFinishedUpdate model npc =
    let
        trigger =
                query npc.description model.worldModel
                |> List.map Tuple.first -- get List ID
                |> List.head -- get first (suppose only one ID for one NPC. Is it true????)
                |> withDefault "$my$own$error$msg$: no such npc, in updating NPCs."

        state = Rules.findMatchingRule trigger parsedData model.worldModel
        isFinished =
            case state of
                Nothing -> True
                _ -> False
    in
    { npc | isFinished = isFinished }



npcsFinishedUpdate : Model -> Model -- do it every iteration!
npcsFinishedUpdate model =
    let
        npcs_all = model.npcs_all
        npcs_all_ = List.map (singleNpcFinishedUpdate model) npcs_all
    in
    { model | npcs_all = npcs_all_ }

singleMapFinishedUpdate : Model -> MapAttr -> MapAttr -- update the mapattr, if all the npcs in one mapattr is finished, then, it will has a True 'isFInished' field
singleMapFinishedUpdate model mapAttr =
    let
        scene = mapAttr.scene
        npcsInScene = List.filter (\a -> a.place == scene) model.npcs_all
        isFinished = List.foldr (&&) True (npcsInScene |> List.map (\a -> a.isFinished))

    in
    { mapAttr | isFinished = isFinished }

mapsFinishedUpdate : Model -> Model -- do it every iteration
mapsFinishedUpdate model =
    let
        mapAttrs = model.mapAttr_all
        mapAttrs_ = List.map (singleMapFinishedUpdate model) mapAttrs
    in
    { model | mapAttr_all = mapAttrs_ }


chosenChoicesUpdate : Model -> Model --upd every iteration. the choices which has been chosen by player.
chosenChoicesUpdate model =
    let
        newList = List.map Tuple.first (query "*.choices=-1" model.worldModel)
    in
    { model | chosenChoices = newList }

findCertainQuestion : Model -> WorldModel.ID -> Bool
    -- use this to find certain questions. use ids in Rules.elm, like CHOOSEWHICHTAKENOTE, FORGOT2, FORGOT1, ...
    -- warning: only the choices for case 2 is implemented with value -1, that is only the choices after case 2 can be found
findCertainQuestion model id =
    let
        isFound = List.member id model.chosenChoices
    in
    isFound --found then true.

test_1_for_find_chosen_choices : Model -> Model
    -- a test func also an example, for you to find if the choices are chosen.
test_1_for_find_chosen_choices model =
    let
        is_found_bob_day1_yes = findCertainQuestion model "YES"
        story =
            case is_found_bob_day1_yes of
                True ->
                    "hahaha, test is passed."
                False -> "no id found as \"YES\"!"
    in
        { model | story = story }


-- specially made functions for specific scenes.please code out of this area
-- because its function names are formatted and not in the same style with the other functions


specialUpdates : Model -> Model -- put it every iterate
specialUpdates model
    =
    if not model.isEnd then
        model
        |> day2_journalist_finished_update_day
        |> day2_finished_office_finished_finished_update_home
        |> day2_finished_office_finished_update_day
        |> day3_daniel_update_story_npc
        |> day4_allen_update_coffee_machine
        |> day4_jonathon_update_coffee_machine
        |> day4_daniel_evidence_update_phone
        |> day4_daniel_finished_update_jonathon
        |> day5_nightclub_update_energy
    else model



day2_journalist_finished_update_day : Model -> Model -- format: (IMPORTANT) `time`_`mapname`_finished_update. means that this map at this time is finished, and then update somthing.
day2_journalist_finished_update_day model =
    let
        journalist_day2_map = List.filter (\a -> a.scene == (Journalist, Day2) ) model.mapAttr_all
            |> List.head
            |> withDefault journalistAttr_day2
        isFinished = journalist_day2_map.isFinished
    in
    if (model.map, model.dayState) == (Journalist, Day2) then -- restricted!
        case isFinished of
            False -> model
            True -> { model | dayState = Day2_Finished }
    else model

day2_finished_office_finished_finished_update_home : Model -> Model --"office_finished" is a map name, haha
day2_finished_office_finished_finished_update_home model =
    let
        office_finished_day2_map = List.filter (\a -> a.scene == ( PoliceOffice, Day2_Finished ) ) model.mapAttr_all
            |> List.head
            |> withDefault journalistAttr_day2
        isFinished = office_finished_day2_map.isFinished
        homeAttr = List.filter (\a -> a.scene == ( Home, Day2_Finished ) ) model.mapAttr_all
            |> List.head
            |> withDefault journalistAttr_day2
        story_ = "So strange... why there will be a role who has the same appearance as myself in my story? He even knows about me and dies? Oh, I don't submit the evidence brought from the scene, I shall have an inspection on it."
        homeAttr_ = { homeAttr | story = story_ }
        mapAttr_all_ = [ homeAttr_ ] ++ List.filter (\a -> a.scene /= ( Home, Day2_Finished ) ) model.mapAttr_all

    in
    case isFinished of
        False -> model
        True -> { model | mapAttr_all = mapAttr_all_ }

day2_finished_office_finished_update_day : Model -> Model -- format: (IMPORTANT) `time`_`mapname`_finished_update. means that this map at this time is finished, and then update somthing.
day2_finished_office_finished_update_day model =
    let
        office_day2_finished_map = List.filter (\a -> a.scene == (PoliceOffice, Day2_Finished) ) model.mapAttr_all
            |> List.head
            |> withDefault policeOfficeAttr_day2_finished
        isFinished = office_day2_finished_map.isFinished
        currNPCs = List.filter (\a -> a.place == (PoliceOffice, Day2_Night)) model.npcs_all
    in
    if (model.map, model.dayState) == (PoliceOffice, Day2_Finished) then
        case isFinished of
            False -> model
            True -> { model | dayState = Day2_Night, npcs_curr = currNPCs }
    else model

day3_daniel_update_story_npc : Model -> Model --updating story and npc
day3_daniel_update_story_npc model =
    let
        daniel_day3_finished_map = List.filter (\a -> a.scene == (Daniel, Day3) ) model.mapAttr_all
            |> List.head
            |> withDefault danielAttr_day3
        isFinished = daniel_day3_finished_map.isFinished
        park_day3_finished_map = List.filter (\a -> a.scene == (Park, Day3) ) model.mapAttr_all
            |> List.head
            |> withDefault parkAttr_day3
        police_day3_finished_map = List.filter (\a -> a.scene == (PoliceOffice, Day3) ) model.mapAttr_all
            |> List.head
            |> withDefault policeOfficeAttr_day3
        home_day3_finished_map = List.filter (\a -> a.scene == (Home, Day3)) model.mapAttr_all
            |> List.head
            |> withDefault policeOfficeAttr_day3
        story = "It's late now. You decided to go home."
        story_park = "It's night. The sky was in inky black, adorned with stars like dim, pulsing fire. It's time for home, you said to yourself."
        story_police = "There's no one in the office. You should go home."
        story_home = "On your way home, you decided to have dinner at the restaurant near Daniel's home. During your dinner, you see that a police car stopped before the door of Daniel's home. And someone took something from Daniel..."
        rest_map = List.filter (\a -> a.scene /= (Daniel, Day3) && a.scene /= (Park, Day3) && a.scene /= (PoliceOffice, Day3) && a.scene /= (Home, Day3)) model.mapAttr_all
        daniel_day3_finished_map_ = { daniel_day3_finished_map | story = story }
        park_day3_finished_map_ = { park_day3_finished_map | story = story_park }
        police_day3_finished_map_ = { police_day3_finished_map | story = story_police }
        home_day3_finished_map_ = { home_day3_finished_map | story = story_home }
        mapAttr_all = rest_map ++ [daniel_day3_finished_map_] ++ [park_day3_finished_map_] ++ [police_day3_finished_map_] ++ [home_day3_finished_map_]
        npc_all_curr = List.filter (\a -> a.itemType /= Phone ) model.npcs_all
    in
    if (model.map,model.dayState) == (Daniel, Day3) then
        if isFinished then
            { model | mapAttr_all = mapAttr_all, npcs_all = npc_all_curr }
        else
        model
    else
    model

day4_allen_update_coffee_machine : Model -> Model
day4_allen_update_coffee_machine model =
    let
        isChat = findCertainQuestion model "ASK_ALLEN"
        coffee = List.filter (\a -> a.place == ( PoliceOffice , Day4 ) && a.itemType == CoffeeMachine ) model.npcs_all
            |> List.head |> withDefault cCoffeeMachine_day4
        rest = List.filter (\a -> a.place /= ( PoliceOffice , Day4 ) || a.itemType /= CoffeeMachine) model.npcs_all
        coffee_ = { coffee | description = "COFFEE" }
        npcs_all_ = [coffee_] ++ rest
    in
    if coffee.description == "COFFEE_NORMAL" then
        if isChat then
            { model | npcs_all = npcs_all_, npcs_curr = List.filter (\a -> a.place == (PoliceOffice, Day4)) npcs_all_ }
        else model
    else model

day4_jonathon_update_coffee_machine : Model -> Model
day4_jonathon_update_coffee_machine model =
    let
        isDestroyed = findCertainQuestion model "HAVE_INVEST" || findCertainQuestion model "BAD_LIE"
        coffee = List.filter (\a -> a.place == ( PoliceOffice , Day4 ) && a.itemType == CoffeeMachine ) model.npcs_all
            |> List.head |> withDefault cCoffeeMachine_day4
        rest = List.filter (\a -> a.place /= ( PoliceOffice , Day4 ) || a.itemType /= CoffeeMachine) model.npcs_all
        coffee_ = { coffee | description = "COFFEE_NORMAL_NO_CARD" }
        npcs_all_ = [coffee_] ++ rest

    in
    if coffee.description == "COFFEE" then
        if isDestroyed then
            { model | npcs_all = npcs_all_, npcs_curr = List.filter (\a -> a.place == (PoliceOffice, Day4)) npcs_all_ }
        else model
    else model


day4_daniel_evidence_update_phone : Model -> Model
day4_daniel_evidence_update_phone model =
    let
        certainMap = List.filter (\a -> a.scene == (Daniel, Day4)) model.mapAttr_all
            |> List.head
            |> withDefault danielAttr_day4
        isFinished = certainMap.isFinished
        daniel_phone = List.filter (\a -> a.itemType == Phone_Daniel) model.npcs_all
            |> List.head
            |> withDefault danielPhone
        daniel_phone_ = { daniel_phone | place = (Daniel, Day4) }
        rest_npcs = List.filter (\a -> a.itemType /= Phone_Daniel) model.npcs_all
        npcs_all_ = rest_npcs ++ [daniel_phone_]
        npcs_curr_ = List.filter (\a -> a.place == (Daniel, Day4) ) npcs_all_
        story_daniel = "Your phone is ringing. Press X to answer the phone."
    in
    if ( daniel_phone.place == (Daniel, Nowhere) ) then
        if isFinished then
            { model | npcs_all = npcs_all_, npcs_curr = npcs_curr_, story = story_daniel }
        else
        model
    else
    model

day4_daniel_finished_update_jonathon : Model -> Model
day4_daniel_finished_update_jonathon model =
    let
        certainMap = List.filter (\a -> a.scene == (Daniel, Day4)) model.mapAttr_all
            |> List.head
            |> withDefault danielAttr_day4
        daniel_phone = List.filter (\a -> a.itemType == Phone_Daniel) model.npcs_all
            |> List.head
            |> withDefault danielPhone
        is_jonathon_changed = certainMap.isFinished && daniel_phone.place == (Daniel, Day4)
        jonathon = List.filter (\a -> a.itemType == Jonathon && a.place == ( PoliceOffice , Day4 )) model.npcs_all
            |> List.head
            |> withDefault cJonathon_day4
        jonathon_ = { jonathon | description = "JONATHON_DAY4_NEW" }
        rest_npcs = List.filter (\a -> a.itemType /= Jonathon || a.place /= ( PoliceOffice , Day4 ) ) model.npcs_all
        all_npcs_ = rest_npcs ++ [jonathon_]
    in
    if jonathon.description /= "JONATHON_DAY4_NEW" then
        if is_jonathon_changed then
        { model | npcs_all = all_npcs_ }
        else model
    else model

day5_nightclub_update_energy : Model -> Model
day5_nightclub_update_energy model =
    let
        isAPlayBoy = findCertainQuestion model "YES_NIGHT"

    in
    if isAPlayBoy && (model.map,model.dayState) == (NightClub, Day5) then
    { model | energy = 0 }
    else model


badEndsStory : Float -> Model -> Model
badEndsStory elapsed model =
    let
        isEnding = model.isEnd
        accum = model.endingTimeAccum
        accum_ =
            if isEnding then accum + elapsed
            else accum
        interval = 5000
        story_ = List.filter (\a -> Tuple.first a == True) (badEndsList model)
            |> List.head
            |> withDefault (True, "error!!!!!!!!!!!!")
            |> Tuple.second
    in
    if accum_ > interval then
        { model | story = story_, endingTimeAccum = 0 }
    else
        { model | endingTimeAccum = accum_ }


badEndsClear : Model -> Model
badEndsClear model =
    let
        haveBeenEnding = model.isEnd
        isEnding = List.foldr (||) False (List.map (Tuple.first) (badEndsList model))
    in
    if not haveBeenEnding && isEnding then
        { model | npcs_all = [], isEnd = True } |> teleportHero (1000, 1000)
    else
    model




badEnd1 : Model -> ( Bool, String )
badEnd1 model =
    let
        isEatPill = findCertainQuestion model "TAKE_PILL"
    in
    if isEatPill then
    (True, "[Bad End: Reckless Authority]\nYou thought you've made a great decision until the scene before your eyes started to blur and distort. You struggle to induce vomiting, but it's too late." )
    else (False, model.story)

badEnd2 : Model -> ( Bool, String )
badEnd2 model =
    let
        isTooEager = findCertainQuestion model "ITS_YOU"
    in
    if isTooEager then
    (True, "[Bad End: Too eager]\nNews: A fire hazard broke out yesterday at one department in XX's Road. A man named Kay was dead in the accident. The reason for the fire hazard is still under discovery...")
    else (False, model.story)

badEnd3 : Model -> ( Bool, String )
badEnd3 model =
    let
        isParadised = findCertainQuestion model "PARADISE_OWNER"
    in
    if isParadised then
    (True, "[Bad End: Lost in Desire]\nYou find that the VIP card is beyond your imagination... The owner seems to extremely care about you. You drink a lot every night the following week. You get lost in the \"Paradise\".")
    else (False, model.story)

badEnd4 : Model -> ( Bool, String )
badEnd4 model =
    let
        isExploded =
            if not model.codeReached || model.codeContent == "ASWN" then False
            else True
    in
    if isExploded then
    (True, "[Bad End: Exploded]\nNews: An explosion happened at one department on XX's Road. A man named Kay was found dead in the explosion. The link between this explosion and the recent terrorist attacks is still unknown. ")
    else (False, model.story)

badEnd5 : Model -> ( Bool, String )
badEnd5 model =
    let
        isCaught =
            findCertainQuestion model "HEAR"
    in
    if isCaught then
    (True, "[Bad End: Forbidden Park]\nStory: News report: A new policeman is employed to replace the place of the missing police Kay.")
    else (False, model.story)


badEndsList : Model -> List (Bool, String)
badEndsList model = [ badEnd1 model, badEnd2 model, badEnd3 model, badEnd4 model, badEnd5 model ]

pickUpWithEngine : Model -> Model
pickUpWithEngine model =
    model
    |> pickPill
    |> pickDiskOrNote
    |> pickDagger
    |> pickMemCard
    |> pickKey
    |> pickPaper
    |> pickBank
    |> pickFakeMemCard




isRepeat : Item -> Model -> Bool
isRepeat item model =
    let
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
    in
    if item == g1 || item == g2 || item == g3 || item == g4 || item == g5 || item == g6 || item == g7 || item == g8 || item == g9 || item == g10 then
    True
    else
    False


pickSingleItem : String -> Item -> Model -> Model
pickSingleItem theChoice itemIni model =
    let
        isTaken = findCertainQuestion model theChoice
        item =
            if isTaken then itemIni
            else emptyIni
        repeatOrNot = isRepeat item model
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
    in
    if repeatOrNot == False && t1 == Empty then
    { model | bag = { grid1 = item , grid2 = g2 , grid3 = g3 , grid4 = g4 , grid5 = g5 , grid6 = g6 , grid7 = g7 , grid8 = g8 , grid9 = g9 , grid10 = g10 }}
    else if repeatOrNot == False && t1 /= Empty && t2 == Empty then
    { model | bag = { grid1 = g1 , grid2 = item , grid3 = g3 , grid4 = g4 , grid5 = g5 , grid6 = g6 , grid7 = g7 , grid8 = g8 , grid9 = g9 , grid10 = g10 }}
    else if repeatOrNot == False && t1 /= Empty && t2 /= Empty && t3 == Empty then
    { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = item , grid4 = g4 , grid5 = g5 , grid6 = g6 , grid7 = g7 , grid8 = g8 , grid9 = g9 , grid10 = g10 }}
    else if repeatOrNot == False && t1 /= Empty && t2 /= Empty && t3 /= Empty && t4 == Empty then
    { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = g3 , grid4 = item , grid5 = g5 , grid6 = g6 , grid7 = g7 , grid8 = g8 , grid9 = g9 , grid10 = g10 }}
    else if repeatOrNot == False && t1 /= Empty && t2 /= Empty && t3 /= Empty && t4 /= Empty && t5 == Empty then
    { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = g3 , grid4 = g4 , grid5 = item , grid6 = g6 , grid7 = g7 , grid8 = g8 , grid9 = g9 , grid10 = g10 }}
    else if repeatOrNot == False && t1 /= Empty && t2 /= Empty && t3 /= Empty && t4 /= Empty && t5 /= Empty && t6 == Empty then
    { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = g3 , grid4 = g4 , grid5 = g5 , grid6 = item , grid7 = g7 , grid8 = g8 , grid9 = g9 , grid10 = g10 }}
    else if repeatOrNot == False && t1 /= Empty && t2 /= Empty && t3 /= Empty && t4 /= Empty && t5 /= Empty && t6 /= Empty && t7 == Empty then
    { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = g3 , grid4 = g4 , grid5 = g5 , grid6 = g6 , grid7 = item , grid8 = g8 , grid9 = g9 , grid10 = g10 } }
    else if repeatOrNot == False && t1 /= Empty && t2 /= Empty && t3 /= Empty && t4 /= Empty && t5 /= Empty && t6 /= Empty && t7 /= Empty && t8 == Empty then
    { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = g3 , grid4 = g4 , grid5 = g5 , grid6 = g6 , grid7 = g7 , grid8 = item , grid9 = g9 , grid10 = g10 } }
    else if repeatOrNot == False && t1 /= Empty && t2 /= Empty && t3 /= Empty && t4 /= Empty && t5 /= Empty && t6 /= Empty && t7 /= Empty && t8 /= Empty && t9 == Empty then
    { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = g3 , grid4 = g4 , grid5 = g5 , grid6 = g6 , grid7 = g7 , grid8 = g8 , grid9 = item , grid10 = g10 } }
    else if repeatOrNot == False && t1 /= Empty && t2 /= Empty && t3 /= Empty && t4 /= Empty && t5 /= Empty && t6 /= Empty && t7 /= Empty && t8 /= Empty && t9 /= Empty && t10 == Empty then
    { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = g3 , grid4 = g4 , grid5 = g5 , grid6 = g6 , grid7 = g7 , grid8 = g8 , grid9 = g9 , grid10 = item }}
    else
    model


pickFakeMemCard : Model -> Model
pickFakeMemCard model =
    pickSingleItem "FAKE_MEM_CARD" fakeMemCardIni model

pickBank: Model -> Model
pickBank model =
    pickSingleItem "BANK" bankIni model

pickPaper: Model -> Model
pickPaper model =
    pickSingleItem "PAPER" paperIni model

pickKey: Model -> Model
pickKey model =
    pickSingleItem "KEY_JONATHON" keyIni model

pickMemCard : Model -> Model
pickMemCard model =
    pickSingleItem "OPEN_COFFEE_MACHINE" trueMemCardIni model


pickDagger : Model -> Model
pickDagger model =
    pickSingleItem "SEARCH_SOFA" daggerIni model


pickPill : Model -> Model
pickPill model =
    pickSingleItem "SEARCH_TABLE" pillIni model


pickDiskOrNote : Model -> Model
pickDiskOrNote model =
    let
        isDiskTaken = findCertainQuestion model "CHOOSEWHICHTAKEDISK"
        isNoteTaken = findCertainQuestion model "CHOOSEWHICHTAKENOTE"
        item =
             if isDiskTaken == True && isNoteTaken == False then diskIni
             else if isDiskTaken == False && isNoteTaken == True then noteIni
             else if isDiskTaken == False && isNoteTaken == False then emptyIni
             else emptyIni
        repeatOrNot = isRepeat item model
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
    in
    if repeatOrNot == False && t1 == Empty then
    { model | bag = { grid1 = item , grid2 = g2 , grid3 = g3 , grid4 = g4 , grid5 = g5 , grid6 = g6 , grid7 = g7 , grid8 = g8 , grid9 = g9 , grid10 = g10 } }
    else if repeatOrNot == False && t1 /= Empty && t2 == Empty then
    { model | bag = { grid1 = g1 , grid2 = item , grid3 = g3 , grid4 = g4 , grid5 = g5 , grid6 = g6 , grid7 = g7 , grid8 = g8 , grid9 = g9 , grid10 = g10 } }
    else if repeatOrNot == False && t1 /= Empty && t2 /= Empty && t3 == Empty then
    { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = item , grid4 = g4 , grid5 = g5 , grid6 = g6 , grid7 = g7 , grid8 = g8 , grid9 = g9 , grid10 = g10 } }
    else if repeatOrNot == False && t1 /= Empty && t2 /= Empty && t3 /= Empty && t4 == Empty then
    { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = g3 , grid4 = item , grid5 = g5 , grid6 = g6 , grid7 = g7 , grid8 = g8 , grid9 = g9 , grid10 = g10 } }
    else if repeatOrNot == False && t1 /= Empty && t2 /= Empty && t3 /= Empty && t4 /= Empty && t5 == Empty then
    { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = g3 , grid4 = g4 , grid5 = item , grid6 = g6 , grid7 = g7 , grid8 = g8 , grid9 = g9 , grid10 = g10 } }
    else if repeatOrNot == False && t1 /= Empty && t2 /= Empty && t3 /= Empty && t4 /= Empty && t5 /= Empty && t6 == Empty then
    { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = g3 , grid4 = g4 , grid5 = g5 , grid6 = item , grid7 = g7 , grid8 = g8 , grid9 = g9 , grid10 = g10 } }
    else if repeatOrNot == False && t1 /= Empty && t2 /= Empty && t3 /= Empty && t4 /= Empty && t5 /= Empty && t6 /= Empty && t7 == Empty then
    { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = g3 , grid4 = g4 , grid5 = g5 , grid6 = g6 , grid7 = item , grid8 = g8 , grid9 = g9 , grid10 = g10 } }
    else if repeatOrNot == False && t1 /= Empty && t2 /= Empty && t3 /= Empty && t4 /= Empty && t5 /= Empty && t6 /= Empty && t7 /= Empty && t8 == Empty then
    { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = g3 , grid4 = g4 , grid5 = g5 , grid6 = g6 , grid7 = g7 , grid8 = item , grid9 = g9 , grid10 = g10 } }
    else if repeatOrNot == False && t1 /= Empty && t2 /= Empty && t3 /= Empty && t4 /= Empty && t5 /= Empty && t6 /= Empty && t7 /= Empty && t8 /= Empty && t9 == Empty then
    { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = g3 , grid4 = g4 , grid5 = g5 , grid6 = g6 , grid7 = g7 , grid8 = g8 , grid9 = item , grid10 = g10 } }
    else if repeatOrNot == False && t1 /= Empty && t2 /= Empty && t3 /= Empty && t4 /= Empty && t5 /= Empty && t6 /= Empty && t7 /= Empty && t8 /= Empty && t9 /= Empty && t10 == Empty then
    { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = g3 , grid4 = g4 , grid5 = g5 , grid6 = g6 , grid7 = g7 , grid8 = g8 , grid9 = g9 , grid10 = item } }
    else
    model





whichActionTakenDisk : WorldModel.ID -> Bool
whichActionTakenDisk id =
    if id == "CHOOSEWHICHTAKEDISK" then
    True
    else
    False

whichActionTakenNote : WorldModel.ID -> Bool
whichActionTakenNote id =
    if id == "CHOOSEWHICHTAKENOTE" then
    True

    else
    False










