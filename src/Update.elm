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
        ToCityCouncil ->
            ( mapSwitch CityCouncil model
            , Cmd.none
            )
        ToBackStreet ->
            ( mapSwitch BackStreet model
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
                    if model.dayState /= Day7 || findCertainQuestion model "PASSWORD2" then
                    ( teleportHero ( 865, 60 ) model
                    , Cmd.none
                    )
                    else
                    ( interactWithJonathonLock model, Cmd.none )
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
                     , story = "I think Adkins's alibi is not always valid since he was the boss, so no one would disturb him and he could go out without anyone noticing. Allen got the monitoring of Adkins's firm and found Brennan entered the firm without coming out. Then Adkins admitted that he killed Brennan because he was compared to Brennan from an early age. Even Catherine was attracted only to Brennan. This is a tragedy of envy. \n Tutorial: Now take the police car to go home for sleep!" }
            , Cmd.none)

        Catherinecatch ->
            ({ model | conclusion = 0, story = "I think Catherine's alibi is not always valid. We had her in custody, but we cannot found the key evidence. Catherine was devastated and refused to admit she had killed Brennan. We had to release her in the end, but everyone around him was talking about her... \n \n Tutorial: Now take the police car to go home for sleep!" }
            , Cmd.none)

        Robbery ->
            ({ model | conclusion = 0, story = "I think this is just a robbery, though the message sent to Catherine was very strange. We comforted the two people who had lost important people, and issued an arrest warrant, but nothing came of it... \n \n \n Tutorial: Now take the police car to go home for sleep!" }
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

        RenderGrid11Detail ->
            if model.whichGridIsOpen /= 11 then
            ({ model | whichGridIsOpen = 11 }
            , Cmd.none)
            else
            ({ model | whichGridIsOpen = 0 }
            , Cmd.none)

        RenderGrid12Detail ->
            if model.whichGridIsOpen /= 12 then
            ({ model | whichGridIsOpen = 12 }
            , Cmd.none)
            else
            ({ model | whichGridIsOpen = 0 }
            , Cmd.none)

        RenderGrid13Detail ->
            if model.whichGridIsOpen /= 13 then
            ({ model | whichGridIsOpen = 13 }
            , Cmd.none)
            else
            ({ model | whichGridIsOpen = 0 }
            , Cmd.none)

        RenderGrid14Detail ->
            if model.whichGridIsOpen /= 14 then
            ({ model | whichGridIsOpen = 14 }
            , Cmd.none)
            else
            ({ model | whichGridIsOpen = 0 }
            , Cmd.none)

        RenderGrid15Detail ->
            if model.whichGridIsOpen /= 15 then
            ({ model | whichGridIsOpen = 15 }
            , Cmd.none)
            else
            ({ model | whichGridIsOpen = 0 }
            , Cmd.none)

        RenderGrid16Detail ->
            if model.whichGridIsOpen /= 16 then
            ({ model | whichGridIsOpen = 16 }
            , Cmd.none)
            else
            ({ model | whichGridIsOpen = 0 }
            , Cmd.none)

        RenderGrid17Detail ->
            if model.whichGridIsOpen /= 17 then
            ({ model | whichGridIsOpen = 17 }
            , Cmd.none)
            else
            ({ model | whichGridIsOpen = 0 }
            , Cmd.none)

        RenderGrid18Detail ->
            if model.whichGridIsOpen /= 18 then
            ({ model | whichGridIsOpen = 18 }
            , Cmd.none)
            else
            ({ model | whichGridIsOpen = 0 }
            , Cmd.none)

        RenderGrid19Detail ->
            if model.whichGridIsOpen /= 19 then
            ({ model | whichGridIsOpen = 19 }
            , Cmd.none)
            else
            ({ model | whichGridIsOpen = 0 }
            , Cmd.none)

        RenderGrid20Detail ->
            if model.whichGridIsOpen /= 20 then
            ({ model | whichGridIsOpen = 20 }
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
                        11 -> model.bag.grid11
                        12 -> model.bag.grid12
                        13 -> model.bag.grid13
                        14 -> model.bag.grid14
                        15 -> model.bag.grid15
                        16 -> model.bag.grid16
                        17 -> model.bag.grid17
                        18 -> model.bag.grid18
                        19 -> model.bag.grid19
                        20 -> model.bag.grid20
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
                    else if currItem == letterIni then letter_evi
                    else if currItem == bankCardIni then bank_card_evi
                    else if currItem == dagger2Ini then dagger2_evi
                    else if currItem == documentsIni then documents_evi
                    else if currItem == pillsIni then pills_jo_evi
                    else if currItem == planIni then plan_evi
                    else if currItem == bankaccIni then bankacc_evi
                    else if currItem == customconIni then customcon_evi
                    else if currItem == fakeMemCardIni then fakeMemCardContent_evi
                    else empty_evi
            in
            ( examineEvidence currEvi model, Cmd.none )

        ChangeCodeText code ->
            ( { model | codeContent = code }, Cmd.none )

        CloseGrid ->
            ( { model | whichGridIsOpen = 0 }, Cmd.none )

        AskDelete whichGrid ->
            ( (itemDelete model whichGrid), Cmd.none )









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
        |> endings elapsed


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
                6 -> Day6
                7 -> Day7
                8 -> Day8
                9 -> Day9
                _ -> TooBigOrSmall
        model_ = sceneSwitch Home dayState model |> teleportHero ( 840, 100 ) -- bed side
        story =
            if day == 3 || day == 5 || day == 7 || day == 8 then
                model_.story
            else if day == 6 then
            "What a comfortable night! No dream, no maze!"
            else
            "It's time to get up... Uhh, indeed a weird dream."
        isAPlayBoy = findCertainQuestion model "YES_NIGHT"
        energy_Full =
            if day == 6 && isAPlayBoy then model_.energy_Full // 2
            else if day == 7 && isAPlayBoy then model_.energy_Full * 2
            else model_.energy_Full
        energy = model_.energy_Full
    in

    { model_ | story = story, day = day, energy = energy, dayState = dayState, energy_Full = energy_Full, isTeleportedToCouncil = False }


mapSwitch : Map -> Model -> Model
mapSwitch newMap model =
    let
        dayState = model.dayState
        scene = ( newMap, dayState )
        mapAttr
            =
            case newMap of
                Switching ->
                    if dayState /= Day7 then
                    switchingAttr -- including drainenergy, switching & start page
                    else
                    List.filter (\a -> a.scene == ( Switching, Nowhere )) model.mapAttr_all
                    |> List.head
                    |> withDefault switchingAttr

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
        g11 = model.bag.grid11
        g12 = model.bag.grid12
        g13 = model.bag.grid13
        g14 = model.bag.grid14
        g15 = model.bag.grid15
        g16 = model.bag.grid16
        g17 = model.bag.grid17
        g18 = model.bag.grid18
        g19 = model.bag.grid19
        g20 = model.bag.grid20
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
        t11 = model.bag.grid11.itemType
        t12 = model.bag.grid12.itemType
        t13 = model.bag.grid13.itemType
        t14 = model.bag.grid14.itemType
        t15 = model.bag.grid15.itemType
        t16 = model.bag.grid16.itemType
        t17 = model.bag.grid17.itemType
        t18 = model.bag.grid18.itemType
        t19 = model.bag.grid19.itemType
        t20 = model.bag.grid20.itemType
        energy = model.energy
        energy_ = energy - model.energy_Cost_pickup
    in
    if not isPickUp then
    model
    else if isThereAny == 1 && t1 == Empty && abletoPick2 && isPickUp then
    { model | bag = { grid1 = item , grid2 = g2 , grid3 = g3 , grid4 = g4 , grid5 = g5 , grid6 = g6 , grid7 = g7 , grid8 = g8 , grid9 = g9 , grid10 = g10
    , grid11 = g11 , grid12 = g12 , grid13 = g13 , grid14 = g14 , grid15 = g15 , grid16 = g16 , grid17 = g17 , grid18 = g18 , grid19 = g19 , grid20 = g20 } , items = itemsLeft , energy=energy_ ,story="get it" }
    else if isThereAny == 1 && t1 /= Empty && t2 == Empty && abletoPick2 && isPickUp then
    { model | bag = { grid1 = g1 , grid2 = item , grid3 = g3 , grid4 = g4 , grid5 = g5 , grid6 = g6 , grid7 = g7 , grid8 = g8 , grid9 = g9 , grid10 = g10
    , grid11 = g11 , grid12 = g12 , grid13 = g13 , grid14 = g14 , grid15 = g15 , grid16 = g16 , grid17 = g17 , grid18 = g18 , grid19 = g19 , grid20 = g20 } , items = itemsLeft , energy=energy_}
    else if isThereAny == 1 && t1 /= Empty && t2 /= Empty && t3 == Empty && abletoPick2 && isPickUp then
    { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = item , grid4 = g4 , grid5 = g5 , grid6 = g6 , grid7 = g7 , grid8 = g8 , grid9 = g9 , grid10 = g10
    , grid11 = g11 , grid12 = g12 , grid13 = g13 , grid14 = g14 , grid15 = g15 , grid16 = g16 , grid17 = g17 , grid18 = g18 , grid19 = g19 , grid20 = g20 } , items = itemsLeft , energy=energy_}
    else if isThereAny == 1 && t1 /= Empty && t2 /= Empty && t3 /= Empty && t4 == Empty && abletoPick2 && isPickUp then
    { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = g3 , grid4 = item , grid5 = g5 , grid6 = g6 , grid7 = g7 , grid8 = g8 , grid9 = g9 , grid10 = g10
    , grid11 = g11 , grid12 = g12 , grid13 = g13 , grid14 = g14 , grid15 = g15 , grid16 = g16 , grid17 = g17 , grid18 = g18 , grid19 = g19 , grid20 = g20 } , items = itemsLeft , energy=energy_}
    else if isThereAny == 1 && t1 /= Empty && t2 /= Empty && t3 /= Empty && t4 /= Empty && t5 == Empty && abletoPick2 && isPickUp then
    { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = g3 , grid4 = g4 , grid5 = item , grid6 = g6 , grid7 = g7 , grid8 = g8 , grid9 = g9 , grid10 = g10
    , grid11 = g11 , grid12 = g12 , grid13 = g13 , grid14 = g14 , grid15 = g15 , grid16 = g16 , grid17 = g17 , grid18 = g18 , grid19 = g19 , grid20 = g20 } , items = itemsLeft , energy=energy_}
    else if isThereAny == 1 && t1 /= Empty && t2 /= Empty && t3 /= Empty && t4 /= Empty && t5 /= Empty && t6 == Empty && abletoPick2 && isPickUp then
    { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = g3 , grid4 = g4 , grid5 = g5 , grid6 = item , grid7 = g7 , grid8 = g8 , grid9 = g9 , grid10 = g10
    , grid11 = g11 , grid12 = g12 , grid13 = g13 , grid14 = g14 , grid15 = g15 , grid16 = g16 , grid17 = g17 , grid18 = g18 , grid19 = g19 , grid20 = g20 } , items = itemsLeft , energy=energy_}
    else if isThereAny == 1 && t1 /= Empty && t2 /= Empty && t3 /= Empty && t4 /= Empty && t5 /= Empty && t6 /= Empty && t7 == Empty && abletoPick2 && isPickUp then
    { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = g3 , grid4 = g4 , grid5 = g5 , grid6 = g6 , grid7 = item , grid8 = g8 , grid9 = g9 , grid10 = g10
    , grid11 = g11 , grid12 = g12 , grid13 = g13 , grid14 = g14 , grid15 = g15 , grid16 = g16 , grid17 = g17 , grid18 = g18 , grid19 = g19 , grid20 = g20 } , items = itemsLeft , energy=energy_}
    else if isThereAny == 1 && t1 /= Empty && t2 /= Empty && t3 /= Empty && t4 /= Empty && t5 /= Empty && t6 /= Empty && t7 /= Empty && t8 == Empty && abletoPick2 && isPickUp then
    { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = g3 , grid4 = g4 , grid5 = g5 , grid6 = g6 , grid7 = g7 , grid8 = item , grid9 = g9 , grid10 = g10
    , grid11 = g11 , grid12 = g12 , grid13 = g13 , grid14 = g14 , grid15 = g15 , grid16 = g16 , grid17 = g17 , grid18 = g18 , grid19 = g19 , grid20 = g20 } , items = itemsLeft , energy=energy_}
    else if isThereAny == 1 && t1 /= Empty && t2 /= Empty && t3 /= Empty && t4 /= Empty && t5 /= Empty && t6 /= Empty && t7 /= Empty && t8 /= Empty && t9 == Empty && abletoPick2 && isPickUp then
    { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = g3 , grid4 = g4 , grid5 = g5 , grid6 = g6 , grid7 = g7 , grid8 = g8 , grid9 = item , grid10 = g10
    , grid11 = g11 , grid12 = g12 , grid13 = g13 , grid14 = g14 , grid15 = g15 , grid16 = g16 , grid17 = g17 , grid18 = g18 , grid19 = g19 , grid20 = g20 } , items = itemsLeft , energy=energy_}
    else if isThereAny == 1 && t1 /= Empty && t2 /= Empty && t3 /= Empty && t4 /= Empty && t5 /= Empty && t6 /= Empty && t7 /= Empty && t8 /= Empty && t9 /= Empty && t10 == Empty && abletoPick2 && isPickUp then
    { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = g3 , grid4 = g4 , grid5 = g5 , grid6 = g6 , grid7 = g7 , grid8 = g8 , grid9 = g9 , grid10 = item
    , grid11 = g11 , grid12 = g12 , grid13 = g13 , grid14 = g14 , grid15 = g15 , grid16 = g16 , grid17 = g17 , grid18 = g18 , grid19 = g19 , grid20 = g20 } , items = itemsLeft , energy=energy_}
    else if isThereAny == 1 && t1 /= Empty && t2 /= Empty && t3 /= Empty && t4 /= Empty && t5 /= Empty && t6 /= Empty && t7 /= Empty && t8 /= Empty && t9 /= Empty && t10 /= Empty
     && t11 == Empty && abletoPick2 && isPickUp then
    { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = g3 , grid4 = g4 , grid5 = g5 , grid6 = g6 , grid7 = g7 , grid8 = g8 , grid9 = g9 , grid10 = g10
    , grid11 = item , grid12 = g12 , grid13 = g13 , grid14 = g14 , grid15 = g15 , grid16 = g16 , grid17 = g17 , grid18 = g18 , grid19 = g19 , grid20 = g20 } , items = itemsLeft , energy=energy_ ,story="get it" }
    else if isThereAny == 1 && t1 /= Empty && t2 /= Empty && t3 /= Empty && t4 /= Empty && t5 /= Empty && t6 /= Empty && t7 /= Empty && t8 /= Empty && t9 /= Empty && t10 /= Empty
     && t11 /= Empty && t12 == Empty && abletoPick2 && isPickUp then
    { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = g3 , grid4 = g4 , grid5 = g5 , grid6 = g6 , grid7 = g7 , grid8 = g8 , grid9 = g9 , grid10 = g10
    , grid11 = g11 , grid12 = item , grid13 = g13 , grid14 = g14 , grid15 = g15 , grid16 = g16 , grid17 = g17 , grid18 = g18 , grid19 = g19 , grid20 = g20 } , items = itemsLeft , energy=energy_}
    else if isThereAny == 1 && t1 /= Empty && t2 /= Empty && t3 /= Empty && t4 /= Empty && t5 /= Empty && t6 /= Empty && t7 /= Empty && t8 /= Empty && t9 /= Empty && t10 /= Empty
     && t11 /= Empty && t12 /= Empty && t13 == Empty && abletoPick2 && isPickUp then
    { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = g3 , grid4 = g4 , grid5 = g5 , grid6 = g6 , grid7 = g7 , grid8 = g8 , grid9 = g9 , grid10 = g10
    , grid11 = g11 , grid12 = g12 , grid13 = item , grid14 = g14 , grid15 = g15 , grid16 = g16 , grid17 = g17 , grid18 = g18 , grid19 = g19 , grid20 = g20 } , items = itemsLeft , energy=energy_}
    else if isThereAny == 1 && t1 /= Empty && t2 /= Empty && t3 /= Empty && t4 /= Empty && t5 /= Empty && t6 /= Empty && t7 /= Empty && t8 /= Empty && t9 /= Empty && t10 /= Empty
     && t11 /= Empty && t12 /= Empty && t13 /= Empty && t14 == Empty && abletoPick2 && isPickUp then
    { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = g3 , grid4 = g4 , grid5 = g5 , grid6 = g6 , grid7 = g7 , grid8 = g8 , grid9 = g9 , grid10 = g10
    , grid11 = g11 , grid12 = g12 , grid13 = g13 , grid14 = item , grid15 = g15 , grid16 = g16 , grid17 = g17 , grid18 = g18 , grid19 = g19 , grid20 = g20 } , items = itemsLeft , energy=energy_}
    else if isThereAny == 1 && t1 /= Empty && t2 /= Empty && t3 /= Empty && t4 /= Empty && t5 /= Empty && t6 /= Empty && t7 /= Empty && t8 /= Empty && t9 /= Empty && t10 /= Empty
     && t11 /= Empty && t12 /= Empty && t13 /= Empty && t14 /= Empty && t15 == Empty && abletoPick2 && isPickUp then
    { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = g3 , grid4 = g4 , grid5 = g5 , grid6 = g6 , grid7 = g7 , grid8 = g8 , grid9 = g9 , grid10 = g10
    , grid11 = g11 , grid12 = g12 , grid13 = g13 , grid14 = g14 , grid15 = item , grid16 = g16 , grid17 = g17 , grid18 = g18 , grid19 = g19 , grid20 = g20 } , items = itemsLeft , energy=energy_}
    else if isThereAny == 1 && t1 /= Empty && t2 /= Empty && t3 /= Empty && t4 /= Empty && t5 /= Empty && t6 /= Empty && t7 /= Empty && t8 /= Empty && t9 /= Empty && t10 /= Empty
     && t11 /= Empty && t12 /= Empty && t13 /= Empty && t14 /= Empty && t15 /= Empty && t16 == Empty && abletoPick2 && isPickUp then
    { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = g3 , grid4 = g4 , grid5 = g5 , grid6 = g6 , grid7 = g7 , grid8 = g8 , grid9 = g9 , grid10 = g10
    , grid11 = g11 , grid12 = g12 , grid13 = g13 , grid14 = g14 , grid15 = g15 , grid16 = item , grid17 = g17 , grid18 = g18 , grid19 = g19 , grid20 = g20 } , items = itemsLeft , energy=energy_}
    else if isThereAny == 1 && t1 /= Empty && t2 /= Empty && t3 /= Empty && t4 /= Empty && t5 /= Empty && t6 /= Empty && t7 /= Empty && t8 /= Empty && t9 /= Empty && t10 /= Empty
     && t11 /= Empty && t12 /= Empty && t13 /= Empty && t14 /= Empty && t15 /= Empty && t16 /= Empty && t17 == Empty && abletoPick2 && isPickUp then
    { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = g3 , grid4 = g4 , grid5 = g5 , grid6 = g6 , grid7 = g7 , grid8 = g8 , grid9 = g9 , grid10 = g10
    , grid11 = g11 , grid12 = g12 , grid13 = g13 , grid14 = g14 , grid15 = g15 , grid16 = g16 , grid17 = item , grid18 = g18 , grid19 = g19 , grid20 = g20 } , items = itemsLeft , energy=energy_}
    else if isThereAny == 1 && t1 /= Empty && t2 /= Empty && t3 /= Empty && t4 /= Empty && t5 /= Empty && t6 /= Empty && t7 /= Empty && t8 /= Empty && t9 /= Empty && t10 /= Empty
     && t11 /= Empty && t12 /= Empty && t13 /= Empty && t14 /= Empty && t15 /= Empty && t16 /= Empty && t17 /= Empty && t18 == Empty && abletoPick2 && isPickUp then
    { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = g3 , grid4 = g4 , grid5 = g5 , grid6 = g6 , grid7 = g7 , grid8 = g8 , grid9 = g9 , grid10 = g10
    , grid11 = g11 , grid12 = g12 , grid13 = g13 , grid14 = g14 , grid15 = g15 , grid16 = g16 , grid17 = g17 , grid18 = item , grid19 = g19 , grid20 = g20 } , items = itemsLeft , energy=energy_}
    else if isThereAny == 1 && t1 /= Empty && t2 /= Empty && t3 /= Empty && t4 /= Empty && t5 /= Empty && t6 /= Empty && t7 /= Empty && t8 /= Empty && t9 /= Empty && t10 /= Empty
     && t11 /= Empty && t12 /= Empty && t13 /= Empty && t14 /= Empty && t15 /= Empty && t16 /= Empty && t17 /= Empty && t18 /= Empty && t19 == Empty && abletoPick2 && isPickUp then
    { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = g3 , grid4 = g4 , grid5 = g5 , grid6 = g6 , grid7 = g7 , grid8 = g8 , grid9 = g9 , grid10 = g10
    , grid11 = g11 , grid12 = g12 , grid13 = g13 , grid14 = g14 , grid15 = g15 , grid16 = g16 , grid17 = g17 , grid18 = g18 , grid19 = item , grid20 = g20 } , items = itemsLeft , energy=energy_}
    else if isThereAny == 1 && t1 /= Empty && t2 /= Empty && t3 /= Empty && t4 /= Empty && t5 /= Empty && t6 /= Empty && t7 /= Empty && t8 /= Empty && t9 /= Empty && t10 /= Empty
     && t11 /= Empty && t12 /= Empty && t13 /= Empty && t14 /= Empty && t15 /= Empty && t16 /= Empty && t17 /= Empty && t18 /= Empty && t19 /= Empty && t20 == Empty && abletoPick2 && isPickUp then
    { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = g3 , grid4 = g4 , grid5 = g5 , grid6 = g6 , grid7 = g7 , grid8 = g8 , grid9 = g9 , grid10 = g10
    , grid11 = g11 , grid12 = g12 , grid13 = g13 , grid14 = g14 , grid15 = g15 , grid16 = g16 , grid17 = g17 , grid18 = g18 , grid19 = g19 , grid20 = item } , items = itemsLeft , energy=energy_}
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

