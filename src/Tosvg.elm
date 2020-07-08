module Tosvg exposing (..)
import Model exposing (..)
import Svg exposing (..)
import Svg.Attributes exposing (..)


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


