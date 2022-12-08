{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}

{-# HLINT ignore "Redundant if" #-}
import Data.List
import qualified Data.Map as Map
import Data.Maybe (fromMaybe)

convert :: [Char] -> [Int]
convert = map (read . (: []))

visible :: Ord t => [[t]] -> Int -> Int -> Int -> Int -> t -> Bool
visible grid x y dy dx hgt
  | xdx <= 0 || xdx >= bounds || ydy <= 0 || ydy >= bounds = True
  | (grid !! xdx !! ydy) >= hgt = False
  | otherwise = visible grid xdx ydy dy dx hgt
  where
    xdx = x + dx
    ydy = y + dy
    bounds = length grid

score v1 v2 v3 v4 = if v1 || v2 || v3 || v4 then 1 else 0

calc :: [[Int]] -> Int -> Int -> Int -> Int
calc grid x y total
  | xbounds && ybounds = calc grid (x + 1) y sum
  | xequals && ybounds = calc grid 0 (y + 1) total
  | otherwise = total
  where
    ybounds = y < length grid
    xbounds = x < length grid
    xequals = x == length grid
    height = grid !! x !! y
    v1 = visible grid x y 1 0 height
    v2 = visible grid x y 0 1 height
    v3 = visible grid x y (-1) 0 height
    v4 = visible grid x y 0 (-1) height
    sum = score v1 v2 v3 v4 + total

main :: IO ()
main = do
  fileData <- readFile "test.txt"
  let strs = lines fileData
  let forrest = map convert strs
  let sum = calc forrest 0 0 0
  print sum