isEvidenceExamined : Model -> EvidenceType -> Bool
isEvidenceExamined model evi =
    let
        currEvi = List.filter (\a -> a.eviType == evi) model.evidence_all
            |> List.head |> withDefault empty_evi
    in
    currEvi.isExamined


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

interactWithJonathonLock : Model -> Model
interactWithJonathonLock model =
    let
        currNPC = List.filter (\a -> a.description == "LOCK") model.npcs_all
            |> List.head |> withDefault jonathonLock
        currTrigger
            = query currNPC.description model.worldModel
            |> List.map Tuple.first -- get List ID
            |> List.head -- get first (suppose only one ID for one NPC. Is it true????)
            |> withDefault "$my$own$error$msg$: no such npc, in interact by X please contact with group4"
        model_ = interactWith__core currTrigger model |> Tuple.first
        energy = model.energy
        energy_ = energy - model.energy_Cost_interact
    in
    if model.playerDoing == MakingChoices then
        model
    else if energy_ < 0 then
        {model| story = "Ah.... Why am I feel so tired, I should go home for a sleep......"}
    else
        model_



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
        |> day5_park_update_exit
        |> day6_and_day8_home_teleport_council
        |> day6_items_update_speaker
        |> day6_court_update_exit
        |> day7_examine_finish_update_switching_npc
        |> day7_lee_finished_update_eliminate_lee
        |> updating_isTalkingWithLeeDay7
        |> day8_final_court
        |> day8_court_update_exit
        |> day8_court_update_home
        |> day9_teleport_backstreet
        --|> debugFinished
    else model


