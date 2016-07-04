module Main exposing (..)

import Messages exposing (Msg(..))
import Models exposing (Model, Multiplication, initialModel)
import Update exposing (update)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.App as Html
import Html.Events exposing (onInput)
import Time exposing (..)
import Task exposing (perform)


initial : ( Model, Cmd Msg )
initial = ( initialModel, currentTime )


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
