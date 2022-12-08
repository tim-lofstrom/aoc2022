import Data.List
import qualified Data.Map as Map
import Data.Maybe (fromMaybe)

calc (line:lines) cwd ["$", "cd", ".."] tree = calc lines (init cwd) (words line) tree
calc (line:lines) cwd ["$", "cd", dir] tree = calc lines (cwd ++ [dir]) (words line) (Map.insert (intercalate "/" cwd) 0 tree)
calc (line:lines) cwd [size, _] tree = calc lines cwd (words line) (Map.insert (intercalate "/" cwd) (read size :: Int) tree)
calc (line:lines) cwd [] tree = calc lines cwd (words line) tree
calc _ _ _ tree = tree

root :: Map.Map [Char] Int
root = Map.empty

main :: IO ()
main = do
  fileData <- readFile "input.txt"
  let strs = lines fileData
  let tree = calc strs [] [] root
  let result = Map.lookup "/" tree
  print tree
  print result