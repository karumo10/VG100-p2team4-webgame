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
    | Day2_Night
    | Day3
    | Day4
    | Day5
    | Day6
    | Day7
    | Day8
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

parkBarrier : List Area
parkBarrier =
    case gameMode______ of
        GettingCoordinates ->
            [ ]
        _ -> parkBarrierList

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

danielBarrier : List Area
danielBarrier =
    case gameMode______ of
        GettingCoordinates ->
            [ ]
        _ -> danielList



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

danielVehicle : List Vehicle
danielVehicle =
     [ { area = { x = 920, y = 430, wid = 115, hei = 110 }, which = Elevator }
     , { area = { x = 920, y = 195, wid = 100, hei = 110 }, which = Elevator } ]



hintsMaze1 : List Hint
hintsMaze1 =
    [ { area = { x = 185 + 135, y = 135, wid = 20, hei = 20 }, content = "...haven't finished...report...no evidence..." }
    , { area = { x = 360 + 135, y = 320, wid = 20, hei = 20 }, content = "There's still an interview..." }
    , { area = { x = 360 + 135, y = 435, wid = 20, hei = 20 }, content = "Be careful! Be careful! Be careful...Jonathon..." }
    , { area = { x = 530 + 135, y = 240, wid = 20, hei = 20 }, content = "...Jonathon...kill...not Kay...it's you..." } ]

hintsMaze2 : List Hint
hintsMaze2 =
    [ { area = { x = 185 + 135, y = 135, wid = 20, hei = 20 }, content = "...It's quite interesting: now, you are me, I am you... You know that Jonathon is a bad guy as you write it in your novel? Even more interesting..." }
    , { area = { x = 360 + 135, y = 320, wid = 20, hei = 20 }, content = "Ah, it seems that you have lost some memory, my friends. I can tell you something. It's quite weird that the day we planned to meet in the office, I was called to help inspect a night club. Do you think so? Who will inspect a night club at morning?..." }
    , { area = { x = 360 + 135, y = 435, wid = 20, hei = 20 }, content = "The suicide case? Oh, I have gone to the scene, too. But I don't know which evidence you take in \"your\" home. They are both useful but you should pay attention how to use them properly, my dear friend..." }
    , { area = { x = 530 + 135, y = 240, wid = 20, hei = 20 }, content = "...Listen! What is whirring and whizzing? Double, double! Toil and trouble; fire burn and cauldron bubble! ..." } ]

hintsMaze3 : List Hint
hintsMaze3 =
    [ { area = { x = 185 + 135, y = 135, wid = 20, hei = 20 }, content = "Nice to see a new friend join our chat at night. Oh, our new friend seems to be in great pain and guilt. Ha, it's normal to be painful because of the death of family member but the guilty is quite interesting. Do you think so, my lucky, Yuuki?"}
    , { area = { x = 360 + 135, y = 320, wid = 20, hei = 20 }, content = "It's fake. It's fake. It's fake. I had no choice to do. Forgive me. Forgive me. Forgive me. The key evidence will be destroyed tomorrow at a very early time. Please do save it." }
    , { area = { x = 360 + 135, y = 435, wid = 20, hei = 20 }, content = "How stupid our boss is? Too obvious intention!" }
    , { area = { x = 530 + 135, y = 240, wid = 20, hei = 20 }, content = "Be careful, Yuuki. Jonathon seems to be impatient... Don't behave too aggressive." } ]

hintsMaze4 : List Hint
hintsMaze4 =
    [ { area = { x = 185 + 135, y = 135, wid = 20, hei = 20 }, content = "Do you think that, this sudden vacation is quite weird?" }
    , { area = { x = 360 + 135, y = 320, wid = 20, hei = 20 }, content = "Do you think that, some things collecting in this \"sudden\" inspection are like traps?" }
    , { area = { x = 360 + 135, y = 435, wid = 20, hei = 20 }, content = "Do you think that, it's dangerous to possess a key with no knowledge of what it will unlock?" }
    , { area = { x = 530 + 135, y = 240, wid = 20, hei = 20 }, content = "To be, or not to be: that is the question,\nWhether it's nobler in the mind to suffer\nThe slings and arrows of outrageous fortune,\nOr to take arms against a sea of troubles, and by opposing end them." } ]

