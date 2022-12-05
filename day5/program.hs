{-# OPTIONS_GHC -Wno-incomplete-patterns #-}

import qualified Data.ByteString as Map
import Data.Function
import Data.List (intersect, union)
import qualified Data.Map as Map
import Data.Maybe (fromMaybe)

theMap :: Map.Map Int [[Char]]
theMap = Map.fromList (zip [1 .. 9] stackList)

stackList :: [[[Char]]]
stackList =
  [ ["R", "C", "H"],
    ["F", "S", "L", "H", "J", "B"],
    ["Q", "T", "J", "H", "D", "M", "R"],
    ["J", "B", "Z", "H", "R", "G", "S"],
    ["B", "C", "D", "T", "Z", "F", "P", "R"],
    ["G", "C", "H", "T"],
    ["L", "W", "P", "B", "Z", "V", "N", "S"],
    ["C", "G", "Q", "J", "R"],
    ["S", "F", "P", "H", "R", "T", "D", "L"]
  ]

split :: Char -> String -> [String]
split _ "" = []
split delimiter str =
  let (start, rest) = break (== delimiter) str
      (_, remain) = span (== delimiter) rest
   in start : split delimiter remain

replace :: Eq a => [a] -> [a] -> [a] -> [a]
replace [] _ _ = []
replace s find repl =
  if take (length find) s == find
    then repl ++ replace (drop (length find) s) find repl
    else head s : replace (tail s) find repl

replaceToCommas =
  map
    ( (\x -> replace x "move" "")
        . (\x -> replace x "from" ",")
        . (\x -> replace x "to" ",")
        . (\x -> replace x " " "")
    )

calc =
  foldl
    ( \aMap x ->
        let parts = split ',' x
            numbers = read (head parts) :: Int
            from = read (parts !! 1) :: Int
            to = read (parts !! 2) :: Int
            fromList = fromMaybe [] (Map.lookup from aMap)
            toList = fromMaybe [] (Map.lookup to aMap)
         in aMap
              & Map.insert from (drop numbers fromList)
              & Map.insert to (reverse (take numbers fromList) ++ toList)
    )

toResult aMap =
  foldl
    ( \reslList x ->
        reslList ++ head (fromMaybe [] (Map.lookup x aMap))
    )
    []

main :: IO ()
main = do
  fileData <- readFile "input.txt"
  let strs = lines fileData
  let commaList = replaceToCommas strs
  let sum = calc theMap commaList
  let result = toResult sum [1 .. 9]
  print result