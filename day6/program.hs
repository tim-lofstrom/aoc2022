import Data.List (nub)

calc numbers [] list = calc numbers (take numbers list) (drop 1 list)
calc numbers window rest =
  if length (nub window) == numbers
    then numbers
    else calc numbers (take numbers rest) (drop 1 rest) + 1

main :: IO ()
main = do
  line <- readFile "input.txt"
  print (calc 4 [] line)
  print (calc 14 [] line)