hintsMaze5 : List Hint
hintsMaze5 =
    [ { area = { x = 185 + 135, y = 135, wid = 20, hei = 20 }, content = "" }
    , { area = { x = 360 + 135, y = 320, wid = 20, hei = 20 }, content = "" }
    , { area = { x = 360 + 135, y = 435, wid = 20, hei = 20 }, content = "" }
    , { area = { x = 530 + 135, y = 240, wid = 20, hei = 20 }, content = "" } ]

hintsMaze6 : List Hint
hintsMaze6 =
    [ { area = { x = 185 + 135, y = 135, wid = 20, hei = 20 }, content = "It can be seen that Jonathon cannot wait to address you..." }
    , { area = { x = 360 + 135, y = 320, wid = 20, hei = 20 }, content = "Yukki, you have made a lot of effort. But there exists little time now..." }
    , { area = { x = 360 + 135, y = 435, wid = 20, hei = 20 }, content = "Tomorrow will be the last chance, Yuuki. You should take some risks." }
    , { area = { x = 530 + 135, y = 240, wid = 20, hei = 20 }, content = "It never occurs to me that Jonathon will love someone. HaHaHa!" } ]

hintsMaze7 : List Hint
hintsMaze7 =
    [ { area = { x = 185 + 135, y = 135, wid = 20, hei = 20 }, content = "Now the story has come to the end. What will happen tomorrow? I'm looking forward to it." }
    , { area = { x = 360 + 135, y = 320, wid = 20, hei = 20 }, content = "Thinking about the relationship between each pieces of evidence before you go to the city council tomorrow, my friend." }
    , { area = { x = 360 + 135, y = 435, wid = 20, hei = 20 }, content = "Pay attention that Jonathon has an armed team. If you don't overwhelmingly beat him in the city council. It's hard to imagine what will happen." }
    , { area = { x = 530 + 135, y = 240, wid = 20, hei = 20 }, content = "Out, out, brief candle!...\nLife s but a walking shadow，a poor player\nThat struts and frets his hour upon the stage\nAnd then is heard no more." } ]


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

policeOfficeAttr_day2_night : MapAttr
policeOfficeAttr_day2_night =
    { exit = { x = 165, y = 480 , wid = 70, hei = 120 }
    , heroIni = { x = 300, y = 520, width = 20, height = 60 }
    , barrier = policeOfficeBarrier
    , hint = []
    , vehicle = policeOfficeVehicle
    , story = "Another day at work, another boring day. But I need to avoid being killed."
    , scene = ( PoliceOffice, Day2_Night )
    , isFinished = False
    }

policeOfficeAttr_day3 : MapAttr
policeOfficeAttr_day3 =
    { exit = { x = 165, y = 480 , wid = 70, hei = 120 }
    , heroIni = { x = 300, y = 520, width = 20, height = 60 }
    , barrier = policeOfficeBarrier
    , hint = []
    , vehicle = policeOfficeVehicle
    , story = "Another day at work, another boring day. But I need to avoid being killed."
    , scene = ( PoliceOffice, Day3 )
    , isFinished = False
    }

policeOfficeAttr_day4 : MapAttr
policeOfficeAttr_day4 =
    { exit = { x = 165, y = 480 , wid = 70, hei = 120 }
    , heroIni = { x = 300, y = 520, width = 20, height = 60 }
    , barrier = policeOfficeBarrier
    , hint = []
    , vehicle = policeOfficeVehicle
    , story = "Another day at work, another boring day. But I need to avoid being killed."
    , scene = ( PoliceOffice, Day4 )
    , isFinished = False
    }

policeOfficeAttr_day5 : MapAttr
policeOfficeAttr_day5 =
    { exit = { x = 165, y = 480 , wid = 70, hei = 120 }
    , heroIni = { x = 300, y = 520, width = 20, height = 60 }
    , barrier = policeOfficeBarrier
    , hint = []
    , vehicle = policeOfficeVehicle
    , story = "There is no one in the police office tonight. It's quite weird. But at the same time, it is the best time to have a deeper investigation of Jonathon's office."
    , scene = ( PoliceOffice, Day5 )
    , isFinished = False
    }

