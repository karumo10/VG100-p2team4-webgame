module View exposing (..)
import Html.Attributes exposing (autoplay, class, id, loop, src, style, type_, value)
import Html.Events exposing (on, onClick, onInput, onMouseDown, onMouseUp)
import Debug exposing (toString)
import Message exposing (Msg(..))
import Model exposing (..)
import Tosvg exposing (..)
import Svg exposing (image, rect, svg, Svg)
import Svg.Attributes exposing (x,y,width,height,viewBox,fill,stroke,strokeWidth,xlinkHref,transform,opacity)
import Items exposing ( .. )
import Html exposing (Html, br, button, div, input, p, text, ul)
import MapAttr exposing (Day(..), Mode(..), gameMode______)


pixelWidth : Float
pixelWidth =
    1050


pixelHeight : Float
pixelHeight =
    700

view : Model -> Html Msg
view model =
    let
        ( w, h ) =
            model.size
        r =
            if w / h > pixelWidth / pixelHeight then
                min 1 (h / pixelHeight)
            else
                min 1 (w / pixelWidth)
    in
        div
        [ style "width" "100%"
        , style "height" "100%"
        ]
        ([ div
        [ style "width" (String.fromFloat pixelWidth ++ "px")
        , style "height" (String.fromFloat pixelHeight ++ "px")
        , style "position" "absolute"
        , style "margin" "auto"
        , style "left" "0"
        , style "top" "0"
        , style "right" "0"
        , style "bottom" "0"
        , style "transform-origin" "0 0"
        , style "transform" ("scale(" ++ String.fromFloat r ++ ")")]
         (renderMain model)

        ]
        ++ (rendersuspectlist model)
        ++ (elevatorQuestToSvg model)
        ++ (renderBagButton model)
        ++ (renderhelp))

renderMain : Model -> List (Html Msg)
renderMain model =
        if not model.isEnd then
         [renderPic model
        , renderMapButton model
        , renderMusic model
        , axisHelper model
        , renderGrid1Detail model
        , renderGrid2Detail model
        , renderGrid3Detail model
        , renderGrid4Detail model
        , renderGrid5Detail model
        , renderGrid6Detail model
        , renderGrid7Detail model
        , renderGrid8Detail model
        , renderGrid9Detail model
        , renderGrid10Detail model
        , renderGrid11Detail model
        , renderGrid12Detail model
        , renderGrid13Detail model
        , renderGrid14Detail model
        , renderGrid15Detail model
        , renderGrid16Detail model
        , renderGrid17Detail model
        , renderGrid18Detail model
        , renderGrid19Detail model
        , renderGrid20Detail model
        , renderStartButton model
        , renderAboutUsButton model
        , renderStoryButton model
        , renderBackButton model
        , renderCloseGrid model
        ]

        else
        [ renderPic model
        , renderMapButton model
        , renderMusic model
        , axisHelper model
        , renderStartButton model
        , renderAboutUsButton model
        , renderStoryButton model
        , renderBackButton model
        ]

renderInput : String -> Model -> Html Msg
renderInput opacity model =
    div
                [ style "border-style" "inset"
                , style "border-color" "white"
                , style "border-width" "6px"
                , style "border-radius" "20%"
                , style "width" "500px"
                , style "height" "30px"
                , style "background-color" "white"
                , style "position" "absolute"
                , style "left" "300px"
                , style "top" "300px"
                , style "text-align" "center"
                , style "margin" "auto"
                , style "font-family" "Helvetica, Arial, sans-serif"
                , style "font-size" "18px"
                , style "font-weight" "300"
                ]

    [  if model.map == Home then
       (input [ value model.codeContent, onInput ChangeCodeText
            ] [])
       else
       (text "Need a computer to read the file.")


          ,
          div []
          [ button
          [ onClick (ExamineItemsInBag model.whichGridIsOpen)
          , Html.Attributes.style "width" "85px"
          , Html.Attributes.style "height" "30px"
          , Html.Attributes.style "font-size" "18px"
          , style "position" "absolute"
          , style "left" "207.5px"
          , style "top" "37px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "opacity" opacity
          ] [ text "Examine" ]
          ]

    ]




axisHelper : Model -> Html Msg
axisHelper model =
    if gameMode______ /= Game then
        div []
            [ text (model.hero.x |> Debug.toString), br [] []
            , text (model.hero.y |> Debug.toString)
            ]
    else
    div [] []

renderMusic : Model-> Html Msg
renderMusic model=
    let
        map=model.map
    in
    case map of
        PoliceOffice ->
                div []
                 [ div []
                    [ Html.iframe
                    [ src "./trigger.mp3"
                    , autoplay True
                    , style "display" "none"
                    ] []
                    ]
                  , div []
                    [ Html.audio
                    [ id "player"
                    , autoplay True
                    , loop True
                    , src "./audio/police~1.mp3" --If bgm need to be switched, I think here should be a function._Kevin
                    , type_ "audio/mp3"
                    ] []
                    ]
                    ]
        Park ->
                div []
                 [ div []
                    [ Html.iframe
                    [ src "./trigger.mp3"
                    , autoplay True
                    , style "display" "none"
                    ] []
                    ]
                  , div []
                    [ Html.audio
                    [ id "player"
                    , autoplay True
                    , loop True
                    , src "./audio/park~1.mp3" --If bgm need to be switched, I think here should be a function._Kevin
                    , type_ "audio/mp3"
                    ] []
                    ]
                    ]
        DreamMaze ->
                div []
                 [ div []
                    [ Html.iframe
                    [ src "./trigger.mp3"
                    , autoplay True
                    , style "display" "none"
                    ] []
                    ]
                  , div []
                    [ Html.audio
                    [ id "player"
                    , autoplay True
                    , loop True
                    , src "./bgm.mp3" --If bgm need to be switched, I think here should be a function._Kevin
                    , type_ "audio/mp3"
                    ] []
                    ]
                    ]
        NightClub ->
                div []
                 [ div []
                    [ Html.iframe
                    [ src "./trigger.mp3"
                    , autoplay True
                    , style "display" "none"
                    ] []
                    ]
                  , div []
                    [ Html.audio
                    [ id "player"
                    , autoplay True
                    , loop True
                    , src "././audio/nightclub~1.mp3" --If bgm need to be switched, I think here should be a function._Kevin
                    , type_ "audio/mp3"
                    ] []
                    ]
                    ]
        Journalist ->
                div []
                 [ div []
                    [ Html.iframe
                    [ src "./trigger.mp3"
                    , autoplay True
                    , style "display" "none"
                    ] []
                    ]
                  , div []
                    [ Html.audio
                    [ id "player"
                    , autoplay True
                    , loop True
                    , src "./bgm.mp3" --If bgm need to be switched, I think here should be a function._Kevin
                    , type_ "audio/mp3"
                    ] []
                    ]
                    ]
        Home ->
                div []
                 [ div []
                    [ Html.iframe
                    [ src "./trigger.mp3"
                    , autoplay True
                    , style "display" "none"
                    ] []
                    ]
                  , div []
                    [ Html.audio
                    [ id "player"
                    , autoplay True
                    , loop True
                    , src "././audio/home~1.mp3" --If bgm need to be switched, I think here should be a function._Kevin
                    , type_ "audio/mp3"
                    ] []
                    ]
                    ]
        Daniel ->
                div []
                 [ div []
                    [ Html.iframe
                    [ src "./trigger.mp3"
                    , autoplay True
                    , style "display" "none"
                    ] []
                    ]
                  , div []
                    [ Html.audio
                    [ id "player"
                    , autoplay True
                    , loop True
                    , src "./audio/daniel~1.mp3" --If bgm need to be switched, I think here should be a function._Kevin
                    , type_ "audio/mp3"
                    ] []
                    ]
                    ]
        CityCouncil ->
                div []
                 [ div []
                    [ Html.iframe
                    [ src "./trigger.mp3"
                    , autoplay True
                    , style "display" "none"
                    ] []
                    ]
                  , div []
                    [ Html.audio
                    [ id "player"
                    , autoplay True
                    , loop True
                    , src "./audio/court~1.mp3" --If bgm need to be switched, I think here should be a function._Kevin
                    , type_ "audio/mp3"
                    ] []
                    ]
                    ]
        BackStreet ->
                div []
                 [ div []
                    [ Html.iframe
                    [ src "./trigger.mp3"
                    , autoplay True
                    , style "display" "none"
                    ] []
                    ]
                  , div []
                    [ Html.audio
                    [ id "player"
                    , autoplay True
                    , loop True
                    , src "./audio/backstreet~1.mp3" --If bgm need to be switched, I think here should be a function._Kevin
                    , type_ "audio/mp3"
                    ] []
                    ]
                    ]
        StarterPage ->
                        div []
                         [ div []
                            [ Html.iframe
                            [ src "./trigger.mp3"
                            , autoplay True
                            , style "display" "none"
                            ] []
                            ]
                          , div []
                            [ Html.audio
                            [ id "player"
                            , autoplay True
                            , loop True
                            , src "./audio/starter~1.mp3" --If bgm need to be switched, I think here should be a function._Kevin
                            , type_ "audio/mp3"
                            ] []
                            ]
                            ]
        BadEnds ->
                        div []
                         [ div []
                            [ Html.iframe
                            [ src "./trigger.mp3"
                            , autoplay True
                            , style "display" "none"
                            ] []
                            ]
                          , div []
                            [ Html.audio
                            [ id "player"
                            , autoplay True
                            , loop True
                            , src "./audio/ending~1.mp3" --If bgm need to be switched, I think here should be a function._Kevin
                            , type_ "audio/mp3"
                            ] []
                            ]
                            ]
        Switching ->
                div []
                 [ ]


        _ ->
                div []
                 [ div []
                    [ Html.iframe
                    [ src "./trigger.mp3"
                    , autoplay True
                    , style "display" "none"
                    ] []
                    ]
                  , div []
                    [ Html.audio
                    [ id "player"
                    , autoplay True
                    , loop True
                    , src "./bgm.mp3" --If bgm need to be switched, I think here should be a function._Kevin
                    , type_ "audio/mp3"
                    ] []
                    ]
                    ]



