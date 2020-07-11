module Color exposing (..)

import Json.Decode as Decode
import Json.Encode as Encode


type Color
    = Color { red : Int, green : Int, blue : Int }


rgb : Int -> Int -> Int -> Color
rgb red green blue =
    Color { red = red, green = green, blue = blue }


toString : Color -> String
toString (Color { red, green, blue }) =
    "rgb("
        ++ String.fromInt red
        ++ ","
        ++ String.fromInt green
        ++ ","
        ++ String.fromInt blue
        ++ ")"


decode : Decode.Decoder Color
decode =
    Decode.map3 rgb
        (Decode.index 0 Decode.int)
        (Decode.index 1 Decode.int)
        (Decode.index 2 Decode.int)


encode : Color -> Encode.Value
encode (Color { red, green, blue }) =
    Encode.list Encode.int [ red, green, blue ]


colorExit = rgb 130 10 10

colorBarrier = rgb 10 10 130

colorElevator = rgb 10 130 10


