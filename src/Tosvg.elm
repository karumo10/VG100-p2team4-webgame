module Tosvg exposing (..)

import Model exposing (..)
import NPC exposing (NPC)
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
import MapAttr exposing (..)


heroToSvg : Model -> List (Svg msg)
heroToSvg model =
    let
        ( x_, y_ ) =
            if gameMode______ == Game then
            ( toFloat (model.hero.x), toFloat model.hero.y - model.hero.height * 0.65 )
            else
            ( toFloat (model.hero.x), toFloat (model.hero.y) )

        ( wid, hei ) =
            if gameMode______ == Game then
            ( model.hero.width*2, model.hero.height*2 )
            else
            ( model.hero.width, model.hero.height )

        link = model.heroimage

    in
    if gameMode______ == Game then
    [
        Svg.image
        [ x (x_ |> Debug.toString)
        , y (y_ |> Debug.toString)
        , width (wid |> Debug.toString)
        , Svg.Attributes.xlinkHref link
        ]
        []
    ]
    else
    [
        Svg.rect
        [ x (x_ |> Debug.toString)
        , y (y_ |> Debug.toString)
        , width (wid |> Debug.toString)
        , height (hei |> Debug.toString)
        , fill "pink"
        ]
        []
    ]


heroToSvgInMaze : Hero -> List (Svg msg)
heroToSvgInMaze hero =
    let
        ( wid, hei ) = ( hero.width, hero.height )
        ( x_, y_ ) = ( toFloat hero.x - 4 + wid/2 , toFloat hero.y + 1 + hei/2 )
        r_ = ( min wid hei ) / 2 - 1
    in
    [
        circle
        [ cx (x_ |> Debug.toString)
        , cy (y_ |> Debug.toString)
        , r (r_ |> Debug.toString)
        , strokeWidth "0px"
        , fill "url(#hero-ball-maze)"
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


elevatorQuestToSvg : Model -> List (Html Msg)
elevatorQuestToSvg model =
            case model.map of
                NightClub ->
                    if model.hero.x >= 1000 then
                    [ div [Html.Attributes.class "main", Html.Attributes.class "basicBox"]
                         [Svg.svg [ width "100"
                                 , height "280"
                                 , Svg.Attributes.viewBox "0 0 100 280"
                                 ]
                                 [ rect [ x "10" , y "100"
                                        , width "80" , height "80"
                                        , strokeWidth "5px"
                                        , stroke "black"
                                        , fill "none"
                                        , onClick ElevateTo1
                                        , Svg.Attributes.class "h"
                                        ] [] -- f1
                                 , rect [ x "10", y "10"
                                        , width "80", height "80"
                                        , strokeWidth "5px"
                                        , stroke "black"
                                        , fill "white"
                                        , onClick ElevateTo2
                                        , Svg.Attributes.class "h"
                                        ] [] -- f2
                                 , text_ [ x "35", y "150"
                                         , fill "#F7CA18"
                                         , fontSize "40px"
                                        , onClick ElevateTo1
                                         ] [ text "1" ]
                                 , text_ [ x "35", y "60"
                                         , fill "#F7CA18"
                                         , fontSize "40px"
                                        , onClick ElevateTo2
                                         ] [ text "2" ]
                                 ]] ]
                    else [ div [][] ]

                PoliceOffice ->
                    if model.hero.x >= 800 && model.hero.x <= 920 then
                    [div [Html.Attributes.class "main", Html.Attributes.class "basicBox"]
                        [Svg.svg [ width "100"
                                 , height "280"
                                 , Svg.Attributes.viewBox "0 0 100 280"
                                 ]
                                 [ rect [ x "10" , y "190"
                                        , width "80" , height "80"
                                        , strokeWidth "5px"
                                        , stroke "black"
                                        , fill "none"
                                        , onClick ElevateTo1
                                        , Svg.Attributes.class "h"
                                        ] [] -- f1
                                 , rect [ x "10", y "100"
                                        , width "80", height "80"
                                        , strokeWidth "5px"
                                        , stroke "black"
                                        , fill "white"
                                        , onClick ElevateTo2
                                        , Svg.Attributes.class "h"
                                        ] [] -- f2
                                 , rect [ x "10", y "10"
                                        , width "80", height "80"
                                        , strokeWidth "5px"
                                        , stroke "black"
                                        , fill "white"
                                        , onClick ElevateTo3
                                        , Svg.Attributes.class "h"
                                        ] [] -- f3
                                 , text_ [ x "35", y "240"
                                         , fill "#F7CA18"
                                         , fontSize "40px"
                                        , onClick ElevateTo1
                                         ] [ text "1" ]
                                 , text_ [ x "35", y "150"
                                         , fill "#F7CA18"
                                         , fontSize "40px"
                                        , onClick ElevateTo2
                                         ] [ text "2" ]
                                 , text_ [ x "35", y "60"
                                         , fill "#F7CA18"
                                         , fontSize "40px"
                                        , onClick ElevateTo3
                                         ] [ text "3" ]]] ]
                    else [div [][]]
                Home ->
                    if model.hero.x >= 1050 && model.hero.x <= 1080 then
                    [div [Html.Attributes.class "main", Html.Attributes.class "basicBox"]
                         [Svg.svg [ width "100"
                                  , height "280"
                                  , Svg.Attributes.viewBox "0 0 100 280"
                                  ]
                                  [ rect [ x "10" , y "190"
                                  , width "80" , height "80"
                                  , strokeWidth "5px"
                                  , stroke "black"
                                  , fill "none"
                                  , onClick ElevateTo1
                                  , Svg.Attributes.class "h"
                                  ] [] -- f1
                                  , rect [ x "10", y "100"
                                  , width "80", height "80"
                                  , strokeWidth "5px"
                                  , stroke "black"
                                  , fill "white"
                                  , onClick ElevateTo2
                                  , Svg.Attributes.class "h"
                                  ] [] -- f2
                                  , rect [ x "10", y "10"
                                  , width "80", height "80"
                                  , strokeWidth "5px"
                                  , stroke "black"
                                  , fill "white"
                                  , onClick ElevateTo3
                                  , Svg.Attributes.class "h"
                                  ] [] -- f3
                                  , text_ [ x "35", y "240"
                                  , fill "#F7CA18"
                                  , fontSize "40px"
                                  , onClick ElevateTo1
                                  ] [ text "1" ]
                                  , text_ [ x "35", y "150"
                                  , fill "#F7CA18"
                                  , fontSize "40px"
                                  , onClick ElevateTo2
                                  ] [ text "2" ]
                                  , text_ [ x "35", y "60"
                                  , fill "#F7CA18"
                                  , fontSize "40px"
                                  , onClick ElevateTo3
                                  ] [ text "3" ]]] ]
                    else [div [][]]
                Daniel ->
                                    if model.hero.x >= 900 then
                                    [div [Html.Attributes.class "main", Html.Attributes.class "basicBox"]
                                         [Svg.svg [ width "100"
                                                  , height "280"
                                                  , Svg.Attributes.viewBox "0 0 100 280"
                                                  ]
                                                  [ rect [ x "10" , y "190"
                                                  , width "80" , height "80"
                                                  , strokeWidth "5px"
                                                  , stroke "black"
                                                  , fill "none"
                                                  , onClick ElevateTo1
                                                  , Svg.Attributes.class "h"
                                                  ] [] -- f1
                                                  , rect [ x "10", y "100"
                                                  , width "80", height "80"
                                                  , strokeWidth "5px"
                                                  , stroke "black"
                                                  , fill "white"
                                                  , onClick ElevateTo2
                                                  , Svg.Attributes.class "h"
                                                  ] [] -- f2
                                                  , text_ [ x "35", y "240"
                                                  , fill "#F7CA18"
                                                  , fontSize "40px"
                                                  , onClick ElevateTo1
                                                  ] [ text "1" ]
                                                  , text_ [ x "35", y "150"
                                                  , fill "#F7CA18"
                                                  , fontSize "40px"
                                                  , onClick ElevateTo2
                                                  ] [ text "2" ]
                                                  ]] ]
                                    else [div [][]]
                _ ->
                                     [div [][]]





bedQuestToSvg : Model -> Svg Msg
bedQuestToSvg model =
    case model.quests of
        BedQuest ->
            Svg.foreignObject
                [ x "350", y "200", width "500", height "100%", style "opacity" "1" ]
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
    case gameMode______ of
        CollisionTest ->
            elevatorSvgList ++ exitSvgList ++ barrierSvgList
        TotalTest ->
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
        , Svg.Attributes.opacity "0"
        ]
        []

npcListView : Model -> List (Svg Msg)
npcListView model =
    let
        npcList = model.npcs_curr
        npcSvgList = List.map entityView npcList
    in
    npcSvgList



entityViewchoices : ( WorldModel.ID, MyEntity ) -> Html Msg
entityViewchoices ( id, { name } ) =
    li [ onClick <| InteractWith id, style "cursor" "pointer" ] [ text name ]

getnpc : NPC -> String
getnpc npc =
    let
        npc_ =
            case npc.interacttrue of
                True ->
                    npc.name
                _ ->
                    ""
    in
        npc_

getnpc_ : Model -> List String
getnpc_ model =
    List.map getnpc model.npcs_curr

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
    if model.map /= Story && model.map /= StarterPage && model.map /= AboutUs && model.day /= 9 then
    [
        text_
        [ x "20"
        , y "20"
        , fill "black"
        , fontSize "20"
        , fontFamily "Segoe UI Black"
        ] [text ("Day " ++ (Debug.toString model.day))]

    ]
    else if model.map /= Story && model.map /= StarterPage && model.map /= AboutUs && model.day == 9 then
    [
        text_
        [ x "20"
        , y "20"
        , fill "black"
        , fontSize "20"
        , fontFamily "Segoe UI Black"
        ] [text ("Day ??") ]

    ]

    else [ text_[][]]




energytosvg : Int -> Int -> List (Svg msg)
energytosvg energy energyFull =
    let
        ( x_, y_ ) = ( 100, 585 )
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
            [ x ((x_ - 80)|>Debug.toString)
            , y ((y_ + 10)|>Debug.toString)
            , fill "#999C86"
            , fontSize "15"
            , fontFamily "Segoe UI Black"
            , textDecoration "underline"
            ] [text "Energy"]
            ,
            text_
            [ x ((x_ - 28)|>Debug.toString)
            , y ((y_ + 10)|>Debug.toString)
            , textDecoration "underline"
            , fill "#999C86"
            , fontSize "15"
            , fontFamily "Segoe UI Black"
            ] [text (Debug.toString energy)]
        ]








