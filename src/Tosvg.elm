module Tosvg exposing (..)

import Model exposing (..)
import Svg exposing (Svg, rect, text_, text, circle)
import Svg.Attributes exposing (x, y, width, height, strokeWidth, fill, stroke, fontSize, fontFamily, textDecoration, cx, cy, r)
import Items exposing (..)
import Color exposing (..)
import Message exposing (Msg(..))
import Rules exposing (..)
import NarrativeEngine.Core.WorldModel as WorldModel
import Html exposing (Html, button, div, li, h3, ul, em, p)
import Html.Attributes exposing (style)
import Html.Events exposing (on, onClick, onMouseDown, onMouseUp)
import Areas exposing (..)

heroToSvg : Hero -> List (Svg msg)
heroToSvg hero =
    let
        ( x_, y_ ) = ( toFloat hero.x, toFloat hero.y )
        ( wid, hei ) = ( hero.width, hero.height )
    in
    [
        rect
        [ x (x_ |> Debug.toString)
        , y (y_ |> Debug.toString)
        , width (wid |> Debug.toString)
        , height (hei |> Debug.toString)
        , strokeWidth "0px"
        , fill "pink"
        ]
        []

    ]

formSvg : Item -> Svg msg
formSvg item =
    rect
            [ x ( item.x |> Debug.toString)
            , y ( item.y |> Debug.toString)
            , width "100"
            , height "20"
            , stroke (toString(rgb 226 0 0))
            , fill (toString(rgb 248 0 0))
            ]
            []

itemsToSvg : Model -> List ( Svg msg )
itemsToSvg model =
    let
        itemsLeft = List.filter isNotPick model.items
        itemsExact = List.filter (isItemAtMap model) itemsLeft
    in
    List.map ( \a -> formSvg a) itemsExact


elevatorQuestToSvg : Model -> List (Svg Msg)
elevatorQuestToSvg model =
    case model.quests of
        ElevatorQuest ->
            [
                rect
                [ x "405"
                , y "140"
                , width "100"
                , height "280"
                , strokeWidth "0px"
                , stroke "black"
                , fill "grey"
                ]
                [] -- choice board

            ,
                rect
                [ x "415"
                , y "150"
                , width "80"
                , height "80"
                , strokeWidth "5px"
                , stroke "black"
                , fill "white"
                , onClick ElevateTo1
                ]
                [] -- f1
            ,
                rect
                [ x "415"
                , y "240"
                , width "80"
                , height "80"
                , strokeWidth "5px"
                , stroke "black"
                , fill "white"
                , onClick ElevateTo2
                ]
                [] -- f2
            ,
                rect
                [ x "415"
                , y "330"
                , width "80"
                , height "80"
                , strokeWidth "5px"
                , stroke "black"
                , fill "white"
                , onClick ElevateTo3
                ]
                [] -- f3
            ,
                text_
                [ x "445"
                , y "200"
                , fill "black"
                , fontSize "40px"
                ] [ text "1" ]
            ,
                text_
                [ x "445"
                , y "290"
                , fill "black"
                , fontSize "40px"
                ] [ text "2" ]
            ,
                text_
                [ x "445"
                , y "380"
                , fill "black"
                , fontSize "40px"
                ] [ text "3" ]

            ]
        _ ->
            [ rect[][] ]


bedQuestToSvg : Model -> Svg Msg
bedQuestToSvg model =
    case model.quests of
        BedQuest ->
            Svg.foreignObject
                [ x "200", y "200", width "500", height "100%", style "opacity" "1" ]
                [ p [ style "flex" "1 1 auto", style "font-size" "1.5em", style "padding" "0 1em", Html.Attributes.class "inset" ]
                    [ ul []
                    [ li [ onClick (Sleep True), Html.Attributes.class "click-on" ]  [ Html.text "Let me sleep for a while."]
                    , li [ onClick (Sleep False), Html.Attributes.class "click-on" ] [ Html.text "I can still work..."]
                    ]
                    ]
                ]

        _ ->  rect [] []



areaToSvg : Area -> Color -> List (Svg msg)
areaToSvg area color =
        let
            ( x_, y_ ) = ( area.x, area.y )
            ( wid, hei ) = ( area.wid, area.hei )
            color_ = Color.toString color
        in
        [
            rect
            [ x (x_ |> Debug.toString)
            , y (y_ |> Debug.toString)
            , width (wid |> Debug.toString)
            , height (hei |> Debug.toString)
            , strokeWidth "0px"
            , fill color_
            ]
            []

        ]

