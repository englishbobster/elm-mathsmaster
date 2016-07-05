module QuizGen exposing (..)

import Models exposing (Multiplication)
import Random exposing (step, list, initialSeed, pair, int)
import Http expoisng (..)


-- Fallback to homegrown random
quizGenerator : Int -> Int -> List Multiplication
quizGenerator size seed =
    let
       (randomlist, _) = step (list size intPairGen) (initialSeed seed)

    in
       List.indexedMap (\i (a,b) ->  {left = a, right = b, result = 0, index = i}) randomlist


intPairGen : Random.Generator(Int, Int)
intPairGen =
    pair (int 2 12) (int 2 12)

-- Ask random.org
-- url: https://api.random.org/json-rpc/1/invoke
-- api-key: c3a3ec02-bc59-469f-9358-3fe5ac40dd9c



