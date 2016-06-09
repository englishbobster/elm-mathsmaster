module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.App as Html
import Html.Events exposing (onInput)
import Random exposing (Seed)
import Time exposing (..)
import Task exposing (..)

-- MODEL
type alias Index = Int
type alias Multiplication =
    {
      left: Int
    , right: Int
    , result: Int
    }

type alias Model = List (Index, Multiplication)

initialModel : Model
initialModel = []


initial : ( Model, Cmd Msg )
initial = ( initialModel, currentTime )


-- UPDATE
type Msg = NoOp
    | Now Time
    | Answer Int String


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    NoOp -> ( model, Cmd.none)

    Now now -> ( (quizGenerator 10 (timeInSeconds now)), Cmd.none )

    Answer index result -> (model, Cmd.none )



timeInSeconds : Time  -> Int
timeInSeconds time =
    round (inSeconds time)

quizGenerator : Int -> Int -> List (Index, Multiplication)
quizGenerator size seed =
    let
       (list, _) = Random.step ( Random.list size intPairGen) ( Random.initialSeed seed)

    in
       List.indexedMap (\i (a,b) ->  (i, {left = a, right = b, result = 0})) list


intPairGen : Random.Generator(Int, Int)
intPairGen =
    Random.pair (Random.int 1 12) (Random.int 1 12)


-- SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none


-- VIEW
view : Model -> Html Msg
view model =
  div [] [table [] (List.map problemRow model)]


problemRow : (Index, Multiplication) -> Html Msg
problemRow (index, multi)  =
    tr [classList [ ("highlight", multi.left * multi.right == multi.result) ] ]
        [ quizElement multi.left multi.right
        , answerElement index
        ]


quizElement : Int -> Int -> Html Msg
quizElement left right =
    td [] [ text(row left right) ]


answerElement : Int -> Html Msg
answerElement index =
     td [] [ input [ type' "number"
                   , Html.Attributes.min "0"
                   , Html.Attributes.max "999"
                   , size 3
                   , value "0"
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
