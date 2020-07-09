port module Update exposing (update)

import Message exposing (Msg(..))
import Model exposing (Map(..), Model, State(..), parkAttr, policeOfficeAttr, switchingAttr)


port save : String -> Cmd msg


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


        Noop ->
            ( model, Cmd.none )




animate : Float -> Model -> Model
animate elapsed model =
    model
        |> moveHeroLR elapsed
        |> moveHeroUD elapsed
        |> goToSwitching



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
        x_ = x + dx * 5
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
        y_ = y + dy * 5
        hero = model.hero
        hero_ = { hero | y = y_ }
    in
    { model | hero = hero_ }


judgeExit : Model -> Bool
judgeExit model =
    let
        exit = model.mapAttr.exit
        ( x1, y1 ) = ( toFloat model.hero.x, toFloat model.hero.y )
        ( x2, y2 ) = ( exit.x, exit.y )
        ( w1, h1 ) = ( model.hero.width, model.hero.height )
        ( w2, h2 ) = ( exit.wid, exit.hei )
    in
    if x2 - w1 <= x1 && x1 <= x2 + w2 && y2 - h1 <= y1 && y1 <= y2 + h2 then True
    else False



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
    in
    { model | hero = hero, mapAttr = mapAttr, map = newMap }