renderMapButton : Model -> Html Msg
renderMapButton model =
    case model.map of
        Switching ->
            if model.dayState == Day1 then
            div []
            [
            button
            [ style "position" "absolute"
            , style "left" "500px"
            , style "top" "350px"
            , style "font-family" "Helvetica, Arial, sans-serif"
            , style "font-size" "12px"
            , style "height" "30px"
            , style "width" "120px"
            , class "fill"
            , onClick ToPoliceOffice
            ]
            [ Html.text "Police Office" ]
            ,
            button
            [ style "position" "absolute"
            , style "left" "800px"
            , style "top" "200px"
            , style "font-family" "Helvetica, Arial, sans-serif"
            , style "font-size" "12px"
            , style "height" "30px"
            , style "width" "120px"
            , class "fill"
            , onClick ToPark
            ]
            [ Html.text "Park" ]
            ,
            button
            [ style "position" "absolute"
            , style "left" "350px"
            , style "top" "400px"
            , style "font-family" "Helvetica, Arial, sans-serif"
            , style "font-size" "12px"
            , style "height" "30px"
            , style "width" "120px"
            , class "fill"
            , onClick ToHome
            ]
            [ Html.text "Home" ]
            ]
            else if model.dayState == Day2 || model.dayState == Day2_Finished then
            div []
            [
            button
            [ style "position" "absolute"
            , style "left" "500px"
            , style "top" "350px"
            , style "font-family" "Helvetica, Arial, sans-serif"
            , style "font-size" "12px"
            , style "height" "30px"
            , style "width" "120px"
            , class "fill"
            , onClick ToPoliceOffice
            ]
            [ Html.text "Police Office" ]
            ,
            button
            [ style "position" "absolute"
            , style "left" "350px"
            , style "top" "400px"
            , style "font-family" "Helvetica, Arial, sans-serif"
            , style "font-size" "12px"
            , style "height" "30px"
            , style "width" "120px"
            , class "fill"
            , onClick ToHome
            ]
            [ Html.text "Home" ]
            ,
            button
            [ style "position" "absolute"
            , style "left" "200px"
            , style "top" "100px"
            , style "font-family" "Helvetica, Arial, sans-serif"
            , style "font-size" "12px"
            , style "height" "30px"
            , style "width" "120px"
            , class "fill"
            , onClick ToJournalist
            ]
            [ Html.text "Journalist's Home" ]
            ,
            button
            [ style "position" "absolute"
            , style "left" "800px"
            , style "top" "200px"
            , style "font-family" "Helvetica, Arial, sans-serif"
            , style "font-size" "12px"
            , style "height" "30px"
            , style "width" "120px"
            , class "fill"
            , onClick ToPark
            ]
            [ Html.text "Park" ]
            ]
            else if model.dayState == Day2_Night then
            div []
            [
            button
            [ style "position" "absolute"
            , style "left" "500px"
            , style "top" "350px"
            , style "font-family" "Helvetica, Arial, sans-serif"
            , style "font-size" "12px"
            , style "height" "30px"
            , style "width" "120px"
            , class "fill"
            , onClick ToPoliceOffice
            ]
            [ Html.text "Police Office" ]
            ,
            button
            [ style "position" "absolute"
            , style "left" "350px"
            , style "top" "400px"
            , style "font-family" "Helvetica, Arial, sans-serif"
            , style "font-size" "12px"
            , style "height" "30px"
            , style "width" "120px"
            , class "fill"
            , onClick ToHome
            ]
            [ Html.text "Home" ]
            ,
            button
            [ style "position" "absolute"
            , style "left" "330px"
            , style "top" "270px"
            , style "font-family" "Helvetica, Arial, sans-serif"
            , style "font-size" "12px"
            , style "height" "30px"
            , style "width" "120px"
            , class "fill"
            , onClick ToNightClub
            ]
            [ Html.text "NightClub" ]
            ]
            else if model.dayState == Day3 then
            div []
            [
            button
            [ style "position" "absolute"
            , style "left" "500px"
            , style "top" "350px"
            , style "font-family" "Helvetica, Arial, sans-serif"
            , style "font-size" "12px"
            , style "height" "30px"
            , style "width" "120px"
            , class "fill"
            , onClick ToPoliceOffice
            ]
            [ Html.text "Police Office" ]
            ,
            button
            [ style "position" "absolute"
            , style "left" "350px"
            , style "top" "400px"
            , style "font-family" "Helvetica, Arial, sans-serif"
            , style "font-size" "12px"
            , style "height" "30px"
            , style "width" "120px"
            , class "fill"
            , onClick ToHome
            ]
            [ Html.text "Home" ]
            ,
            button
            [ style "position" "absolute"
            , style "left" "550px"
            , style "top" "100px"
            , style "font-family" "Helvetica, Arial, sans-serif"
            , style "font-size" "12px"
            , style "height" "30px"
            , style "width" "120px"
            , class "fill"
            , onClick ToDaniel
            ]
            [ Html.text "Daniel's home" ]
            ,
            button
            [ style "position" "absolute"
            , style "left" "800px"
            , style "top" "200px"
            , style "font-family" "Helvetica, Arial, sans-serif"
            , style "font-size" "12px"
            , style "height" "30px"
            , style "width" "120px"
            , class "fill"
            , onClick ToPark
            ]
            [ Html.text "Park" ]

            ]
            else if model.dayState == Day4 then
            div []
            [
            button
            [ style "position" "absolute"
            , style "left" "500px"
            , style "top" "350px"
            , style "font-family" "Helvetica, Arial, sans-serif"
            , style "font-size" "12px"
            , style "height" "30px"
            , style "width" "120px"
            , class "fill"
            , onClick ToPoliceOffice
            ]
            [ Html.text "Police Office" ]
            ,
            button
            [ style "position" "absolute"
            , style "left" "350px"
            , style "top" "400px"
            , style "font-family" "Helvetica, Arial, sans-serif"
            , style "font-size" "12px"
            , style "height" "30px"
            , style "width" "120px"
            , class "fill"
            , onClick ToHome
            ]
            [ Html.text "Home" ]
            ,
            button
            [ style "position" "absolute"
            , style "left" "550px"
            , style "top" "100px"
            , style "font-family" "Helvetica, Arial, sans-serif"
            , style "font-size" "12px"
            , style "height" "30px"
            , style "width" "120px"
            , class "fill"
            , onClick ToDaniel
            ]
            [ Html.text "Daniel's home" ]
            ,
            button
            [ style "position" "absolute"
            , style "left" "800px"
            , style "top" "200px"
            , style "font-family" "Helvetica, Arial, sans-serif"
            , style "font-size" "12px"
            , style "height" "30px"
            , style "width" "120px"
            , class "fill"
            , onClick ToPark
            ]
            [ Html.text "Park" ]

            ]
            else if model.dayState == Day5 then
            div []
            [
            button
            [ style "position" "absolute"
            , style "left" "500px"
            , style "top" "350px"
            , style "font-family" "Helvetica, Arial, sans-serif"
            , style "font-size" "12px"
            , style "height" "30px"
            , style "width" "120px"
            , class "fill"
            , onClick ToPoliceOffice
            ]
            [ Html.text "Police Office" ]
            ,
            button
            [ style "position" "absolute"
            , style "left" "800px"
            , style "top" "200px"
            , style "font-family" "Helvetica, Arial, sans-serif"
            , style "font-size" "12px"
            , style "height" "30px"
            , style "width" "120px"
            , class "fill"
            , onClick ToPark
            ]
            [ Html.text "Park" ]
            ,
            button
            [ style "position" "absolute"
            , style "left" "350px"
            , style "top" "400px"
            , style "font-family" "Helvetica, Arial, sans-serif"
            , style "font-size" "12px"
            , style "height" "30px"
            , style "width" "120px"
            , class "fill"
            , onClick ToHome
            ]
            [ Html.text "Home" ]
            ,
            button
            [ style "position" "absolute"
            , style "left" "330px"
            , style "top" "270px"
            , style "font-family" "Helvetica, Arial, sans-serif"
            , style "font-size" "12px"
            , style "height" "30px"
            , style "width" "120px"
            , class "fill"
            , onClick ToNightClub
            ]
            [ Html.text "NightClub" ]
            ]
            else if model.dayState == Day6 then
            div []
            [
            --button
            --[ style "position" "absolute"
            --, style "left" "500px"
            --, style "top" "350px"
            --, style "font-family" "Helvetica, Arial, sans-serif"
            --, style "font-size" "12px"
            --, style "height" "30px"
            --, style "width" "120px"
            --, class "fill"
            --, onClick ToPoliceOffice
            --]
            --[ Html.text "Police Office" ]
            --,
            button
            [ style "position" "absolute"
            , style "left" "350px"
            , style "top" "400px"
            , style "font-family" "Helvetica, Arial, sans-serif"
            , style "font-size" "12px"
            , style "height" "30px"
            , style "width" "120px"
            , class "fill"
            , onClick ToHome
            ]
            [ Html.text "Home" ]
            ,
            button
            [ style "position" "absolute"
            , style "left" "440px"
            , style "top" "240px"
            , style "font-family" "Helvetica, Arial, sans-serif"
            , style "font-size" "12px"
            , style "height" "30px"
            , style "width" "120px"
            , class "fill"
            , onClick ToCityCouncil
            ]
            [ Html.text "City Council" ]
            ]
            else if model.dayState == Day7 && not model.isTalkingWithLeeDay7 then
            div []
            [
            button
            [ style "position" "absolute"
            , style "left" "500px"
            , style "top" "350px"
            , style "font-family" "Helvetica, Arial, sans-serif"
            , style "font-size" "12px"
            , style "height" "30px"
            , style "width" "120px"
            , class "fill"
            , onClick ToPoliceOffice
            ]
            [ Html.text "Police Office" ]
            ,
            button
            [ style "position" "absolute"
            , style "left" "350px"
            , style "top" "400px"
            , style "font-family" "Helvetica, Arial, sans-serif"
            , style "font-size" "12px"
            , style "height" "30px"
            , style "width" "120px"
            , class "fill"
            , onClick ToHome
            ]
            [ Html.text "Home" ]
            ]
            else if model.dayState == Day8 then
            div []
            [
            button
            [ style "position" "absolute"
            , style "left" "500px"
            , style "top" "350px"
            , style "font-family" "Helvetica, Arial, sans-serif"
            , style "font-size" "12px"
            , style "height" "30px"
            , style "width" "120px"
            , class "fill"
            , onClick ToPoliceOffice
            ]
            [ Html.text "Police Office" ]
            ,
            button
            [ style "position" "absolute"
            , style "left" "440px"
            , style "top" "240px"
            , style "font-family" "Helvetica, Arial, sans-serif"
            , style "font-size" "12px"
            , style "height" "30px"
            , style "width" "120px"
            , class "fill"
            , onClick ToCityCouncil
            ]
            [ Html.text "City Council" ]
            ,
            button
            [ style "position" "absolute"
            , style "left" "350px"
            , style "top" "400px"
            , style "font-family" "Helvetica, Arial, sans-serif"
            , style "font-size" "12px"
            , style "height" "30px"
            , style "width" "120px"
            , class "fill"
            , onClick ToHome
            ]
            [ Html.text "Home" ]
            ]
            else if model.dayState == Day9 then
            div []
            [
            button
            [ style "position" "absolute"
            , style "left" "350px"
            , style "top" "400px"
            , style "font-family" "Helvetica, Arial, sans-serif"
            , style "font-size" "12px"
            , style "height" "30px"
            , style "width" "120px"
            , class "fill"
            , onClick ToHome
            ]
            [ Html.text "Home" ]
            ,
            button
            [ style "position" "absolute"
            , style "left" "230px"
            , style "top" "345px"
            , style "font-family" "Helvetica, Arial, sans-serif"
            , style "font-size" "12px"
            , style "height" "30px"
            , style "width" "120px"
            , class "fill"
            , onClick ToBackStreet
            ]
            [ Html.text "Back Street" ]

            ]

            else div [][]






        EnergyDrain ->
            div []
             [
             button
             [ style "background" "red"
             , style "position" "absolute"
             , style "left" "350px"
             , style "top" "400px"
             , style "color" "#f3f2e9"
             , style "cursor" "pointer"
             , style "display" "block"
             , style "font-family" "Helvetica, Arial, sans-serif"
             , style "font-size" "18px"
             , style "font-weight" "300"
             , style "height" "80px"
             , style "line-height" "60px"
             , style "outline" "none"
             , style "padding" "0"
             , style "width" "130px"
             , style "border-style" "inset"
             , style "border-color" "white"
             , style "border-width" "6px"
             , style "border-radius" "20%"
             , onClick ToHome
             ]
             [ Html.text "Home" ]


                        ]

        _ ->
            div [] []



