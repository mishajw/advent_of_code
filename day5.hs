type IncrementRule = Int -> Int

main :: IO ()
main = do
  input <- getFile "inputs/day5.txt"
  let firstSteps = getSteps firstIncrementRule input
  let secondSteps = getSteps secondIncrementRule input
  putStrLn $ "First steps: " ++ show firstSteps
  putStrLn $ "Second steps: " ++ show secondSteps

getFile :: String -> IO [Int]
getFile path = do
  input <- readFile path
  return $ map read . lines $ input

firstIncrementRule :: IncrementRule
firstIncrementRule = (+1)

secondIncrementRule :: IncrementRule
secondIncrementRule x = if x > 3 then x - 1 else x + 1

getSteps :: IncrementRule -> [Int] -> Int
getSteps rule instructions = getSteps' 0 0 instructions
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
      take index instructions ++ rule (instructions !! index) : drop (index + 1) instructions