policeOfficeAttr_day6 : MapAttr
policeOfficeAttr_day6 =
    { exit = { x = 165, y = 480 , wid = 70, hei = 120 }
    , heroIni = { x = 300, y = 520, width = 20, height = 60 }
    , barrier = policeOfficeBarrier
    , hint = []
    , vehicle = policeOfficeVehicle
    , story = ""
    , scene = ( PoliceOffice, Day6 )
    , isFinished = False
    }

policeOfficeAttr_day7 : MapAttr
policeOfficeAttr_day7 =
    { exit = { x = 165, y = 480 , wid = 70, hei = 120 }
    , heroIni = { x = 300, y = 520, width = 20, height = 60 }
    , barrier = policeOfficeBarrier
    , hint = []
    , vehicle = policeOfficeVehicle
    , story = "It's so lucky that tonight, no one is at the police office again."
    , scene = ( PoliceOffice, Day7 )
    , isFinished = False
    }


parkAttr_day1 : MapAttr
parkAttr_day1 =
    { exit = { x = 915, y = 190 , wid = 225, hei = 75 }
    , heroIni = { x = 500, y = 250, width = 50, height = 180 }
    , barrier = parkBarrier
    , hint = []
    , vehicle = []
    , story = "I arrive at the park. This is a desolate place. \n \n \n \n \n Tutorial: Talk with Lee. He seems to need your help."
    , scene = ( Park, Day1 )
    , isFinished = False
    }

parkAttr_day2 : MapAttr
parkAttr_day2 =
    { exit = { x = 915, y = 190 , wid = 225, hei = 75 }
    , heroIni = { x = 500, y = 250, width = 50, height = 180 }
    , barrier = parkBarrier
    , hint = []
    , vehicle = []
    , story = "The park, where a promising man was killed. May him rest in peace..."
    , scene = ( Park, Day2 )
    , isFinished = False
    }

parkAttr_day2_finished : MapAttr
parkAttr_day2_finished =
    { exit = { x = 915, y = 190 , wid = 225, hei = 75 }
    , heroIni = { x = 500, y = 250, width = 50, height = 180 }
    , barrier = parkBarrier
    , hint = []
    , vehicle = []
    , story = "The park, where a promising man was killed. May him rest in peace..."
    , scene = ( Park, Day2_Finished )
    , isFinished = False
    }

parkAttr_day2_night : MapAttr
parkAttr_day2_night =
    { exit = { x = 915, y = 190 , wid = 225, hei = 75 }
    , heroIni = { x = 500, y = 250, width = 50, height = 180 }
    , barrier = parkBarrier
    , hint = []
    , vehicle = []
    , story = "It's pitch black here now. Everything is hiding behind the mist."
    , scene = ( Park, Day2_Night )
    , isFinished = False
    }

parkAttr_day3 : MapAttr
parkAttr_day3 =
    { exit = { x = 915, y = 190 , wid = 225, hei = 75 }
    , heroIni = { x = 500, y = 250, width = 50, height = 180 }
    , barrier = parkBarrier
    , hint = []
    , vehicle = []
    , story = "The park, where a promising man was killed. May him rest in peace..."
    , scene = ( Park, Day3 )
    , isFinished = False
    }

parkAttr_day4 : MapAttr
parkAttr_day4 =
    { exit = { x = 915, y = 190 , wid = 225, hei = 75 }
    , heroIni = { x = 500, y = 250, width = 50, height = 180 }
    , barrier = []
    , hint = []
    , vehicle = []
    , story = "The park, where a promising man was killed. May him rest in peace..."
    , scene = ( Park, Day4 )
    , isFinished = False
    }

parkAttr_day5 : MapAttr
parkAttr_day5 =
    { exit = { x = 5000, y = 5000 , wid = 1, hei = 1 }
    , heroIni = { x = 5000, y = 0, width = 50, height = 180 }
    , barrier = []
    , hint = []
    , vehicle = []
    , story = "The park is in darkness this night. And you see a crowd wearing weird uniforms are wandering. Do you still want to enter? Press X to do your choice! Hint: Police is not allowed to be equipped with a gun during vacation."
    , scene = ( Park, Day5 )
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
    , story = "$my$own$error$msg$ : You are not supposed to appear here. You are expected to be at the police office. Please contact with developer Yuxiang Zhou from Group 4."
    , scene = ( Home, Day2_Finished )
    , isFinished = False
    }


