
{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
import Data.List (intersect, union)

split :: Char -> String -> [String]
split _ "" = []
split delimiter str =
    let (start, rest) = break (== delimiter) str
        (_, remain) = span (== delimiter) rest
     in start : split delimiter remain


lineRanges line =
    let r1p1 = head (split '-' (head (split ',' line)))
        r1p2 = last (split '-' (head (split ',' line)))
        r2p1 = head (split '-' (last (split ',' line)))
        r2p2 = last (split '-' (last (split ',' line)))
        rangeOne = [(read r1p1::Int)..(read r1p2::Int)]
        rangeTwo = [(read r2p1::Int)..(read r2p2::Int)]
    in
        not (null (rangeOne `intersect` rangeTwo))


calc :: Foldable t => t [Char] -> Int
calc = foldl ( \total x -> if lineRanges x then total + 1 else total ) 0

main :: IO ()
main = do
  fileData <- readFile "input.txt"
  let strs = lines fileData
  let sum = calc strs
  print sum