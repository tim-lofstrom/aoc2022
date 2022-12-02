{-# OPTIONS_GHC -Wno-incomplete-patterns #-}

-- A Rock, B Paper, C Scissor
-- X Rock, Y Paper, Z Scissor

draw = 3
win = 6

winPoints "A" "Y" = win
winPoints "B" "Z" = win
winPoints "C" "X" = win
winPoints "A" "X" = draw
winPoints "B" "Y" = draw
winPoints "C" "Z" = draw
winPoints _ _ = 0

shapePoints "X" = 1
shapePoints "Y" = 2
shapePoints "Z" = 3
shapePoints _ = 0

stringToSum (x:y:_) = winPoints x y + shapePoints y

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