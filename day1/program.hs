{-# HLINT ignore "Eta reduce" #-}
{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
import Data.List (sort)

mylist = ["1", "6", "", "3"]

findMax list =
  foldl
    ( \(totalMax, currentMax) x ->
        if x /= ""
          then (totalMax, currentMax + (read x :: Int))
          else (max totalMax currentMax, 0)
    )
    (0, 0)
    list

replaceMin [x] y = [max x y]
replaceMin (x : xs) y =
  if y < x
    then x : replaceMin xs y
    else max x y : xs

findMax3 list =
  foldl
    ( \(totalMax, currentMax) x ->
        if x /= ""
          then (totalMax, currentMax + (read x :: Int))
          else (replaceMin (sort totalMax) currentMax, 0)
    )
    ([0, 0, 0], 0)
    list

main :: IO ()
main = do
  fileData <- readFile "input.txt"
  let strs = lines fileData
  print (sum (fst(findMax3 strs)))
  pure ()