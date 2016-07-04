module Update exposing (..)

import Messages exposing (Msg(..))
import Models exposing (Model)
import QuizGen exposing (quizGenerator, intPairGen)

import Time exposing (Time, inSeconds)
import String exposing (toInt)


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    NoOp ->
        ( model, Cmd.none)

    Now now ->
        ( (quizGenerator 10 (timeInSeconds now)), Cmd.none )

    Answer index result ->
        let
            updateEntry e =
                if e.index == index then {e | result = (asInt result)} else e
        in
            ( List.map updateEntry model, Cmd.none)


timeInSeconds : Time  -> Int
timeInSeconds time =
    round (inSeconds time)


asInt : String -> Int
asInt string =
    toInt string
        |> Result.toMaybe
        |> Maybe.withDefault 0
