module Tosvg exposing (..)

import Html.Events exposing (onClick)
import Model exposing (..)
import List exposing (filter)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Items exposing (..)
import Color exposing (..)
import Message exposing (Msg(..))
import Rules exposing (..)
import NarrativeEngine.Core.WorldModel as WorldModel
import Html exposing (Html, button, div, li, h3, ul, em)
import Html.Attributes exposing (style)
import Html.Events exposing (on, onClick, onMouseDown, onMouseUp)


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
            elevatorSvgList ++ exitSvgList ++ barrierSvgList
        _ -> [ rect [] [] ]


entityView : NPC -> (( WorldModel.ID, MyEntity ), Model) ->  Svg.Svg Msg
entityView npc ((id, { name }), model) =
    let
        msg =
            case model.interacttrue of
                True ->
                    InteractWith id
                _ ->
                    Noop
        ( x_, y_ ) = ( npc.area.x, npc.area.y )
        ( wid, hei ) = ( npc.area.wid, npc.area.hei )

    in
        rect
        [ x (x_ |> Debug.toString)
        , y (y_ |> Debug.toString)
        , width (wid |> Debug.toString)
        , height (hei |> Debug.toString)
        , strokeWidth "5px", stroke "#191970"
        , onClick (msg)
        ]
        []

entityViewchoices : ( WorldModel.ID, MyEntity ) -> Html Msg
entityViewchoices ( id, { name } ) =
    li [ onClick <| InteractWith id, Html.Attributes.style "cursor" "pointer" ] [ text name ]

bob model = List.map (entityView cBob) (List.map2 Tuple.pair (query "BOBPOLICEOFFICE.npc.day=1" model.worldModel) [model])

lee model = List.map (entityView cLee) (List.map2 Tuple.pair (query "LEEPOLICEOFFICE.npc.day=1" model.worldModel) [model])

allen model = List.map (entityView cAllen) (List.map2 Tuple.pair (query "ALLENPOLICEOFFICE.npc.day=1" model.worldModel) [model])

allenpark model = List.map (entityView pAllen) (List.map2 Tuple.pair (query "ALLENPARK.npc.day=1" model.worldModel) [model])

leepark model = List.map (entityView pLee) (List.map2 Tuple.pair (query "LEEPARK.npc.day=1" model.worldModel) [model])

adkinspark model = List.map (entityView pAdkins) (List.map2 Tuple.pair (query "ADKINS.npc.day=1" model.worldModel) [model])

catherinepark model = List.map (entityView pCatherine) (List.map2 Tuple.pair (query "CATHERINE.npc.day=1" model.worldModel) [model])


intToFloat : Int -> Float
intToFloat a =
    let
        c = Debug.toString a
        o = String.toFloat c
    in
    Maybe.withDefault 0 o

energytosvg : Int -> Int -> List (Svg msg)
energytosvg energy energyFull =
    let
        ( x_, y_ ) = ( 70, 585 )
        wid = 10
        lenTotal = 100
        len = lenTotal * ( intToFloat energy / intToFloat energyFull )
    in
        [
            Svg.rect
            [ x (x_|>Debug.toString)
            , y (y_|>Debug.toString)
            , height (wid|>Debug.toString)
            , width (lenTotal|>Debug.toString)
            , fill (toString (rgb 10 10 10))
            , stroke (toString (rgb 14 13 13))
            , strokeWidth "5px"
            ] []
            ,
            Svg.rect
            [ x (x_|>Debug.toString)
            , y (y_|>Debug.toString)
            , height (wid|>Debug.toString)
            , width (len|>Debug.toString)
            , fill (toString (rgb 255 255 187))
            ] []
            ,
            Svg.text_
            [ x ((x_ - 70)|>Debug.toString)
            , y ((y_ + 10)|>Debug.toString)
            , fill "#999C86"
            , fontSize "15"
            , fontFamily "Segoe UI Black"
            , textDecoration "underline"
            ] [text "Energy"]
        ]








