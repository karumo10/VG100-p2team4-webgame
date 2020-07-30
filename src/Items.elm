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
    | CityCouncil
    | BackStreet
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
    , img : String
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
    , img = ""
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
    , img = ""
    }

noteIni : Item
noteIni =
    { itemType = BulletProof
    , isPick = False
    , isHeld = False
    , isWear = False
    , number = 1
    , scene = Journalist
    , x = 700
    , y = 530
    , intro = "note"
    , comment = "Note"
    , canBeExamined = False
    , img = "./items/note.png"
    }

diskIni : Item
diskIni =
    { itemType = BulletProof
    , isPick = False
    , isHeld = False
    , isWear = False
    , number = 1
    , scene = Journalist
    , x = 700
    , y = 530
    , intro = "disk"
    , comment = "Disk"
    , canBeExamined = True
    , img = "./items/disk.png"
    }

pillIni : Item
pillIni =
    { itemType = BulletProof
    , isPick = False
    , isHeld = False
    , isWear = False
    , number = 1
    , scene = NightClub
    , x = 700
    , y = 530
    , intro = "pill"
    , comment = "Weird pills taken from Paradise."
    , canBeExamined = True
    , img = "./items/pills_nightclub.png"
    }

daggerIni : Item
daggerIni =
    { itemType = BulletProof
    , isPick = False
    , isHeld = False
    , isWear = False
    , number = 1
    , scene = NightClub
    , x = 700
    , y = 530
    , intro = "dagger"
    , comment = "A dagger with weird letters on it."
    , canBeExamined = True
    , img = "./items/dagger_Ann.png"
    }

trueMemCardIni : Item
trueMemCardIni =
    { itemType = BulletProof
    , isPick = False
    , isHeld = False
    , isWear = False
    , number = 1
    , scene = PoliceOffice
    , x = 700
    , y = 530
    , intro = "memory card"
    , comment = "VERIFICATION PASSED. ACCESS ALLOWED."
    , canBeExamined = True
    , img = "./items/memorycard.png"
    }

fakeMemCardIni : Item
fakeMemCardIni =
    { itemType = BulletProof
    , isPick = False
    , isHeld = False
    , isWear = False
    , number = 1
    , scene = Daniel
    , x = 700
    , y = 530
    , intro = "another memory card"
    , comment = "A memory card, used for cameras, found in Daniel's house."
    , canBeExamined = True
    , img = "./items/memorycard_fake.png"
    }

keyIni : Item
keyIni =
    { itemType = BulletProof
    , isPick = False
    , isHeld = False
    , isWear = False
    , number = 1
    , scene = Daniel
    , x = 700
    , y = 530
    , intro = "key"
    , comment = "The key found in Daniel's house."
    , canBeExamined = True
    , img = "./items/key.png"
    }

paperIni : Item
paperIni =
    { itemType = BulletProof
    , isPick = False
    , isHeld = False
    , isWear = False
    , number = 1
    , scene = Daniel
    , x = 700
    , y = 530
    , intro = "Paper"
    , comment = "A paper with customer's favor, found in Daniel's house."
    , canBeExamined = True
    , img = "./items/custom's_favor.png"
    }

bankIni : Item
bankIni =
    { itemType = BulletProof
    , isPick = False
    , isHeld = False
    , isWear = False
    , number = 1
    , scene = Daniel
    , x = 700
    , y = 530
    , intro = "Bank statement"
    , comment = "A bank account statement, found in Daniel's house."
    , canBeExamined = True
    , img = "./items/bank_account_stat.png"
    }

bankCardIni : Item
bankCardIni =
    { itemType = BulletProof
    , isPick = False
    , isHeld = False
    , isWear = False
    , number = 1
    , scene = PoliceOffice
    , x = 300
    , y = 100
    , intro = "Bank card"
    , comment = "A bank card taken from Jonathon's office."
    , canBeExamined = True
    , img = "./items/bankcard.png"
    }

dagger2Ini : Item
dagger2Ini =
    { itemType = BulletProof
    , isPick = False
    , isHeld = False
    , isWear = False
    , number = 1
    , scene = PoliceOffice
    , x = 310
    , y = 100
    , intro = "Dagger 2"
    , comment = "A dagger taken from Jonathon's office."
    , canBeExamined = True
    , img = "./items/dagger_Jonathon.png"
    }

letterIni : Item
letterIni =
    { itemType = BulletProof
    , isPick = False
    , isHeld = False
    , isWear = False
    , number = 1
    , scene = PoliceOffice
    , x = 700
    , y = 530
    , intro = "Letter"
    , comment = "Letter taken from Jonathon's office."
    , canBeExamined = True
    , img = "./items/letter.png"
    }

documentsIni : Item
documentsIni =
    { itemType = BulletProof
    , isPick = False
    , isHeld = False
    , isWear = False
    , number = 1
    , scene = PoliceOffice
    , x = 700
    , y = 530
    , intro = "Documents"
    , comment = "Documents taken from Jonathon's office."
    , canBeExamined = True
    , img = "./items/documents.png"
    }

pillsIni : Item
pillsIni =
    { itemType = BulletProof
    , isPick = False
    , isHeld = False
    , isWear = False
    , number = 1
    , scene = PoliceOffice
    , x = 700
    , y = 530
    , intro = "A bottle of pills"
    , comment = "A plain bottle of pills. The most popular 'food' in this city, Paradise."
    , canBeExamined = True
    , img = "./items/pills_policeoffice.png"
    }

planIni : Item
planIni =
    { itemType = BulletProof
    , isPick = False
    , isHeld = False
    , isWear = False
    , number = 1
    , scene = PoliceOffice
    , x = 700
    , y = 530
    , intro = "Plan document"
    , comment = "A plan document. The most popular 'food' in this city, Paradise."
    , canBeExamined = True
    , img = "./items/plan.png"
    }

bankaccIni : Item
bankaccIni =
    { itemType = BulletProof
    , isPick = False
    , isHeld = False
    , isWear = False
    , number = 1
    , scene = PoliceOffice
    , x = 700
    , y = 530
    , intro = "Another bank account statement"
    , comment = "Another bank account statement taken from Jonathon's office."
    , canBeExamined = True
    , img = "./items/bank_account_stat_Jonathon.png"
    }

customconIni : Item
customconIni =
    { itemType = BulletProof
    , isPick = False
    , isHeld = False
    , isWear = False
    , number = 1
    , scene = PoliceOffice
    , x = 700
    , y = 530
    , intro = "A custom contract"
    , comment = "A custom contract taken from Jonathon's office."
    , canBeExamined = True
    , img = "./items/custom_contract.png"
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
    , img = ""
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
    , img = ""
    }

bagIni : Bag
bagIni =
    { grid1 = fakeMemCardIni
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