renderPic : Model -> Html Msg
renderPic model =
    svg
        [ width "1050"
        , height "700"
        , viewBox "0 0 1200 800"
        ]
        (
        [ Svg.defs [] [ Svg.radialGradient
            [ Svg.Attributes.id "hero-ball-maze"
            , Svg.Attributes.x1 "0", Svg.Attributes.x2 "0", Svg.Attributes.y1 "0", Svg.Attributes.y2 "1"]
            [ Svg.stop [ Svg.Attributes.offset "50%", Svg.Attributes.stopColor "white" ] []
            , Svg.stop [ Svg.Attributes.offset "100%", Svg.Attributes.stopColor "black" ] []
            ] ]
        ] ++
        (
        --if not model.isEnd then
        case model.map of
            PoliceOffice ->
                if model.dayState == Day5 || model.dayState == Day7 then
                [Svg.image
                    [ xlinkHref "./police_office_night.png" -- I'll change all the maps into 1050*630... ——Lan Wang
                    , x "0"
                    , y "0"
                    , width "1200"
                    , height "600"
                    , transform "translate(-30,0)"
                    ] []]
                ++ [renderdialog model]
                ++ npcListView model
                ++ ( heroToSvg model )
                ++ [renderportrait model]
                ++ [ bedQuestToSvg model ]
                ++ [renderchoice model]
                ++ energytosvg model.energy model.energy_Full
                else if model.dayState == Day2 then
                [Svg.image
                    [ xlinkHref "./police_office_without_lee.png" -- I'll change all the maps into 1050*630... ——Lan Wang
                    , x "0"
                    , y "0"
                    , width "1200"
                    , height "600"
                    , transform "translate(-30,0)"
                    ] []]
                ++ [renderdialog model]
                ++ npcListView model
                ++ ( heroToSvg model )
                ++ [renderportrait model]
                ++ [ bedQuestToSvg model ]
                ++ [renderchoice model]
                ++ energytosvg model.energy model.energy_Full
                else
                [Svg.image
                    [ xlinkHref "./police_office.png" -- I'll change all the maps into 1050*630... ——Lan Wang
                    , x "0"
                    , y "0"
                    , width "1200"
                    , height "600"
                    , transform "translate(-30,0)"
                    ] []]
                ++ [renderdialog model]
                ++ npcListView model
                ++ ( heroToSvg model )
                ++ [renderportrait model]
                ++ [ bedQuestToSvg model ]
                ++ [renderchoice model]
                ++ energytosvg model.energy model.energy_Full

            Park ->
                if model.dayState == Day1 then
                ([ Svg.image
                    [ xlinkHref "./park.png"
                    , x "0"
                    , y "0"
                    , width "1200"
                    , height "600"
                    , transform "translate(-30,0)" -- in this scale for a 2388*1688 picture, all things are favorable. But I still confused about this. So can anyone help? --zhouyuxiang 7/9
                    ] [] ])
                ++ [renderdialog model]
                ++ npcListView model
                ++ ( heroToSvg model )
                ++ [renderportrait model]
                ++ [ bedQuestToSvg model ]
                ++ [renderchoice model]
                ++ energytosvg model.energy model.energy_Full

                else if model.dayState == Day5 then
                ([ Svg.rect
                    [ x "0"
                    , y "0"
                    , width "1171"
                    , height "600"
                    , transform "translate(-30,0)" -- in this scale for a 2388*1688 picture, all things are favorable. But I still confused about this. So can anyone help? --zhouyuxiang 7/9
                    ] [] ])

                ++ [renderdialog model]
                ++ npcListView model
                ++ ( heroToSvg model )
                ++ [renderportrait model]
                ++ [ bedQuestToSvg model ]
                ++ [renderchoice model]
                ++ energytosvg model.energy model.energy_Full
                else
                ([ Svg.image
                    [ xlinkHref "./park_without_npc.png"
                    , x "0"
                    , y "0"
                    , width "1200"
                    , height "600"
                    , transform "translate(-30,0)" -- in this scale for a 2388*1688 picture, all things are favorable. But I still confused about this. So can anyone help? --zhouyuxiang 7/9
                    ] [] ])
                ++ [renderdialog model]
                ++ npcListView model
                ++ ( heroToSvg model )
                ++ [renderportrait model]
                ++ [ bedQuestToSvg model ]
                ++ [renderchoice model]
                ++ energytosvg model.energy model.energy_Full

            Switching ->

                [ rect [x "0", y "0", width "1150", height "600", fill "#a0775a"] []
                , Svg.image
                    [ xlinkHref "./mapswitch.png"
                    , x "5"
                    , y "5"
                    , width "1200"
                    , height "590"
                    , transform "translate(-30,0)" -- in this scale for a 2388*1688 picture, all things are favorable. But I still confused about this. So can anyone help? --zhouyuxiang 7/9
                    ] [] ]
                ++ [ renderdialog model ]
                ++ [ renderchoice model ]
                ++ [renderportrait model]

            EnergyDrain ->

                [Svg.rect
                    [ x "0"
                    , y "0"
                    , width "1200"
                    , height "600"][]]
                ++ [ renderdialog model ]
                ++ [renderportrait model]


            Home ->
                [Svg.image
                    [ xlinkHref "./Kay's_home.png"
                    , x "0"
                    , y "0"
                    , width "1200"
                    , height "600"
                    , transform "translate(-30,0)" -- in this scale for a 2388*1688 picture, all things are favorable. But I still confused about this. So can anyone help? --zhouyuxiang 7/9
                    ] []]
                ++ [renderdialog model]
                ++ npcListView model
                ++ ( heroToSvg model )
                ++ [renderportrait model]
                ++ [ bedQuestToSvg model ]
                ++ [renderchoice model]
                ++ energytosvg model.energy model.energy_Full


            DreamMaze ->
                [Svg.image
                    [ xlinkHref "./dream_maze_1.png"
                    , x "135"
                    , y "0"
                    , width "900"
                    , height "630"
                    , transform "translate(0,-20)" -- in this scale for a 2388*1688 picture, all things are favorable. But I still confused about this. So can anyone help? --zhouyuxiang 7/9
                    ] [] ]
                --++ heroToSvg model.hero
                ++ ( heroToSvgInMaze model.hero )
                ++ [ renderdialog model ]
                ++ [renderportrait model]



            Journalist ->
                [ Svg.image
                    [ xlinkHref "./journalist's_home.png"
                    , x "0"
                    , y "0"
                    , width "1200"
                    , height "600"
                    , transform "translate(-30,0)" -- in this scale for a 2388*1688 picture, all things are favorable. But I still confused about this. So can anyone help? --zhouyuxiang 7/9
                    ] []]
                ++ [renderdialog model]
                ++ npcListView model
                ++ ( heroToSvg model )
                ++ [renderportrait model]
                ++ [ bedQuestToSvg model ]
                ++ [renderchoice model]
                ++ energytosvg model.energy model.energy_Full


            NightClub ->
                if model.dayState == Day5 then
                [ Svg.image
                    [ xlinkHref "./nightclub_without_body.png"
                    , x "0"
                    , y "0"
                    , width "1200"
                    , height "600"
                    , transform "translate(-30,0)" -- in this scale for a 2388*1688 picture, all things are favorable. But I still confused about this. So can anyone help? --zhouyuxiang 7/9
                    ] []]
                ++ [renderdialog model]
                ++ npcListView model
                ++ ( heroToSvg model )
                ++ [renderportrait model]
                ++ [ bedQuestToSvg model ]
                ++ [renderchoice model]
                ++ energytosvg model.energy model.energy_Full
                else
                [ Svg.image
                    [ xlinkHref "./nightclub.png"
                    , x "0"
                    , y "0"
                    , width "1200"
                    , height "600"
                    , transform "translate(-30,0)" -- in this scale for a 2388*1688 picture, all things are favorable. But I still confused about this. So can anyone help? --zhouyuxiang 7/9
                    ] []]
                ++ [renderdialog model]
                ++ npcListView model
                ++ ( heroToSvg model )
                ++ [renderportrait model]
                ++ [ bedQuestToSvg model ]
                ++ [renderchoice model]
                ++ energytosvg model.energy model.energy_Full


            Daniel ->
                if model.dayState /= Day4 then
                [ Svg.image
                    [ xlinkHref "./Ann_and_Daniel's_home.png"
                    , x "0"
                    , y "0"
                    , width "1200"
                    , height "600"
                    , transform "translate(-30,0)" -- in this scale for a 2388*1688 picture, all things are favorable. But I still confused about this. So can anyone help? --zhouyuxiang 7/9
                    ] []]
                ++ [renderdialog model]
                ++ npcListView model
                ++ ( heroToSvg model )
                ++ [renderportrait model]
                ++ [ bedQuestToSvg model ]
                ++ [renderchoice model]
                ++ energytosvg model.energy model.energy_Full
                else
                [ Svg.image
                    [ xlinkHref "./Ann_and_Daniel's_home_without_npcs.png"
                    , x "0"
                    , y "0"
                    , width "1200"
                    , height "600"
                    , transform "translate(-30,0)" -- in this scale for a 2388*1688 picture, all things are favorable. But I still confused about this. So can anyone help? --zhouyuxiang 7/9
                    ] []]
                ++ [renderdialog model]
                ++ npcListView model
                ++ ( heroToSvg model )
                ++ [renderportrait model]
                ++ [ bedQuestToSvg model ]
                ++ [renderchoice model]
                ++ energytosvg model.energy model.energy_Full

            CityCouncil->
                [ Svg.image
                    [ xlinkHref "./court.png"
                    , x "0"
                    , y "0"
                    , width "1200"
                    , height "600"
                    , transform "translate(-30,0)" -- in this scale for a 2388*1688 picture, all things are favorable. But I still confused about this. So can anyone help? --zhouyuxiang 7/9
                    ] []]
                ++ [renderdialog model]
                ++ npcListView model
                ++ ( heroToSvg model )
                ++ [renderportrait model]
                ++ [ bedQuestToSvg model ]
                ++ [renderchoice model]
                ++ energytosvg model.energy model.energy_Full

            BackStreet->
                [ Svg.image
                    [ xlinkHref "./street.png"
                    , x "0"
                    , y "0"
                    , width "1200"
                    , height "600"
                    , transform "translate(-30,0)" -- in this scale for a 2388*1688 picture, all things are favorable. But I still confused about this. So can anyone help? --zhouyuxiang 7/9
                    ] []]
                ++ [renderdialog model]
                ++ npcListView model
                ++ ( heroToSvg model )
                ++ [renderportrait model]
                ++ [ bedQuestToSvg model ]
                ++ [renderchoice model]
                ++ energytosvg model.energy model.energy_Full

 -----


            StarterPage ->
                [image [xlinkHref "./title.png", x "300", y "100", width "570"][]]

            Story ->
                [div [][]]

            AboutUs ->
                [div [][]]


            BadEnds ->
                let
                    c =
                        if model.isGoodEnd == True then "white"
                        else if model.isSpecialEnd == True then "black"
                        else "red"
                in
                renderPreviousMap model ++
                 [Svg.rect
                 [ x "0"
                 , y "0"
                 , width "1171"
                 , height "600"
                 , transform "translate(-30,0)"
                 , Svg.Attributes.opacity (toString (0.5 * (model.endingTimeAccum / 4000)))
                 , fill c
                 ]
                 []]
                 ++ [renderdialog model]


            NoPlace ->
                [rect[][]]





        --else




        ) ++
        ( testToSvg model
        ++ itemsToSvg model
        ++ dayToSvg model )
        )

renderPreviousMap : Model -> List ( Svg Msg )
renderPreviousMap model =
    case model.badEndPreviousMap of
            PoliceOffice ->

                [Svg.image
                    [ xlinkHref "./police_office.png" -- I'll change all the maps into 1050*630... ——Lan Wang
                    , x "0"
                    , y "0"
                    , width "1200"
                    , height "600"
                    , transform "translate(-30,0)"
                    ] []]
            Park ->
                if model.dayState /= Day5 then
                [ Svg.image
                    [ xlinkHref "./park.png"
                    , x "0"
                    , y "0"
                    , width "1200"
                    , height "600"
                    , transform "translate(-30,0)" -- in this scale for a 2388*1688 picture, all things are favorable. But I still confused about this. So can anyone help? --zhouyuxiang 7/9
                    ] [] ]
                else
                [ Svg.rect
                    [ x "0"
                    , y "0"
                    , width "1200"
                    , height "600"
                    , transform "translate(-30,0)" -- in this scale for a 2388*1688 picture, all things are favorable. But I still confused about this. So can anyone help? --zhouyuxiang 7/9
                    ] [] ]

            Switching ->

                [ Svg.image
                    [ xlinkHref "./mapswitch.png"
                    , x "0"
                    , y "0"
                    , width "1200"
                    , height "590"
                    , transform "translate(-30,0)" -- in this scale for a 2388*1688 picture, all things are favorable. But I still confused about this. So can anyone help? --zhouyuxiang 7/9
                    ] [] ]
            EnergyDrain ->

                [Svg.rect
                    [ x "0"
                    , y "0"
                    , width "1200"
                    , height "600"][]]
            Home ->
                [Svg.image
                    [ xlinkHref "./Kay's_home.png"
                    , x "0"
                    , y "0"
                    , width "1200"
                    , height "600"
                    , transform "translate(-30,0)" -- in this scale for a 2388*1688 picture, all things are favorable. But I still confused about this. So can anyone help? --zhouyuxiang 7/9
                    ] []]
            DreamMaze ->
                [Svg.image
                    [ xlinkHref "./dream_maze_1.png"
                    , x "135"
                    , y "0"
                    , width "900"
                    , height "630"
                    , transform "translate(0,-20)" -- in this scale for a 2388*1688 picture, all things are favorable. But I still confused about this. So can anyone help? --zhouyuxiang 7/9
                    ] [] ]
            Journalist ->
                [ Svg.image
                    [ xlinkHref "./journalist's_home.png"
                    , x "0"
                    , y "0"
                    , width "1200"
                    , height "600"
                    , transform "translate(-30,0)" -- in this scale for a 2388*1688 picture, all things are favorable. But I still confused about this. So can anyone help? --zhouyuxiang 7/9
                    ] []]
            NightClub ->
                [ Svg.image
                    [ xlinkHref "./nightclub.png"
                    , x "0"
                    , y "0"
                    , width "1200"
                    , height "600"
                    , transform "translate(-30,0)" -- in this scale for a 2388*1688 picture, all things are favorable. But I still confused about this. So can anyone help? --zhouyuxiang 7/9
                    ] []]
            Daniel ->
                [ Svg.image
                    [ xlinkHref "./Ann_and_Daniel's_home.png"
                    , x "0"
                    , y "0"
                    , width "1200"
                    , height "600"
                    , transform "translate(-30,0)" -- in this scale for a 2388*1688 picture, all things are favorable. But I still confused about this. So can anyone help? --zhouyuxiang 7/9
                    ] []]
            CityCouncil->
                [ Svg.image
                    [ xlinkHref "./court.png"
                    , x "0"
                    , y "0"
                    , width "1200"
                    , height "600"
                    , transform "translate(-30,0)" -- in this scale for a 2388*1688 picture, all things are favorable. But I still confused about this. So can anyone help? --zhouyuxiang 7/9
                    ] []]
            BackStreet->
                [ Svg.image
                    [ xlinkHref "./street.png"
                    , x "0"
                    , y "0"
                    , width "1200"
                    , height "600"
                    , transform "translate(-30,0)" -- in this scale for a 2388*1688 picture, all things are favorable. But I still confused about this. So can anyone help? --zhouyuxiang 7/9
                    ] []]

            StarterPage ->
                [rect[][]]

            Story ->
                [rect[][]]


            AboutUs ->
                [rect[][]]


            BadEnds ->
                [rect[][]]

            NoPlace ->
                [rect[][]]






