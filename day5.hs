main :: IO ()
main = do
  input <- getFile "inputs/day5.txt"
  let steps = getSteps input
  putStrLn $ "Steps: " ++ show steps

getFile :: String -> IO [Int]
getFile path = do
  input <- readFile path
  return $ map read . lines $ input

getSteps :: [Int] -> Int
getSteps instructions = getSteps' 0 0 instructions
  where
    getSteps' :: Int -> Int -> [Int] -> Int
    getSteps' step index instructions =
      if index < 0 || index >= instructionLength then step else
        getSteps'
          (step + 1)
          (index + instructions !! index)
          (incrementInstruction index instructions)

    instructionLength = length instructions

    incrementInstruction :: Int -> [Int] -> [Int]
    incrementInstruction index instructions =
      take index instructions ++ (instructions !! index) + 1 : drop (index + 1) instructions

