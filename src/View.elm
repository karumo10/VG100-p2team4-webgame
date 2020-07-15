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
                    , width "900"
                    , height "630"
                    , transform "translate(0,-20)" -- in this scale for a 2388*1688 picture, all things are favorable. But I still confused about this. So can anyone help? --zhouyuxiang 7/9
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
                    , width "900"
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
                    , width "900"
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
                    , width "900"
                    , height "630"
                    , transform "translate(0,-20)" -- in this scale for a 2388*1688 picture, all things are favorable. But I still confused about this. So can anyone help? --zhouyuxiang 7/9
                    ] []]
                ++ [renderdialog model]
                ++ [renderchoice model]
                ++ ( elevatorQuestToSvg model )
                ++ ( heroToSvg model.hero )
                ++ [renderportrait model]





        )++ (
          energytosvg model.energy model.energy_Full
         ++ testToSvg model
         ++ itemsToSvg model )
        )

renderdialog : Model -> Svg Msg
renderdialog model =
    Svg.foreignObject [ x "200", y "600", width "1000", height "150"]
                      [ p [ style "flex" "1 1 auto", style "font-size" "1.5em", style "padding" "0 1em", Html.Attributes.class "inset" ]
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
        Svg.foreignObject [ x "200", y "200", width "500", height "100%", style "opacity" opacity]
                          [ p [ style "flex" "1 1 auto", style "font-size" "1.5em", style "padding" "0 1em", Html.Attributes.class "inset" ]
                              [ul [] <| List.map entityViewchoices (query "*.choices=1" model.worldModel)]
                          ]

renderportrait : Model -> Svg Msg
renderportrait model =
    let
        portr =
            case model.portrait of
                "" ->
                    Svg.image [ Svg.Attributes.xlinkHref ("./player.png")
                              , x "10", y "610", width "140", height "140"
                              ] []
                _ ->
                    Svg.image [ Svg.Attributes.xlinkHref ("./"++model.portrait++".png")
                              , x "10", y "610", width "140", height "140"
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
