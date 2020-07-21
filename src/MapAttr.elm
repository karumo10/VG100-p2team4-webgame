module MapAttr exposing (..)
import Areas exposing (..)
import Items exposing (..)

type Mode
    = CollisionTest
    | GettingCoordinates
    | Game
    | TotalTest
gameMode______ : Mode
gameMode______ = Game

type VehicleType
    = Elevator
    | Bed
    | Car
type Day
    = Day1
    | Day2
    | Day2_Finished
    | Day3
    | Nowhere
    | TooBigOrSmall

type alias Vehicle =
    { area : Area
    , which : VehicleType
    }
type alias MapAttr = -- things determined by map.
    { exit : Area
    , heroIni : Hero
    , barrier : List Area
    , hint : List Hint
    , vehicle : List Vehicle
    , story : String
    , scene : Scene
    , isFinished : Bool
    }
type alias Scene = ( Map, Day )
type alias Hero =
    { x : Int
    , y : Int
    , width : Float
    , height: Float
    }
type alias Hint =
    { area : Area
    , content : String
    }

policeOfficeBarrier : List Area
policeOfficeBarrier =
    case gameMode______ of
        GettingCoordinates ->
            [ ]
        _ -> policeBarrierList

homeBarrier : List Area
homeBarrier =
    case gameMode______ of
        GettingCoordinates ->
            [ ]
        _ -> homeBarrierList

journalistBarrier : List Area
journalistBarrier =
    case gameMode______ of
        GettingCoordinates ->
            [ ]
        _ -> journalistBarrierList


maze1Barrier : List Area
maze1Barrier =
    case gameMode______ of
        GettingCoordinates ->
            [ ]
        _ -> mazeList

nightClubBarrier : List Area
nightClubBarrier =
    case gameMode______ of
        GettingCoordinates ->
            [ ]
        _ -> nightClubBarrierList

policeOfficeVehicle : List Vehicle
policeOfficeVehicle =
    [ { area = { x = 820, y = 430, wid = 115, hei = 110 }, which = Elevator }
    , { area = { x = 835, y = 195, wid = 100, hei = 110 }, which = Elevator }
    , { area = { x = 820, y = 0, wid = 115, hei = 85 }, which = Elevator } ]

homeVehicle : List Vehicle
homeVehicle =
    [ { area = { x = 1050, y = 430, wid = 115, hei = 110 }, which = Elevator }
    , { area = { x = 1065, y = 195, wid = 100, hei = 110 }, which = Elevator }
    , { area = { x = 1050, y = 80, wid = 115, hei = 85 }, which = Elevator }
    , { area = { x = 855, y = 65, wid = 55, hei = 85 }, which = Bed } ]

nightClubVehicle : List Vehicle
nightClubVehicle =
    [ { area = { x = 1050, y = 430, wid = 115, hei = 110 }, which = Elevator }
    , { area = { x = 1050, y = 195, wid = 100, hei = 110 }, which = Elevator } ]

hintsMaze1 : List Hint
hintsMaze1 =
    [ { area = { x = 185, y = 135, wid = 20, hei = 20 }, content = "hint1" }
    , { area = { x = 360, y = 320, wid = 20, hei = 20 }, content = "hint2" }
    , { area = { x = 360, y = 435, wid = 20, hei = 20 }, content = "hint3" }
    , { area = { x = 530, y = 240, wid = 20, hei = 20 }, content = "hint4" } ]

hintsMaze2 : List Hint
hintsMaze2 =
    [ { area = { x = 185, y = 135, wid = 20, hei = 20 }, content = "...It's quite interesting: now, you are me, I am you... You know that Jonathon is a bad guy as you write it in your novel? Even more interesting..." }
    , { area = { x = 360, y = 320, wid = 20, hei = 20 }, content = "Ah, it seems that you have lost some memory, my friends. I can tell you something. It's quite weird that the day we planned to meet in the office, I was called to help inspect a night club. Do you think so? Who will inspect a night club at morning?..." }
    , { area = { x = 360, y = 435, wid = 20, hei = 20 }, content = "The suicide case? Oh, I have gone to the scene, too. But I don’t know which evidence you take in \"your\" home. They are both useful but you should pay attention how to use them properly, my dear friend..." }
    , { area = { x = 530, y = 240, wid = 20, hei = 20 }, content = "...Listen! What is whirring and whizzing? Double, double! Toil and trouble; fire burn and cauldron bubble! ..." } ]




