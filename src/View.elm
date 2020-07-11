module View exposing (..)
import Html exposing (Html, button, div, text, br, ul, em)
import Html.Attributes exposing (style,src,type_)
import Html.Events exposing (on, onClick, onMouseDown, onMouseUp)
import Json.Decode as Json
import Message exposing (Msg(..))
import Model exposing (..)
import Tosvg exposing (heroToSvg , itemsToSvg)
import Svg exposing (image, rect, svg)
import Svg.Attributes exposing (x,y,width,height,viewBox,fill,stroke,strokeWidth)
import Items exposing ( .. )
import Rules exposing (..)
import NarrativeEngine.Core.WorldModel as WorldModel
import NarrativeEngine.Syntax.RuleParser as RuleParser

view : Model -> Html Msg
view model =
    div []
            [ renderPic model
            , renderMapButton model
            , renderdialog model
            , renderMusic
            , axisHelper model
            ]


axisHelper : Model -> Html Msg
axisHelper model =
    div []
        [ text (model.hero.x |> Debug.toString), br [] []
        , text (model.hero.y |> Debug.toString)
        ]

renderMusic : Html Msg
renderMusic =
    div []
    [ div []
        [ Html.iframe
            [ Html.Attributes.src "./trigger.mp3"
            , Html.Attributes.autoplay True
            , style "display" "none"
            ] []
        ]
    , div []
        [ Html.audio
            [ Html.Attributes.id "player"
            , Html.Attributes.autoplay True
            , Html.Attributes.loop True
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
        ((

        case model.map of
            PoliceOffice ->

                [Svg.image
                    [Svg.Attributes.xlinkHref "./police_office.png"
                    , x "0"
                    , y "0"
                    , width "900"
                    , height "630"
                    , Svg.Attributes.transform "translate(0,-20)" -- in this scale for a 2388*1688 picture, all things are favorable. But I still confused about this. So can anyone help? --zhouyuxiang 7/9
                    ] []]
                ++ ( heroToSvg model.hero )
                ++ ( bob model)
                ++ ( lee model)
                ++ ( allen model)

            Park ->

                [Svg.image
                    [Svg.Attributes.xlinkHref "./park.png"
                    , x "0"
                    , y "0"
                    , width "900"
                    , height "630"
                    , Svg.Attributes.transform "translate(0,-20)" -- in this scale for a 2388*1688 picture, all things are favorable. But I still confused about this. So can anyone help? --zhouyuxiang 7/9
                    ] []]
                ++ ( heroToSvg model.hero )
                ++ ( leepark model)
                ++ ( allenpark model)

            Switching ->

                [Svg.rect
                    [ x "0"
                    , y "0"
                    , width "900"
                    , height "600"
                    , fill "black"][]] --useless now




        )++ ( itemsToSvg model )
        )

renderdialog : Model -> Html Msg
renderdialog model =
        div [ style "width" "70%", style "margin" "auto" ]
        [ div [ style "flex" "1 1 auto", style "font-size" "2em", style "padding" "0 2em" ]
              [em [] [ text model.story ]
                     ,ul [] <| List.map entityViewchoices (query "*.choices=1" model.worldModel)]
        ]