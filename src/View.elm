module View exposing (..)
import Html.Attributes exposing (style,src,type_,autoplay,id,loop)
import Html.Events exposing (on, onClick, onMouseDown, onMouseUp)
import Json.Decode as Json
import Message exposing (Msg(..))
import Model exposing (..)
import Tosvg exposing (..)
import Svg exposing (image, rect, svg)
import Svg.Attributes exposing (x,y,width,height,viewBox,fill,stroke,strokeWidth,xlinkHref,transform)
import Items exposing ( .. )
import Rules exposing (..)
import NarrativeEngine.Core.WorldModel as WorldModel
import NarrativeEngine.Syntax.RuleParser as RuleParser
import Css exposing (borderRadius, px, hover, textDecoration, underline)
import Html exposing (Html, button, div, text, br, ul, em)

pixelWidth : Float
pixelWidth =
    900


pixelHeight : Float
pixelHeight =
    600

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
        , style "position" "absolute"
        , style "left" "0"
        , style "top" "0"
        ]
        [ div
        [ style "width" (String.fromFloat pixelWidth ++ "px")
        , style "height" (String.fromFloat pixelHeight ++ "px")
        , style "position" "absolute"
        , style "left" (String.fromFloat ((w - pixelWidth * r) / 2) ++ "px")
        , style "top" (String.fromFloat ((h - pixelHeight * r) / 2) ++ "px")
        , style "transform-origin" "0 0"
        , style "transform" ("scale(" ++ String.fromFloat r ++ ")")]
        [ renderPic model
        , renderMapButton model
        , renderdialog model
        , renderMusic
        , axisHelper model
        ]]



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


        _ ->
            div [] []



renderPic : Model -> Html Msg
renderPic model =
    svg
        [ width "900"
        , height "600"
        , viewBox "0 0 900 600"
        ]
        ((

        case model.map of
            PoliceOffice ->

                [Svg.image
                    [ xlinkHref "./police_office.png"
                    , x "0"
                    , y "0"
                    , width "900"
                    , height "630"
                    , transform "translate(0,-20)" -- in this scale for a 2388*1688 picture, all things are favorable. But I still confused about this. So can anyone help? --zhouyuxiang 7/9
                    ] []]
                ++ [ entityView cBob ]
                ++ [ entityView cLee ]
                ++ [ entityView cAllen ]
                ++ ( elevatorQuestToSvg model )
                ++ ( heroToSvg model.hero )


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

            Switching ->

                [Svg.rect
                    [ x "0"
                    , y "0"
                    , width "900"
                    , height "600"
                    , fill "black"][]] --useless now

            Home ->
                [Svg.image
                    [ xlinkHref "./Kay's_home.png"
                    , x "0"
                    , y "0"
                    , width "900"
                    , height "630"
                    , transform "translate(0,-20)" -- in this scale for a 2388*1688 picture, all things are favorable. But I still confused about this. So can anyone help? --zhouyuxiang 7/9
                    ] []]
                ++ ( elevatorQuestToSvg model )
                ++ ( heroToSvg model.hero )





        )++ (
          energytosvg model.energy model.energy_Full
         ++ testToSvg model )
        )

renderdialog : Model -> Html Msg
renderdialog model =
        div [ style "width" "70%", style "margin" "auto" ]
        [ div [ style "flex" "1 1 auto", style "font-size" "1.5em", style "padding" "0 1em" ]
              ([div [] [ text model.story ]
              ,ul [] <| List.map entityViewchoices (query "*.choices=1" model.worldModel)
              ]++
              case model.map of
                  Park ->
                      [ button [onClick Catherinecatch, style "opacity" (model.conclusion|>Debug.toString)] [text "Catherine"]
                      , button [onClick Adkinscatch, style "opacity" (model.conclusion|>Debug.toString)] [text "Adkins"]
                      , button [onClick Robbery, style "opacity" (model.conclusion|>Debug.toString)] [text "This is a robbery."]
                      ]
                  _ ->
                      []
              )
        ]