
{-# OPTIONS_GHC -Wno-incomplete-patterns #-}

{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
import Data.List (intersect, union)

split :: Char -> String -> [String]
split _ "" = []
split delimiter str =
    let (start, rest) = break (== delimiter) str
        (_, remain) = span (== delimiter) rest
     in start : split delimiter remain


first (a:b) = a
second (a:b:_) = b

lineRanges line =
    let ranges = split ',' line
        r1 = first ranges
        r2 = second ranges
        rangeOneTemp = split '-' r1
        rangeTwoTemp = split '-' r2
        r1p1 = first rangeOneTemp
        r1p2 = second rangeOneTemp
        r2p1 = first rangeTwoTemp
        r2p2 = second rangeTwoTemp
        rangeOne = [(read r1p1::Int)..(read r1p2::Int)]
        rangeTwo = [(read r2p1::Int)..(read r2p2::Int)]
        rangeOneLength = length rangeOne
        rangeTwoLength = length rangeTwo
        maxLen = max rangeOneLength rangeTwoLength
        theUnion = intersect rangeOne rangeTwo
    in
        not (null theUnion)


calc :: Foldable t => t [Char] -> Int
calc = foldl
    ( \total x ->
        if lineRanges x then
            total + 1
        else
            total
    )
    0

main :: IO ()
main = do
  fileData <- readFile "input.txt"
  let strs = lines fileData
  let sum = calc strs
  print sum