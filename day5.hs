import qualified Data.Sequence as DS

type Instructions = DS.Seq Int
type IncrementRule = Int -> Int

main :: IO ()
main = do
  input <- getFile "inputs/day5.txt"
  let firstSteps = getSteps firstIncrementRule input
  let secondSteps = getSteps secondIncrementRule input
  putStrLn $ "First steps: " ++ show firstSteps
  putStrLn $ "Second steps: " ++ show secondSteps

getFile :: String -> IO Instructions
getFile path = do
  input <- readFile path
  return $ DS.fromList . map read . lines $ input

firstIncrementRule :: IncrementRule
firstIncrementRule = (+1)

secondIncrementRule :: IncrementRule
secondIncrementRule x = if x >= 3 then x - 1 else x + 1

getSteps :: IncrementRule -> Instructions -> Int
getSteps rule = getSteps' 0 0
  where
    getSteps' :: Int -> Int -> Instructions -> Int
    getSteps' step index instructions =
      case DS.lookup index instructions of
        Just instruction ->
          getSteps'
            (step + 1)
            (index + instruction)
            (DS.adjust rule index instructions)
        Nothing -> step

