module View exposing (..)
import Html exposing (Html, button, div, text)
import Html.Attributes exposing (style)
import Html.Events exposing (on, onClick, onMouseDown, onMouseUp)
import Json.Decode as Json
import Message exposing (Msg(..))
import Model exposing (Model, Map(..))
import Tosvg exposing (heroToSvg)
import Svg exposing (..)
import Svg.Attributes exposing (..)

view : Model -> Html Msg
view model =
    div []
            [ renderPic model
            ]

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
