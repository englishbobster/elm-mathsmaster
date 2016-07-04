module Main exposing (..)

import Models exposing (Model, Multiplication, initialModel)
import QuizGen exposing (quizGenerator, intPairGen)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.App as Html
import Html.Events exposing (onInput)
import Time exposing (..)
import Task exposing (..)
import String exposing (..)
import Result exposing (..)



initial : ( Model, Cmd Msg )
initial = ( initialModel, currentTime )


-- UPDATE
type Msg = NoOp
    | Now Time
    | Answer Int String


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


asInt : String -> Int
asInt string =
    String.toInt string
        |> Result.toMaybe
        |> Maybe.withDefault 0


timeInSeconds : Time  -> Int
timeInSeconds time =
    round (inSeconds time)


-- SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none


-- VIEW
view : Model -> Html Msg
view model =
  div [id "container"] [table [] (List.map problemRow model)]


problemRow : Multiplication -> Html Msg
problemRow multi  =
    tr [classList [ ("highlight", multi.left * multi.right == multi.result) ] ]
        [ quizElement multi.left multi.right
        , answerElement multi.index multi.result
        ]


quizElement : Int -> Int -> Html Msg
quizElement left right =
    td [] [ text(row left right) ]


answerElement : Int -> Int -> Html Msg
answerElement index result =
     td [] [ input [ type' "number"
                   , Html.Attributes.min "0"
                   , Html.Attributes.max "999"
                   , size 3
                   , value (toString result)
                   , onInput (Answer index)
                   ] [ ]
           ]


row : Int -> Int -> String
row left right =
    (toString left) ++ " x " ++ (toString right) ++ " = "


-- MAIN
currentTime : Cmd Msg
currentTime =
    perform (\_ -> NoOp) Now Time.now


main =
  Html.program { init  = initial
               , view = view
               , update = update
               , subscriptions = subscriptions }