homeAttr_day2_night : MapAttr
homeAttr_day2_night =
    { exit = { x = 610, y = 450 , wid = 20, hei = 150 }
    , heroIni = { x = 665, y = 520, width = 20, height = 60 }
    , barrier = homeBarrier
    , hint = []
    , vehicle = homeVehicle
    , story = "Home, sweet home."
    , scene = ( Home, Day2_Night )
    , isFinished = False
    }

homeAttr_day3 : MapAttr
homeAttr_day3 =
    { exit = { x = 610, y = 450 , wid = 20, hei = 150 }
    , heroIni = { x = 665, y = 520, width = 20, height = 60 }
    , barrier = homeBarrier
    , hint = []
    , vehicle = homeVehicle
    , story = "You are woken up by the ringing of your phone. Press X to pick up it! "
    , scene = ( Home, Day3 )
    , isFinished = False
    }

homeAttr_day4 : MapAttr
homeAttr_day4 =
    { exit = { x = 610, y = 450 , wid = 20, hei = 150 }
    , heroIni = { x = 665, y = 520, width = 20, height = 60 }
    , barrier = homeBarrier
    , hint = []
    , vehicle = homeVehicle
    , story = "That weird dream... what did that 'person' speak? WHAT will be destroyed tomorrow at a very early time?... Alas, maybe I shouldn't pay such attention on a dream... but dream has told me a lot, and Jonathon is dangerous..."
    , scene = ( Home, Day4 )
    , isFinished = False
    }

homeAttr_day5 : MapAttr
homeAttr_day5 =
    { exit = { x = 610, y = 450 , wid = 20, hei = 150 }
    , heroIni = { x = 665, y = 520, width = 20, height = 60 }
    , barrier = homeBarrier
    , hint = []
    , vehicle = homeVehicle
    , story = "Vacation! I don't need to go to the police office today. I decide to have a thorough inspection on the evidences I've collected!"
    , scene = ( Home, Day5 )
    , isFinished = False
    }

homeAttr_day6 : MapAttr
homeAttr_day6 =
    { exit = { x = 610, y = 450 , wid = 20, hei = 150 }
    , heroIni = { x = 665, y = 520, width = 20, height = 60 }
    , barrier = homeBarrier
    , hint = []
    , vehicle = homeVehicle
    , story = "Phone rings... press X to pick the phone."
    , scene = ( Home, Day6 )
    , isFinished = False
    }

homeAttr_day7 : MapAttr
homeAttr_day7 =
    { exit = { x = 610, y = 450 , wid = 20, hei = 150 }
    , heroIni = { x = 665, y = 520, width = 20, height = 60 }
    , barrier = homeBarrier
    , hint = []
    , vehicle = homeVehicle
    , story = "Ah... That is to say, I have to challenge Jonathon bravely but wisely... The only superior authority in our city is... the city council. Press X to phone there."
    , scene = ( Home, Day7 )
    , isFinished = False
    }
homeAttr_day8 : MapAttr
homeAttr_day8 =
    { exit = { x = 610, y = 450 , wid = 20, hei = 150 }
    , heroIni = { x = 665, y = 520, width = 20, height = 60 }
    , barrier = homeBarrier
    , hint = []
    , vehicle = homeVehicle
    , story = "This day, the judgment day, who will win, who will lose? Can your rebirth contribute to the rebirth of the city?\nThere is someone calling you from out side. Press X to hear."
    , scene = ( Home, Day8 )
    , isFinished = False
    }

journalistAttr_day1 : MapAttr
journalistAttr_day1 =
    { exit = { x = 130, y = 205 , wid = 20, hei = 250 }
    , heroIni = { x = 205, y = 335, width = 60, height = 180 }
    , barrier = journalistBarrier
    , hint = []
    , vehicle = []
    , story = "It's not the proper time to enter here."
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
    , story = "Nasty Smell... How long hasn't this guy cleaned his home? Well, I should go there to help Lee to examine the body."
    , scene = ( Journalist, Day2 )
    , isFinished = False
    }