renderdialog : Model -> Svg Msg
renderdialog model =
    Svg.foreignObject [ x "200", y "600", width "1000", height "180"]
                      [ p [ style "flex" "1 1 auto", style "font-size" "1.3em", style "padding" "0 1em", Html.Attributes.class "inset2" ]
                          [ text model.story ]
                      ]

renderchoice : Model -> Svg Msg
renderchoice model =
    let
        opacity =
            case (query "*.choices=1" model.worldModel) of
                [] -> "0"
                _ -> "1"
    in
        Svg.foreignObject [ x "200", y "400", width "800", height "100%", style "opacity" opacity ]
                          [ p [ style "flex" "1 1 auto", style "font-size" "1.4em", style "padding" "0 1em", Html.Attributes.class "inset" ]
                              [ul [] <| List.map entityViewchoices (query "*.choices=1" model.worldModel)]
                          ]

renderportrait : Model -> Svg Msg
renderportrait model =
    let
        portr =
            case model.portrait of
                "" ->
                    Svg.image [ Svg.Attributes.xlinkHref ("./portrait/player.png")
                              , x "5", y "610", width "180"
                              ] []
                _ ->
                    Svg.image [ Svg.Attributes.xlinkHref ("./portrait/"++model.portrait++".png")
                              , x "5", y "610", width "180"
                              ] []
    in
        portr

rendersuspectlist model =
    let
        suspect =
            case model.map of
                Park ->
                    [ button [ onClick Catherinecatch
                             , style "top" "100px", class "slide"
                             , style "opacity" (model.conclusion|>Debug.toString)] [text "Catherine"]
                    , button [ onClick Adkinscatch
                             , style "top" "200px", class "slide"
                             , style "opacity" (model.conclusion|>Debug.toString)] [text "Adkins"]
                    , button [ onClick Robbery
                             , style "top" "300px", class "slide"
                             , style "opacity" (model.conclusion|>Debug.toString)] [text "This is a robbery."]
                    ]
                _ ->
                    []
    in
        [Html.input [Html.Attributes.type_ "checkbox", id "menu"][]
        ,Html.label [Html.Attributes.for "menu", class "menu"][Html.span [] [], Html.span [] [], Html.span [] [] ]
        ,Html.nav [class "nav"] [div [class "container"]
                                     [div [ style "font-family" "Helvetica, Arial, sans-serif"
                                          , style "font-size" "18px"] suspect]]
        ]


renderSingleBagButton : Int -> Model -> Html Msg
renderSingleBagButton num model =
    let
        command =
            case num of
                1 -> RenderGrid1Detail
                2 -> RenderGrid2Detail
                3 -> RenderGrid3Detail
                4 -> RenderGrid4Detail
                5 -> RenderGrid5Detail
                6 -> RenderGrid6Detail
                7 -> RenderGrid7Detail
                8 -> RenderGrid8Detail
                9 -> RenderGrid9Detail
                10 -> RenderGrid10Detail
                11 -> RenderGrid11Detail
                12 -> RenderGrid12Detail
                13 -> RenderGrid13Detail
                14 -> RenderGrid14Detail
                15 -> RenderGrid15Detail
                16 -> RenderGrid16Detail
                17 -> RenderGrid17Detail
                18 -> RenderGrid18Detail
                19 -> RenderGrid19Detail
                20 -> RenderGrid20Detail
                _ -> RenderGrid20Detail
        ( left, top ) =
            case num of
                1 -> ( "20px", "100px" )
                2 -> ( "20px", "180px" )
                3 -> ( "20px", "260px" )
                4 -> ( "20px", "340px" )
                5 -> ( "20px", "420px" )
                6 -> ( "100px", "100px" )
                7 -> ( "100px", "180px" )
                8 -> ( "100px", "260px" )
                9 -> ( "100px", "340px" )
                10 -> ( "100px", "420px" )
                11 -> ( "180px", "100px" )
                12 -> ( "180px", "180px" )
                13 -> ( "180px", "260px" )
                14 -> ( "180px", "340px" )
                15 -> ( "180px", "420px" )
                16 -> ( "260px", "100px" )
                17 -> ( "260px", "180px" )
                18 -> ( "260px", "260px" )
                19 -> ( "260px", "340px" )
                20 -> ( "260px", "420px" )
                _ -> ( "260px", "420px" )
        grid =
            case num of
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
        font_size =
            if grid == noteIni || grid == pillIni || grid == keyIni || grid == pillsIni || grid == diskIni || grid == bankCardIni then
                "15px"
            else if grid == trueMemCardIni || grid == fakeMemCardIni || grid == daggerIni || grid == dagger2Ini || grid == letterIni || grid == bankCardIni then
                "12px"
            else if grid == bankIni || grid == bankaccIni || grid == letterIni || grid == planIni || grid == documentsIni || grid == customconIni then
                "10px"
            else "12px"
    in
    button
        [ onClick command
        , Html.Attributes.style "width" "60px"
        , Html.Attributes.style "height" "60px"
        , Html.Attributes.style "font-size" font_size
        , style "position" "absolute"
        , style "left" left
        , style "top" top
        ] [text grid.intro]


renderBagButton : Model -> List(Html Msg)
renderBagButton model =
    let
        contents =
            div [] [ renderSingleBagButton 1 model, renderSingleBagButton 2 model, renderSingleBagButton 3 model, renderSingleBagButton 4 model
                   , renderSingleBagButton 5 model, renderSingleBagButton 6 model, renderSingleBagButton 7 model, renderSingleBagButton 8 model
                   , renderSingleBagButton 9 model, renderSingleBagButton 10 model, renderSingleBagButton 11 model, renderSingleBagButton 12 model
                   , renderSingleBagButton 13 model, renderSingleBagButton 14 model, renderSingleBagButton 15 model, renderSingleBagButton 16 model
                   , renderSingleBagButton 17 model, renderSingleBagButton 18 model, renderSingleBagButton 19 model, renderSingleBagButton 20 model ]
    in
        [Html.input [Html.Attributes.type_ "checkbox", id "menu2"][]
        ,Html.label [Html.Attributes.for "menu2", class "menu2"][ text "B" ]
        ,Html.nav [class "nav2"] [div [class "container"]
                                      [div [ style "font-family" "Helvetica, Arial, sans-serif"
                                           , style "font-size" "18px"] [contents]]]
        ]



renderGrid1Detail : Model -> Html Msg
renderGrid1Detail model =
    let
        opacity =
            case model.bag.grid1.canBeExamined of
                True -> "1"
                False -> "0"
    in
    if model.whichGridIsOpen == 1 then
        if model.bag.grid1 /= trueMemCardIni || model.codeReached then
        if model.map == Home then
        div
          [ style "border-style" "inset"
          , style "border-color" "#ffa940"
          , style "border-width" "3px"
          , style "border-radius" "20%"
          , style "width" "300px"
          , style "height" "300px"
          , style "background-color" "white"
          , style "position" "absolute"
          , style "left" "350px"
          , style "top" "25px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "font-family" "Helvetica, Arial, sans-serif"
          , style "font-size" "18px"
          , style "font-weight" "300"
          ]
          [ Html.img [src model.bag.grid1.img, width "300px"] []
          ,
          div []
          [ button
          [ onClick (ExamineItemsInBag model.whichGridIsOpen)
          , Html.Attributes.style "width" "85px"
          , Html.Attributes.style "height" "30px"
          , Html.Attributes.style "font-size" "18px"
          , style "position" "absolute"
          , style "left" "107.5px"
          , style "top" "300px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "opacity" opacity
          ] [ text "Examine" ]
          ]
          ,
          div []
          [ button
          [ onClick (AskDelete model.whichGridIsOpen)
          , Html.Attributes.style "width" "85px"
          , Html.Attributes.style "height" "30px"
          , Html.Attributes.style "font-size" "18px"
          , style "position" "absolute"
          , style "left" "107.5px"
          , style "top" "333px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "opacity" opacity
          ] [ text "Discard" ]
          ]
          ]
        else
        div
          [ style "border-style" "inset"
          , style "border-color" "#ffa940"
          , style "border-width" "3px"
          , style "border-radius" "20%"
          , style "width" "300px"
          , style "height" "300px"
          , style "background-color" "white"
          , style "position" "absolute"
          , style "left" "350px"
          , style "top" "25px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "font-family" "Helvetica, Arial, sans-serif"
          , style "font-size" "18px"
          , style "font-weight" "300"
          ]
          [ Html.img [src model.bag.grid1.img, width "300px"] []
          ,
          div []
          [ button
          [ onClick (ExamineItemsInBag model.whichGridIsOpen)
          , Html.Attributes.style "width" "85px"
          , Html.Attributes.style "height" "30px"
          , Html.Attributes.style "font-size" "18px"
          , style "position" "absolute"
          , style "left" "107.5px"
          , style "top" "300px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "opacity" opacity
          ] [ text "Examine" ]
          ]
          ]
          else renderInput opacity model
    else
    div [][]

renderGrid2Detail : Model -> Html Msg
renderGrid2Detail model =
    let
        opacity =
            case model.bag.grid2.canBeExamined of
                True -> "1"
                False -> "0"
    in
    if model.whichGridIsOpen == 2 then
        if model.bag.grid2 /= trueMemCardIni || model.codeReached then
        if model.map == Home then
        div
          [ style "border-style" "inset"
          , style "border-color" "#ffa940"
          , style "border-width" "3px"
          , style "border-radius" "20%"
          , style "width" "300px"
          , style "height" "300px"
          , style "background-color" "white"
          , style "position" "absolute"
          , style "left" "350px"
          , style "top" "25px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "font-family" "Helvetica, Arial, sans-serif"
          , style "font-size" "18px"
          , style "font-weight" "300"
          ]
          [ Html.img [src model.bag.grid2.img, width "300px"] []
          ,
          div []
          [ button
          [ onClick (ExamineItemsInBag model.whichGridIsOpen)
          , Html.Attributes.style "width" "85px"
          , Html.Attributes.style "height" "30px"
          , Html.Attributes.style "font-size" "18px"
          , style "position" "absolute"
          , style "left" "107.5px"
          , style "top" "300px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "opacity" opacity
          ] [ text "Examine" ]
          ]
          ,
          div []
          [ button
          [ onClick (AskDelete model.whichGridIsOpen)
          , Html.Attributes.style "width" "85px"
          , Html.Attributes.style "height" "30px"
          , Html.Attributes.style "font-size" "18px"
          , style "position" "absolute"
          , style "left" "107.5px"
          , style "top" "333px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "opacity" opacity
          ] [ text "Discard" ]
          ]
          ]
        else
        div
          [ style "border-style" "inset"
          , style "border-color" "#ffa940"
          , style "border-width" "3px"
          , style "border-radius" "20%"
          , style "width" "300px"
          , style "height" "300px"
          , style "background-color" "white"
          , style "position" "absolute"
          , style "left" "350px"
          , style "top" "25px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "font-family" "Helvetica, Arial, sans-serif"
          , style "font-size" "18px"
          , style "font-weight" "300"
          ]
          [ Html.img [src model.bag.grid2.img, width "300px"] []
          ,
          div []
          [ button
          [ onClick (ExamineItemsInBag model.whichGridIsOpen)
          , Html.Attributes.style "width" "85px"
          , Html.Attributes.style "height" "30px"
          , Html.Attributes.style "font-size" "18px"
          , style "position" "absolute"
          , style "left" "107.5px"
          , style "top" "300px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "opacity" opacity
          ] [ text "Examine" ]
          ]
          ]
        else renderInput opacity model
    else
    div [][]