debugFinished : Model -> Model
debugFinished model =
    let
        policeMap = List.filter (\a -> a.scene == (PoliceOffice, Day7)) model.mapAttr_all
                |> List.head |> withDefault policeOfficeAttr_day7
        isFinished = policeMap.isFinished
        story = Debug.toString isFinished
    in
        { model | story = story }


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
    if ( daniel_phone.place == (Daniel, Nowhere) && model.dayState == Day4 && model.map == Daniel) then
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

day5_park_update_exit : Model -> Model
day5_park_update_exit model =
    let
        isExiting = findCertainQuestion model "EXIT"
    in
    if isExiting && (model.map,model.dayState) == (Park, Day5) && model.hero.y <= 2500 then
    model |> teleportHero ( 5000, 5000 )
    else model

day6_and_day8_home_teleport_council : Model -> Model
day6_and_day8_home_teleport_council model =
    let
        isCaught = findCertainQuestion model "POLICEXPHONEANSWER4"
        isAgree_day8 = findCertainQuestion model "GO_COURT"
        new_ = mapSwitch CityCouncil model
    in
    if model.isTeleportedToCouncil == False && ((model.dayState == Day6 && isCaught) || (model.dayState == Day8 && isAgree_day8)) then
        { new_ | isTeleportedToCouncil = True }
    else model

day6_items_update_speaker : Model -> Model
day6_items_update_speaker model =
    let
        isHavingKey = isRepeat keyIni model
        isHavingFakeCard = isRepeat fakeMemCardIni model
        speaker = List.filter (\a -> a.place == (CityCouncil,Day6)) model.npcs_all
            |> List.head |> withDefault courtSpeaker
        speaker_ =
            if isHavingKey then { speaker | description = "HAVING_KEY" }
            else if isHavingFakeCard then { speaker | description = "HAVING_FAKE" }
            else { speaker | description = "GOOD_COURT" }
        rest = List.filter (\a -> a.place /= (CityCouncil,Day6)) model.npcs_all
        npcs_all_ = [speaker_] ++ rest
        curr_npcs_ = List.filter (\a -> a.place == (CityCouncil,Day6)) npcs_all_

    in
    if speaker.description == "COURT.day6" && (findCertainQuestion model "COURTANSWER8") then
        { model | npcs_all = npcs_all_, npcs_curr = curr_npcs_ }
    else model

day6_court_update_exit : Model -> Model
day6_court_update_exit model =
    let
        isExiting = findCertainQuestion model "NOCAUGHT_GO"
    in
    if isExiting && (model.map,model.dayState) == (CityCouncil, Day6) && model.hero.y >= 2500 then
    model |> teleportHero ( 2000, 2000 )
    else model

day7_examine_finish_update_switching_npc : Model -> Model
day7_examine_finish_update_switching_npc model =
    let
        isFinished = findCertainQuestion model "TABLE_7" && findCertainQuestion model "CLOSET_7" && findCertainQuestion model "PASSWORD2"
        switchingMap = List.filter (\a -> a.scene == (Switching, Nowhere)) model.mapAttr_all
            |> List.head |> withDefault switchingAttr
        leeInSwitching = List.filter (\a -> a.itemType == PoliceX ) model.npcs_all
            |> List.head |> withDefault switchingPolice
        lee_ = { leeInSwitching | place = (Switching, Nowhere), description = "LEE7" }
        story = " Before you enter the home, you meet one of your former colleagues, Lee. Press X to talk with him."
        switchingMap_ = { switchingMap | story = story }
        restMap = List.filter (\a -> a.scene /= (Switching, Nowhere)) model.mapAttr_all
        restNpcs = List.filter (\a -> a.itemType /= PoliceX) model.npcs_all
        npcs_ = [lee_] ++ restNpcs
        maps_ = [switchingMap_] ++ restMap
    in
    if isFinished && leeInSwitching.description /= "LEE7" then
    { model | npcs_all = npcs_, mapAttr_all = maps_ }
    else model

day7_lee_finished_update_eliminate_lee : Model -> Model
day7_lee_finished_update_eliminate_lee model =
    let
        isFinished = findCertainQuestion model "LEEANS5"
        switchingMap = List.filter (\a -> a.scene == (Switching, Nowhere)) model.mapAttr_all
            |> List.head |> withDefault switchingAttr
        leeInSwitching = List.filter (\a -> a.itemType == PoliceX ) model.npcs_all
            |> List.head |> withDefault switchingPolice
        lee_ = { leeInSwitching | place = (NoPlace, Nowhere), description = "" }
        story = "Where to go?"
        switchingMap_ = { switchingMap | story = story }
        restMap = List.filter (\a -> a.scene /= (Switching, Nowhere)) model.mapAttr_all
        restNpcs = List.filter (\a -> a.itemType /= PoliceX) model.npcs_all
        npcs_ = [lee_] ++ restNpcs
        maps_ = [switchingMap_] ++ restMap
    in
    if isFinished && leeInSwitching.description == "LEE7" then
    { model | npcs_all = npcs_, mapAttr_all = maps_ }
    else model

updating_isTalkingWithLeeDay7 : Model -> Model
updating_isTalkingWithLeeDay7 model =
    { model | isTalkingWithLeeDay7 =
        (findCertainQuestion model "TABLE_7" && findCertainQuestion model "CLOSET_7" && findCertainQuestion model "PASSWORD2")
        && (not (findCertainQuestion model "LEEANS5"))}

