module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.App as Html
import Html.Events exposing (onInput)
import Random exposing (Seed)
import Time exposing (..)
import Task exposing (..)

-- MODEL
type alias Result = Int
type alias Model = List (Int, Int, Result)

initialModel = []

initial : ( Model, Cmd Msg )
initial = ( initialModel, currentTime )


-- UPDATE
type Msg = NoOp
    | Now Time
    | Answer String


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    NoOp -> ( model, Cmd.none)
    Now now -> ( (randomDigitPairList (timeInSeconds now)), Cmd.none )
    Answer answer -> ( model, Cmd.none )


timeInSeconds : Time  -> Int
timeInSeconds time =
    round (inSeconds time)


randomDigitPairList : Int -> List (Int, Int, Result)
randomDigitPairList seed =
    let
        (list, _) = listGenerator 10 seed
    in
        addZeroResult list


addZeroResult : List (Int, Int) -> List (Int, Int, Result)
addZeroResult list =
    List.map (\(a,b) -> (a, b, 0)) list


listGenerator : Int -> Int -> ( List (Int, Int), Seed )
listGenerator size seed =
    Random.step ( Random.list size integerPairGenerator) ( Random.initialSeed seed)


integerPairGenerator : Random.Generator(Int, Int)
integerPairGenerator =
    Random.pair (Random.int 1 12) (Random.int 1 12)


-- SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none


-- VIEW
view : Model -> Html Msg
view model =
  div [] [table [] (List.map problemRow model)]


problemRow : (Int, Int, Result) -> Html Msg
problemRow integerPair =
    let
        (left, right, result) = integerPair
    in
        tr [classList [ ("highlight", left*right == result) ] ]
            [ quizElement left right
            , answerElement
            ]


quizElement : Int -> Int -> Html Msg
quizElement left right =
    td [] [ text(row left right) ]


answerElement : Html Msg
answerElement =
     td [] [ input [ type' "number"
                   , Html.Attributes.min "0"
                   , Html.Attributes.max "999"
                   , size 3
                   , value "0"
                   , onInput Answer
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
