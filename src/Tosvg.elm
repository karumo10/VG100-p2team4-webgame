module Tosvg exposing (..)

import Model exposing (..)
import List exposing (filter)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Items exposing (..)
import Color exposing (Color,rgb, toString)

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
        , strokeWidth "5px"
        , stroke "black"
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