renderGrid3Detail : Model -> Html Msg
renderGrid3Detail model =
    let
        opacity =
            case model.bag.grid3.canBeExamined of
                True -> "1"
                False -> "0"
    in


    if model.whichGridIsOpen == 3 then
        if model.bag.grid3 /= trueMemCardIni || model.codeReached then
        if model.map == Home then
        div
          [ style "border-style" "inset"
          , style "border-color" "#ffa940"
          , style "border-width" "3px"
          , style "border-radius" "20%"
          , style "width" "300px"
          , style "height" "300px"
          , style "background-color" "white"
          , style "position" "absolute"
          , style "left" "350px"
          , style "top" "25px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "font-family" "Helvetica, Arial, sans-serif"
          , style "font-size" "18px"
          , style "font-weight" "300"
          ]
          [ Html.img [src model.bag.grid3.img, width "300px"] []
          ,
          div []
          [ button
          [ onClick (ExamineItemsInBag model.whichGridIsOpen)
          , Html.Attributes.style "width" "85px"
          , Html.Attributes.style "height" "30px"
          , Html.Attributes.style "font-size" "18px"
          , style "position" "absolute"
          , style "left" "107.5px"
          , style "top" "300px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "opacity" opacity
          ] [ text "Examine" ]
          ]
          ,
          div []
          [ button
          [ onClick (AskDelete model.whichGridIsOpen)
          , Html.Attributes.style "width" "85px"
          , Html.Attributes.style "height" "30px"
          , Html.Attributes.style "font-size" "18px"
          , style "position" "absolute"
          , style "left" "107.5px"
          , style "top" "333px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "opacity" opacity
          ] [ text "Discard" ]
          ]
          ]
        else
        div
          [ style "border-style" "inset"
          , style "border-color" "#ffa940"
          , style "border-width" "3px"
          , style "border-radius" "20%"
          , style "width" "300px"
          , style "height" "300px"
          , style "background-color" "white"
          , style "position" "absolute"
          , style "left" "350px"
          , style "top" "25px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "font-family" "Helvetica, Arial, sans-serif"
          , style "font-size" "18px"
          , style "font-weight" "300"
          ]
          [ Html.img [src model.bag.grid3.img, width "300px"] []
          ,
          div []
          [ button
          [ onClick (ExamineItemsInBag model.whichGridIsOpen)
          , Html.Attributes.style "width" "85px"
          , Html.Attributes.style "height" "30px"
          , Html.Attributes.style "font-size" "18px"
          , style "position" "absolute"
          , style "left" "107.5px"
          , style "top" "300px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "opacity" opacity
          ] [ text "Examine" ]
          ]
          ]
        else renderInput opacity model
    else
    div [][]

renderGrid4Detail : Model -> Html Msg
renderGrid4Detail model =
    let
        opacity =
            case model.bag.grid4.canBeExamined of
                True -> "1"
                False -> "0"
    in

    if model.whichGridIsOpen == 4 then
        if model.bag.grid4 /= trueMemCardIni || model.codeReached then
        if model.map == Home then
        div
          [ style "border-style" "inset"
          , style "border-color" "#ffa940"
          , style "border-width" "3px"
          , style "border-radius" "20%"
          , style "width" "300px"
          , style "height" "300px"
          , style "background-color" "white"
          , style "position" "absolute"
          , style "left" "350px"
          , style "top" "25px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "font-family" "Helvetica, Arial, sans-serif"
          , style "font-size" "18px"
          , style "font-weight" "300"
          ]
          [ Html.img [src model.bag.grid4.img, width "300px"] []
          ,
          div []
          [ button
          [ onClick (ExamineItemsInBag model.whichGridIsOpen)
          , Html.Attributes.style "width" "85px"
          , Html.Attributes.style "height" "30px"
          , Html.Attributes.style "font-size" "18px"
          , style "position" "absolute"
          , style "left" "107.5px"
          , style "top" "300px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "opacity" opacity
          ] [ text "Examine" ]
          ]
          ,
          div []
          [ button
          [ onClick (AskDelete model.whichGridIsOpen)
          , Html.Attributes.style "width" "85px"
          , Html.Attributes.style "height" "30px"
          , Html.Attributes.style "font-size" "18px"
          , style "position" "absolute"
          , style "left" "107.5px"
          , style "top" "333px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "opacity" opacity
          ] [ text "Discard" ]
          ]
          ]
        else
        div
          [ style "border-style" "inset"
          , style "border-color" "#ffa940"
          , style "border-width" "3px"
          , style "border-radius" "20%"
          , style "width" "300px"
          , style "height" "300px"
          , style "background-color" "white"
          , style "position" "absolute"
          , style "left" "350px"
          , style "top" "25px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "font-family" "Helvetica, Arial, sans-serif"
          , style "font-size" "18px"
          , style "font-weight" "300"
          ]
          [ Html.img [src model.bag.grid4.img, width "300px"] []
          ,
          div []
          [ button
          [ onClick (ExamineItemsInBag model.whichGridIsOpen)
          , Html.Attributes.style "width" "85px"
          , Html.Attributes.style "height" "30px"
          , Html.Attributes.style "font-size" "18px"
          , style "position" "absolute"
          , style "left" "107.5px"
          , style "top" "300px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "opacity" opacity
          ] [ text "Examine" ]
          ]
          ]
        else renderInput opacity model
    else
    div [][]

renderGrid5Detail : Model -> Html Msg
renderGrid5Detail model =
    let
        opacity =
            case model.bag.grid5.canBeExamined of
                True -> "1"
                False -> "0"
    in

    if model.whichGridIsOpen == 5 then
        if model.bag.grid5 /= trueMemCardIni || model.codeReached then
        if model.map == Home then
        div
          [ style "border-style" "inset"
          , style "border-color" "#ffa940"
          , style "border-width" "3px"
          , style "border-radius" "20%"
          , style "width" "300px"
          , style "height" "300px"
          , style "background-color" "white"
          , style "position" "absolute"
          , style "left" "350px"
          , style "top" "25px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "font-family" "Helvetica, Arial, sans-serif"
          , style "font-size" "18px"
          , style "font-weight" "300"
          ]
          [ Html.img [src model.bag.grid5.img, width "300px"] []
          ,
          div []
          [ button
          [ onClick (ExamineItemsInBag model.whichGridIsOpen)
          , Html.Attributes.style "width" "85px"
          , Html.Attributes.style "height" "30px"
          , Html.Attributes.style "font-size" "18px"
          , style "position" "absolute"
          , style "left" "107.5px"
          , style "top" "300px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "opacity" opacity
          ] [ text "Examine" ]
          ]
          ,
          div []
          [ button
          [ onClick (AskDelete model.whichGridIsOpen)
          , Html.Attributes.style "width" "85px"
          , Html.Attributes.style "height" "30px"
          , Html.Attributes.style "font-size" "18px"
          , style "position" "absolute"
          , style "left" "107.5px"
          , style "top" "333px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "opacity" opacity
          ] [ text "Discard" ]
          ]
          ]
        else
        div
          [ style "border-style" "inset"
          , style "border-color" "#ffa940"
          , style "border-width" "3px"
          , style "border-radius" "20%"
          , style "width" "300px"
          , style "height" "300px"
          , style "background-color" "white"
          , style "position" "absolute"
          , style "left" "350px"
          , style "top" "25px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "font-family" "Helvetica, Arial, sans-serif"
          , style "font-size" "18px"
          , style "font-weight" "300"
          ]
          [ Html.img [src model.bag.grid5.img, width "300px"] []
          ,
          div []
          [ button
          [ onClick (ExamineItemsInBag model.whichGridIsOpen)
          , Html.Attributes.style "width" "85px"
          , Html.Attributes.style "height" "30px"
          , Html.Attributes.style "font-size" "18px"
          , style "position" "absolute"
          , style "left" "107.5px"
          , style "top" "300px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "opacity" opacity
          ] [ text "Examine" ]
          ]
          ]
        else renderInput opacity model
    else
    div [][]

renderGrid6Detail : Model -> Html Msg
renderGrid6Detail model=
    let
        opacity =
            case model.bag.grid6.canBeExamined of
                True -> "1"
                False -> "0"
    in

    if model.whichGridIsOpen == 6 then
        if model.bag.grid6 /= trueMemCardIni || model.codeReached then
        if model.map == Home then
        div
          [ style "border-style" "inset"
          , style "border-color" "#ffa940"
          , style "border-width" "3px"
          , style "border-radius" "20%"
          , style "width" "300px"
          , style "height" "300px"
          , style "background-color" "white"
          , style "position" "absolute"
          , style "left" "350px"
          , style "top" "25px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "font-family" "Helvetica, Arial, sans-serif"
          , style "font-size" "18px"
          , style "font-weight" "300"
          ]
          [ Html.img [src model.bag.grid6.img, width "300px"] []
          ,
          div []
          [ button
          [ onClick (ExamineItemsInBag model.whichGridIsOpen)
          , Html.Attributes.style "width" "85px"
          , Html.Attributes.style "height" "30px"
          , Html.Attributes.style "font-size" "18px"
          , style "position" "absolute"
          , style "left" "107.5px"
          , style "top" "300px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "opacity" opacity
          ] [ text "Examine" ]
          ]
          ,
          div []
          [ button
          [ onClick (AskDelete model.whichGridIsOpen)
          , Html.Attributes.style "width" "85px"
          , Html.Attributes.style "height" "30px"
          , Html.Attributes.style "font-size" "18px"
          , style "position" "absolute"
          , style "left" "107.5px"
          , style "top" "333px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "opacity" opacity
          ] [ text "Discard" ]
          ]
          ]
        else
        div
          [ style "border-style" "inset"
          , style "border-color" "#ffa940"
          , style "border-width" "3px"
          , style "border-radius" "20%"
          , style "width" "300px"
          , style "height" "300px"
          , style "background-color" "white"
          , style "position" "absolute"
          , style "left" "350px"
          , style "top" "25px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "font-family" "Helvetica, Arial, sans-serif"
          , style "font-size" "18px"
          , style "font-weight" "300"
          ]
          [ Html.img [src model.bag.grid6.img, width "300px"] []
          ,
          div []
          [ button
          [ onClick (ExamineItemsInBag model.whichGridIsOpen)
          , Html.Attributes.style "width" "85px"
          , Html.Attributes.style "height" "30px"
          , Html.Attributes.style "font-size" "18px"
          , style "position" "absolute"
          , style "left" "107.5px"
          , style "top" "300px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "opacity" opacity
          ] [ text "Examine" ]
          ]
          ]
        else renderInput opacity model
    else
    div [][]

renderGrid7Detail : Model -> Html Msg
renderGrid7Detail model=
    let
        opacity =
            case model.bag.grid7.canBeExamined of
                True -> "1"
                False -> "0"
    in

    if model.whichGridIsOpen == 7 then
        if model.bag.grid7 /= trueMemCardIni || model.codeReached then
        if model.map == Home then
        div
          [ style "border-style" "inset"
          , style "border-color" "#ffa940"
          , style "border-width" "3px"
          , style "border-radius" "20%"
          , style "width" "300px"
          , style "height" "300px"
          , style "background-color" "white"
          , style "position" "absolute"
          , style "left" "350px"
          , style "top" "25px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "font-family" "Helvetica, Arial, sans-serif"
          , style "font-size" "18px"
          , style "font-weight" "300"
          ]
          [ Html.img [src model.bag.grid7.img, width "300px"] []
          ,
          div []
          [ button
          [ onClick (ExamineItemsInBag model.whichGridIsOpen)
          , Html.Attributes.style "width" "85px"
          , Html.Attributes.style "height" "30px"
          , Html.Attributes.style "font-size" "18px"
          , style "position" "absolute"
          , style "left" "107.5px"
          , style "top" "300px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "opacity" opacity
          ] [ text "Examine" ]
          ]
          ,
          div []
          [ button
          [ onClick (AskDelete model.whichGridIsOpen)
          , Html.Attributes.style "width" "85px"
          , Html.Attributes.style "height" "30px"
          , Html.Attributes.style "font-size" "18px"
          , style "position" "absolute"
          , style "left" "107.5px"
          , style "top" "333px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "opacity" opacity
          ] [ text "Discard" ]
          ]
          ]
        else
        div
          [ style "border-style" "inset"
          , style "border-color" "#ffa940"
          , style "border-width" "3px"
          , style "border-radius" "20%"
          , style "width" "300px"
          , style "height" "300px"
          , style "background-color" "white"
          , style "position" "absolute"
          , style "left" "350px"
          , style "top" "25px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "font-family" "Helvetica, Arial, sans-serif"
          , style "font-size" "18px"
          , style "font-weight" "300"
          ]
          [ Html.img [src model.bag.grid7.img, width "300px"] []
          ,
          div []
          [ button
          [ onClick (ExamineItemsInBag model.whichGridIsOpen)
          , Html.Attributes.style "width" "85px"
          , Html.Attributes.style "height" "30px"
          , Html.Attributes.style "font-size" "18px"
          , style "position" "absolute"
          , style "left" "107.5px"
          , style "top" "300px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "opacity" opacity
          ] [ text "Examine" ]
          ]
          ]
        else renderInput opacity model
    else
    div [][]

