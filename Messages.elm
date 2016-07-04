module Messages exposing (..)

import Time exposing (..)

type Msg = NoOp
    | Now Time
    | Answer Int String