journalistAttr_day2_finished : MapAttr
journalistAttr_day2_finished =
    { exit = { x = 130, y = 205 , wid = 20, hei = 250 }
    , heroIni = { x = 205, y = 335, width = 60, height = 180 }
    , barrier = journalistBarrier
    , hint = []
    , vehicle = []
    , story = "Nasty Smell... How long hasn't this guy cleaned his home?"
    , scene = ( Journalist, Day2_Finished )
    , isFinished = False
    }

journalistAttr_day2_night : MapAttr
journalistAttr_day2_night =
    { exit = { x = 130, y = 205 , wid = 20, hei = 250 }
    , heroIni = { x = 205, y = 335, width = 60, height = 180 }
    , barrier = journalistBarrier
    , hint = []
    , vehicle = []
    , story = "Once a murder scene."
    , scene = ( Journalist, Day2_Night )
    , isFinished = False
    }

journalistAttr_day3 : MapAttr
journalistAttr_day3 =
    { exit = { x = 130, y = 205 , wid = 20, hei = 250 }
    , heroIni = { x = 205, y = 335, width = 60, height = 180 }
    , barrier = journalistBarrier
    , hint = []
    , vehicle = []
    , story = "Once the murder scene."
    , scene = ( Journalist, Day3 )
    , isFinished = False
    }

journalistAttr_day4 : MapAttr
journalistAttr_day4 =
    { exit = { x = 130, y = 205 , wid = 20, hei = 250 }
    , heroIni = { x = 205, y = 335, width = 60, height = 180 }
    , barrier = journalistBarrier
    , hint = []
    , vehicle = []
    , story = "Once the murder scene."
    , scene = ( Journalist, Day4 )
    , isFinished = False
    }

nightClubAttr_day1 : MapAttr
nightClubAttr_day1 =
    { exit = { x = 125, y = 385 , wid = 20, hei = 215  }
    , heroIni = { x = 150, y = 475, width = 40, height = 120 }
    , barrier = nightClubBarrier
    , hint = []
    , vehicle = nightClubVehicle
    , story = "Welcome to PARADISE! The highest unconscious, the highest joy!"
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
    , story = "Welcome to PARADISE! The highest unconscious, the highest joy! \nDo you want something *exciting*, Sir?"
    , scene = ( NightClub, Day2 )
    , isFinished = False
    }

nightClubAttr_day2_finished : MapAttr
nightClubAttr_day2_finished =
    { exit = { x = 125, y = 385 , wid = 20, hei = 215  }
    , heroIni = { x = 150, y = 475, width = 40, height = 120 }
    , barrier = nightClubBarrier
    , hint = []
    , vehicle = nightClubVehicle
    , story = "Welcome to PARADISE! The highest unconscious, the highest joy! \nDo you want something *exciting*, Sir?"
    , scene = ( NightClub, Day2_Finished )
    , isFinished = False
    }

nightClubAttr_day2_night : MapAttr
nightClubAttr_day2_night =
    { exit = { x = 125, y = 385 , wid = 20, hei = 215  }
    , heroIni = { x = 150, y = 475, width = 40, height = 120 }
    , barrier = nightClubBarrier
    , hint = []
    , vehicle = nightClubVehicle
    , story = "Paradise, the biggest nightclub in this city, features in \"unlimited joy, best joy\". Once it was the place where lust and alcoholism intertwined. But now only sin reigns.\n The staff told you the body was found on the 2nd floor."
    , scene = ( NightClub, Day2_Night )
    , isFinished = False
    }

nightClubAttr_day3 : MapAttr
nightClubAttr_day3 =
    { exit = { x = 125, y = 385 , wid = 20, hei = 215  }
    , heroIni = { x = 150, y = 475, width = 40, height = 120 }
    , barrier = nightClubBarrier
    , hint = []
    , vehicle = nightClubVehicle
    , story = "Welcome to PARADISE! The highest unconscious, the highest joy! \nDo you want something *exciting*, Sir?"
    , scene = ( NightClub, Day3 )
    , isFinished = False
    }

nightClubAttr_day4 : MapAttr
nightClubAttr_day4 =
    { exit = { x = 125, y = 385 , wid = 20, hei = 215  }
    , heroIni = { x = 150, y = 475, width = 40, height = 120 }
    , barrier = nightClubBarrier
    , hint = []
    , vehicle = nightClubVehicle
    , story = "Welcome to PARADISE! The highest unconscious, the highest joy! \nDo you want something *exciting*, Sir?"
    , scene = ( NightClub, Day4 )
    , isFinished = False
    }

