module QuizGen exposing (..)

import Models exposing (Multiplication)
import Random exposing (step, list, initialSeed, pair, int)
import ReqBodies exposing (encodeBody)

import Json.Decode exposing (..)

-- Fallback to homegrown random
quizGenerator : Int -> Int -> List Multiplication
quizGenerator size seed =
    let
       (randomlist, _) = step (Random.list size intPairGen) (initialSeed seed)

    in
       List.indexedMap (\i (a,b) ->  {left = a, right = b, result = 0, index = i}) randomlist


intPairGen : Random.Generator(Int, Int)
intPairGen =
    pair (Random.int 2 12) (Random.int 2 12)


-- Ask random.org
-- url: https://api.random.org/json-rpc/1/invoke
-- example response body
{-|
    "jsonrpc": "2.0",
    "result": {
    	"random": {
            "data": [
                1, 5, 4, 6, 6, 4
            ],
            "completionTime": "2011-10-10 13:19:12Z"
        },
        "bitsUsed": 16,
        "bitsLeft": 199984,
        "requestsLeft": 9999,
        "advisoryDelay": 0
    },
    "id": 42
-}


test = 1