exitToSvg : Area -> List (Svg msg)
exitToSvg area =
    areaToSvg area colorExit

elevatorToSvg : Area -> List (Svg msg)
elevatorToSvg area =
    areaToSvg area colorElevator

barrierToSvg : Area -> List (Svg msg)
barrierToSvg area =
    areaToSvg area colorBarrier

testToSvg : Model -> List (Svg msg)
testToSvg model =
    let
        mapAttr = model.mapAttr
        exitSvgList = exitToSvg mapAttr.exit
        barrierSvgListList = List.map barrierToSvg mapAttr.barrier
        barrierSvgList = List.foldl (++) [] barrierSvgListList
        elevatorAreas = List.map (\a -> a.area) mapAttr.vehicle
        elevatorSvgListList = List.map elevatorToSvg elevatorAreas
        elevatorSvgList = List.foldl (++) [] elevatorSvgListList
    in
    case Model.gameMode______ of
        Test ->
            elevatorSvgList ++ exitSvgList ++ barrierSvgList
        _ -> [ rect [] [] ]


entityView : NPC ->  Svg Msg
entityView npc =
    let
        ( x_, y_ ) = ( npc.area.x, npc.area.y )
        ( wid, hei ) = ( npc.area.wid, npc.area.hei )

    in
        rect
        [ x (x_ |> Debug.toString)
        , y (y_ |> Debug.toString)
        , width (wid |> Debug.toString)
        , height (hei |> Debug.toString)
        , strokeWidth "5px", stroke "#191970"
        ]
        []





entityViewchoices : ( WorldModel.ID, MyEntity ) -> Html Msg
entityViewchoices ( id, { name } ) =
    li [ onClick <| InteractWith id, style "cursor" "pointer" ] [ text name ]

getnpc : NPC -> String
getnpc npc =
    let
        npc_ =
            case npc.interacttrue of
                True ->
                    npc.description
                _ ->
                    ""
    in
        npc_

getnpc_ : Model -> List String
getnpc_ model =
    List.map getnpc model.npcs

getdescription model =
    List.filter (\x -> x /= "") (getnpc_ model)

intToFloat : Int -> Float
intToFloat a =
    let
        c = Debug.toString a
        o = String.toFloat c
    in
    Maybe.withDefault 0 o

dayToSvg : Model -> List (Svg msg)
dayToSvg model =
    [
        text_
        [ x "20"
        , y "20"
        , fill "black"
        , fontSize "20"
        , fontFamily "Segoe UI Black"
        ] [text ("Day " ++ (Debug.toString model.day))]

    ]




energytosvg : Int -> Int -> List (Svg msg)
energytosvg energy energyFull =
    let
        ( x_, y_ ) = ( 70, 585 )
        wid = 10
        lenTotal = 100
        len = lenTotal * ( intToFloat energy / intToFloat energyFull )
    in
        [
            rect
            [ x (x_|>Debug.toString)
            , y (y_|>Debug.toString)
            , height (wid|>Debug.toString)
            , width (lenTotal|>Debug.toString)
            , fill (toString (rgb 10 10 10))
            , stroke (toString (rgb 14 13 13))
            , strokeWidth "5px"
            ] []
            ,
            rect
            [ x (x_|>Debug.toString)
            , y (y_|>Debug.toString)
            , height (wid|>Debug.toString)
            , width (len|>Debug.toString)
            , fill (toString (rgb 255 255 187))
            ] []
            ,
            text_
            [ x ((x_ - 72)|>Debug.toString)
            , y ((y_ + 10)|>Debug.toString)
            , fill "#999C86"
            , fontSize "15"
            , fontFamily "Segoe UI Black"
            , textDecoration "underline"
            ] [text "Energy"]
            ,
            text_
            [ x ((x_ - 20)|>Debug.toString)
            , y ((y_ + 10)|>Debug.toString)
            , textDecoration "underline"
            , fill "#999C86"
            , fontSize "15"
            , fontFamily "Segoe UI Black"
            ] [text (Debug.toString energy)]
        ]








