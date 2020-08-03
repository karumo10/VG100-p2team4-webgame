module Message exposing (Msg(..))

import Browser.Dom exposing (Viewport)
import NarrativeEngine.Core.WorldModel as WorldModel

type Msg
    = Start
    | Pause
    | Resume
    | Tick Float
    | MoveLeft Bool
    | MoveRight Bool
    | MoveUp Bool
    | MoveDown Bool
    | Resize Int Int
    | GetViewport Viewport
    | InteractByKey Bool
    | ToPoliceOffice
    | ToPark
    | ToHome
    | ToJournalist
    | ToNightClub
    | ToDaniel
    | ToCityCouncil
    | ToBackStreet
    | Sleep Bool
    | PickUp Bool
    | ElevateTo1
    | ElevateTo2
    | ElevateTo3
    | EnterVehicle Bool-- including elevator and cars
    | Noop
    | InteractWith WorldModel.ID
    | UpdateDebugSearchText String
    | Catherinecatch
    | Adkinscatch
    | Robbery
    | RenderGrid1Detail
    | RenderGrid2Detail
    | RenderGrid3Detail
    | RenderGrid4Detail
    | RenderGrid5Detail
    | RenderGrid6Detail
    | RenderGrid7Detail
    | RenderGrid8Detail
    | RenderGrid9Detail
    | RenderGrid10Detail
    | RenderGrid11Detail
    | RenderGrid12Detail
    | RenderGrid13Detail
    | RenderGrid14Detail
    | RenderGrid15Detail
    | RenderGrid16Detail
    | RenderGrid17Detail
    | RenderGrid18Detail
    | RenderGrid19Detail
    | RenderGrid20Detail
    | ExamineItemsInBag Int
    | StartGame
    | ViewAboutUs
    | ViewStory
    | BackToStarter
    | ChangeCodeText String
    | CloseGrid
    | AskDelete

