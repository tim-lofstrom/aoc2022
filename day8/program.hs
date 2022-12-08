import Data.List
import qualified Data.Map as Map
import Data.Maybe (fromMaybe)

convert :: [Char] -> [Int]
convert = map (read . (: []))

main :: IO ()
main = do
  fileData <- readFile "test.txt"
  let strs = lines fileData
  let forrest = map convert strs
  print forrest