renderGrid8Detail : Model -> Html Msg
renderGrid8Detail model =
    let
        opacity =
            case model.bag.grid8.canBeExamined of
                True -> "1"
                False -> "0"
    in

    if model.whichGridIsOpen == 8 then
        if model.bag.grid8 /= trueMemCardIni || model.codeReached then
        if model.map == Home then
        div
          [ style "border-style" "inset"
          , style "border-color" "#ffa940"
          , style "border-width" "3px"
          , style "border-radius" "20%"
          , style "width" "300px"
          , style "height" "300px"
          , style "background-color" "white"
          , style "position" "absolute"
          , style "left" "350px"
          , style "top" "25px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "font-family" "Helvetica, Arial, sans-serif"
          , style "font-size" "18px"
          , style "font-weight" "300"
          ]
          [ Html.img [src model.bag.grid8.img, width "300px"] []
          ,
          div []
          [ button
          [ onClick (ExamineItemsInBag model.whichGridIsOpen)
          , Html.Attributes.style "width" "85px"
          , Html.Attributes.style "height" "30px"
          , Html.Attributes.style "font-size" "18px"
          , style "position" "absolute"
          , style "left" "107.5px"
          , style "top" "300px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "opacity" opacity
          ] [ text "Examine" ]
          ]
          ,
          div []
          [ button
          [ onClick (AskDelete model.whichGridIsOpen)
          , Html.Attributes.style "width" "85px"
          , Html.Attributes.style "height" "30px"
          , Html.Attributes.style "font-size" "18px"
          , style "position" "absolute"
          , style "left" "107.5px"
          , style "top" "333px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "opacity" opacity
          ] [ text "Discard" ]
          ]
          ]
        else
        div
          [ style "border-style" "inset"
          , style "border-color" "#ffa940"
          , style "border-width" "3px"
          , style "border-radius" "20%"
          , style "width" "300px"
          , style "height" "300px"
          , style "background-color" "white"
          , style "position" "absolute"
          , style "left" "350px"
          , style "top" "25px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "font-family" "Helvetica, Arial, sans-serif"
          , style "font-size" "18px"
          , style "font-weight" "300"
          ]
          [ Html.img [src model.bag.grid8.img, width "300px"] []
          ,
          div []
          [ button
          [ onClick (ExamineItemsInBag model.whichGridIsOpen)
          , Html.Attributes.style "width" "85px"
          , Html.Attributes.style "height" "30px"
          , Html.Attributes.style "font-size" "18px"
          , style "position" "absolute"
          , style "left" "107.5px"
          , style "top" "300px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "opacity" opacity
          ] [ text "Examine" ]
          ]
          ]
        else renderInput opacity model
    else
    div [][]

renderGrid9Detail : Model -> Html Msg
renderGrid9Detail model=
    let
        opacity =
            case model.bag.grid9.canBeExamined of
                True -> "1"
                False -> "0"
    in

    if model.whichGridIsOpen == 9 then
        if model.bag.grid9 /= trueMemCardIni || model.codeReached then
        if model.map == Home then
        div
          [ style "border-style" "inset"
          , style "border-color" "#ffa940"
          , style "border-width" "3px"
          , style "border-radius" "20%"
          , style "width" "300px"
          , style "height" "300px"
          , style "background-color" "white"
          , style "position" "absolute"
          , style "left" "350px"
          , style "top" "25px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "font-family" "Helvetica, Arial, sans-serif"
          , style "font-size" "18px"
          , style "font-weight" "300"
          ]
          [ Html.img [src model.bag.grid9.img, width "300px"] []
          ,
          div []
          [ button
          [ onClick (ExamineItemsInBag model.whichGridIsOpen)
          , Html.Attributes.style "width" "85px"
          , Html.Attributes.style "height" "30px"
          , Html.Attributes.style "font-size" "18px"
          , style "position" "absolute"
          , style "left" "107.5px"
          , style "top" "300px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "opacity" opacity
          ] [ text "Examine" ]
          ]
          ,
          div []
          [ button
          [ onClick (AskDelete model.whichGridIsOpen)
          , Html.Attributes.style "width" "85px"
          , Html.Attributes.style "height" "30px"
          , Html.Attributes.style "font-size" "18px"
          , style "position" "absolute"
          , style "left" "107.5px"
          , style "top" "333px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "opacity" opacity
          ] [ text "Discard" ]
          ]
          ]
        else
        div
          [ style "border-style" "inset"
          , style "border-color" "#ffa940"
          , style "border-width" "3px"
          , style "border-radius" "20%"
          , style "width" "300px"
          , style "height" "300px"
          , style "background-color" "white"
          , style "position" "absolute"
          , style "left" "350px"
          , style "top" "25px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "font-family" "Helvetica, Arial, sans-serif"
          , style "font-size" "18px"
          , style "font-weight" "300"
          ]
          [ Html.img [src model.bag.grid9.img, width "300px"] []
          ,
          div []
          [ button
          [ onClick (ExamineItemsInBag model.whichGridIsOpen)
          , Html.Attributes.style "width" "85px"
          , Html.Attributes.style "height" "30px"
          , Html.Attributes.style "font-size" "18px"
          , style "position" "absolute"
          , style "left" "107.5px"
          , style "top" "300px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "opacity" opacity
          ] [ text "Examine" ]
          ]
          ]
        else renderInput opacity model
    else
    div [][]

renderGrid10Detail : Model -> Html Msg
renderGrid10Detail model =
    let
        opacity =
            case model.bag.grid10.canBeExamined of
                True -> "1"
                False -> "0"
    in

    if model.whichGridIsOpen == 10 then
        if model.bag.grid10 /= trueMemCardIni || model.codeReached then
        if model.map == Home then
        div
          [ style "border-style" "inset"
          , style "border-color" "#ffa940"
          , style "border-width" "3px"
          , style "border-radius" "20%"
          , style "width" "300px"
          , style "height" "300px"
          , style "background-color" "white"
          , style "position" "absolute"
          , style "left" "350px"
          , style "top" "25px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "font-family" "Helvetica, Arial, sans-serif"
          , style "font-size" "18px"
          , style "font-weight" "300"
          ]
          [ Html.img [src model.bag.grid10.img, width "300px"] []
          ,
          div []
          [ button
          [ onClick (ExamineItemsInBag model.whichGridIsOpen)
          , Html.Attributes.style "width" "85px"
          , Html.Attributes.style "height" "30px"
          , Html.Attributes.style "font-size" "18px"
          , style "position" "absolute"
          , style "left" "107.5px"
          , style "top" "300px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "opacity" opacity
          ] [ text "Examine" ]
          ]
          ,
          div []
          [ button
          [ onClick (AskDelete model.whichGridIsOpen)
          , Html.Attributes.style "width" "85px"
          , Html.Attributes.style "height" "30px"
          , Html.Attributes.style "font-size" "18px"
          , style "position" "absolute"
          , style "left" "107.5px"
          , style "top" "333px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "opacity" opacity
          ] [ text "Discard" ]
          ]
          ]
        else
        div
          [ style "border-style" "inset"
          , style "border-color" "#ffa940"
          , style "border-width" "3px"
          , style "border-radius" "20%"
          , style "width" "300px"
          , style "height" "300px"
          , style "background-color" "white"
          , style "position" "absolute"
          , style "left" "350px"
          , style "top" "25px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "font-family" "Helvetica, Arial, sans-serif"
          , style "font-size" "18px"
          , style "font-weight" "300"
          ]
          [ Html.img [src model.bag.grid10.img, width "300px"] []
          ,
          div []
          [ button
          [ onClick (ExamineItemsInBag model.whichGridIsOpen)
          , Html.Attributes.style "width" "85px"
          , Html.Attributes.style "height" "30px"
          , Html.Attributes.style "font-size" "18px"
          , style "position" "absolute"
          , style "left" "107.5px"
          , style "top" "300px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "opacity" opacity
          ] [ text "Examine" ]
          ]
          ]
        else renderInput opacity model
    else
    div [][]

renderGrid11Detail : Model -> Html Msg
renderGrid11Detail model =
    let
        opacity =
            case model.bag.grid11.canBeExamined of
                True -> "1"
                False -> "0"
    in
    if model.whichGridIsOpen == 11 then
        if model.bag.grid11 /= trueMemCardIni || model.codeReached then
        if model.map == Home then
        div
          [ style "border-style" "inset"
          , style "border-color" "#ffa940"
          , style "border-width" "3px"
          , style "border-radius" "20%"
          , style "width" "300px"
          , style "height" "300px"
          , style "background-color" "white"
          , style "position" "absolute"
          , style "left" "350px"
          , style "top" "25px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "font-family" "Helvetica, Arial, sans-serif"
          , style "font-size" "18px"
          , style "font-weight" "300"
          ]
          [ Html.img [src model.bag.grid11.img, width "300px"] []
          ,
          div []
          [ button
          [ onClick (ExamineItemsInBag model.whichGridIsOpen)
          , Html.Attributes.style "width" "85px"
          , Html.Attributes.style "height" "30px"
          , Html.Attributes.style "font-size" "18px"
          , style "position" "absolute"
          , style "left" "107.5px"
          , style "top" "300px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "opacity" opacity
          ] [ text "Examine" ]
          ]
          ,
          div []
          [ button
          [ onClick (AskDelete model.whichGridIsOpen)
          , Html.Attributes.style "width" "85px"
          , Html.Attributes.style "height" "30px"
          , Html.Attributes.style "font-size" "18px"
          , style "position" "absolute"
          , style "left" "107.5px"
          , style "top" "333px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "opacity" opacity
          ] [ text "Discard" ]
          ]
          ]
        else
        div
          [ style "border-style" "inset"
          , style "border-color" "#ffa940"
          , style "border-width" "3px"
          , style "border-radius" "20%"
          , style "width" "300px"
          , style "height" "300px"
          , style "background-color" "white"
          , style "position" "absolute"
          , style "left" "350px"
          , style "top" "25px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "font-family" "Helvetica, Arial, sans-serif"
          , style "font-size" "18px"
          , style "font-weight" "300"
          ]
          [ Html.img [src model.bag.grid11.img, width "300px"] []
          ,
          div []
          [ button
          [ onClick (ExamineItemsInBag model.whichGridIsOpen)
          , Html.Attributes.style "width" "85px"
          , Html.Attributes.style "height" "30px"
          , Html.Attributes.style "font-size" "18px"
          , style "position" "absolute"
          , style "left" "107.5px"
          , style "top" "300px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "opacity" opacity
          ] [ text "Examine" ]
          ]
          ]
          else renderInput opacity model
    else
    div [][]

renderGrid12Detail : Model -> Html Msg
renderGrid12Detail model =
    let
        opacity =
            case model.bag.grid12.canBeExamined of
                True -> "1"
                False -> "0"
    in
    if model.whichGridIsOpen == 12 then
        if model.bag.grid12 /= trueMemCardIni || model.codeReached then
        if model.map == Home then
        div
          [ style "border-style" "inset"
          , style "border-color" "#ffa940"
          , style "border-width" "3px"
          , style "border-radius" "20%"
          , style "width" "300px"
          , style "height" "300px"
          , style "background-color" "white"
          , style "position" "absolute"
          , style "left" "350px"
          , style "top" "25px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "font-family" "Helvetica, Arial, sans-serif"
          , style "font-size" "18px"
          , style "font-weight" "300"
          ]
          [ Html.img [src model.bag.grid12.img, width "300px"] []
          ,
          div []
          [ button
          [ onClick (ExamineItemsInBag model.whichGridIsOpen)
          , Html.Attributes.style "width" "85px"
          , Html.Attributes.style "height" "30px"
          , Html.Attributes.style "font-size" "18px"
          , style "position" "absolute"
          , style "left" "107.5px"
          , style "top" "300px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "opacity" opacity
          ] [ text "Examine" ]
          ]
          ,
          div []
          [ button
          [ onClick (AskDelete model.whichGridIsOpen)
          , Html.Attributes.style "width" "85px"
          , Html.Attributes.style "height" "30px"
          , Html.Attributes.style "font-size" "18px"
          , style "position" "absolute"
          , style "left" "107.5px"
          , style "top" "333px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "opacity" opacity
          ] [ text "Discard" ]
          ]
          ]
        else
        div
          [ style "border-style" "inset"
          , style "border-color" "#ffa940"
          , style "border-width" "3px"
          , style "border-radius" "20%"
          , style "width" "300px"
          , style "height" "300px"
          , style "background-color" "white"
          , style "position" "absolute"
          , style "left" "350px"
          , style "top" "25px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "font-family" "Helvetica, Arial, sans-serif"
          , style "font-size" "18px"
          , style "font-weight" "300"
          ]
          [ Html.img [src model.bag.grid12.img, width "300px"] []
          ,
          div []
          [ button
          [ onClick (ExamineItemsInBag model.whichGridIsOpen)
          , Html.Attributes.style "width" "85px"
          , Html.Attributes.style "height" "30px"
          , Html.Attributes.style "font-size" "18px"
          , style "position" "absolute"
          , style "left" "107.5px"
          , style "top" "300px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "opacity" opacity
          ] [ text "Examine" ]
          ]
          ]
            else renderInput opacity model
    else
    div [][]

