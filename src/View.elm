module View exposing (..)
import Html.Attributes exposing (style,src,type_,autoplay,id,loop,class)
import Html.Events exposing (on, onClick, onMouseDown, onMouseUp)
import Json.Decode as Json
import Message exposing (Msg(..))
import Model exposing (..)
import Tosvg exposing (..)
import Svg exposing (image, rect, svg, Svg)
import Svg.Attributes exposing (x,y,width,height,viewBox,fill,stroke,strokeWidth,xlinkHref,transform)
import Items exposing ( .. )
import Html exposing (Html, button, div, text, br, ul, p)

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
        [ renderPic model
        , renderMapButton model
        , renderdialog model
        , renderMusic
        , axisHelper model
        , renderBagButton model
        , renderBag model
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
        , renderStartButton model
        , renderAboutUsButton model
        , renderStoryButton model
        , renderBackButton model
        ]]
        ++ (rendersuspectlist model))



axisHelper : Model -> Html Msg
axisHelper model =
    if gameMode______ /= Game then
        div []
            [ text (model.hero.x |> Debug.toString), br [] []
            , text (model.hero.y |> Debug.toString)
            ]
    else
    div [] []

renderMusic : Html Msg
renderMusic =
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
            div []
            [
            button
            [ style "background" "blue"
            , style "position" "absolute"
            , style "left" "100px"
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
            , onClick ToPoliceOffice
            ]
            [ Html.text "Police Office" ]
            ,
            button
            [ style "background" "red"
            , style "position" "absolute"
            , style "left" "300px"
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
            , onClick ToPark
            ]
            [ Html.text "Park" ]
            ,
            button
            [ style "background" "red"
            , style "position" "absolute"
            , style "left" "500px"
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

        EnergyDrain ->
            div []
             [
             button
             [ style "background" "red"
             , style "position" "absolute"
             , style "left" "500px"
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
        ((

        case model.map of
            PoliceOffice ->

                [Svg.image
                    [ xlinkHref "./police_office.png" -- I'll change all the maps into 1050*630... ——Lan Wang
                    , x "0"
                    , y "0"
                    , width "1200"
                    , transform "translate(0,0)" -- in this scale for a 2388*1688 picture, all things are favorable. But I still confused about this. So can anyone help? --zhouyuxiang 7/9
                    ] []]
                ++ [ entityView cBob ]
                ++ [ entityView cLee ]
                ++ [ entityView cAllen ]
                ++ ( heroToSvg model.hero )
                ++ [renderdialog model]
                ++ [renderchoice model]
                ++ ( elevatorQuestToSvg model )
                ++ [renderportrait model]


            Park ->

                [Svg.image
                    [ xlinkHref "./park.png"
                    , x "0"
                    , y "0"
                    , width "1200"
                    , height "630"
                    , transform "translate(0,-20)" -- in this scale for a 2388*1688 picture, all things are favorable. But I still confused about this. So can anyone help? --zhouyuxiang 7/9
                    ] []]
                ++ ( heroToSvg model.hero )
                ++ [ entityView pLee ]
                ++ [ entityView pAllen ]
                ++ [ entityView pAdkins ]
                ++ [ entityView pCatherine ]
                ++ [renderdialog model]
                ++ [renderchoice model]
                ++ [renderportrait model]

            Switching ->

                [Svg.rect
                    [ x "0"
                    , y "0"
                    , width "1200"
                    , height "600"
                    , fill "black"][]] --useless now

            EnergyDrain ->

                [Svg.rect
                    [ x "0"
                    , y "0"
                    , width "900"
                    , height "600"][]]

            Home ->
                [Svg.image
                    [ xlinkHref "./Kay's_home.png"
                    , x "0"
                    , y "0"
                    , width "1200"
                    , height "630"
                    , transform "translate(0,-20)" -- in this scale for a 2388*1688 picture, all things are favorable. But I still confused about this. So can anyone help? --zhouyuxiang 7/9
                    ] []]
                ++ [renderdialog model]
                ++ [renderchoice model]
                ++ ( elevatorQuestToSvg model )
                ++ ( heroToSvg model.hero )
                ++ [renderportrait model]

            StarterPage ->
                [div [][]]

            Story ->
                [div [][]]

            AboutUs ->
                [div [][]]


        )++ (
          energytosvg model.energy model.energy_Full
         ++ testToSvg model
         ++ itemsToSvg model )
        )

renderdialog : Model -> Svg Msg
renderdialog model =
    Svg.foreignObject [ x "200", y "630", width "1000", height "150"]
                      [ p [ style "flex" "1 1 auto", style "font-size" "1.4em", style "padding" "0 1em", Html.Attributes.class "inset" ]
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
        Svg.foreignObject [ x "200", y "200", width "500", height "100%", style "opacity" opacity ]
                          [ p [ style "flex" "1 1 auto", style "font-size" "1.4em", style "padding" "0 1em", Html.Attributes.class "inset" ]
                              [ul [] <| List.map entityViewchoices (query "*.choices=1" model.worldModel)]
                          ]

renderportrait : Model -> Svg Msg
renderportrait model =
    let
        portr =
            case model.portrait of
                "" ->
                    Svg.image [ Svg.Attributes.xlinkHref ("./player.png")
                              , x "10", y "640", width "140", height "140"
                              ] []
                _ ->
                    Svg.image [ Svg.Attributes.xlinkHref ("./"++model.portrait++".png")
                              , x "10", y "640", width "140", height "140"
                              ] []
    in
        portr

rendersuspectlist model =
    let
        suspect =
            case model.map of
                Park ->
                    [ div [onClick Catherinecatch, style "opacity" (model.conclusion|>Debug.toString), class "btn btn-sm animated-button thar-three"] [text "Catherine"]
                    , div [onClick Adkinscatch, style "opacity" (model.conclusion|>Debug.toString), class "btn btn-sm animated-button thar-three"] [text "Adkins"]
                    , div [onClick Robbery, style "opacity" (model.conclusion|>Debug.toString), class "btn btn-sm animated-button thar-three"] [text "This is a robbery."]
                    ]
                _ ->
                    []
    in
        [Html.input [Html.Attributes.type_ "checkbox", id "menu-toggle"][]
        ,Html.label [Html.Attributes.for "menu-toggle", class "menu-icon"][Html.i [class "fa fa-bars"][]]
        ,div [class "slideout-sidebar"] [div [class "container"] suspect]
        ]

renderBagButton : Model -> Html Msg
renderBagButton model =
    if model.isBagOpen == True && model.map /= StarterPage && model.map /= AboutUs && model.map /= Story then
    button
                [ style "background" "red"
                , style "position" "absolute"
                , style "left" "850px"
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
                , onClick CloseBag
                ]
                [ Html.text "Close the bag" ]
    else if model.isBagOpen == False && model.map /= StarterPage && model.map /= AboutUs && model.map /= Story then
    button
                [ style "background" "red"
                , style "position" "absolute"
                , style "left" "850px"
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
                , onClick OpenBag
                ]
                [ Html.text "Open the bag" ]
    else
    div [][]




renderBag : Model -> Html Msg
renderBag model =
    case model.isBagOpen of
        False ->
            div[][]
        True ->
            div []
            [
            button
            [ onClick RenderGrid1Detail
            , Html.Attributes.style "width" "60px"
            , Html.Attributes.style "height" "60px"
            , Html.Attributes.style "font-size" "18px"
            , style "position" "absolute"
            , style "left" "100px"
            , style "top" "100px"
            ] [ text "G1" ],

            button
            [ onClick RenderGrid2Detail
            , Html.Attributes.style "width" "60px"
            , Html.Attributes.style "height" "60px"
            , Html.Attributes.style "font-size" "18px"
            , style "position" "absolute"
            , style "left" "100px"
            , style "top" "180px"
            ] [ text "G2" ],

            button
            [ onClick RenderGrid3Detail
            , Html.Attributes.style "width" "60px"
            , Html.Attributes.style "height" "60px"
            , Html.Attributes.style "font-size" "18px"
            , style "position" "absolute"
            , style "left" "100px"
            , style "top" "260px"
            ] [ text "G3" ],

            button
            [ onClick RenderGrid4Detail
            , Html.Attributes.style "width" "60px"
            , Html.Attributes.style "height" "60px"
            , Html.Attributes.style "font-size" "18px"
            , style "position" "absolute"
            , style "left" "100px"
            , style "top" "340px"
            ] [ text "G4" ],

            button
            [ onClick RenderGrid5Detail
            , Html.Attributes.style "width" "60px"
            , Html.Attributes.style "height" "60px"
            , Html.Attributes.style "font-size" "18px"
            , style "position" "absolute"
            , style "left" "100px"
            , style "top" "420px"
            ] [ text "G5" ],

            button
            [ onClick RenderGrid6Detail
            , Html.Attributes.style "width" "60px"
            , Html.Attributes.style "height" "60px"
            , Html.Attributes.style "font-size" "18px"
            , style "position" "absolute"
            , style "left" "180px"
            , style "top" "100px"
            ] [ text "G6" ],

            button
            [ onClick RenderGrid7Detail
            , Html.Attributes.style "width" "60px"
            , Html.Attributes.style "height" "60px"
            , Html.Attributes.style "font-size" "18px"
            , style "position" "absolute"
            , style "left" "180px"
            , style "top" "180px"
            ] [ text "G7" ],

             button
             [ onClick RenderGrid8Detail
             , Html.Attributes.style "width" "60px"
             , Html.Attributes.style "height" "60px"
             , Html.Attributes.style "font-size" "18px"
             , style "position" "absolute"
             , style "left" "180px"
             , style "top" "260px"
             ] [ text "G8" ],

              button
              [ onClick RenderGrid9Detail
              , Html.Attributes.style "width" "60px"
              , Html.Attributes.style "height" "60px"
              , Html.Attributes.style "font-size" "18px"
              , style "position" "absolute"
              , style "left" "180px"
              , style "top" "340px"
              ] [ text "G9" ],

              button
              [ onClick RenderGrid10Detail
              , Html.Attributes.style "width" "60px"
              , Html.Attributes.style "height" "60px"
              , Html.Attributes.style "font-size" "18px"
              , style "position" "absolute"
              , style "left" "180px"
              , style "top" "420px"
              ] [ text "G10" ]

              ]

renderGrid1Detail : Model -> Html Msg
renderGrid1Detail model =
    if model.whichGridIsOpen == 1 then
    div
      [ style "border-style" "inset"
      , style "border-color" "white"
      , style "border-width" "6px"
      , style "border-radius" "20%"
      , style "width" "500px"
      , style "height" "20px"
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
      [ Html.text ( "The information of this grid " )
    ]
    else
    div [][]

renderGrid2Detail : Model -> Html Msg
renderGrid2Detail model =
    if model.whichGridIsOpen == 2 then
    div
      [ style "border-style" "inset"
      , style "border-color" "white"
      , style "border-width" "6px"
      , style "border-radius" "20%"
      , style "width" "500px"
      , style "height" "20px"
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
      [ Html.text ( "The information of this grid " )
    ]
    else
    div [][]

renderGrid3Detail : Model -> Html Msg
renderGrid3Detail model=
    if model.whichGridIsOpen == 3 then
    div
      [ style "border-style" "inset"
      , style "border-color" "white"
      , style "border-width" "6px"
      , style "border-radius" "20%"
      , style "width" "500px"
      , style "height" "20px"
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
      [ Html.text ( "The information of this grid " )
    ]
    else
    div [][]

renderGrid4Detail : Model -> Html Msg
renderGrid4Detail model =
    if model.whichGridIsOpen == 4 then
    div
      [ style "border-style" "inset"
      , style "border-color" "white"
      , style "border-width" "6px"
      , style "border-radius" "20%"
      , style "width" "500px"
      , style "height" "20px"
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
      [ Html.text ( "The information of this grid " )
    ]
    else
    div [][]

renderGrid5Detail : Model -> Html Msg
renderGrid5Detail model =
    if model.whichGridIsOpen == 5 then
    div
      [ style "border-style" "inset"
      , style "border-color" "white"
      , style "border-width" "6px"
      , style "border-radius" "20%"
      , style "width" "500px"
      , style "height" "20px"
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
      [ Html.text ( "The information of this grid " )
    ]
    else
    div [][]

renderGrid6Detail : Model -> Html Msg
renderGrid6Detail model=
    if model.whichGridIsOpen == 6 then
    div
      [ style "border-style" "inset"
      , style "border-color" "white"
      , style "border-width" "6px"
      , style "border-radius" "20%"
      , style "width" "500px"
      , style "height" "20px"
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
      [ Html.text ( "The information of this grid " )
    ]
    else
    div [][]

renderGrid7Detail : Model -> Html Msg
renderGrid7Detail model=
    if model.whichGridIsOpen == 7 then
    div
      [ style "border-style" "inset"
      , style "border-color" "white"
      , style "border-width" "6px"
      , style "border-radius" "20%"
      , style "width" "500px"
      , style "height" "20px"
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
      [ Html.text ( "The information of this grid " )
    ]
    else
    div [][]

renderGrid8Detail : Model -> Html Msg
renderGrid8Detail model =
    if model.whichGridIsOpen == 8 then
    div
      [ style "border-style" "inset"
      , style "border-color" "white"
      , style "border-width" "6px"
      , style "border-radius" "20%"
      , style "width" "500px"
      , style "height" "20px"
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
      [ Html.text ( "The information of this grid " )
    ]
    else
    div [][]

renderGrid9Detail : Model -> Html Msg
renderGrid9Detail model=
    if model.whichGridIsOpen == 9 then
    div
      [ style "border-style" "inset"
      , style "border-color" "white"
      , style "border-width" "6px"
      , style "border-radius" "20%"
      , style "width" "500px"
      , style "height" "20px"
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
      [ Html.text ( "The information of this grid " )
    ]
    else
    div [][]

renderGrid10Detail : Model -> Html Msg
renderGrid10Detail model =
    if model.whichGridIsOpen == 10 then
    div
      [ style "border-style" "inset"
      , style "border-color" "white"
      , style "border-width" "6px"
      , style "border-radius" "20%"
      , style "width" "500px"
      , style "height" "20px"
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
      [ Html.text ( "The information of this grid " )
    ]
    else
    div [][]

renderStartButton : Model -> Html Msg
renderStartButton model =
    if model.map == StarterPage then
    button
                [ style "background" "red"
                , style "position" "absolute"
                , style "left" "500px"
                , style "top" "350px"
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
                , onClick StartGame
                ]
                [ Html.text "Start" ]
    else
    div [][]

renderStoryButton : Model -> Html Msg
renderStoryButton model =
    if model.map == StarterPage then
    button
                [ style "background" "red"
                , style "position" "absolute"
                , style "left" "700px"
                , style "top" "350px"
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
                , onClick ViewStory
                ]
                [ Html.text "Story" ]
    else
    div [][]

renderAboutUsButton : Model -> Html Msg
renderAboutUsButton model =
    if model.map == StarterPage then
    button
                [ style "background" "red"
                , style "position" "absolute"
                , style "left" "300px"
                , style "top" "350px"
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
                , onClick ViewAboutUs
                ]
                [ Html.text "About Us" ]
    else
    div [][]

renderBackButton : Model -> Html Msg
renderBackButton model =
    if model.map == Story || model.map == AboutUs then
    button
                [ style "background" "red"
                , style "position" "absolute"
                , style "left" "300px"
                , style "top" "350px"
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
                , onClick BackToStarter
                ]
                [ Html.text "Back to Start menu" ]
    else
    div [][]