policeOfficeAttr_day1 : MapAttr
policeOfficeAttr_day1 =
    { exit = { x = 165, y = 480 , wid = 70, hei = 120 }
    , heroIni = { x = 300, y = 520, width = 20, height = 60 }
    , barrier = policeOfficeBarrier
    , hint = []
    , vehicle = policeOfficeVehicle
    , story = "Another day at work, another boring day. But I need to avoid being killed."
    , scene = ( PoliceOffice, Day1 )
    , isFinished = False
    }

policeOfficeAttr_day2 : MapAttr
policeOfficeAttr_day2 =
    { exit = { x = 165, y = 480 , wid = 70, hei = 120 }
    , heroIni = { x = 300, y = 520, width = 20, height = 60 }
    , barrier = policeOfficeBarrier
    , hint = []
    , vehicle = policeOfficeVehicle
    , story = "Another day at work, another boring day. But I need to avoid being killed."
    , scene = ( PoliceOffice, Day2 )
    , isFinished = False
    }
policeOfficeAttr_day2_finished : MapAttr
policeOfficeAttr_day2_finished =
    { exit = { x = 165, y = 480 , wid = 70, hei = 120 }
    , heroIni = { x = 300, y = 520, width = 20, height = 60 }
    , barrier = policeOfficeBarrier
    , hint = []
    , vehicle = policeOfficeVehicle
    , story = "I'm back to the police office."
    , scene = ( PoliceOffice, Day2_Finished )
    , isFinished = False -- this map is not finished
    }

parkAttr_day1 : MapAttr
parkAttr_day1 =
    { exit = { x = 915, y = 190 , wid = 225, hei = 75 }
    , heroIni = { x = 500, y = 250, width = 50, height = 180 }
    , barrier = []
    , hint = []
    , vehicle = []
    , story = "I arrive at the park. This is a desolate place."
    , scene = ( Park, Day1 )
    , isFinished = False
    }

parkAttr_day2 : MapAttr
parkAttr_day2 =
    { exit = { x = 915, y = 190 , wid = 225, hei = 75 }
    , heroIni = { x = 500, y = 250, width = 50, height = 180 }
    , barrier = []
    , hint = []
    , vehicle = []
    , story = "I arrive at the park. This is a desolate place."
    , scene = ( Park, Day2 )
    , isFinished = False
    }


homeAttr_day1 : MapAttr
homeAttr_day1 =
    { exit = { x = 610, y = 450 , wid = 20, hei = 150 }
    , heroIni = { x = 665, y = 520, width = 20, height = 60 }
    , barrier = homeBarrier
    , hint = []
    , vehicle = homeVehicle
    , story = "Home, sweet home."
    , scene = ( Home, Day1 )
    , isFinished = False

    }

homeAttr_day2 : MapAttr
homeAttr_day2 =
    { exit = { x = 610, y = 450 , wid = 20, hei = 150 }
    , heroIni = { x = 665, y = 520, width = 20, height = 60 }
    , barrier = homeBarrier
    , hint = []
    , vehicle = homeVehicle
    , story = "Home, sweet home."
    , scene = ( Home, Day2 )
    , isFinished = False
    }

homeAttr_day2_finished : MapAttr
homeAttr_day2_finished =
    { exit = { x = 610, y = 450 , wid = 20, hei = 150 }
    , heroIni = { x = 665, y = 520, width = 20, height = 60 }
    , barrier = homeBarrier
    , hint = []
    , vehicle = homeVehicle
    , story = "What a tired day!"
    , scene = ( Home, Day2_Finished )
    , isFinished = False
    }

journalistAttr_day1 : MapAttr
journalistAttr_day1 =
    { exit = { x = 130, y = 205 , wid = 20, hei = 250 }
    , heroIni = { x = 205, y = 335, width = 60, height = 180 }
    , barrier = journalistBarrier
    , hint = []
    , vehicle = []
    , story = "Nasty Smell... How long hasn't this guy cleaned his home?"
    , scene = ( Journalist, Day1 )
    , isFinished = False

    }