renderGrid13Detail : Model -> Html Msg
renderGrid13Detail model =
    let
        opacity =
            case model.bag.grid13.canBeExamined of
                True -> "1"
                False -> "0"
    in


    if model.whichGridIsOpen == 13 then
        if model.bag.grid13 /= trueMemCardIni || model.codeReached then
        if model.map == Home then
        div
          [ style "border-style" "inset"
          , style "border-color" "#ffa940"
          , style "border-width" "3px"
          , style "border-radius" "20%"
          , style "width" "300px"
          , style "height" "300px"
          , style "background-color" "white"
          , style "position" "absolute"
          , style "left" "350px"
          , style "top" "25px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "font-family" "Helvetica, Arial, sans-serif"
          , style "font-size" "18px"
          , style "font-weight" "300"
          ]
          [ Html.img [src model.bag.grid13.img, width "300px"] []
          ,
          div []
          [ button
          [ onClick (ExamineItemsInBag model.whichGridIsOpen)
          , Html.Attributes.style "width" "85px"
          , Html.Attributes.style "height" "30px"
          , Html.Attributes.style "font-size" "18px"
          , style "position" "absolute"
          , style "left" "107.5px"
          , style "top" "300px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "opacity" opacity
          ] [ text "Examine" ]
          ]
          ,
          div []
          [ button
          [ onClick (AskDelete model.whichGridIsOpen)
          , Html.Attributes.style "width" "85px"
          , Html.Attributes.style "height" "30px"
          , Html.Attributes.style "font-size" "18px"
          , style "position" "absolute"
          , style "left" "107.5px"
          , style "top" "333px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "opacity" opacity
          ] [ text "Discard" ]
          ]
          ]
        else
        div
          [ style "border-style" "inset"
          , style "border-color" "#ffa940"
          , style "border-width" "3px"
          , style "border-radius" "20%"
          , style "width" "300px"
          , style "height" "300px"
          , style "background-color" "white"
          , style "position" "absolute"
          , style "left" "350px"
          , style "top" "25px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "font-family" "Helvetica, Arial, sans-serif"
          , style "font-size" "18px"
          , style "font-weight" "300"
          ]
          [ Html.img [src model.bag.grid13.img, width "300px"] []
          ,
          div []
          [ button
          [ onClick (ExamineItemsInBag model.whichGridIsOpen)
          , Html.Attributes.style "width" "85px"
          , Html.Attributes.style "height" "30px"
          , Html.Attributes.style "font-size" "18px"
          , style "position" "absolute"
          , style "left" "107.5px"
          , style "top" "300px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "opacity" opacity
          ] [ text "Examine" ]
          ]
          ]
        else renderInput opacity model
    else
    div [][]

renderGrid14Detail : Model -> Html Msg
renderGrid14Detail model =
    let
        opacity =
            case model.bag.grid14.canBeExamined of
                True -> "1"
                False -> "0"
    in
    if model.whichGridIsOpen == 14 then
        if model.bag.grid14 /= trueMemCardIni || model.codeReached then
        if model.map == Home then
        div
          [ style "border-style" "inset"
          , style "border-color" "#ffa940"
          , style "border-width" "3px"
          , style "border-radius" "20%"
          , style "width" "300px"
          , style "height" "300px"
          , style "background-color" "white"
          , style "position" "absolute"
          , style "left" "350px"
          , style "top" "25px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "font-family" "Helvetica, Arial, sans-serif"
          , style "font-size" "18px"
          , style "font-weight" "300"
          ]
          [ Html.img [src model.bag.grid14.img, width "300px"] []
          ,
          div []
          [ button
          [ onClick (ExamineItemsInBag model.whichGridIsOpen)
          , Html.Attributes.style "width" "85px"
          , Html.Attributes.style "height" "30px"
          , Html.Attributes.style "font-size" "18px"
          , style "position" "absolute"
          , style "left" "107.5px"
          , style "top" "300px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "opacity" opacity
          ] [ text "Examine" ]
          ]
          ,
          div []
          [ button
          [ onClick (AskDelete model.whichGridIsOpen)
          , Html.Attributes.style "width" "85px"
          , Html.Attributes.style "height" "30px"
          , Html.Attributes.style "font-size" "18px"
          , style "position" "absolute"
          , style "left" "107.5px"
          , style "top" "333px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "opacity" opacity
          ] [ text "Discard" ]
          ]
          ]
        else
        div
          [ style "border-style" "inset"
          , style "border-color" "#ffa940"
          , style "border-width" "3px"
          , style "border-radius" "20%"
          , style "width" "300px"
          , style "height" "300px"
          , style "background-color" "white"
          , style "position" "absolute"
          , style "left" "350px"
          , style "top" "25px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "font-family" "Helvetica, Arial, sans-serif"
          , style "font-size" "18px"
          , style "font-weight" "300"
          ]
          [ Html.img [src model.bag.grid14.img, width "300px"] []
          ,
          div []
          [ button
          [ onClick (ExamineItemsInBag model.whichGridIsOpen)
          , Html.Attributes.style "width" "85px"
          , Html.Attributes.style "height" "30px"
          , Html.Attributes.style "font-size" "18px"
          , style "position" "absolute"
          , style "left" "107.5px"
          , style "top" "300px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "opacity" opacity
          ] [ text "Examine" ]
          ]
          ]
        else renderInput opacity model
    else
    div [][]

renderGrid15Detail : Model -> Html Msg
renderGrid15Detail model =
    let
        opacity =
            case model.bag.grid15.canBeExamined of
                True -> "1"
                False -> "0"
    in

    if model.whichGridIsOpen == 15 then
        if model.bag.grid15 /= trueMemCardIni || model.codeReached then
        if model.map == Home then
        div
          [ style "border-style" "inset"
          , style "border-color" "#ffa940"
          , style "border-width" "3px"
          , style "border-radius" "20%"
          , style "width" "300px"
          , style "height" "300px"
          , style "background-color" "white"
          , style "position" "absolute"
          , style "left" "350px"
          , style "top" "25px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "font-family" "Helvetica, Arial, sans-serif"
          , style "font-size" "18px"
          , style "font-weight" "300"
          ]
          [ Html.img [src model.bag.grid15.img, width "300px"] []
          ,
          div []
          [ button
          [ onClick (ExamineItemsInBag model.whichGridIsOpen)
          , Html.Attributes.style "width" "85px"
          , Html.Attributes.style "height" "30px"
          , Html.Attributes.style "font-size" "18px"
          , style "position" "absolute"
          , style "left" "107.5px"
          , style "top" "300px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "opacity" opacity
          ] [ text "Examine" ]
          ]
          ,
          div []
          [ button
          [ onClick (AskDelete model.whichGridIsOpen)
          , Html.Attributes.style "width" "85px"
          , Html.Attributes.style "height" "30px"
          , Html.Attributes.style "font-size" "18px"
          , style "position" "absolute"
          , style "left" "107.5px"
          , style "top" "333px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "opacity" opacity
          ] [ text "Discard" ]
          ]
          ]
        else
        div
          [ style "border-style" "inset"
          , style "border-color" "#ffa940"
          , style "border-width" "3px"
          , style "border-radius" "20%"
          , style "width" "300px"
          , style "height" "300px"
          , style "background-color" "white"
          , style "position" "absolute"
          , style "left" "350px"
          , style "top" "25px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "font-family" "Helvetica, Arial, sans-serif"
          , style "font-size" "18px"
          , style "font-weight" "300"
          ]
          [ Html.img [src model.bag.grid15.img, width "300px"] []
          ,
          div []
          [ button
          [ onClick (ExamineItemsInBag model.whichGridIsOpen)
          , Html.Attributes.style "width" "85px"
          , Html.Attributes.style "height" "30px"
          , Html.Attributes.style "font-size" "18px"
          , style "position" "absolute"
          , style "left" "107.5px"
          , style "top" "300px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "opacity" opacity
          ] [ text "Examine" ]
          ]
          ]
        else renderInput opacity model
    else
    div [][]

renderGrid16Detail : Model -> Html Msg
renderGrid16Detail model=
    let
        opacity =
            case model.bag.grid16.canBeExamined of
                True -> "1"
                False -> "0"
    in

    if model.whichGridIsOpen == 16 then
        if model.bag.grid16 /= trueMemCardIni || model.codeReached then
        if model.map == Home then
        div
          [ style "border-style" "inset"
          , style "border-color" "#ffa940"
          , style "border-width" "3px"
          , style "border-radius" "20%"
          , style "width" "300px"
          , style "height" "300px"
          , style "background-color" "white"
          , style "position" "absolute"
          , style "left" "350px"
          , style "top" "25px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "font-family" "Helvetica, Arial, sans-serif"
          , style "font-size" "18px"
          , style "font-weight" "300"
          ]
          [ Html.img [src model.bag.grid16.img, width "300px"] []
          ,
          div []
          [ button
          [ onClick (ExamineItemsInBag model.whichGridIsOpen)
          , Html.Attributes.style "width" "85px"
          , Html.Attributes.style "height" "30px"
          , Html.Attributes.style "font-size" "18px"
          , style "position" "absolute"
          , style "left" "107.5px"
          , style "top" "300px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "opacity" opacity
          ] [ text "Examine" ]
          ]
          ,
          div []
          [ button
          [ onClick (AskDelete model.whichGridIsOpen)
          , Html.Attributes.style "width" "85px"
          , Html.Attributes.style "height" "30px"
          , Html.Attributes.style "font-size" "18px"
          , style "position" "absolute"
          , style "left" "107.5px"
          , style "top" "333px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "opacity" opacity
          ] [ text "Discard" ]
          ]
          ]
        else
        div
          [ style "border-style" "inset"
          , style "border-color" "#ffa940"
          , style "border-width" "3px"
          , style "border-radius" "20%"
          , style "width" "300px"
          , style "height" "300px"
          , style "background-color" "white"
          , style "position" "absolute"
          , style "left" "350px"
          , style "top" "25px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "font-family" "Helvetica, Arial, sans-serif"
          , style "font-size" "18px"
          , style "font-weight" "300"
          ]
          [ Html.img [src model.bag.grid16.img, width "300px"] []
          ,
          div []
          [ button
          [ onClick (ExamineItemsInBag model.whichGridIsOpen)
          , Html.Attributes.style "width" "85px"
          , Html.Attributes.style "height" "30px"
          , Html.Attributes.style "font-size" "18px"
          , style "position" "absolute"
          , style "left" "107.5px"
          , style "top" "300px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "opacity" opacity
          ] [ text "Examine" ]
          ]
          ]
        else renderInput opacity model
    else
    div [][]

renderGrid17Detail : Model -> Html Msg
renderGrid17Detail model=
    let
        opacity =
            case model.bag.grid17.canBeExamined of
                True -> "1"
                False -> "0"
    in

    if model.whichGridIsOpen == 17 then
        if model.bag.grid17 /= trueMemCardIni || model.codeReached then
        if model.map == Home then
        div
          [ style "border-style" "inset"
          , style "border-color" "#ffa940"
          , style "border-width" "3px"
          , style "border-radius" "20%"
          , style "width" "300px"
          , style "height" "300px"
          , style "background-color" "white"
          , style "position" "absolute"
          , style "left" "350px"
          , style "top" "25px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "font-family" "Helvetica, Arial, sans-serif"
          , style "font-size" "18px"
          , style "font-weight" "300"
          ]
          [ Html.img [src model.bag.grid17.img, width "300px"] []
          ,
          div []
          [ button
          [ onClick (ExamineItemsInBag model.whichGridIsOpen)
          , Html.Attributes.style "width" "85px"
          , Html.Attributes.style "height" "30px"
          , Html.Attributes.style "font-size" "18px"
          , style "position" "absolute"
          , style "left" "107.5px"
          , style "top" "300px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "opacity" opacity
          ] [ text "Examine" ]
          ]
          ,
          div []
          [ button
          [ onClick (AskDelete model.whichGridIsOpen)
          , Html.Attributes.style "width" "85px"
          , Html.Attributes.style "height" "30px"
          , Html.Attributes.style "font-size" "18px"
          , style "position" "absolute"
          , style "left" "107.5px"
          , style "top" "333px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "opacity" opacity
          ] [ text "Discard" ]
          ]
          ]
        else
        div
          [ style "border-style" "inset"
          , style "border-color" "#ffa940"
          , style "border-width" "3px"
          , style "border-radius" "20%"
          , style "width" "300px"
          , style "height" "300px"
          , style "background-color" "white"
          , style "position" "absolute"
          , style "left" "350px"
          , style "top" "25px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "font-family" "Helvetica, Arial, sans-serif"
          , style "font-size" "18px"
          , style "font-weight" "300"
          ]
          [ Html.img [src model.bag.grid17.img, width "300px"] []
          ,
          div []
          [ button
          [ onClick (ExamineItemsInBag model.whichGridIsOpen)
          , Html.Attributes.style "width" "85px"
          , Html.Attributes.style "height" "30px"
          , Html.Attributes.style "font-size" "18px"
          , style "position" "absolute"
          , style "left" "107.5px"
          , style "top" "300px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "opacity" opacity
          ] [ text "Examine" ]
          ]
          ]
        else renderInput opacity model
    else
    div [][]

