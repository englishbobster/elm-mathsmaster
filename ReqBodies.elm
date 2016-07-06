module ReqBodies exposing (..)

import Json.Encode exposing (..)

--the required request body to get 10 random numbers in range 1..12
{-|
    "jsonrpc": "2.0",
    "method": "generateIntegers",
    "params": {
        "apiKey": "c3a3ec02-bc59-469f-9358-3fe5ac40dd9c",
        "n": 10,
        "min": 1,
        "max": 12,
        "replacement": true
    },
    "id": 1
-}

genIntReqBody : Int -> Int -> Int -> Value
genIntReqBody nr min max =
    let
        params = object [ ("apiKey", string "c3a3ec02-bc59-469f-9358-3fe5ac40dd9c")
                        , ("n", int nr)
                        , ("min", int min)
                        , ("max", int max)
                        , ("replacement", bool True)
                        ]
    in
        object [ ("jsonrpc", string "2.0")
               , ("method", string "generateIntegers")
               , ("params", params)
               , ("id", int 1)
               ]

encodeBody : Int -> Int -> Int -> String
encodeBody nr min max =
    encode 0 (genIntReqBody nr min max)
