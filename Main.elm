module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.App as Html
import Html.Events exposing (onInput)
import Random exposing (Seed)
import Time exposing (..)
import Task exposing (..)

-- MODEL
type alias Product = Int
type alias Model = List (Int, Int, Product)

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


randomDigitPairList : Int -> List (Int, Int, Product)
randomDigitPairList seed =
    let
        (list, _) = listGenerator 10 seed
    in
        addProductTo list


addProductTo : List (Int, Int) -> List (Int, Int, Product)
addProductTo list =
    List.map (\(a,b) -> (a, b, a*b)) list


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


problemRow : (Int, Int, Product) -> Html Msg
problemRow integerPair =
    let
        (left, right, _) = integerPair
    in
        tr [class "problem"]
            [ td [] [ text(row left right)]
            , td [] [ input [ type' "number"
                            , Html.Attributes.min "0"
                            , Html.Attributes.max "999"
                            , size 3
                            , onInput Answer
                            ] [ ]
                    ]
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
