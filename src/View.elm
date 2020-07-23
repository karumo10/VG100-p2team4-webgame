module View exposing (..)
import Html.Attributes exposing (style,src,type_,autoplay,id,loop,class)
import Html.Events exposing (on, onClick, onMouseDown, onMouseUp)
import Json.Decode as Json
import Message exposing (Msg(..))
import Model exposing (..)
import Tosvg exposing (..)
import Svg exposing (image, rect, svg, Svg)
import Svg.Attributes exposing (x,y,width,height,viewBox,fill,stroke,strokeWidth,xlinkHref,transform)
import Items exposing ( .. )
import Html exposing (Html, button, div, text, br, ul, p)
import MapAttr exposing (gameMode______, Mode(..))
pixelWidth : Float
pixelWidth =
    1050


pixelHeight : Float
pixelHeight =
    700

view : Model -> Html Msg
view model =
    let
        ( w, h ) =
            model.size
        r =
            if w / h > pixelWidth / pixelHeight then
                min 1 (h / pixelHeight)
            else
                min 1 (w / pixelWidth)
    in
        div
        [ style "width" "100%"
        , style "height" "100%"
        ]
        ([ div
        [ style "width" (String.fromFloat pixelWidth ++ "px")
        , style "height" (String.fromFloat pixelHeight ++ "px")
        , style "position" "absolute"
        , style "margin" "auto"
        , style "left" "0"
        , style "top" "0"
        , style "right" "0"
        , style "bottom" "0"
        , style "transform-origin" "0 0"
        , style "transform" ("scale(" ++ String.fromFloat r ++ ")")]
        [ renderPic model
        , renderMapButton model
        --, renderdialog model
        , renderMusic
        , axisHelper model
        --, renderBag model
        , renderGrid1Detail model
        , renderGrid2Detail model
        , renderGrid3Detail model
        , renderGrid4Detail model
        , renderGrid5Detail model
        , renderGrid6Detail model
        , renderGrid7Detail model
        , renderGrid8Detail model
        , renderGrid9Detail model
        , renderGrid10Detail model
        , renderStartButton model
        , renderAboutUsButton model
        , renderStoryButton model
        , renderBackButton model
        ]]
        ++ (rendersuspectlist model)
        ++ ( elevatorQuestToSvg model )
        ++ (renderBagButton model))



axisHelper : Model -> Html Msg
axisHelper model =
    if gameMode______ /= Game then
        div []
            [ text (model.hero.x |> Debug.toString), br [] []
            , text (model.hero.y |> Debug.toString)
            ]
    else
    div [] []

