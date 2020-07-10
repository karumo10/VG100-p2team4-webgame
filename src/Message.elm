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
    | ToPoliceOffice
    | ToPark
    | PickUp
    | Noop
    | InteractWith WorldModel.ID
    | UpdateDebugSearchText String