renderGrid18Detail : Model -> Html Msg
renderGrid18Detail model =
    let
        opacity =
            case model.bag.grid18.canBeExamined of
                True -> "1"
                False -> "0"
    in

    if model.whichGridIsOpen == 18 then
        if model.bag.grid18 /= trueMemCardIni || model.codeReached then
        if model.map == Home then
        div
          [ style "border-style" "inset"
          , style "border-color" "#ffa940"
          , style "border-width" "3px"
          , style "border-radius" "20%"
          , style "width" "300px"
          , style "height" "300px"
          , style "background-color" "white"
          , style "position" "absolute"
          , style "left" "350px"
          , style "top" "25px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "font-family" "Helvetica, Arial, sans-serif"
          , style "font-size" "18px"
          , style "font-weight" "300"
          ]
          [ Html.img [src model.bag.grid18.img, width "300px"] []
          ,
          div []
          [ button
          [ onClick (ExamineItemsInBag model.whichGridIsOpen)
          , Html.Attributes.style "width" "85px"
          , Html.Attributes.style "height" "30px"
          , Html.Attributes.style "font-size" "18px"
          , style "position" "absolute"
          , style "left" "107.5px"
          , style "top" "300px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "opacity" opacity
          ] [ text "Examine" ]
          ]
          ,
          div []
          [ button
          [ onClick (AskDelete model.whichGridIsOpen)
          , Html.Attributes.style "width" "85px"
          , Html.Attributes.style "height" "30px"
          , Html.Attributes.style "font-size" "18px"
          , style "position" "absolute"
          , style "left" "107.5px"
          , style "top" "333px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "opacity" opacity
          ] [ text "Discard" ]
          ]
          ]
        else
        div
          [ style "border-style" "inset"
          , style "border-color" "#ffa940"
          , style "border-width" "3px"
          , style "border-radius" "20%"
          , style "width" "300px"
          , style "height" "300px"
          , style "background-color" "white"
          , style "position" "absolute"
          , style "left" "350px"
          , style "top" "25px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "font-family" "Helvetica, Arial, sans-serif"
          , style "font-size" "18px"
          , style "font-weight" "300"
          ]
          [ Html.img [src model.bag.grid18.img, width "300px"] []
          ,
          div []
          [ button
          [ onClick (ExamineItemsInBag model.whichGridIsOpen)
          , Html.Attributes.style "width" "85px"
          , Html.Attributes.style "height" "30px"
          , Html.Attributes.style "font-size" "18px"
          , style "position" "absolute"
          , style "left" "107.5px"
          , style "top" "300px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "opacity" opacity
          ] [ text "Examine" ]
          ]
          ]
        else renderInput opacity model
    else
    div [][]

renderGrid19Detail : Model -> Html Msg
renderGrid19Detail model=
    let
        opacity =
            case model.bag.grid19.canBeExamined of
                True -> "1"
                False -> "0"
    in

    if model.whichGridIsOpen == 19 then
        if model.bag.grid19 /= trueMemCardIni || model.codeReached then
        if model.map == Home then
        div
          [ style "border-style" "inset"
          , style "border-color" "#ffa940"
          , style "border-width" "3px"
          , style "border-radius" "20%"
          , style "width" "300px"
          , style "height" "300px"
          , style "background-color" "white"
          , style "position" "absolute"
          , style "left" "350px"
          , style "top" "25px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "font-family" "Helvetica, Arial, sans-serif"
          , style "font-size" "18px"
          , style "font-weight" "300"
          ]
          [ Html.img [src model.bag.grid19.img, width "300px"] []
          ,
          div []
          [ button
          [ onClick (ExamineItemsInBag model.whichGridIsOpen)
          , Html.Attributes.style "width" "85px"
          , Html.Attributes.style "height" "30px"
          , Html.Attributes.style "font-size" "18px"
          , style "position" "absolute"
          , style "left" "107.5px"
          , style "top" "300px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "opacity" opacity
          ] [ text "Examine" ]
          ]
          ,
          div []
          [ button
          [ onClick (AskDelete model.whichGridIsOpen)
          , Html.Attributes.style "width" "85px"
          , Html.Attributes.style "height" "30px"
          , Html.Attributes.style "font-size" "18px"
          , style "position" "absolute"
          , style "left" "107.5px"
          , style "top" "333px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "opacity" opacity
          ] [ text "Discard" ]
          ]
          ]
        else
        div
          [ style "border-style" "inset"
          , style "border-color" "#ffa940"
          , style "border-width" "3px"
          , style "border-radius" "20%"
          , style "width" "300px"
          , style "height" "300px"
          , style "background-color" "white"
          , style "position" "absolute"
          , style "left" "350px"
          , style "top" "25px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "font-family" "Helvetica, Arial, sans-serif"
          , style "font-size" "18px"
          , style "font-weight" "300"
          ]
          [ Html.img [src model.bag.grid19.img, width "300px"] []
          ,
          div []
          [ button
          [ onClick (ExamineItemsInBag model.whichGridIsOpen)
          , Html.Attributes.style "width" "85px"
          , Html.Attributes.style "height" "30px"
          , Html.Attributes.style "font-size" "18px"
          , style "position" "absolute"
          , style "left" "107.5px"
          , style "top" "300px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "opacity" opacity
          ] [ text "Examine" ]
          ]
          ]
        else renderInput opacity model
    else
    div [][]

renderGrid20Detail : Model -> Html Msg
renderGrid20Detail model =
    let
        opacity =
            case model.bag.grid20.canBeExamined of
                True -> "1"
                False -> "0"
    in

    if model.whichGridIsOpen == 20 then
        if model.bag.grid20 /= trueMemCardIni || model.codeReached then
        if model.map == Home then
        div
          [ style "border-style" "inset"
          , style "border-color" "#ffa940"
          , style "border-width" "3px"
          , style "border-radius" "20%"
          , style "width" "300px"
          , style "height" "300px"
          , style "background-color" "white"
          , style "position" "absolute"
          , style "left" "350px"
          , style "top" "25px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "font-family" "Helvetica, Arial, sans-serif"
          , style "font-size" "18px"
          , style "font-weight" "300"
          ]
          [ Html.img [src model.bag.grid20.img, width "300px"] []
          ,
          div []
          [ button
          [ onClick (ExamineItemsInBag model.whichGridIsOpen)
          , Html.Attributes.style "width" "85px"
          , Html.Attributes.style "height" "30px"
          , Html.Attributes.style "font-size" "18px"
          , style "position" "absolute"
          , style "left" "107.5px"
          , style "top" "300px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "opacity" opacity
          ] [ text "Examine" ]
          ]
          ,
          div []
          [ button
          [ onClick (AskDelete model.whichGridIsOpen)
          , Html.Attributes.style "width" "85px"
          , Html.Attributes.style "height" "30px"
          , Html.Attributes.style "font-size" "18px"
          , style "position" "absolute"
          , style "left" "107.5px"
          , style "top" "333px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "opacity" opacity
          ] [ text "Discard" ]
          ]
          ]
        else
        div
          [ style "border-style" "inset"
          , style "border-color" "#ffa940"
          , style "border-width" "3px"
          , style "border-radius" "20%"
          , style "width" "300px"
          , style "height" "300px"
          , style "background-color" "white"
          , style "position" "absolute"
          , style "left" "350px"
          , style "top" "25px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "font-family" "Helvetica, Arial, sans-serif"
          , style "font-size" "18px"
          , style "font-weight" "300"
          ]
          [ Html.img [src model.bag.grid20.img, width "300px"] []
          ,
          div []
          [ button
          [ onClick (ExamineItemsInBag model.whichGridIsOpen)
          , Html.Attributes.style "width" "85px"
          , Html.Attributes.style "height" "30px"
          , Html.Attributes.style "font-size" "18px"
          , style "position" "absolute"
          , style "left" "107.5px"
          , style "top" "300px"
          , style "text-align" "center"
          , style "margin" "auto"
          , style "opacity" opacity
          ] [ text "Examine" ]
          ]
          ]
        else renderInput opacity model
    else
    div [][]


renderStartButton : Model -> Html Msg
renderStartButton model =
    if model.map == StarterPage then
    button
        [ style "position" "absolute"
        , style "left" "390px"
        , style "top" "390px"
        , style "font-size" "23px"
        , style "font-family" "TRAJAN PRO"
        , style "height" "60px"
        , style "line-height" "60px"
        , style "width" "250px"
        , style "background-color" "#333333"
        , class "fill"
        , onClick StartGame
        ]
        [ Html.text "Start" ]
    else
    div [][]

renderStoryButton : Model -> Html Msg
renderStoryButton model =
    if model.map == StarterPage then
    button
        [ style "position" "absolute"
        , style "left" "390px"
        , style "top" "470px"
        , style "font-size" "23px"
        , style "font-family" "TRAJAN PRO"
        , style "height" "60px"
        , style "line-height" "60px"
        , style "width" "250px"
        , style "background-color" "#333333"
        , class "fill"
        , onClick ViewStory
        ]
        [ Html.text "Story" ]
    else
    div [][]

renderAboutUsButton : Model -> Html Msg
renderAboutUsButton model =
    if model.map == StarterPage then
    button
        [ style "position" "absolute"
        , style "left" "390px"
        , style "top" "550px"
        , style "font-size" "23px"
        , style "font-family" "TRAJAN PRO"
        , style "height" "60px"
        , style "line-height" "60px"
        , style "width" "250px"
        , style "background-color" "#333333"
        , class "fill"
        , onClick ViewAboutUs
        ]
        [ Html.text "About us" ]
    else
    div [][]

renderBackButton : Model -> Html Msg
renderBackButton model =
    if model.map == Story || model.map == AboutUs then
    button
        [ style "position" "absolute"
        , style "left" "500px"
        , style "top" "350px"
        , style "font-family" "Helvetica, Arial, sans-serif"
        , style "font-size" "18px"
        , style "font-weight" "300"
        , style "height" "60px"
        , style "line-height" "60px"
        , style "width" "130px"
        , class "fill"
        , onClick BackToStarter
        ]
        [ Html.text "Back to Starter" ]
    else
    div [][]

renderhelp =
    [Html.input [Html.Attributes.type_ "checkbox", id "menuhelp"][]
    ,Html.label [Html.Attributes.for "menuhelp", class "menuhelp"][text "?"]
    ,Html.nav [class "navhelp"] [div [class "container"]
                                     [div [ style "font-family" "Helvetica, Arial, sans-serif"
                                          , style "color" "white", style "font-size" "18px"]
                                          [ Html.br [] []
                                          , Html.br [] []
                                          , Html.br [] []
                                          , p [] [ text "Use '↑', '↓', '←', '→' to move." ]
                                          , p [] [ text "You cannot move if you run into an obstacle." ]
                                          , p [] [ text "Use 'X' to interact with NPCs. Click the choice which you want to choose." ]
                                          , p [] [ text "Carefully read the text, or you'll miss some information." ]
                                          , p [] [ text "Talk with NPCs if you are stuck."]
                                          , p [] [ text "If the case you are solving required you to decide who is the murderer, please go to the suspect list (top left corner)."]
                                          , p [] [ text "Sometimes you get some items. You can see them in your bag (top right corner). You can examine or destroy items in you home."]
                                          ]]]
        ]


renderCloseGrid : Model -> Html Msg
renderCloseGrid model =
    if model.whichGridIsOpen /= 0 then
    button
        [ style "position" "absolute"
        , style "left" "610px"
        , style "top" "50px"
        , style "font-family" "Helvetica, Arial, sans-serif"
        , style "font-size" "10px"
        , style "font-weight" "100"
        , style "height" "20px"
        , style "line-height" "20x"
        , style "width" "20px"
        , class "fill"
        , onClick CloseGrid
        ]
        [ Html.text "X " ]
    else
    div [][]