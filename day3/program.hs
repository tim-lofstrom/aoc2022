{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
import Data.List (sort, intersect)
import qualified Data.Map as Map
import Data.Maybe (fromMaybe)

safeHead :: [a] -> Maybe a
safeHead [] = Nothing
safeHead (x : xs) = Just x

lowercaseMap = Map.fromList zippedLowercase
zippedLowercase = zip allLowerCase allLowerCasePrio
allLowerCasePrio = [1..26]
allLowerCase = ['a'..'z']

uppercaseMap = Map.fromList zippedUppercase
zippedUppercase = zip allUpperCase allUpperCasePrio
allUpperCasePrio = [27..52]
allUpperCase = ['A'..'Z']

splitHalve line = splitAt ((length line + 1) `div` 2) line

sortHalves (a:b:_) = (sort a, sort b)

intersecting (c1,c2) = c1 `intersect` c2

getPrioSum :: [Char] -> Int
getPrioSum line = fromMaybe 0 (Map.lookup (fromMaybe ' ' (safeHead (intersecting (splitHalve line)))) lowercaseMap) +
    fromMaybe 0 (Map.lookup (fromMaybe ' ' (safeHead (intersecting (splitHalve line)))) uppercaseMap)

calc :: Foldable t => t [Char] -> Int
calc = foldl
    ( \total x ->
        total + getPrioSum x
    )
    0

main :: IO ()
main = do
  fileData <- readFile "input.txt"
  let strs = lines fileData
  let result = calc strs
  print result