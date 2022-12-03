{-# OPTIONS_GHC -Wno-incomplete-patterns #-}

import Data.List (intersect, sort)
import qualified Data.Map as Map
import Data.Maybe (fromMaybe)

safeHead :: [a] -> Maybe a
safeHead [] = Nothing
safeHead (x : xs) = Just x

lowercaseMap = Map.fromList zippedLowercase

zippedLowercase = zip allLowerCase allLowerCasePrio

allLowerCasePrio = [1 .. 26]

allLowerCase = ['a' .. 'z']

uppercaseMap = Map.fromList zippedUppercase

zippedUppercase = zip allUpperCase allUpperCasePrio

allUpperCasePrio = [27 .. 52]

allUpperCase = ['A' .. 'Z']

splitHalve line = splitAt ((length line + 1) `div` 2) line

sortHalves (a : b : _) = (sort a, sort b)

intersecting (c1, c2) = c1 `intersect` c2

getPrioSum :: [Char] -> Int
getPrioSum line =
  fromMaybe 0 (Map.lookup (fromMaybe ' ' (safeHead (intersecting (splitHalve line)))) lowercaseMap)
    + fromMaybe 0 (Map.lookup (fromMaybe ' ' (safeHead (intersecting (splitHalve line)))) uppercaseMap)


getPrioSum2 :: [Char] -> Int
getPrioSum2 line = 
  fromMaybe 0 (Map.lookup (fromMaybe ' ' (safeHead line)) lowercaseMap)
    + fromMaybe 0 (Map.lookup (fromMaybe ' ' (safeHead line)) uppercaseMap)

testa line = intersecting (splitHalve line)

findCommon e1 e2 e3 = e1 `intersect` e2 `intersect` e3

findCommonAdd e1 e2 e3 = getPrioSum2 (findCommon e1 e2 e3)

calc :: Foldable t => Map.Map Int [Char] -> t Int -> Int
calc theMap =
  foldl
    ( \total x ->
        total
          + findCommonAdd
            (fromMaybe "" (Map.lookup x theMap))
            (fromMaybe "" (Map.lookup (x + 1) theMap))
            (fromMaybe "" (Map.lookup (x + 2) theMap))
    )
    0

allNumbers :: [Int]
allNumbers = [0 .. 299]

allNumbers2 :: [Int]
allNumbers2 = [0 .. 99]

allNumbers3 :: [Int]
allNumbers3 = map (* 3) allNumbers2

indexFrom :: Int -> Int
indexFrom x = div x 3

main :: IO ()
main = do
  fileData <- readFile "input.txt"
  let strs = lines fileData
  let zipped = zip allNumbers strs
  let theMap = Map.fromList zipped
  print theMap
  let result = calc theMap allNumbers3
  print result