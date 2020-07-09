module View exposing (..)
import Html exposing (Html, button, div, text)
import Html.Attributes exposing (style)
import Html.Events exposing (on, onClick, onMouseDown, onMouseUp)
import Json.Decode as Json
import Message exposing (Msg(..))
import Model exposing (Model, Map(..))
import Tosvg exposing (heroToSvg)
import Svg exposing (image, rect, svg)
import Svg.Attributes exposing (x,y,width,height,viewBox,fill)

view : Model -> Html Msg
view model =
    div []
            [ renderPic model
            , renderMapButton model
            ]


renderMapButton : Model -> Html Msg
renderMapButton model =
    case model.map of
        Switching ->
            div []
            [
            button
            [ Html.Attributes.style "background" "blue"
            , style "position" "absolute"
            , style "left" "105px"
            , style "top" "400px"
            , Html.Attributes.style "color" "#f3f2e9"
            , Html.Attributes.style "cursor" "pointer"
            , Html.Attributes.style "display" "block"
            , Html.Attributes.style "font-family" "Helvetica, Arial, sans-serif"
            , Html.Attributes.style "font-size" "18px"
            , Html.Attributes.style "font-weight" "300"
            , Html.Attributes.style "height" "80px"
            , Html.Attributes.style "line-height" "60px"
            , Html.Attributes.style "outline" "none"
            , Html.Attributes.style "padding" "0"
            , Html.Attributes.style "width" "130px"
            , style "border-style" "inset"
            , style "border-color" "white"
            , style "border-width" "6px"
            , style "border-radius" "20%"
            , onClick ToPoliceOffice
            ]
            [ Html.text "Police Office" ]
            ,
            button
            [ Html.Attributes.style "background" "red"
            , style "position" "absolute"
            , style "left" "300px"
            , style "top" "400px"
            , Html.Attributes.style "color" "#f3f2e9"
            , Html.Attributes.style "cursor" "pointer"
            , Html.Attributes.style "display" "block"
            , Html.Attributes.style "font-family" "Helvetica, Arial, sans-serif"
            , Html.Attributes.style "font-size" "18px"
            , Html.Attributes.style "font-weight" "300"
            , Html.Attributes.style "height" "80px"
            , Html.Attributes.style "line-height" "60px"
            , Html.Attributes.style "outline" "none"
            , Html.Attributes.style "padding" "0"
            , Html.Attributes.style "width" "130px"
            , style "border-style" "inset"
            , style "border-color" "white"
            , style "border-width" "6px"
            , style "border-radius" "20%"
            , onClick ToPark
            ]
            [ Html.text "Park" ]
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
        (
        [
        case model.map of
            PoliceOffice ->

                Svg.image
                    [Svg.Attributes.xlinkHref "./police_office.png"
                    , x "0"
                    , y "0"
                    , width "900"
                    , height "630"
                    , Svg.Attributes.transform "translate(0,-20)" -- in this scale for a 2388*1688 picture, all things are favorable. But I still confused about this. So can anyone help? --zhouyuxiang 7/9
                    ] []

            Park ->

                Svg.image
                    [Svg.Attributes.xlinkHref "./park.png"
                    , x "0"
                    , y "0"
                    , width "900"
                    , height "630"
                    , Svg.Attributes.transform "translate(0,-20)" -- in this scale for a 2388*1688 picture, all things are favorable. But I still confused about this. So can anyone help? --zhouyuxiang 7/9
                    ] []


            Switching ->

                Svg.rect
                    [ x "0"
                    , y "0"
                    , width "900"
                    , height "600"
                    , fill "black"][] --useless now

        ]


        ++ ( heroToSvg model.hero )
        )