journalistAttr_day2 : MapAttr
journalistAttr_day2 =
    { exit = { x = 130, y = 205 , wid = 20, hei = 250 }
    , heroIni = { x = 205, y = 335, width = 60, height = 180 }
    , barrier = journalistBarrier
    , hint = []
    , vehicle = []
    , story = "Nasty Smell... How long hasn't this guy cleaned his home?"
    , scene = ( Journalist, Day2 )
    , isFinished = False

    }

nightClubAttr_day1 : MapAttr
nightClubAttr_day1 =
    { exit = { x = 125, y = 385 , wid = 20, hei = 215  }
    , heroIni = { x = 150, y = 475, width = 40, height = 120 }
    , barrier = nightClubBarrier
    , hint = []
    , vehicle = nightClubVehicle
    , story = "It's the place where lust and alcoholism intertwined."
    , scene = ( NightClub, Day1 )
    , isFinished = False
    }

nightClubAttr_day2 : MapAttr
nightClubAttr_day2 =
    { exit = { x = 125, y = 385 , wid = 20, hei = 215  }
    , heroIni = { x = 150, y = 475, width = 40, height = 120 }
    , barrier = nightClubBarrier
    , hint = []
    , vehicle = nightClubVehicle
    , story = "It's the place where lust and alcoholism intertwined."
    , scene = ( NightClub, Day2 )
    , isFinished = False
    }

nightClubAttr_day3 : MapAttr
nightClubAttr_day3 =
    { exit = { x = 125, y = 385 , wid = 20, hei = 215  }
    , heroIni = { x = 150, y = 475, width = 40, height = 120 }
    , barrier = nightClubBarrier
    , hint = []
    , vehicle = nightClubVehicle
    , story = "It's the place where lust and alcoholism intertwined; but now only sin reigns."
    , scene = ( NightClub, Day3 )
    , isFinished = False
    }





--energyDrainAttr : MapAttr
--energyDrainAttr =
--    { exit = { x = 0, y = 0 , wid = 0, hei = 0 }
--    , heroIni = { x = 6000, y = 6000, width = 20, height = 60 }
--    , barrier = []
--    , hint = []
--    , vehicle = []
--    , story = "I'm tired...all I desire is somewhere to take a nap."
--    , scene = ( Switching, Nowhere )
--    , isFinished = False
--
--    }



dreamMazeAttr_day1 : MapAttr
dreamMazeAttr_day1 =
    { exit = { x = 470, y = 575 , wid = 20, hei = 20 }
    , heroIni = { x = 415 , y = 15, width = 20, height = 20 } --judge box
    , barrier = maze1Barrier
    , hint = hintsMaze1
    , vehicle = []
    , story = "Where is here...?"
    , scene = ( DreamMaze, Day1 )
    , isFinished = False
    }

dreamMazeAttr_day2 : MapAttr
dreamMazeAttr_day2 =
    { exit = { x = 470, y = 575 , wid = 20, hei = 20 }
    , heroIni = { x = 415 , y = 15, width = 20, height = 20 } --judge box
    , barrier = maze1Barrier
    , hint = hintsMaze1
    , vehicle = []
    , story = "Maze again? Really odd... "
    , scene = ( DreamMaze, Day2 )
    , isFinished = False
    }

dreamMazeAttr_day2_finished : MapAttr
dreamMazeAttr_day2_finished =
    { exit = { x = 470, y = 575 , wid = 20, hei = 20 }
    , heroIni = { x = 415 , y = 15, width = 20, height = 20 } --judge box
    , barrier = maze1Barrier
    , hint = hintsMaze2
    , vehicle = []
    , story = "Maze again? Really odd... "
    , scene = ( DreamMaze, Day2_Finished )
    , isFinished = False
    }


switchingAttr : MapAttr
switchingAttr =
    { exit = { x = 0, y = 0 , wid = 0, hei = 0 }
    , heroIni = { x = 6000, y = 6000, width = 20, height = 60 }
    , barrier = []
    , hint = []
    , vehicle = []
    , story = "Where to go?"
    , scene = ( Switching, Nowhere )
    , isFinished = False

    }


