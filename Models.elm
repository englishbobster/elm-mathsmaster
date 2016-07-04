module Models exposing (..)

type alias Multiplication =
    {
      left: Int
    , right: Int
    , result: Int
    , index: Int
    }

type alias Model = List Multiplication

initialModel : Model
initialModel = []