nightClubAttr_day5 : MapAttr
nightClubAttr_day5 =
    { exit = { x = 125, y = 385 , wid = 20, hei = 215  }
    , heroIni = { x = 150, y = 475, width = 40, height = 120 }
    , barrier = nightClubBarrier
    , hint = []
    , vehicle = nightClubVehicle
    , story = "Welcome to PARADISE! The highest unconscious, the highest joy! "
    , scene = ( NightClub, Day5 )
    , isFinished = False
    }

danielAttr_day3 : MapAttr
danielAttr_day3 =
    { exit = { x = 125, y = 385 , wid = 20, hei = 215  }
    , heroIni = { x = 150, y = 475, width = 40, height = 120 }
    , barrier = danielBarrier
    , hint = []
    , vehicle = danielVehicle
    , story = "Daniel's home. It seems that this family is under a financial crisis."
    , scene = ( Daniel, Day3 )
    , isFinished = False
    }

danielAttr_day4 : MapAttr
danielAttr_day4 =
    { exit = { x = 125, y = 385 , wid = 20, hei = 215  }
    , heroIni = { x = 150, y = 475, width = 40, height = 120 }
    , barrier = danielBarrier
    , hint = []
    , vehicle = danielVehicle
    , story = "You go to Daniel's home again. Interesting, Daniel isn't at home as Jonathon said."
    , scene = ( Daniel, Day4 )
    , isFinished = False
    }

courtAttr_day6 : MapAttr
courtAttr_day6 =
    { exit = { x = 2000, y = 2000 , wid = 20, hei = 20  }
    , heroIni = { x = 3050, y = 3050, width = 20, height = 20 }
    , barrier = courtBarrierList
    , hint = []
    , vehicle = []
    , story = "On the court."
    , scene = ( CityCouncil, Day6 )
    , isFinished = False
    }


