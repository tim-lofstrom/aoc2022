replaceMin :: Ord a => [a] -> a -> [a]
replaceMin [] y = [y]
replaceMin [x] y = [max x y]
replaceMin (x : xs) y =
  if y > x
    then max x y : replaceMin xs x
    else x : replaceMin xs y


findMax :: Foldable t => t [Char] -> (Int, Int)
findMax = foldl
    ( \(totalMax, currentMax) x ->
        if x /= ""
          then (totalMax, currentMax + (read x :: Int))
          else (max totalMax currentMax, 0)
    )
    (0, 0)

findMax3 :: Foldable t => t [Char] -> ([Int], Int)
findMax3 = foldl
    ( \(totalMax, currentMax) x ->
        if x /= ""
          then (totalMax, currentMax + (read x :: Int))
          else (replaceMin totalMax currentMax, 0)
    )
    ([0, 0, 0], 0)

main :: IO ()
main = do
  fileData <- readFile "input.txt"
  let strs = lines fileData
  print (fst (findMax strs))
  print (sum (fst(findMax3 strs)))