day8_final_court : Model -> Model
day8_final_court model =
    let
        isFailed
            =  findCertainQuestion model "BANKACC_CARD8" && not (isEvidenceExamined model BankCardEvi && isEvidenceExamined model BankAccJoEvi && isRepeat bankaccIni model && isRepeat bankCardIni model)
            || findCertainQuestion model "PAPER8" && not (isEvidenceExamined model PaperEvi && isRepeat paperIni model)
            || findCertainQuestion model "LETTER8" && not (isEvidenceExamined model LetterEvi && isRepeat letterIni model)
            || findCertainQuestion model "LETTER8_" && not (isEvidenceExamined model LetterEvi && isRepeat letterIni model)
            || findCertainQuestion model "MEMCARD8" && not (model.codeReached && isRepeat trueMemCardIni model)
            || findCertainQuestion model "CONTRACT8" && not (isEvidenceExamined model CustomEvi && isRepeat customconIni model)
            || findCertainQuestion model "CALL_LEE" && not (isEvidenceExamined model PillsJoEvi && isEvidenceExamined model Pill && isRepeat pillIni model && isRepeat pillsIni model)
            || findCertainQuestion model "BANKACC2_8" && not (isEvidenceExamined model BankAccJoEvi && isRepeat bankaccIni model)
            || findCertainQuestion model "SUB_DOCUMENT8" && not (isEvidenceExamined model DocumentsEvi && isRepeat documentsIni model)
            || findCertainQuestion model "SUB_PLAN8" && not (isEvidenceExamined model PlanEvi && isRepeat planIni model)
            || findCertainQuestion model "SUB_CARD_ACC8" && not (isEvidenceExamined model BankCardEvi && isEvidenceExamined model BankAccountEvi && isEvidenceExamined model BankAccJoEvi && isRepeat bankaccIni model && isRepeat bankCardIni model && isRepeat bankIni model )
        court_day8 = List.filter (\a -> a.place == ( CityCouncil , Day8 )) model.npcs_all
            |> List.head |> withDefault courtFinal
        rest = List.filter (\a -> a.place /= ( CityCouncil , Day8 )) model.npcs_all
        court_day8_ = { court_day8 | description = "COURT_FAIL" }
        npcs_ = [court_day8_] ++ rest
        curr_npcs = List.filter (\a -> a.place == ( CityCouncil , Day8 )) npcs_
        story_debug =
            Debug.toString (isRepeat bankCardIni model) ++ Debug.toString (isRepeat bankaccIni model ) ++ Debug.toString (isEvidenceExamined model BankAccJoEvi) ++ Debug.toString (isEvidenceExamined model BankCardEvi)
    in
    if isFailed && (model.map, model.dayState) == ( CityCouncil , Day8 ) && court_day8.description /= "COURT_FAIL" then
    { model | npcs_all = npcs_, npcs_curr = curr_npcs }
    else model

day8_court_update_exit : Model -> Model
day8_court_update_exit model =
    let
        isExiting = findCertainQuestion model "LEAVE8_F"
    in
    if isExiting && (model.map,model.dayState) == (CityCouncil, Day8) && model.hero.y >= 2500 then
    model |> teleportHero ( 2000, 2000 )
    else model

day8_court_update_home : Model -> Model
day8_court_update_home model =
    let
        isExiting = findCertainQuestion model "LEAVE8_F"
        home = List.filter (\a -> a.scene == (Home, Day8)) model.mapAttr_all
            |> List.head |> withDefault homeAttr_day8
        rest = List.filter (\a -> a.scene /= (Home, Day8)) model.mapAttr_all
        home_ = { home | story = "You feel very tired. You really need a sleep and a break for several days..." }
        maps_ = [home_] ++ rest
        home_npc = List.filter (\a -> a.place == (Home, Day8)) model.npcs_all
            |> List.head |> withDefault homeOutsideSounds
        rest_npc = List.filter (\a -> a.place /= (Home, Day8)) model.npcs_all
        home_npc_ = { home_npc | place = (NoPlace, Nowhere) }
        npcs_ = [home_npc_] ++ rest_npc
    in
    if (isExiting && home.story /= "You feel very tired. You really need a sleep and a break for several days...") then
        { model | npcs_all = npcs_, mapAttr_all = maps_ }
    else model

day9_teleport_backstreet : Model -> Model
day9_teleport_backstreet model =
    let
        isGo = findCertainQuestion model "TP_STREET"
        new_ = mapSwitch BackStreet model
    in
    if model.isTeleportedToCouncil == False && ((model.dayState == Day9 && isGo) ) then
        { new_ | isTeleportedToCouncil = True }
    else model

endings : Float -> Model -> Model
endings elapsed model =
    model
        |> badEndsClear
        |> badEndsStory elapsed
        |> goodEndsClear
        |> goodEndsStory elapsed
        |> specialEndsClear
        |> specialEndsStory elapsed


badEndsStory : Float -> Model -> Model
badEndsStory elapsed model =
    let
        isEnding = model.isEnd
        accum = model.endingTimeAccum
        accum_ =
            if isEnding then accum + elapsed
            else accum
        interval = 4000
        story_ = List.filter (\a -> Tuple.first a == True) (badEndsList model)
            |> List.head
            |> withDefault (True, "error!!!!!!!!!!!!")
            |> Tuple.second
    in
    if accum_ > interval then
        { model | story = story_, endingTimeAccum = 4000 }
    else
        { model | endingTimeAccum = accum_ }



badEndsClear : Model -> Model
badEndsClear model =
    let
        haveBeenEnding = model.isEnd
        isEnding = List.foldr (||) False (List.map (Tuple.first) (badEndsList model))
        previousMap = model.map
    in
    if not haveBeenEnding && isEnding then
        { model | npcs_all = [], isEnd = True, map = BadEnds, badEndPreviousMap = previousMap } |> teleportHero (1000, 1000)
    else
    model

goodEndsClear : Model -> Model
goodEndsClear model =
    let
        haveBeenEnding = model.isGoodEnd
        isEnding = List.foldr (||) False (List.map (Tuple.first) (goodEndsList model))
        previousMap = model.map
    in
    if not haveBeenEnding && isEnding then
        { model | npcs_all = [], isGoodEnd = True, map = BadEnds, badEndPreviousMap = previousMap } |> teleportHero (1000, 1000)
    else
    model

goodEndsStory : Float -> Model -> Model
goodEndsStory elapsed model =
    let
        isEnding = model.isGoodEnd
        accum = model.endingTimeAccum
        accum_ =
            if isEnding then accum + elapsed
            else accum
        interval = 4000
        story_ = List.filter (\a -> Tuple.first a == True) (goodEndsList model)
            |> List.head
            |> withDefault (True, "error!!!!!!!!!!!!")
            |> Tuple.second
    in
    if accum_ > interval then
        { model | story = story_, endingTimeAccum = 4000 }
    else
        { model | endingTimeAccum = accum_ }

specialEndsClear : Model -> Model
specialEndsClear model =
    let
        haveBeenEnding = model.isSpecialEnd
        isEnding = List.foldr (||) False (List.map (Tuple.first) (specialEndsList model))
        previousMap = model.map
    in
    if not haveBeenEnding && isEnding then
        { model | npcs_all = [], isSpecialEnd = True, map = BadEnds, badEndPreviousMap = previousMap } |> teleportHero (1000, 1000)
    else
    model

specialEndsStory : Float -> Model -> Model
specialEndsStory elapsed model =
    let
        isEnding = model.isSpecialEnd
        accum = model.endingTimeAccum
        accum_ =
            if isEnding then accum + elapsed
            else accum
        interval = 4000
        story_ = List.filter (\a -> Tuple.first a == True) (specialEndsList model)
            |> List.head
            |> withDefault (True, "error!!!!!!!!!!!!")
            |> Tuple.second
    in
    if accum_ > interval then
        { model | story = story_, endingTimeAccum = 4000 }
    else
        { model | endingTimeAccum = accum_ }


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
    (True, "[Bad End: Forbidden Park]\nNews: A new policeman is employed to replace the place of the missing police Kay.")
    else (False, model.story)

badEnd6 : Model -> ( Bool, String )
badEnd6 model =
    let
        isKey =
            findCertainQuestion model "KEY_END" || findCertainQuestion model "FAKE_END"
    in
    if isKey then
    (True, "[Bad End: Imprisoned] News: Recently, the case of a series of killings has been solved by Jonathon's team. The murderer Kay, a former policeman in our city, was sentenced to life imprisonment. Thanks for Jonathon's effort on maintaining justice, he was elected as the new speaker of our city council.")
    else (False, model.story)

badEnd7 : Model -> ( Bool, String )
badEnd7 model =
    let
        isFalse =
            findCertainQuestion model "PASSWORD1" || findCertainQuestion model "PASSWORD3" || findCertainQuestion model "PASSWORD4"
    in
    if isFalse then
    (True, "[Bad End: Forget-Me-Not] News: New crime set: steal the secret of the darkness. The Owner of our city,\"Darkness\", has made a new crime valid -- steal the secret of the darkness. And the first one who is guilty of this crime is the former policeman Kay.")
    else (False, model.story)

badEnd8 : Model -> ( Bool, String )
badEnd8 model =
    let
        isKilled =
            findCertainQuestion model "DEATH2"
    in
    if isKilled then
    (True, "[Bad End: Dark Fever] Darkness is spreading in the city. Jonathon completes his plan successfully. The city's rebirth can never be reached.")
    else (False, model.story)


goodEnd : Model -> ( Bool, String )
goodEnd model =
    let
        isGood =
            findCertainQuestion model "LEAVE8"
    in
    if isGood then
    (True, "[Perfect End: Double Rebirth] Our Hero Kay Becomes the Chief Police\nStorm in CBD: City Council takes over the night club Paradise!\nEnd of darkness: Former chief police, Jonathan, sentenced to death!\nAlso notice: Curfew Tonight near Park region!")
    else (False, model.story)

specialEnd : Model -> ( Bool , String )
specialEnd model =
    let
        isSpecial =
            findCertainQuestion model "STREET"
    in
    if isSpecial then
    (True, "[Special End: Disappearing Slim Light] You succeed in revenging the darkness \"Jonathon\" in your rebirth. But at the same time, the obsession gets control of you.\n You do take revenge successfully, and now you're the new ruler of this city. \nHowever, is all this worth it?")
    else (False, model.story)