courtAttr_day8 : MapAttr
courtAttr_day8 =
    { exit = { x = 2000, y = 2000 , wid = 20, hei = 20  }
    , heroIni = { x = 3050, y = 3050, width = 20, height = 20 }
    , barrier = courtBarrierList
    , hint = []
    , vehicle = []
    , story = "On the court, again."
    , scene = ( CityCouncil, Day8 )
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
    { exit = { x = 470 + 135, y = 575 , wid = 20, hei = 20 }
    , heroIni = { x = 415 + 135 , y = 15, width = 20, height = 20 } --judge box
    , barrier = maze1Barrier
    , hint = hintsMaze1
    , vehicle = []
    , story = "Where is here...?"
    , scene = ( DreamMaze, Day1 )
    , isFinished = False
    }

dreamMazeAttr_day2 : MapAttr
dreamMazeAttr_day2 =
    { exit = { x = 470 + 135, y = 575 , wid = 20, hei = 20 }
    , heroIni = { x = 415 + 135, y = 15, width = 20, height = 20 } --judge box
    , barrier = maze1Barrier
    , hint = hintsMaze2
    , vehicle = []
    , story = "Maze again? Really odd... "
    , scene = ( DreamMaze, Day2 )
    , isFinished = False
    }

dreamMazeAttr_day2_finished : MapAttr
dreamMazeAttr_day2_finished =
    { exit = { x = 470 + 135, y = 575 , wid = 20, hei = 20 }
    , heroIni = { x = 415 + 135, y = 15, width = 20, height = 20 } --judge box
    , barrier = maze1Barrier
    , hint = hintsMaze2
    , vehicle = []
    , story = "Maze again? Really odd... "
    , scene = ( DreamMaze, Day2_Finished )
    , isFinished = False
    }

dreamMazeAttr_day2_night : MapAttr
dreamMazeAttr_day2_night =
    { exit = { x = 470 + 135, y = 575 , wid = 20, hei = 20 }
    , heroIni = { x = 415 + 135, y = 15, width = 20, height = 20 } --judge box
    , barrier = maze1Barrier
    , hint = hintsMaze2
    , vehicle = []
    , story = "..."
    , scene = ( DreamMaze, Day2_Night )
    , isFinished = False
    }

dreamMazeAttr_day3 : MapAttr
dreamMazeAttr_day3 =
    { exit = { x = 470 + 135, y = 575 , wid = 20, hei = 20 }
    , heroIni = { x = 415 + 135, y = 15, width = 20, height = 20 } --judge box
    , barrier = maze1Barrier
    , hint = hintsMaze3
    , vehicle = []
    , story = "..."
    , scene = ( DreamMaze, Day3 )
    , isFinished = False
    }

dreamMazeAttr_day4 : MapAttr
dreamMazeAttr_day4 =
    { exit = { x = 470 + 135, y = 575 , wid = 20, hei = 20 }
    , heroIni = { x = 415 + 135, y = 15, width = 20, height = 20 } --judge box
    , barrier = maze1Barrier
    , hint = hintsMaze4
    , vehicle = []
    , story = "..."
    , scene = ( DreamMaze, Day4 )
    , isFinished = False
    }

dreamMazeAttr_day5 : MapAttr
dreamMazeAttr_day5 =
    { exit = { x = 470 + 135, y = 575 , wid = 20, hei = 20 }
    , heroIni = { x = 470 + 135, y = 575, width = 20, height = 20 } --no dream
    , barrier = maze1Barrier
    , hint = hintsMaze5
    , vehicle = []
    , story = "..."
    , scene = ( DreamMaze, Day5 )
    , isFinished = False
    }

dreamMazeAttr_day6 : MapAttr
dreamMazeAttr_day6 =
    { exit = { x = 470 + 135, y = 575 , wid = 20, hei = 20 }
    , heroIni = { x = 415 + 135, y = 15, width = 20, height = 20 }
    , barrier = maze1Barrier
    , hint = hintsMaze6
    , vehicle = []
    , story = "It seems the maze appears tonight? huh."
    , scene = ( DreamMaze, Day6 )
    , isFinished = False
    }

dreamMazeAttr_day7 : MapAttr
dreamMazeAttr_day7 =
    { exit = { x = 470 + 135, y = 575 , wid = 20, hei = 20 }
    , heroIni = { x = 415 + 135, y = 15, width = 20, height = 20 }
    , barrier = maze1Barrier
    , hint = hintsMaze7
    , vehicle = []
    , story = "......"
    , scene = ( DreamMaze, Day7 )
    , isFinished = False
    }



switchingAttr : MapAttr
switchingAttr =
    { exit = { x = 0, y = 0 , wid = 0, hei = 0 }
    , heroIni = { x = 6050, y = 6050, width = 2, height = 2 }
    , barrier = switchingBarrierList
    , hint = []
    , vehicle = []
    , story = "Where to go?"
    , scene = ( Switching, Nowhere )
    , isFinished = False
    }


allMapAttrs : List MapAttr
allMapAttrs =
    [ dreamMazeAttr_day1, dreamMazeAttr_day2, dreamMazeAttr_day2_finished, dreamMazeAttr_day2_night, dreamMazeAttr_day3, dreamMazeAttr_day4, dreamMazeAttr_day5, dreamMazeAttr_day6, dreamMazeAttr_day7
    , homeAttr_day1, homeAttr_day2, homeAttr_day2_finished, homeAttr_day2_night, homeAttr_day3, homeAttr_day4, homeAttr_day5, homeAttr_day6, homeAttr_day7, homeAttr_day8
    , parkAttr_day1, parkAttr_day2, parkAttr_day2_finished, parkAttr_day2_night, parkAttr_day3, parkAttr_day4, parkAttr_day5
    , journalistAttr_day1, journalistAttr_day2, journalistAttr_day2_finished, journalistAttr_day2_night, journalistAttr_day3, journalistAttr_day4
    , policeOfficeAttr_day1, policeOfficeAttr_day2, policeOfficeAttr_day2_finished, policeOfficeAttr_day2_night, policeOfficeAttr_day3, policeOfficeAttr_day4, policeOfficeAttr_day5, policeOfficeAttr_day6, policeOfficeAttr_day7
    , nightClubAttr_day1, nightClubAttr_day2, nightClubAttr_day2_finished, nightClubAttr_day2_night, nightClubAttr_day3, nightClubAttr_day4, nightClubAttr_day5
    , danielAttr_day3, danielAttr_day4
    , switchingAttr
    , courtAttr_day6, courtAttr_day8 ]



