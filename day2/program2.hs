{-# OPTIONS_GHC -Wno-incomplete-patterns #-}

-- A Rock, B Paper, C Scissor
-- X Lose, Y Draw, Z Win

loose = 0
draw = 3
win = 6

winPoints :: [Char] -> Int
winPoints "X" = loose
winPoints "Y" = draw
winPoints "Z" = win
winPoints _ = loose

invertPoints "X" x = shapePoints (loosingMove x)
invertPoints "Y" x = shapePoints x
invertPoints "Z" x = shapePoints (winningMove x)
invertPoints _ _ = 0

shapePoints "A" = 1
shapePoints "B" = 2
shapePoints "C" = 3
shapePoints _ = 0

loosingMove "A" = "C"
loosingMove "B" = "A"
loosingMove "C" = "B"

winningMove "A" = "B"
winningMove "B" = "C"
winningMove "C" = "A"

stringToSum (x:y:_) = winPoints y + invertPoints y x

calc :: Foldable t => t [Char] -> Int
calc = foldl
    ( \total x ->
        total + stringToSum (words x)
    )
    0

main :: IO ()
main = do
  fileData <- readFile "input.txt"
  let strs = lines fileData
  let result = calc strs
  print result