module Areas exposing (..)

type alias Area =
    { x : Float
    , y : Float
    , wid : Float
    , hei : Float
    } -- a general type for object interaction (like, with door, so you can exit the police office)

homeBarrierList : List Area
homeBarrierList =
            [ { x = 555, y = 490 , wid = 575, hei = 20 } -- f1.ceiling (every floor 230)
            , { x = 690, y = 500, wid = 120, hei = 20 } -- f1.sofa
            , { x = 850, y = 500, wid = 90, hei = 20 } -- f1.tv
            , { x = 470, y = 260 , wid = 650, hei = 20 } -- f2.ceiling
            , { x = 530, y = 60 , wid = 610, hei = 20 } -- f3.ceiling
            , { x = 740, y = 270 , wid = 30, hei = 20 } -- f2.washroom.door
            , { x = 965, y = 510 , wid = 30, hei = 20 } -- f1.door
            , { x = 470, y = 300, wid = 30, hei = 20} -- f2.bookshelf.left
            , { x = 615, y = 270, wid = 105, hei = 20 } -- f2.washroom.stuffs
            , { x = 800, y = 270, wid = 125, hei = 20 } -- f2.desk.chair
            , { x = 595, y = 280, wid = 20 , hei = 80 } -- f2.bathtub
            , { x = 500, y = 275, wid = 50, hei = 20} --f2.left corner
            , { x = 840, y = 75, wid = 35, hei = 20 } --f3.bedside lap
            , { x = 820, y = 80, wid = 20, hei = 80 } -- f3.bedwall
            , { x = 915, y = 75, wid = 95, hei = 20 } -- f3.shelf
            , { x = 1090, y = 520 , wid = 20, hei = 80 } -- f1.right wall
            , { x = 1085, y = 280 , wid = 20, hei = 80 } -- f2.right wall
            , { x = 1070, y = 80 , wid = 20, hei = 80 } -- f3.right wall
            , { x = 450, y = 420 , wid = 20, hei = 180 } -- f1.left wall
            , { x = 450, y = 190 , wid = 20, hei = 180 } -- f2.left wall
            , { x = 450, y = -25 , wid = 20, hei = 180 } -- f3.left wall
            , { x = 470, y = 600 , wid = 660, hei = 20 } -- f1.floor
            , { x = 470, y = 360 , wid = 660, hei = 20 } -- f2.floor
            , { x = 470, y = 160 , wid = 660, hei = 20 } -- f3.floor
            ]
policeBarrierList : List Area
policeBarrierList =
            [ { x = 205, y = 485 , wid = 755, hei = 20 } -- f1.ceiling (every floor 230)
            , { x = 205, y = 260 , wid = 755, hei = 20 } -- f2.ceiling
            , { x = 205, y = 40 , wid = 755, hei = 20 } -- f3.ceiling
            , { x = 395, y = 500 , wid = 145, hei = 30 } -- f1.reception desk
            , { x = 310, y = 275 , wid = 135, hei = 20 } -- f2.left desk
            , { x = 500, y = 275 , wid = 135, hei = 20 } -- f2.right desk
            , { x = 695, y = 275 , wid = 30, hei = 20 } -- f2.elevator wall
            , { x = 205, y = 275, wid = 75, hei = 20 } -- f2.bookshelf.up
            , { x = 205, y = 300, wid = 60, hei = 20} -- f2.bookshelf.left
            , { x = 205, y = 500, wid = 75, hei = 20 } -- f1.bookshelf.up
            --, { x = 205, y = 525, wid = 60, hei = 20} -- f1.bookshelf.left
            , { x = 205, y = 60, wid = 75, hei = 20 } -- f3.bookshelf.up
            , { x = 205, y = 85, wid = 60, hei = 20} -- f3.bookshelf.left
            , { x = 960, y = 420 , wid = 20, hei = 180 } -- f1.right wall
            , { x = 960, y = 190 , wid = 20, hei = 180 } -- f2.right wall
            , { x = 960, y = -40 , wid = 20, hei = 180 } -- f3.right wall
            , { x = 185, y = 420 , wid = 20, hei = 180 } -- f1.left wall
            , { x = 185, y = 190 , wid = 20, hei = 180 } -- f2.left wall
            , { x = 185, y = -40 , wid = 20, hei = 180 } -- f3.left wall
            , { x = 205, y = 595 , wid = 755, hei = 20 } -- f1.floor
            , { x = 205, y = 360 , wid = 755, hei = 20 } -- f2.floor
            , { x = 205, y = 150 , wid = 755, hei = 20 } -- f3.floor
            ]