goodEndsList : Model -> List (Bool,String)
goodEndsList model = [ goodEnd model ]

badEndsList : Model -> List (Bool, String)
badEndsList model = [ badEnd1 model, badEnd2 model, badEnd3 model, badEnd4 model, badEnd5 model, badEnd6 model, badEnd7 model, badEnd8 model ]

specialEndsList :  Model -> List (Bool, String)
specialEndsList model = [ specialEnd model ]

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
    |> pickLetter
    |> pickBankCard
    |> pickDocument
    |> pickDagger2
    |> pickContract
    |> pickDocument2
    |> pickPillJo
    |> pickBankStateJo



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
        g11 = model.bag.grid11
        g12 = model.bag.grid12
        g13 = model.bag.grid13
        g14 = model.bag.grid14
        g15 = model.bag.grid15
        g16 = model.bag.grid16
        g17 = model.bag.grid17
        g18 = model.bag.grid18
        g19 = model.bag.grid19
        g20 = model.bag.grid20
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
        t11 = model.bag.grid11.itemType
        t12 = model.bag.grid12.itemType
        t13 = model.bag.grid13.itemType
        t14 = model.bag.grid14.itemType
        t15 = model.bag.grid15.itemType
        t16 = model.bag.grid16.itemType
        t17 = model.bag.grid17.itemType
        t18 = model.bag.grid18.itemType
        t19 = model.bag.grid19.itemType
        t20 = model.bag.grid20.itemType
    in
    if repeatOrNot == False && t1 == Empty then
    { model | bag = { grid1 = item , grid2 = g2 , grid3 = g3 , grid4 = g4 , grid5 = g5 , grid6 = g6 , grid7 = g7 , grid8 = g8 , grid9 = g9 , grid10 = g10
    , grid11 = g11 , grid12 = g12 , grid13 = g13 , grid14 = g14 , grid15 = g15 , grid16 = g16 , grid17 = g17 , grid18 = g18 , grid19 = g19 , grid20 = g20 } }
    else if repeatOrNot == False && t1 /= Empty && t2 == Empty then
    { model | bag = { grid1 = g1 , grid2 = item , grid3 = g3 , grid4 = g4 , grid5 = g5 , grid6 = g6 , grid7 = g7 , grid8 = g8 , grid9 = g9 , grid10 = g10
    , grid11 = g11 , grid12 = g12 , grid13 = g13 , grid14 = g14 , grid15 = g15 , grid16 = g16 , grid17 = g17 , grid18 = g18 , grid19 = g19 , grid20 = g20 } }
    else if repeatOrNot == False && t1 /= Empty && t2 /= Empty && t3 == Empty  then
    { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = item , grid4 = g4 , grid5 = g5 , grid6 = g6 , grid7 = g7 , grid8 = g8 , grid9 = g9 , grid10 = g10
    , grid11 = g11 , grid12 = g12 , grid13 = g13 , grid14 = g14 , grid15 = g15 , grid16 = g16 , grid17 = g17 , grid18 = g18 , grid19 = g19 , grid20 = g20 } }
    else if repeatOrNot == False && t1 /= Empty && t2 /= Empty && t3 /= Empty && t4 == Empty then
    { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = g3 , grid4 = item , grid5 = g5 , grid6 = g6 , grid7 = g7 , grid8 = g8 , grid9 = g9 , grid10 = g10
    , grid11 = g11 , grid12 = g12 , grid13 = g13 , grid14 = g14 , grid15 = g15 , grid16 = g16 , grid17 = g17 , grid18 = g18 , grid19 = g19 , grid20 = g20 } }
    else if repeatOrNot == False && t1 /= Empty && t2 /= Empty && t3 /= Empty && t4 /= Empty && t5 == Empty then
    { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = g3 , grid4 = g4 , grid5 = item , grid6 = g6 , grid7 = g7 , grid8 = g8 , grid9 = g9 , grid10 = g10
    , grid11 = g11 , grid12 = g12 , grid13 = g13 , grid14 = g14 , grid15 = g15 , grid16 = g16 , grid17 = g17 , grid18 = g18 , grid19 = g19 , grid20 = g20 } }
    else if repeatOrNot == False && t1 /= Empty && t2 /= Empty && t3 /= Empty && t4 /= Empty && t5 /= Empty && t6 == Empty then
    { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = g3 , grid4 = g4 , grid5 = g5 , grid6 = item , grid7 = g7 , grid8 = g8 , grid9 = g9 , grid10 = g10
    , grid11 = g11 , grid12 = g12 , grid13 = g13 , grid14 = g14 , grid15 = g15 , grid16 = g16 , grid17 = g17 , grid18 = g18 , grid19 = g19 , grid20 = g20 } }
    else if repeatOrNot == False && t1 /= Empty && t2 /= Empty && t3 /= Empty && t4 /= Empty && t5 /= Empty && t6 /= Empty && t7 == Empty then
    { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = g3 , grid4 = g4 , grid5 = g5 , grid6 = g6 , grid7 = item , grid8 = g8 , grid9 = g9 , grid10 = g10
    , grid11 = g11 , grid12 = g12 , grid13 = g13 , grid14 = g14 , grid15 = g15 , grid16 = g16 , grid17 = g17 , grid18 = g18 , grid19 = g19 , grid20 = g20 } }
    else if repeatOrNot == False && t1 /= Empty && t2 /= Empty && t3 /= Empty && t4 /= Empty && t5 /= Empty && t6 /= Empty && t7 /= Empty && t8 == Empty then
    { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = g3 , grid4 = g4 , grid5 = g5 , grid6 = g6 , grid7 = g7 , grid8 = item , grid9 = g9 , grid10 = g10
    , grid11 = g11 , grid12 = g12 , grid13 = g13 , grid14 = g14 , grid15 = g15 , grid16 = g16 , grid17 = g17 , grid18 = g18 , grid19 = g19 , grid20 = g20 } }
    else if repeatOrNot == False && t1 /= Empty && t2 /= Empty && t3 /= Empty && t4 /= Empty && t5 /= Empty && t6 /= Empty && t7 /= Empty && t8 /= Empty && t9 == Empty then
    { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = g3 , grid4 = g4 , grid5 = g5 , grid6 = g6 , grid7 = g7 , grid8 = g8 , grid9 = item , grid10 = g10
    , grid11 = g11 , grid12 = g12 , grid13 = g13 , grid14 = g14 , grid15 = g15 , grid16 = g16 , grid17 = g17 , grid18 = g18 , grid19 = g19 , grid20 = g20 } }
    else if repeatOrNot == False && t1 /= Empty && t2 /= Empty && t3 /= Empty && t4 /= Empty && t5 /= Empty && t6 /= Empty && t7 /= Empty && t8 /= Empty && t9 /= Empty && t10 == Empty then
    { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = g3 , grid4 = g4 , grid5 = g5 , grid6 = g6 , grid7 = g7 , grid8 = g8 , grid9 = g9 , grid10 = item
    , grid11 = g11 , grid12 = g12 , grid13 = g13 , grid14 = g14 , grid15 = g15 , grid16 = g16 , grid17 = g17 , grid18 = g18 , grid19 = g19 , grid20 = g20 } }
    else if repeatOrNot == False && t1 /= Empty && t2 /= Empty && t3 /= Empty && t4 /= Empty && t5 /= Empty && t6 /= Empty && t7 /= Empty && t8 /= Empty && t9 /= Empty && t10 /= Empty
     && t11 == Empty then
    { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = g3 , grid4 = g4 , grid5 = g5 , grid6 = g6 , grid7 = g7 , grid8 = g8 , grid9 = g9 , grid10 = g10
    , grid11 = item , grid12 = g12 , grid13 = g13 , grid14 = g14 , grid15 = g15 , grid16 = g16 , grid17 = g17 , grid18 = g18 , grid19 = g19 , grid20 = g20 } }
    else if repeatOrNot == False && t1 /= Empty && t2 /= Empty && t3 /= Empty && t4 /= Empty && t5 /= Empty && t6 /= Empty && t7 /= Empty && t8 /= Empty && t9 /= Empty && t10 /= Empty
     && t11 /= Empty && t12 == Empty then
    { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = g3 , grid4 = g4 , grid5 = g5 , grid6 = g6 , grid7 = g7 , grid8 = g8 , grid9 = g9 , grid10 = g10
    , grid11 = g11 , grid12 = item , grid13 = g13 , grid14 = g14 , grid15 = g15 , grid16 = g16 , grid17 = g17 , grid18 = g18 , grid19 = g19 , grid20 = g20 } }
    else if repeatOrNot == False && t1 /= Empty && t2 /= Empty && t3 /= Empty && t4 /= Empty && t5 /= Empty && t6 /= Empty && t7 /= Empty && t8 /= Empty && t9 /= Empty && t10 /= Empty
     && t11 /= Empty && t12 /= Empty && t13 == Empty then
    { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = g3 , grid4 = g4 , grid5 = g5 , grid6 = g6 , grid7 = g7 , grid8 = g8 , grid9 = g9 , grid10 = g10
    , grid11 = g11 , grid12 = g12 , grid13 = item , grid14 = g14 , grid15 = g15 , grid16 = g16 , grid17 = g17 , grid18 = g18 , grid19 = g19 , grid20 = g20 } }
    else if repeatOrNot == False && t1 /= Empty && t2 /= Empty && t3 /= Empty && t4 /= Empty && t5 /= Empty && t6 /= Empty && t7 /= Empty && t8 /= Empty && t9 /= Empty && t10 /= Empty
     && t11 /= Empty && t12 /= Empty && t13 /= Empty && t14 == Empty then
    { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = g3 , grid4 = g4 , grid5 = g5 , grid6 = g6 , grid7 = g7 , grid8 = g8 , grid9 = g9 , grid10 = g10
    , grid11 = g11 , grid12 = g12 , grid13 = g13 , grid14 = item , grid15 = g15 , grid16 = g16 , grid17 = g17 , grid18 = g18 , grid19 = g19 , grid20 = g20 } }
    else if repeatOrNot == False && t1 /= Empty && t2 /= Empty && t3 /= Empty && t4 /= Empty && t5 /= Empty && t6 /= Empty && t7 /= Empty && t8 /= Empty && t9 /= Empty && t10 /= Empty
     && t11 /= Empty && t12 /= Empty && t13 /= Empty && t14 /= Empty && t15 == Empty then
    { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = g3 , grid4 = g4 , grid5 = g5 , grid6 = g6 , grid7 = g7 , grid8 = g8 , grid9 = g9 , grid10 = g10
    , grid11 = g11 , grid12 = g12 , grid13 = g13 , grid14 = g14 , grid15 = item , grid16 = g16 , grid17 = g17 , grid18 = g18 , grid19 = g19 , grid20 = g20 } }
    else if repeatOrNot == False && t1 /= Empty && t2 /= Empty && t3 /= Empty && t4 /= Empty && t5 /= Empty && t6 /= Empty && t7 /= Empty && t8 /= Empty && t9 /= Empty && t10 /= Empty
     && t11 /= Empty && t12 /= Empty && t13 /= Empty && t14 /= Empty && t15 /= Empty && t16 == Empty then
    { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = g3 , grid4 = g4 , grid5 = g5 , grid6 = g6 , grid7 = g7 , grid8 = g8 , grid9 = g9 , grid10 = g10
    , grid11 = g11 , grid12 = g12 , grid13 = g13 , grid14 = g14 , grid15 = g15 , grid16 = item , grid17 = g17 , grid18 = g18 , grid19 = g19 , grid20 = g20 } }
    else if repeatOrNot == False && t1 /= Empty && t2 /= Empty && t3 /= Empty && t4 /= Empty && t5 /= Empty && t6 /= Empty && t7 /= Empty && t8 /= Empty && t9 /= Empty && t10 /= Empty
     && t11 /= Empty && t12 /= Empty && t13 /= Empty && t14 /= Empty && t15 /= Empty && t16 /= Empty && t17 == Empty then
    { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = g3 , grid4 = g4 , grid5 = g5 , grid6 = g6 , grid7 = g7 , grid8 = g8 , grid9 = g9 , grid10 = g10
    , grid11 = g11 , grid12 = g12 , grid13 = g13 , grid14 = g14 , grid15 = g15 , grid16 = g16 , grid17 = item , grid18 = g18 , grid19 = g19 , grid20 = g20 } }
    else if repeatOrNot == False && t1 /= Empty && t2 /= Empty && t3 /= Empty && t4 /= Empty && t5 /= Empty && t6 /= Empty && t7 /= Empty && t8 /= Empty && t9 /= Empty && t10 /= Empty
     && t11 /= Empty && t12 /= Empty && t13 /= Empty && t14 /= Empty && t15 /= Empty && t16 /= Empty && t17 /= Empty && t18 == Empty then
    { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = g3 , grid4 = g4 , grid5 = g5 , grid6 = g6 , grid7 = g7 , grid8 = g8 , grid9 = g9 , grid10 = g10
    , grid11 = g11 , grid12 = g12 , grid13 = g13 , grid14 = g14 , grid15 = g15 , grid16 = g16 , grid17 = g17 , grid18 = item , grid19 = g19 , grid20 = g20 } }
    else if repeatOrNot == False && t1 /= Empty && t2 /= Empty && t3 /= Empty && t4 /= Empty && t5 /= Empty && t6 /= Empty && t7 /= Empty && t8 /= Empty && t9 /= Empty && t10 /= Empty
     && t11 /= Empty && t12 /= Empty && t13 /= Empty && t14 /= Empty && t15 /= Empty && t16 /= Empty && t17 /= Empty && t18 /= Empty && t19 == Empty then
    { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = g3 , grid4 = g4 , grid5 = g5 , grid6 = g6 , grid7 = g7 , grid8 = g8 , grid9 = g9 , grid10 = g10
    , grid11 = g11 , grid12 = g12 , grid13 = g13 , grid14 = g14 , grid15 = g15 , grid16 = g16 , grid17 = g17 , grid18 = g18 , grid19 = item , grid20 = g20 } }
    else if repeatOrNot == False && t1 /= Empty && t2 /= Empty && t3 /= Empty && t4 /= Empty && t5 /= Empty && t6 /= Empty && t7 /= Empty && t8 /= Empty && t9 /= Empty && t10 /= Empty
     && t11 /= Empty && t12 /= Empty && t13 /= Empty && t14 /= Empty && t15 /= Empty && t16 /= Empty && t17 /= Empty && t18 /= Empty && t19 /= Empty && t20 == Empty then
    { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = g3 , grid4 = g4 , grid5 = g5 , grid6 = g6 , grid7 = g7 , grid8 = g8 , grid9 = g9 , grid10 = g10
    , grid11 = g11 , grid12 = g12 , grid13 = g13 , grid14 = g14 , grid15 = g15 , grid16 = g16 , grid17 = g17 , grid18 = g18 , grid19 = g19 , grid20 = item } }
    else
    model

