module Main exposing (..)

import Messages exposing (Msg(..))
import Models exposing (Model, Multiplication, initialModel)
import Update exposing (update)
import View exposing (view)

import Html.App as Html
import Time exposing (..)
import Task exposing (perform)


initial : ( Model, Cmd Msg )
initial = ( initialModel, currentTime )


-- SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none


-- MAIN
currentTime : Cmd Msg
currentTime =
    perform (\_ -> NoOp) Now Time.now


main =
  Html.program { init  = initial
               , view = view
               , update = update
               , subscriptions = subscriptions }
