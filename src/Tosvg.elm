module Tosvg exposing (..)

import Html.Events exposing (onClick)
import Model exposing (..)
import List exposing (filter)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Items exposing (..)
import Color exposing (..)
import Message exposing (Msg(..))
import Svg.Events exposing (onMouseOver)

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
        , fill "black"
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
    in
    List.map ( \a -> formSvg a) itemsLeft


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
        elevatorAreas = List.map (\a -> a.area) mapAttr.elevator
        elevatorSvgListList = List.map elevatorToSvg elevatorAreas
        elevatorSvgList = List.foldl (++) [] elevatorSvgListList
    in
    case Model.gameMode______ of
        Test ->
            exitSvgList ++ barrierSvgList ++ elevatorSvgList
        _ -> [ rect [] [] ]



















draftSvg : List (Svg msg)
draftSvg =
    [
        line
        [ x1 "200"
        , y1 "0"
        , x2 "200"
        , y2 "600"
        , strokeWidth "5px"
        , stroke "black"
        ] []
        ,
        line
        [ x1 "400"
        , y1 "0"
        , x2 "400"
        , y2 "600"
        , strokeWidth "5px"
        , stroke "black"
        ] []
        ,
        line
        [ x1 "600"
        , y1 "0"
        , x2 "600"
        , y2 "600"
        , strokeWidth "5px"
        , stroke "black"
        ] []
        ,
        line
        [ x1 "800"
        , y1 "0"
        , x2 "800"
        , y2 "600"
        , strokeWidth "5px"
        , stroke "black"
        ] []

        ,

        line
        [ x1 "0"
        , y1 "200"
        , x2 "900"
        , y2 "200"
        , strokeWidth "5px"
        , stroke "black"
        ] []
        ,
        line
        [ x1 "0"
        , y1 "400"
        , x2 "900"
        , y2 "400"
        , strokeWidth "5px"
        , stroke "black"
        ] []


    ]