pickBankCard : Model -> Model
pickBankCard model =
    pickSingleItem "TABLE" bankCardIni model

pickDagger2 : Model -> Model
pickDagger2 model =
    pickSingleItem "TABLE" dagger2Ini model

pickDocument : Model -> Model
pickDocument model =
    pickSingleItem "CLOSET" documentsIni model

pickLetter : Model -> Model
pickLetter model =
    pickSingleItem "CLOSET" letterIni model

pickBankStateJo : Model -> Model
pickBankStateJo model =
    pickSingleItem "CLOSET_7" bankaccIni model

pickPillJo : Model -> Model
pickPillJo model =
    pickSingleItem "TABLE_7" pillsIni model

pickDocument2 : Model -> Model
pickDocument2 model =
    pickSingleItem "CLOSET_7" planIni model

pickContract : Model -> Model
pickContract model =
    pickSingleItem "CLOSET_7" customconIni model



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
        g11 = model.bag.grid11
        g12 = model.bag.grid12
        g13 = model.bag.grid13
        g14 = model.bag.grid14
        g15 = model.bag.grid15
        g16 = model.bag.grid16
        g17 = model.bag.grid17
        g18 = model.bag.grid18
        g19 = model.bag.grid19
        g20 = model.bag.grid20
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
        t11 = model.bag.grid11.itemType
        t12 = model.bag.grid12.itemType
        t13 = model.bag.grid13.itemType
        t14 = model.bag.grid14.itemType
        t15 = model.bag.grid15.itemType
        t16 = model.bag.grid16.itemType
        t17 = model.bag.grid17.itemType
        t18 = model.bag.grid18.itemType
        t19 = model.bag.grid19.itemType
        t20 = model.bag.grid20.itemType
    in
    if repeatOrNot == False && t1 == Empty then
    { model | bag = { grid1 = item , grid2 = g2 , grid3 = g3 , grid4 = g4 , grid5 = g5 , grid6 = g6 , grid7 = g7 , grid8 = g8 , grid9 = g9 , grid10 = g10
    , grid11 = g11 , grid12 = g12 , grid13 = g13 , grid14 = g14 , grid15 = g15 , grid16 = g16 , grid17 = g17 , grid18 = g18 , grid19 = g19 , grid20 = g20 } }
    else if repeatOrNot == False && t1 /= Empty && t2 == Empty then
    { model | bag = { grid1 = g1 , grid2 = item , grid3 = g3 , grid4 = g4 , grid5 = g5 , grid6 = g6 , grid7 = g7 , grid8 = g8 , grid9 = g9 , grid10 = g10
    , grid11 = g11 , grid12 = g12 , grid13 = g13 , grid14 = g14 , grid15 = g15 , grid16 = g16 , grid17 = g17 , grid18 = g18 , grid19 = g19 , grid20 = g20 } }
    else if repeatOrNot == False && t1 /= Empty && t2 /= Empty && t3 == Empty  then
    { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = item , grid4 = g4 , grid5 = g5 , grid6 = g6 , grid7 = g7 , grid8 = g8 , grid9 = g9 , grid10 = g10
    , grid11 = g11 , grid12 = g12 , grid13 = g13 , grid14 = g14 , grid15 = g15 , grid16 = g16 , grid17 = g17 , grid18 = g18 , grid19 = g19 , grid20 = g20 } }
    else if repeatOrNot == False && t1 /= Empty && t2 /= Empty && t3 /= Empty && t4 == Empty then
    { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = g3 , grid4 = item , grid5 = g5 , grid6 = g6 , grid7 = g7 , grid8 = g8 , grid9 = g9 , grid10 = g10
    , grid11 = g11 , grid12 = g12 , grid13 = g13 , grid14 = g14 , grid15 = g15 , grid16 = g16 , grid17 = g17 , grid18 = g18 , grid19 = g19 , grid20 = g20 } }
    else if repeatOrNot == False && t1 /= Empty && t2 /= Empty && t3 /= Empty && t4 /= Empty && t5 == Empty then
    { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = g3 , grid4 = g4 , grid5 = item , grid6 = g6 , grid7 = g7 , grid8 = g8 , grid9 = g9 , grid10 = g10
    , grid11 = g11 , grid12 = g12 , grid13 = g13 , grid14 = g14 , grid15 = g15 , grid16 = g16 , grid17 = g17 , grid18 = g18 , grid19 = g19 , grid20 = g20 } }
    else if repeatOrNot == False && t1 /= Empty && t2 /= Empty && t3 /= Empty && t4 /= Empty && t5 /= Empty && t6 == Empty then
    { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = g3 , grid4 = g4 , grid5 = g5 , grid6 = item , grid7 = g7 , grid8 = g8 , grid9 = g9 , grid10 = g10
    , grid11 = g11 , grid12 = g12 , grid13 = g13 , grid14 = g14 , grid15 = g15 , grid16 = g16 , grid17 = g17 , grid18 = g18 , grid19 = g19 , grid20 = g20 } }
    else if repeatOrNot == False && t1 /= Empty && t2 /= Empty && t3 /= Empty && t4 /= Empty && t5 /= Empty && t6 /= Empty && t7 == Empty then
    { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = g3 , grid4 = g4 , grid5 = g5 , grid6 = g6 , grid7 = item , grid8 = g8 , grid9 = g9 , grid10 = g10
    , grid11 = g11 , grid12 = g12 , grid13 = g13 , grid14 = g14 , grid15 = g15 , grid16 = g16 , grid17 = g17 , grid18 = g18 , grid19 = g19 , grid20 = g20 } }
    else if repeatOrNot == False && t1 /= Empty && t2 /= Empty && t3 /= Empty && t4 /= Empty && t5 /= Empty && t6 /= Empty && t7 /= Empty && t8 == Empty then
    { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = g3 , grid4 = g4 , grid5 = g5 , grid6 = g6 , grid7 = g7 , grid8 = item , grid9 = g9 , grid10 = g10
    , grid11 = g11 , grid12 = g12 , grid13 = g13 , grid14 = g14 , grid15 = g15 , grid16 = g16 , grid17 = g17 , grid18 = g18 , grid19 = g19 , grid20 = g20 } }
    else if repeatOrNot == False && t1 /= Empty && t2 /= Empty && t3 /= Empty && t4 /= Empty && t5 /= Empty && t6 /= Empty && t7 /= Empty && t8 /= Empty && t9 == Empty then
    { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = g3 , grid4 = g4 , grid5 = g5 , grid6 = g6 , grid7 = g7 , grid8 = g8 , grid9 = item , grid10 = g10
    , grid11 = g11 , grid12 = g12 , grid13 = g13 , grid14 = g14 , grid15 = g15 , grid16 = g16 , grid17 = g17 , grid18 = g18 , grid19 = g19 , grid20 = g20 } }
    else if repeatOrNot == False && t1 /= Empty && t2 /= Empty && t3 /= Empty && t4 /= Empty && t5 /= Empty && t6 /= Empty && t7 /= Empty && t8 /= Empty && t9 /= Empty && t10 == Empty then
    { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = g3 , grid4 = g4 , grid5 = g5 , grid6 = g6 , grid7 = g7 , grid8 = g8 , grid9 = g9 , grid10 = item
    , grid11 = g11 , grid12 = g12 , grid13 = g13 , grid14 = g14 , grid15 = g15 , grid16 = g16 , grid17 = g17 , grid18 = g18 , grid19 = g19 , grid20 = g20 } }
    else if repeatOrNot == False && t1 /= Empty && t2 /= Empty && t3 /= Empty && t4 /= Empty && t5 /= Empty && t6 /= Empty && t7 /= Empty && t8 /= Empty && t9 /= Empty && t10 /= Empty
     && t11 == Empty then
    { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = g3 , grid4 = g4 , grid5 = g5 , grid6 = g6 , grid7 = g7 , grid8 = g8 , grid9 = g9 , grid10 = g10
    , grid11 = item , grid12 = g12 , grid13 = g13 , grid14 = g14 , grid15 = g15 , grid16 = g16 , grid17 = g17 , grid18 = g18 , grid19 = g19 , grid20 = g20 } }
    else if repeatOrNot == False && t1 /= Empty && t2 /= Empty && t3 /= Empty && t4 /= Empty && t5 /= Empty && t6 /= Empty && t7 /= Empty && t8 /= Empty && t9 /= Empty && t10 /= Empty
     && t11 /= Empty && t12 == Empty then
    { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = g3 , grid4 = g4 , grid5 = g5 , grid6 = g6 , grid7 = g7 , grid8 = g8 , grid9 = g9 , grid10 = g10
    , grid11 = g11 , grid12 = item , grid13 = g13 , grid14 = g14 , grid15 = g15 , grid16 = g16 , grid17 = g17 , grid18 = g18 , grid19 = g19 , grid20 = g20 } }
    else if repeatOrNot == False && t1 /= Empty && t2 /= Empty && t3 /= Empty && t4 /= Empty && t5 /= Empty && t6 /= Empty && t7 /= Empty && t8 /= Empty && t9 /= Empty && t10 /= Empty
     && t11 /= Empty && t12 /= Empty && t13 == Empty then
    { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = g3 , grid4 = g4 , grid5 = g5 , grid6 = g6 , grid7 = g7 , grid8 = g8 , grid9 = g9 , grid10 = g10
    , grid11 = g11 , grid12 = g12 , grid13 = item , grid14 = g14 , grid15 = g15 , grid16 = g16 , grid17 = g17 , grid18 = g18 , grid19 = g19 , grid20 = g20 } }
    else if repeatOrNot == False && t1 /= Empty && t2 /= Empty && t3 /= Empty && t4 /= Empty && t5 /= Empty && t6 /= Empty && t7 /= Empty && t8 /= Empty && t9 /= Empty && t10 /= Empty
     && t11 /= Empty && t12 /= Empty && t13 /= Empty && t14 == Empty then
    { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = g3 , grid4 = g4 , grid5 = g5 , grid6 = g6 , grid7 = g7 , grid8 = g8 , grid9 = g9 , grid10 = g10
    , grid11 = g11 , grid12 = g12 , grid13 = g13 , grid14 = item , grid15 = g15 , grid16 = g16 , grid17 = g17 , grid18 = g18 , grid19 = g19 , grid20 = g20 } }
    else if repeatOrNot == False && t1 /= Empty && t2 /= Empty && t3 /= Empty && t4 /= Empty && t5 /= Empty && t6 /= Empty && t7 /= Empty && t8 /= Empty && t9 /= Empty && t10 /= Empty
     && t11 /= Empty && t12 /= Empty && t13 /= Empty && t14 /= Empty && t15 == Empty then
    { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = g3 , grid4 = g4 , grid5 = g5 , grid6 = g6 , grid7 = g7 , grid8 = g8 , grid9 = g9 , grid10 = g10
    , grid11 = g11 , grid12 = g12 , grid13 = g13 , grid14 = g14 , grid15 = item , grid16 = g16 , grid17 = g17 , grid18 = g18 , grid19 = g19 , grid20 = g20 } }
    else if repeatOrNot == False && t1 /= Empty && t2 /= Empty && t3 /= Empty && t4 /= Empty && t5 /= Empty && t6 /= Empty && t7 /= Empty && t8 /= Empty && t9 /= Empty && t10 /= Empty
     && t11 /= Empty && t12 /= Empty && t13 /= Empty && t14 /= Empty && t15 /= Empty && t16 == Empty then
    { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = g3 , grid4 = g4 , grid5 = g5 , grid6 = g6 , grid7 = g7 , grid8 = g8 , grid9 = g9 , grid10 = g10
    , grid11 = g11 , grid12 = g12 , grid13 = g13 , grid14 = g14 , grid15 = g15 , grid16 = item , grid17 = g17 , grid18 = g18 , grid19 = g19 , grid20 = g20 } }
    else if repeatOrNot == False && t1 /= Empty && t2 /= Empty && t3 /= Empty && t4 /= Empty && t5 /= Empty && t6 /= Empty && t7 /= Empty && t8 /= Empty && t9 /= Empty && t10 /= Empty
     && t11 /= Empty && t12 /= Empty && t13 /= Empty && t14 /= Empty && t15 /= Empty && t16 /= Empty && t17 == Empty then
    { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = g3 , grid4 = g4 , grid5 = g5 , grid6 = g6 , grid7 = g7 , grid8 = g8 , grid9 = g9 , grid10 = g10
    , grid11 = g11 , grid12 = g12 , grid13 = g13 , grid14 = g14 , grid15 = g15 , grid16 = g16 , grid17 = item , grid18 = g18 , grid19 = g19 , grid20 = g20 } }
    else if repeatOrNot == False && t1 /= Empty && t2 /= Empty && t3 /= Empty && t4 /= Empty && t5 /= Empty && t6 /= Empty && t7 /= Empty && t8 /= Empty && t9 /= Empty && t10 /= Empty
     && t11 /= Empty && t12 /= Empty && t13 /= Empty && t14 /= Empty && t15 /= Empty && t16 /= Empty && t17 /= Empty && t18 == Empty then
    { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = g3 , grid4 = g4 , grid5 = g5 , grid6 = g6 , grid7 = g7 , grid8 = g8 , grid9 = g9 , grid10 = g10
    , grid11 = g11 , grid12 = g12 , grid13 = g13 , grid14 = g14 , grid15 = g15 , grid16 = g16 , grid17 = g17 , grid18 = item , grid19 = g19 , grid20 = g20 } }
    else if repeatOrNot == False && t1 /= Empty && t2 /= Empty && t3 /= Empty && t4 /= Empty && t5 /= Empty && t6 /= Empty && t7 /= Empty && t8 /= Empty && t9 /= Empty && t10 /= Empty
     && t11 /= Empty && t12 /= Empty && t13 /= Empty && t14 /= Empty && t15 /= Empty && t16 /= Empty && t17 /= Empty && t18 /= Empty && t19 == Empty then
    { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = g3 , grid4 = g4 , grid5 = g5 , grid6 = g6 , grid7 = g7 , grid8 = g8 , grid9 = g9 , grid10 = g10
    , grid11 = g11 , grid12 = g12 , grid13 = g13 , grid14 = g14 , grid15 = g15 , grid16 = g16 , grid17 = g17 , grid18 = g18 , grid19 = item , grid20 = g20 } }
    else if repeatOrNot == False && t1 /= Empty && t2 /= Empty && t3 /= Empty && t4 /= Empty && t5 /= Empty && t6 /= Empty && t7 /= Empty && t8 /= Empty && t9 /= Empty && t10 /= Empty
     && t11 /= Empty && t12 /= Empty && t13 /= Empty && t14 /= Empty && t15 /= Empty && t16 /= Empty && t17 /= Empty && t18 /= Empty && t19 /= Empty && t20 == Empty then
    { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = g3 , grid4 = g4 , grid5 = g5 , grid6 = g6 , grid7 = g7 , grid8 = g8 , grid9 = g9 , grid10 = g10
    , grid11 = g11 , grid12 = g12 , grid13 = g13 , grid14 = g14 , grid15 = g15 , grid16 = g16 , grid17 = g17 , grid18 = g18 , grid19 = g19 , grid20 = item } }
    else
    model

