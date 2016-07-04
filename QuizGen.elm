module QuizGen exposing (..)

import Models exposing (Multiplication)
import Random exposing (step, list, initialSeed, pair, int)

quizGenerator : Int -> Int -> List Multiplication
quizGenerator size seed =
    let
       (randomList, _) = step (list size intPairGen) (initialSeed seed)

    in
       List.indexedMap (\i (a,b) ->  {left = a, right = b, result = 0, index = i}) randomList


intPairGen : Random.Generator(Int, Int)
intPairGen =
    pair (int 2 12) (int 2 12)

