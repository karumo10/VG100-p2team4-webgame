module Items exposing (..)

type ItemType
    = Gun
    | Bullets
    | Knife
    | BaseballBat
    | BulletProof
    | Helmet
    | Evidence1
    | Evidence2
    | Evidence3
    | Key
    | Empty

type Map
    = PoliceOffice
    | Park
    | Home
    | Switching -- an interface allowing player to choose where to go, also can be design as dialog box
    | EnergyDrain --no energy, home is the only choice
    | DreamMaze
    | Journalist
    | NightClub
    | Daniel
    | StarterPage
    | Story
    | AboutUs

type alias Item =
    { itemType : ItemType
    , isPick : Bool --is this item picked by player (in player's package)
    , isHeld : Bool --is this item held by player
    , isWear : Bool
    , number : Int
    , scene : Map
    , x : Int
    , y : Int
    , intro : String
    , comment : String
    , canBeExamined : Bool
    }

type alias Bag =
    { grid1 : Item
    , grid2 : Item
    , grid3 : Item
    , grid4 : Item
    , grid5 : Item
    , grid6 : Item
    , grid7 : Item
    , grid8 : Item
    , grid9 : Item
    , grid10 : Item
    }

gunIni : Item
gunIni =
    { itemType = Gun
    , isPick = False
    , isHeld = False
    , isWear = False
    , number = 1
    , scene = PoliceOffice
    , x = 400
    , y = 530
    , intro = "gun"
    , comment = "This is a gun"
    , canBeExamined = False
    }

bulletProofIni : Item
bulletProofIni =
    { itemType = BulletProof
    , isPick = False
    , isHeld = False
    , isWear = False
    , number = 1
    , scene = Park
    , x = 700
    , y = 530
    , intro = "bulletproof"
    , comment = "Use this to prevent you from bullet"
    , canBeExamined = False
    }

noteIni : Item
noteIni =
    { itemType = BulletProof
    , isPick = False
    , isHeld = False
    , isWear = False
    , number = 1
    , scene = Park
    , x = 700
    , y = 530
    , intro = "note"
    , comment = "Note"
    , canBeExamined = False

    }

diskIni : Item
diskIni =
    { itemType = BulletProof
    , isPick = False
    , isHeld = False
    , isWear = False
    , number = 1
    , scene = Park
    , x = 700
    , y = 530
    , intro = "disk"
    , comment = "Disk"
    , canBeExamined = True

    }

pillIni : Item
pillIni =
    { itemType = BulletProof
    , isPick = False
    , isHeld = False
    , isWear = False
    , number = 1
    , scene = Park
    , x = 700
    , y = 530
    , intro = "pill"
    , comment = "Weird pills taken from Paradise."
    , canBeExamined = True

    }

daggerIni : Item
daggerIni =
    { itemType = BulletProof
    , isPick = False
    , isHeld = False
    , isWear = False
    , number = 1
    , scene = Park
    , x = 700
    , y = 530
    , intro = "dagger"
    , comment = "A dagger with weird letters on it."
    , canBeExamined = True

    }



emptyIni : Item
emptyIni =
    { itemType = Empty
    , isPick = False
    , isHeld = False
    , isWear = False
    , number = 1
    , scene = Park
    , x = 0
    , y = 0
    , intro = "empty"
    , comment = " Nothing here "
    , canBeExamined = False
    }

emptyPickUp: Item
emptyPickUp =
    { itemType = Empty
    , isPick = True
    , isHeld = False
    , isWear = False
    , number = 1
    , scene = PoliceOffice
    , x = 0
    , y = 0
    , intro = "3"
    , comment = ""
    , canBeExamined = False

    }

bagIni : Bag
bagIni =
    { grid1 = emptyIni
    , grid2 = emptyIni
    , grid3 = emptyIni
    , grid4 = emptyIni
    , grid5 = emptyIni
    , grid6 = emptyIni
    , grid7 = emptyIni
    , grid8 = emptyIni
    , grid9 = emptyIni
    , grid10 = emptyIni
    }

isNotPick: Item -> Bool
isNotPick item =
    if item.isPick == True then
    False
    else
    True