itemDelete : Model -> Int -> Model
itemDelete model whichGrid =
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
       g11 = model.bag.grid11
       g12 = model.bag.grid12
       g13 = model.bag.grid13
       g14 = model.bag.grid14
       g15 = model.bag.grid15
       g16 = model.bag.grid16
       g17 = model.bag.grid17
       g18 = model.bag.grid18
       g19 = model.bag.grid19
       g20 = model.bag.grid20
    in
    case whichGrid of
        1 -> { model | bag = { grid1 = emptyIni , grid2 = g2 , grid3 = g3 , grid4 = g4 , grid5 = g5 , grid6 = g6 , grid7 = g7 , grid8 = g8 , grid9 = g9 , grid10 = g10
                 , grid11 = g11 , grid12 = g12 , grid13 = g13 , grid14 = g14 , grid15 = g15 , grid16 = g16 , grid17 = g17 , grid18 = g18 , grid19 = g19 , grid20 = g20 } }
        2 -> { model | bag = { grid1 = g1 , grid2 = emptyIni , grid3 = g3 , grid4 = g4 , grid5 = g5 , grid6 = g6 , grid7 = g7 , grid8 = g8 , grid9 = g9 , grid10 = g10
                 , grid11 = g11 , grid12 = g12 , grid13 = g13 , grid14 = g14 , grid15 = g15 , grid16 = g16 , grid17 = g17 , grid18 = g18 , grid19 = g19 , grid20 = g20 } }
        3 -> { model | bag = { grid1 = g1 , grid2 = g3 , grid3 = emptyIni , grid4 = g4 , grid5 = g5 , grid6 = g6 , grid7 = g7 , grid8 = g8 , grid9 = g9 , grid10 = g10
                 , grid11 = g11 , grid12 = g12 , grid13 = g13 , grid14 = g14 , grid15 = g15 , grid16 = g16 , grid17 = g17 , grid18 = g18 , grid19 = g19 , grid20 = g20 } }
        4 -> { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = g3 , grid4 = emptyIni , grid5 = g5 , grid6 = g6 , grid7 = g7 , grid8 = g8 , grid9 = g9 , grid10 = g10
                 , grid11 = g11 , grid12 = g12 , grid13 = g13 , grid14 = g14 , grid15 = g15 , grid16 = g16 , grid17 = g17 , grid18 = g18 , grid19 = g19 , grid20 = g20 } }
        5 -> { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = g3 , grid4 = g4 , grid5 = emptyIni , grid6 = g6 , grid7 = g7 , grid8 = g8 , grid9 = g9 , grid10 = g10
                 , grid11 = g11 , grid12 = g12 , grid13 = g13 , grid14 = g14 , grid15 = g15 , grid16 = g16 , grid17 = g17 , grid18 = g18 , grid19 = g19 , grid20 = g20 } }
        6 -> { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = g3 , grid4 = g4 , grid5 = g5 , grid6 = emptyIni , grid7 = g7 , grid8 = g8 , grid9 = g9 , grid10 = g10
                 , grid11 = g11 , grid12 = g12 , grid13 = g13 , grid14 = g14 , grid15 = g15 , grid16 = g16 , grid17 = g17 , grid18 = g18 , grid19 = g19 , grid20 = g20 } }
        7 -> { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = g3 , grid4 = g4 , grid5 = g5 , grid6 = g6 , grid7 = emptyIni , grid8 = g8 , grid9 = g9 , grid10 = g10
                 , grid11 = g11 , grid12 = g12 , grid13 = g13 , grid14 = g14 , grid15 = g15 , grid16 = g16 , grid17 = g17 , grid18 = g18 , grid19 = g19 , grid20 = g20 } }
        8 -> { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = g3 , grid4 = g4 , grid5 = g5 , grid6 = g6 , grid7 = g7 , grid8 = emptyIni , grid9 = g9 , grid10 = g10
                 , grid11 = g11 , grid12 = g12 , grid13 = g13 , grid14 = g14 , grid15 = g15 , grid16 = g16 , grid17 = g17 , grid18 = g18 , grid19 = g19 , grid20 = g20 } }
        9 -> { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = g3 , grid4 = g4 , grid5 = g5 , grid6 = g6 , grid7 = g7 , grid8 = g8 , grid9 = emptyIni , grid10 = g10
                 , grid11 = g11 , grid12 = g12 , grid13 = g13 , grid14 = g14 , grid15 = g15 , grid16 = g16 , grid17 = g17 , grid18 = g18 , grid19 = g19 , grid20 = g20 } }
        10 -> { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = g3 , grid4 = g4 , grid5 = g5 , grid6 = g6 , grid7 = g7 , grid8 = g8 , grid9 = g9 , grid10 = emptyIni
                 , grid11 = g11 , grid12 = g12 , grid13 = g13 , grid14 = g14 , grid15 = g15 , grid16 = g16 , grid17 = g17 , grid18 = g18 , grid19 = g19 , grid20 = g20 } }
        11 -> { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = g3 , grid4 = g4 , grid5 = g5 , grid6 = g6 , grid7 = g7 , grid8 = g8 , grid9 = g9 , grid10 = g10
                 , grid11 = emptyIni , grid12 = g12 , grid13 = g13 , grid14 = g14 , grid15 = g15 , grid16 = g16 , grid17 = g17 , grid18 = g18 , grid19 = g19 , grid20 = g20 } }
        12 -> { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = g3 , grid4 = g4 , grid5 = g5 , grid6 = g6 , grid7 = g7 , grid8 = g8 , grid9 = g9 , grid10 = g10
                 , grid11 = g11 , grid12 = emptyIni , grid13 = g13 , grid14 = g14 , grid15 = g15 , grid16 = g16 , grid17 = g17 , grid18 = g18 , grid19 = g19 , grid20 = g20 } }
        13 -> { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = g3 , grid4 = g4 , grid5 = g5 , grid6 = g6 , grid7 = g7 , grid8 = g8 , grid9 = g9 , grid10 = g10
                 , grid11 = g11 , grid12 = g12 , grid13 = emptyIni , grid14 = g14 , grid15 = g15 , grid16 = g16 , grid17 = g17 , grid18 = g18 , grid19 = g19 , grid20 = g20 } }
        14 -> { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = g3 , grid4 = g4 , grid5 = g5 , grid6 = g6 , grid7 = g7 , grid8 = g8 , grid9 = g9 , grid10 = g10
                 , grid11 = g11 , grid12 = g12 , grid13 = g13 , grid14 = emptyIni , grid15 = g15 , grid16 = g16 , grid17 = g17 , grid18 = g18 , grid19 = g19 , grid20 = g20 } }
        15 -> { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = g3 , grid4 = g4 , grid5 = g5 , grid6 = g6 , grid7 = g7 , grid8 = g8 , grid9 = g9 , grid10 = g10
                 , grid11 = g11 , grid12 = g12 , grid13 = g13 , grid14 = g14 , grid15 = emptyIni , grid16 = g16 , grid17 = g17 , grid18 = g18 , grid19 = g19 , grid20 = g20 } }
        16 -> { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = g3 , grid4 = g4 , grid5 = g5 , grid6 = g6 , grid7 = g7 , grid8 = g8 , grid9 = g9 , grid10 = g10
                 , grid11 = g11 , grid12 = g12 , grid13 = g13 , grid14 = g14 , grid15 = g15 , grid16 = emptyIni , grid17 = g17 , grid18 = g18 , grid19 = g19 , grid20 = g20 } }
        17 -> { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = g3 , grid4 = g4 , grid5 = g5 , grid6 = g6 , grid7 = g7 , grid8 = g8 , grid9 = g9 , grid10 = g10
                 , grid11 = g11 , grid12 = g12 , grid13 = g13 , grid14 = g14 , grid15 = g15 , grid16 = g16 , grid17 = emptyIni , grid18 = g18 , grid19 = g19 , grid20 = g20 } }
        18 -> { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = g3 , grid4 = g4 , grid5 = g5 , grid6 = g6 , grid7 = g7 , grid8 = g8 , grid9 = g9 , grid10 = g10
                 , grid11 = g11 , grid12 = g12 , grid13 = g13 , grid14 = g14 , grid15 = g15 , grid16 = g16 , grid17 = g17 , grid18 = emptyIni , grid19 = g19 , grid20 = g20 } }
        19 -> { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = g3 , grid4 = g4 , grid5 = g5 , grid6 = g6 , grid7 = g7 , grid8 = g8 , grid9 = g9 , grid10 = g10
                 , grid11 = g11 , grid12 = g12 , grid13 = g13 , grid14 = g14 , grid15 = g15 , grid16 = g16 , grid17 = g17 , grid18 = g18 , grid19 = emptyIni , grid20 = g20 } }
        20 -> { model | bag = { grid1 = g1 , grid2 = g2 , grid3 = g3 , grid4 = g4 , grid5 = g5 , grid6 = g6 , grid7 = g7 , grid8 = g8 , grid9 = g9 , grid10 = g10
                 , grid11 = g11 , grid12 = g12 , grid13 = g13 , grid14 = g14 , grid15 = g15 , grid16 = g16 , grid17 = g17 , grid18 = g18 , grid19 = g19 , grid20 = emptyIni } }
        _ -> model