type alias PreArea = -- for maze
    { x : Int
    , y : Int
    , l : Int
    }

columnsMaze1 : List PreArea
columnsMaze1 =
    [ { x = 0, y = 0, l = 10 }, { x = 1, y = 1, l = 2 }
    , { x = 1, y = 8, l = 2 }, { x = 2, y = 0, l = 1 }
    , { x = 2, y = 3, l = 3 }, { x = 2, y = 7, l = 2 }
    , { x = 3, y = 2, l = 3 }, { x = 3, y = 6, l = 4 }
    , { x = 4, y = 0, l = 1 }, { x = 4, y = 5, l = 1 }
    , { x = 4, y = 8, l = 1 }, { x = 5, y = 0, l = 1 }
    , { x = 5, y = 2, l = 2 }, { x = 5, y = 5, l = 2 }
    , { x = 6, y = 4, l = 1 }, { x = 6, y = 7, l = 1 }
    , { x = 6, y = 9, l = 1 }, { x = 7, y = 1, l = 3 }
    , { x = 7, y = 5, l = 2 }, { x = 8, y = 3, l = 3 }
    , { x = 8, y = 7, l = 1 }, { x = 8, y = 9, l = 1 }
    , { x = 9, y = 2, l = 3 }, { x = 9, y = 6, l = 1 }
    , { x = 9, y = 8, l = 1 }, { x = 10, y = 0, l = 10 }
    ]

rowsMaze1 : List PreArea
rowsMaze1 =
    [ { x = 0, y = 0, l = 4 }, { x = 0, y = 4, l = 1 }
    , { x = 0, y = 6, l = 1 }, { x = 0, y = 7, l = 2 }
    , { x = 0, y = 10, l = 5 }, { x = 1, y = 2, l = 3 }
    , { x = 1, y = 5, l = 1 }, { x = 2, y = 1, l = 1 }
    , { x = 2, y = 6, l = 1 }, { x = 3, y = 4, l = 3 }
    , { x = 3, y = 7, l = 2 }, { x = 4, y = 3, l = 1 }
    , { x = 4, y = 5, l = 1 }, { x = 4, y = 8, l = 2 }
    , { x = 4, y = 9, l = 3 }, { x = 5, y = 2, l = 1 }
    , { x = 5, y = 6, l = 1 }, { x = 6, y = 1, l = 4 }
    , { x = 6, y = 3, l = 1 }, { x = 6, y = 5, l = 1 }
    , { x = 6, y = 7, l = 2 }, { x = 6, y = 10, l = 4 }
    , { x = 7, y = 4, l = 1 }, { x = 7, y = 8, l = 1 }
    , { x = 8, y = 2, l = 1 }, { x = 8, y = 6, l = 1 }
    , { x = 9, y = 5, l = 1 }, { x = 9, y = 8, l = 1 }
    , { x = 5, y = 0, l = 5 }
    ]


columnToArea : PreArea -> Area
columnToArea pre =
    let
        x = 170 + 57 * pre.x
        y = 10 + 57 * pre.y
        wid = 5
        hei = 57 * pre.l
    in
    { x = toFloat x, y = toFloat y, wid = toFloat wid, hei = toFloat hei }

rowToArea : PreArea -> Area
rowToArea pre =
    let
        x = 170 + 57 * pre.x
        y = 10 + 57 * pre.y
        wid = 57 * pre.l
        hei = 5
    in
    { x = toFloat x, y = toFloat y, wid = toFloat wid, hei = toFloat hei }

columnsToAreasMaze : List PreArea -> List Area
columnsToAreasMaze prelist =
    List.map columnToArea prelist

rowsToAreasMaze : List PreArea -> List Area
rowsToAreasMaze prelist =
    List.map rowToArea prelist

mazeList : List Area
mazeList =
    columnsToAreasMaze columnsMaze1 ++ rowsToAreasMaze rowsMaze1


