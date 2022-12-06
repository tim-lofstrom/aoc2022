

toCharArray :: String -> [Char]
toCharArray x = x

main :: IO ()
main = do
  fileData <- readFile "input.txt"
  let sum = toCharArray fileData
  print sum