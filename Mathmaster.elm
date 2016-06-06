import Html exposing (..)
import Html.App as Html
import Random exposing (Seed)
import Time exposing (..)
import Task exposing (..)

-- MODEL

type alias Model = List (Int, Int)

initialModel = []

initial : ( Model, Cmd Msg )
initial = ( initialModel, currentTime )


-- UPDATE

type Msg = NoOp
    | Now Time


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    NoOp -> ( model, Cmd.none)
    Now now -> ( (randomDigitPairList (timeInSeconds now)), Cmd.none )


timeInSeconds : Time  -> Int
timeInSeconds time =
    round (inSeconds time)


randomDigitPairList : Int -> List (Int, Int)
randomDigitPairList seed =
    let
        (list, _) = listGenerator 15 seed
    in
      list


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
  h1 [] [ text (toString model) ]

-- MAIN

currentTime : Cmd Msg
currentTime =
    perform (\_ -> NoOp) Now Time.now


main =
  Html.program { init  = initial
               , view = view
               , update = update
               , subscriptions = subscriptions }