renderMusic : Html Msg
renderMusic =
    div []
    [ div []
        [ Html.iframe
            [ src "./trigger.mp3"
            , autoplay True
            , style "display" "none"
            ] []
        ]
    , div []
        [ Html.audio
            [ id "player"
            , autoplay True
            , loop True
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
            [ style "position" "absolute"
            , style "left" "500px"
            , style "top" "350px"
            , style "font-family" "Helvetica, Arial, sans-serif"
            , style "font-size" "12px"
            , style "height" "30px"
            , style "width" "120px"
            , class "fill"
            , onClick ToPoliceOffice
            ]
            [ Html.text "Police Office" ]
            ,
            button
            [ style "position" "absolute"
            , style "left" "800px"
            , style "top" "200px"
            , style "font-family" "Helvetica, Arial, sans-serif"
            , style "font-size" "12px"
            , style "height" "30px"
            , style "width" "120px"
            , class "fill"
            , onClick ToPark
            ]
            [ Html.text "Park" ]
            ,
            button
            [ style "position" "absolute"
            , style "left" "350px"
            , style "top" "350px"
            , style "font-family" "Helvetica, Arial, sans-serif"
            , style "font-size" "12px"
            , style "height" "30px"
            , style "width" "120px"
            , class "fill"
            , onClick ToHome
            ]
            [ Html.text "Home1" ]
            ,
            button
            [ style "position" "absolute"
            , style "left" "200px"
            , style "top" "100px"
            , style "font-family" "Helvetica, Arial, sans-serif"
            , style "font-size" "12px"
            , style "height" "30px"
            , style "width" "120px"
            , class "fill"
            , onClick ToJournalist
            ]
            [ Html.text "Journalist's Home" ]
            ,
            button
            [ style "position" "absolute"
            , style "left" "320px"
            , style "top" "450px"
            , style "font-family" "Helvetica, Arial, sans-serif"
            , style "font-size" "12px"
            , style "height" "30px"
            , style "width" "120px"
            , class "fill"
            , onClick ToNightClub
            ]
            [ Html.text "NightClub" ]
            ,
            button
            [ style "position" "absolute"
            , style "left" "320px"
            , style "top" "450px"
            , style "font-family" "Helvetica, Arial, sans-serif"
            , style "font-size" "12px"
            , style "height" "30px"
            , style "width" "120px"
            , class "fill"
            , onClick ToDaniel
            ]
            [ Html.text "Daniel's home" ]


            ]

        EnergyDrain ->
            div []
             [
             button
             [ style "background" "red"
             , style "position" "absolute"
             , style "left" "500px"
             , style "top" "400px"
             , style "color" "#f3f2e9"
             , style "cursor" "pointer"
             , style "display" "block"
             , style "font-family" "Helvetica, Arial, sans-serif"
             , style "font-size" "18px"
             , style "font-weight" "300"
             , style "height" "80px"
             , style "line-height" "60px"
             , style "outline" "none"
             , style "padding" "0"
             , style "width" "130px"
             , style "border-style" "inset"
             , style "border-color" "white"
             , style "border-width" "6px"
             , style "border-radius" "20%"
             , onClick ToHome
             ]
             [ Html.text "Home" ]


                        ]

        _ ->
            div [] []



renderPic : Model -> Html Msg
renderPic model =
    svg
        [ width "1050"
        , height "700"
        , viewBox "0 0 1200 800"
        ]
        (
        [ Svg.defs [] [ Svg.radialGradient
            [ Svg.Attributes.id "hero-ball-maze"
            , Svg.Attributes.x1 "0", Svg.Attributes.x2 "0", Svg.Attributes.y1 "0", Svg.Attributes.y2 "1"]
            [ Svg.stop [ Svg.Attributes.offset "50%", Svg.Attributes.stopColor "white" ] []
            , Svg.stop [ Svg.Attributes.offset "100%", Svg.Attributes.stopColor "black" ] []
            ] ]
        ] ++
        (
        case model.map of
            PoliceOffice ->

                [Svg.image
                    [ xlinkHref "./police_office.png" -- I'll change all the maps into 1050*630... ——Lan Wang
                    , x "0"
                    , y "0"
                    , width "1200"
                    , height "600"
                    , transform "translate(-30,0)"
                    ] []]
                ++ npcListView model
                ++ ( heroToSvg model.hero )
                ++ [ renderdialog model ]
                ++ [ renderchoice model ]
                ++ [ renderportrait model ]
                ++ [ bedQuestToSvg model ]
                ++ energytosvg model.energy model.energy_Full

            Park ->

                [ Svg.image
                    [ xlinkHref "./park.png"
                    , x "0"
                    , y "0"
                    , width "1200"
                    , height "600"
                    , transform "translate(-30,0)" -- in this scale for a 2388*1688 picture, all things are favorable. But I still confused about this. So can anyone help? --zhouyuxiang 7/9
                    ] [] ]
                ++ ( heroToSvg model.hero )
                ++ npcListView model
                ++ [ renderdialog model ]
                ++ [ renderchoice model ]
                ++ [ renderportrait model ]
                ++ [ bedQuestToSvg model ]
                ++ energytosvg model.energy model.energy_Full

            Switching ->

                [ Svg.image
                    [ xlinkHref "./mapswitch.png"
                    , x "0"
                    , y "0"
                    , width "1200"
                    , height "600"
                    , transform "translate(-30,0)" -- in this scale for a 2388*1688 picture, all things are favorable. But I still confused about this. So can anyone help? --zhouyuxiang 7/9
                    ] [] ]
                ++ [ renderdialog model ]

            EnergyDrain ->

                [Svg.rect
                    [ x "0"
                    , y "0"
                    , width "1200"
                    , height "600"][]]
                ++ [ renderdialog model ]

            Home ->
                [Svg.image
                    [ xlinkHref "./Kay's_home.png"
                    , x "0"
                    , y "0"
                    , width "1200"
                    , height "600"
                    , transform "translate(-30,0)" -- in this scale for a 2388*1688 picture, all things are favorable. But I still confused about this. So can anyone help? --zhouyuxiang 7/9
                    ] []]
                ++ [renderdialog model]
                ++ [renderchoice model]
                ++ ( heroToSvg model.hero )
                ++ [renderportrait model]
                ++ [ bedQuestToSvg model ]
                ++ [ renderdialog model ]
                ++ energytosvg model.energy model.energy_Full


            DreamMaze ->
                [Svg.image
                    [ xlinkHref "./dream_maze_1.png"
                    , x "0"
                    , y "0"
                    , width "900"
                    , height "630"
                    , transform "translate(0,-20)" -- in this scale for a 2388*1688 picture, all things are favorable. But I still confused about this. So can anyone help? --zhouyuxiang 7/9
                    ] [] ]
                --++ heroToSvg model.hero
                ++ ( heroToSvgInMaze model.hero )
                ++ [ renderdialog model ]


            Journalist ->
                [ Svg.image
                    [ xlinkHref "./journalist's_home.png"
                    , x "0"
                    , y "0"
                    , width "1200"
                    , height "600"
                    , transform "translate(-30,0)" -- in this scale for a 2388*1688 picture, all things are favorable. But I still confused about this. So can anyone help? --zhouyuxiang 7/9
                    ] []]
                ++ npcListView model
                ++ ( heroToSvg model.hero )
                ++ [ renderdialog model ]
                ++ [ renderportrait model]
                ++ [ bedQuestToSvg model ]
                ++ [ renderdialog model ]
                ++ [ renderchoice model ]
                ++ energytosvg model.energy model.energy_Full


            NightClub ->
                [ Svg.image
                    [ xlinkHref "./nightclub.png"
                    , x "0"
                    , y "0"
                    , width "1200"
                    , height "600"
                    , transform "translate(-30,0)" -- in this scale for a 2388*1688 picture, all things are favorable. But I still confused about this. So can anyone help? --zhouyuxiang 7/9
                    ] []]
                ++ [renderdialog model]
                ++ [renderchoice model]
                ++ ( heroToSvg model.hero )
                ++ [renderportrait model]
                ++ [ bedQuestToSvg model ]
                ++ [ renderdialog model ]
                ++ energytosvg model.energy model.energy_Full


            Daniel ->
                [ Svg.image
                    [ xlinkHref "./Ann_and_Daniel's_home.png"
                    , x "0"
                    , y "0"
                    , width "1200"
                    , height "600"
                    , transform "translate(-30,0)" -- in this scale for a 2388*1688 picture, all things are favorable. But I still confused about this. So can anyone help? --zhouyuxiang 7/9
                    ] []]
                ++ [renderdialog model]
                ++ npcListView model
                ++ [renderchoice model]
                ++ ( heroToSvg model.hero )
                ++ [renderportrait model]
                ++ [ bedQuestToSvg model ]
                ++ [ renderdialog model ]
                ++ energytosvg model.energy model.energy_Full



            StarterPage ->
                [div [][]]

            Story ->
                [div [][]]

            AboutUs ->
                [div [][]]


        ) ++
        ( testToSvg model
        ++ itemsToSvg model
        ++ dayToSvg model )
        )

renderdialog : Model -> Svg Msg
renderdialog model =
    Svg.foreignObject [ x "200", y "630", width "1000", height "150"]
                      [ p [ style "flex" "1 1 auto", style "font-size" "1.4em", style "padding" "0 1em", Html.Attributes.class "inset" ]
                          [ text model.story ]
                      ]

renderchoice : Model -> Svg Msg
renderchoice model =
    let
        opacity =
            case (query "*.choices=1" model.worldModel) of
                [] -> "0"
                _ -> "1"
    in
        Svg.foreignObject [ x "350", y "200", width "500", height "100%", style "opacity" opacity ]
                          [ p [ style "flex" "1 1 auto", style "font-size" "1.4em", style "padding" "0 1em", Html.Attributes.class "inset" ]
                              [ul [] <| List.map entityViewchoices (query "*.choices=1" model.worldModel)]
                          ]

renderportrait : Model -> Svg Msg
renderportrait model =
    let
        portr =
            case model.portrait of
                "" ->
                    Svg.image [ Svg.Attributes.xlinkHref ("./player.png")
                              , x "10", y "640", width "140", height "140"
                              ] []
                _ ->
                    Svg.image [ Svg.Attributes.xlinkHref ("./"++model.portrait++".png")
                              , x "10", y "640", width "140", height "140"
                              ] []
    in
        portr

rendersuspectlist model =
    let
        suspect =
            case model.map of
                Park ->
                    [ button [ onClick Catherinecatch
                             , style "top" "100px", class "slide"
                             , style "opacity" (model.conclusion|>Debug.toString)] [text "Catherine"]
                    , button [ onClick Adkinscatch
                             , style "top" "200px", class "slide"
                             , style "opacity" (model.conclusion|>Debug.toString)] [text "Adkins"]
                    , button [ onClick Robbery
                             , style "top" "300px", class "slide"
                             , style "opacity" (model.conclusion|>Debug.toString)] [text "This is a robbery."]
                    ]
                _ ->
                    []
    in
        [Html.input [Html.Attributes.type_ "checkbox", id "menu"][]
        ,Html.label [Html.Attributes.for "menu", class "menu"][Html.span [] [], Html.span [] [], Html.span [] [] ]
        ,Html.nav [class "nav"] [div [class "container"]
                                     [div [ style "font-family" "Helvetica, Arial, sans-serif"
                                          , style "font-size" "18px"] suspect]]
        ]

renderBagButton : Model -> List(Html Msg)
renderBagButton model =
    let
        contants =
                        div []
                        [
                        button
                        [ onClick RenderGrid1Detail
                        , Html.Attributes.style "width" "60px"
                        , Html.Attributes.style "height" "60px"
                        , Html.Attributes.style "font-size" "18px"
                        , style "position" "absolute"
                        , style "top" "100px"
                        ] [ text model.bag.grid1.intro ],

                        button
                        [ onClick RenderGrid2Detail
                        , Html.Attributes.style "width" "60px"
                        , Html.Attributes.style "height" "60px"
                        , Html.Attributes.style "font-size" "18px"
                        , style "position" "absolute"
                        , style "top" "180px"
                        ] [ text model.bag.grid2.intro ],

                        button
                        [ onClick RenderGrid3Detail
                        , Html.Attributes.style "width" "60px"
                        , Html.Attributes.style "height" "60px"
                        , Html.Attributes.style "font-size" "18px"
                        , style "position" "absolute"
                        , style "top" "260px"
                        ] [ text model.bag.grid3.intro ],

                        button
                        [ onClick RenderGrid4Detail
                        , Html.Attributes.style "width" "60px"
                        , Html.Attributes.style "height" "60px"
                        , Html.Attributes.style "font-size" "18px"
                        , style "position" "absolute"
                        , style "top" "340px"
                        ] [ text model.bag.grid4.intro ],

                        button
                        [ onClick RenderGrid5Detail
                        , Html.Attributes.style "width" "60px"
                        , Html.Attributes.style "height" "60px"
                        , Html.Attributes.style "font-size" "18px"
                        , style "position" "absolute"
                        , style "top" "420px"
                        ] [ text model.bag.grid5.intro ],

                        button
                        [ onClick RenderGrid6Detail
                        , Html.Attributes.style "width" "60px"
                        , Html.Attributes.style "height" "60px"
                        , Html.Attributes.style "font-size" "18px"
                        , style "position" "absolute"
                        , style "left" "80px"
                        , style "top" "100px"
                        ] [ text model.bag.grid6.intro ],

                        button
                        [ onClick RenderGrid7Detail
                        , Html.Attributes.style "width" "60px"
                        , Html.Attributes.style "height" "60px"
                        , Html.Attributes.style "font-size" "18px"
                        , style "position" "absolute"
                        , style "left" "80px"
                        , style "top" "180px"
                        ] [ text model.bag.grid7.intro ],

                         button
                         [ onClick RenderGrid8Detail
                         , Html.Attributes.style "width" "60px"
                         , Html.Attributes.style "height" "60px"
                         , Html.Attributes.style "font-size" "18px"
                         , style "position" "absolute"
                         , style "left" "80px"
                         , style "top" "260px"
                         ] [ text model.bag.grid8.intro ],

                          button
                          [ onClick RenderGrid9Detail
                          , Html.Attributes.style "width" "60px"
                          , Html.Attributes.style "height" "60px"
                          , Html.Attributes.style "font-size" "18px"
                          , style "position" "absolute"
                          , style "left" "80px"
                          , style "top" "340px"
                          ] [ text model.bag.grid9.intro ],

                          button
                          [ onClick RenderGrid10Detail
                          , Html.Attributes.style "width" "60px"
                          , Html.Attributes.style "height" "60px"
                          , Html.Attributes.style "font-size" "18px"
                          , style "position" "absolute"
                          , style "left" "80px"
                          , style "top" "420px"
                          ] [ text model.bag.grid10.intro ]

                          ]
    in
        [Html.input [Html.Attributes.type_ "checkbox", id "menu2"][]
        ,Html.label [Html.Attributes.for "menu2", class "menu2"][Html.span [] [], Html.span [] [], Html.span [] [] ]
        ,Html.nav [class "nav2"] [div [class "container"]
                                      [div [ style "font-family" "Helvetica, Arial, sans-serif"
                                           , style "font-size" "18px"] [contants]]]
        ]




renderBag : Model -> Html Msg
renderBag model =
    case model.isBagOpen of
        False ->
            div[][]
        True ->
            div []
            [
            button
            [ onClick RenderGrid1Detail
            , Html.Attributes.style "width" "60px"
            , Html.Attributes.style "height" "60px"
            , Html.Attributes.style "font-size" "18px"
            , style "position" "absolute"
            , style "left" "100px"
            , style "top" "100px"
            ] [ text model.bag.grid1.intro ],

            button
            [ onClick RenderGrid2Detail
            , Html.Attributes.style "width" "60px"
            , Html.Attributes.style "height" "60px"
            , Html.Attributes.style "font-size" "18px"
            , style "position" "absolute"
            , style "left" "100px"
            , style "top" "180px"
            ] [ text model.bag.grid2.intro ],

            button
            [ onClick RenderGrid3Detail
            , Html.Attributes.style "width" "60px"
            , Html.Attributes.style "height" "60px"
            , Html.Attributes.style "font-size" "18px"
            , style "position" "absolute"
            , style "left" "100px"
            , style "top" "260px"
            ] [ text model.bag.grid3.intro ],

            button
            [ onClick RenderGrid4Detail
            , Html.Attributes.style "width" "60px"
            , Html.Attributes.style "height" "60px"
            , Html.Attributes.style "font-size" "18px"
            , style "position" "absolute"
            , style "left" "100px"
            , style "top" "340px"
            ] [ text model.bag.grid4.intro ],

            button
            [ onClick RenderGrid5Detail
            , Html.Attributes.style "width" "60px"
            , Html.Attributes.style "height" "60px"
            , Html.Attributes.style "font-size" "18px"
            , style "position" "absolute"
            , style "left" "100px"
            , style "top" "420px"
            ] [ text model.bag.grid5.intro ],

            button
            [ onClick RenderGrid6Detail
            , Html.Attributes.style "width" "60px"
            , Html.Attributes.style "height" "60px"
            , Html.Attributes.style "font-size" "18px"
            , style "position" "absolute"
            , style "left" "180px"
            , style "top" "100px"
            ] [ text model.bag.grid6.intro ],

            button
            [ onClick RenderGrid7Detail
            , Html.Attributes.style "width" "60px"
            , Html.Attributes.style "height" "60px"
            , Html.Attributes.style "font-size" "18px"
            , style "position" "absolute"
            , style "left" "180px"
            , style "top" "180px"
            ] [ text model.bag.grid7.intro ],

             button
             [ onClick RenderGrid8Detail
             , Html.Attributes.style "width" "60px"
             , Html.Attributes.style "height" "60px"
             , Html.Attributes.style "font-size" "18px"
             , style "position" "absolute"
             , style "left" "180px"
             , style "top" "260px"
             ] [ text model.bag.grid8.intro ],

              button
              [ onClick RenderGrid9Detail
              , Html.Attributes.style "width" "60px"
              , Html.Attributes.style "height" "60px"
              , Html.Attributes.style "font-size" "18px"
              , style "position" "absolute"
              , style "left" "180px"
              , style "top" "340px"
              ] [ text model.bag.grid9.intro ],

              button
              [ onClick RenderGrid10Detail
              , Html.Attributes.style "width" "60px"
              , Html.Attributes.style "height" "60px"
              , Html.Attributes.style "font-size" "18px"
              , style "position" "absolute"
              , style "left" "180px"
              , style "top" "420px"
              ] [ text model.bag.grid10.intro ]

              ]

renderGrid1Detail : Model -> Html Msg
renderGrid1Detail model =
    if model.whichGridIsOpen == 1 then
    div
      [ style "border-style" "inset"
      , style "border-color" "white"
      , style "border-width" "6px"
      , style "border-radius" "20%"
      , style "width" "500px"
      , style "height" "20px"
      , style "background-color" "white"
      , style "position" "absolute"
      , style "left" "300px"
      , style "top" "300px"
      , style "text-align" "center"
      , style "margin" "auto"
      , style "font-family" "Helvetica, Arial, sans-serif"
      , style "font-size" "18px"
      , style "font-weight" "300"
      ]
      [ Html.text ( "The information of this grid " )
    ]
    else
    div [][]

renderGrid2Detail : Model -> Html Msg
renderGrid2Detail model =
    if model.whichGridIsOpen == 2 then
    div
      [ style "border-style" "inset"
      , style "border-color" "white"
      , style "border-width" "6px"
      , style "border-radius" "20%"
      , style "width" "500px"
      , style "height" "20px"
      , style "background-color" "white"
      , style "position" "absolute"
      , style "left" "300px"
      , style "top" "300px"
      , style "text-align" "center"
      , style "margin" "auto"
      , style "font-family" "Helvetica, Arial, sans-serif"
      , style "font-size" "18px"
      , style "font-weight" "300"
      ]
      [ Html.text ( "The information of this grid " )
    ]
    else
    div [][]

renderGrid3Detail : Model -> Html Msg
renderGrid3Detail model=
    if model.whichGridIsOpen == 3 then
    div
      [ style "border-style" "inset"
      , style "border-color" "white"
      , style "border-width" "6px"
      , style "border-radius" "20%"
      , style "width" "500px"
      , style "height" "20px"
      , style "background-color" "white"
      , style "position" "absolute"
      , style "left" "300px"
      , style "top" "300px"
      , style "text-align" "center"
      , style "margin" "auto"
      , style "font-family" "Helvetica, Arial, sans-serif"
      , style "font-size" "18px"
      , style "font-weight" "300"
      ]
      [ Html.text ( "The information of this grid " )
    ]
    else
    div [][]

renderGrid4Detail : Model -> Html Msg
renderGrid4Detail model =
    if model.whichGridIsOpen == 4 then
    div
      [ style "border-style" "inset"
      , style "border-color" "white"
      , style "border-width" "6px"
      , style "border-radius" "20%"
      , style "width" "500px"
      , style "height" "20px"
      , style "background-color" "white"
      , style "position" "absolute"
      , style "left" "300px"
      , style "top" "300px"
      , style "text-align" "center"
      , style "margin" "auto"
      , style "font-family" "Helvetica, Arial, sans-serif"
      , style "font-size" "18px"
      , style "font-weight" "300"
      ]
      [ Html.text ( "The information of this grid " )
    ]
    else
    div [][]

renderGrid5Detail : Model -> Html Msg
renderGrid5Detail model =
    if model.whichGridIsOpen == 5 then
    div
      [ style "border-style" "inset"
      , style "border-color" "white"
      , style "border-width" "6px"
      , style "border-radius" "20%"
      , style "width" "500px"
      , style "height" "20px"
      , style "background-color" "white"
      , style "position" "absolute"
      , style "left" "300px"
      , style "top" "300px"
      , style "text-align" "center"
      , style "margin" "auto"
      , style "font-family" "Helvetica, Arial, sans-serif"
      , style "font-size" "18px"
      , style "font-weight" "300"
      ]
      [ Html.text ( "The information of this grid " )
    ]
    else
    div [][]

renderGrid6Detail : Model -> Html Msg
renderGrid6Detail model=
    if model.whichGridIsOpen == 6 then
    div
      [ style "border-style" "inset"
      , style "border-color" "white"
      , style "border-width" "6px"
      , style "border-radius" "20%"
      , style "width" "500px"
      , style "height" "20px"
      , style "background-color" "white"
      , style "position" "absolute"
      , style "left" "300px"
      , style "top" "300px"
      , style "text-align" "center"
      , style "margin" "auto"
      , style "font-family" "Helvetica, Arial, sans-serif"
      , style "font-size" "18px"
      , style "font-weight" "300"
      ]
      [ Html.text ( "The information of this grid " )
    ]
    else
    div [][]

renderGrid7Detail : Model -> Html Msg
renderGrid7Detail model=
    if model.whichGridIsOpen == 7 then
    div
      [ style "border-style" "inset"
      , style "border-color" "white"
      , style "border-width" "6px"
      , style "border-radius" "20%"
      , style "width" "500px"
      , style "height" "20px"
      , style "background-color" "white"
      , style "position" "absolute"
      , style "left" "300px"
      , style "top" "300px"
      , style "text-align" "center"
      , style "margin" "auto"
      , style "font-family" "Helvetica, Arial, sans-serif"
      , style "font-size" "18px"
      , style "font-weight" "300"
      ]
      [ Html.text ( "The information of this grid " )
    ]
    else
    div [][]

renderGrid8Detail : Model -> Html Msg
renderGrid8Detail model =
    if model.whichGridIsOpen == 8 then
    div
      [ style "border-style" "inset"
      , style "border-color" "white"
      , style "border-width" "6px"
      , style "border-radius" "20%"
      , style "width" "500px"
      , style "height" "20px"
      , style "background-color" "white"
      , style "position" "absolute"
      , style "left" "300px"
      , style "top" "300px"
      , style "text-align" "center"
      , style "margin" "auto"
      , style "font-family" "Helvetica, Arial, sans-serif"
      , style "font-size" "18px"
      , style "font-weight" "300"
      ]
      [ Html.text ( "The information of this grid " )
    ]
    else
    div [][]

renderGrid9Detail : Model -> Html Msg
renderGrid9Detail model=
    if model.whichGridIsOpen == 9 then
    div
      [ style "border-style" "inset"
      , style "border-color" "white"
      , style "border-width" "6px"
      , style "border-radius" "20%"
      , style "width" "500px"
      , style "height" "20px"
      , style "background-color" "white"
      , style "position" "absolute"
      , style "left" "300px"
      , style "top" "300px"
      , style "text-align" "center"
      , style "margin" "auto"
      , style "font-family" "Helvetica, Arial, sans-serif"
      , style "font-size" "18px"
      , style "font-weight" "300"
      ]
      [ Html.text ( "The information of this grid " )
    ]
    else
    div [][]

renderGrid10Detail : Model -> Html Msg
renderGrid10Detail model =
    if model.whichGridIsOpen == 10 then
    div
      [ style "border-style" "inset"
      , style "border-color" "white"
      , style "border-width" "6px"
      , style "border-radius" "20%"
      , style "width" "500px"
      , style "height" "20px"
      , style "background-color" "white"
      , style "position" "absolute"
      , style "left" "300px"
      , style "top" "300px"
      , style "text-align" "center"
      , style "margin" "auto"
      , style "font-family" "Helvetica, Arial, sans-serif"
      , style "font-size" "18px"
      , style "font-weight" "300"
      ]
      [ Html.text ( "The information of this grid " )
    ]
    else
    div [][]

renderStartButton : Model -> Html Msg
renderStartButton model =
    if model.map == StarterPage then
    button
        [ style "position" "absolute"
        , style "left" "500px"
        , style "top" "350px"
        , style "font-family" "Helvetica, Arial, sans-serif"
        , style "font-size" "18px"
        , style "font-weight" "300"
        , style "height" "60px"
        , style "line-height" "60px"
        , style "width" "130px"
        , class "fill"
        , onClick StartGame
        ]
        [ Html.text "Start" ]
    else
    div [][]

renderStoryButton : Model -> Html Msg
renderStoryButton model =
    if model.map == StarterPage then
    button
        [ style "position" "absolute"
        , style "left" "350px"
        , style "top" "350px"
        , style "font-family" "Helvetica, Arial, sans-serif"
        , style "font-size" "18px"
        , style "font-weight" "300"
        , style "height" "60px"
        , style "line-height" "60px"
        , style "width" "130px"
        , class "fill"
        , onClick ViewStory
        ]
        [ Html.text "Story" ]
    else
    div [][]

renderAboutUsButton : Model -> Html Msg
renderAboutUsButton model =
    if model.map == StarterPage then
    button
        [ style "position" "absolute"
        , style "left" "650px"
        , style "top" "350px"
        , style "font-family" "Helvetica, Arial, sans-serif"
        , style "font-size" "18px"
        , style "font-weight" "300"
        , style "height" "60px"
        , style "line-height" "60px"
        , style "width" "130px"
        , class "fill"
        , onClick ViewAboutUs
        ]
        [ Html.text "About us" ]
    else
    div [][]

renderBackButton : Model -> Html Msg
renderBackButton model =
    if model.map == Story || model.map == AboutUs then
    button
        [ style "position" "absolute"
        , style "left" "500px"
        , style "top" "350px"
        , style "font-family" "Helvetica, Arial, sans-serif"
        , style "font-size" "18px"
        , style "font-weight" "300"
        , style "height" "60px"
        , style "line-height" "60px"
        , style "width" "130px"
        , class "fill"
        , onClick BackToStarter
        ]
        [ Html.text "Back to Starter" ]
    else
    div [][]