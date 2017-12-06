import qualified Data.Sequence as DS
import qualified Data.Set as DSt

type Bins = DS.Seq Int

main :: IO ()
main = do
  bins <- getFile "inputs/day6.txt"
  print $ countCycle bins

countCycle :: Bins -> Int
countCycle = countCycle' 0 DSt.empty
  where
    countCycle' :: Int -> DSt.Set Bins -> Bins -> Int
    countCycle' step seen bins =
      let nextBins = redistributeMax bins in
      if DSt.member nextBins seen
      then step + 1
      else countCycle' (step + 1) (DSt.insert nextBins seen) nextBins

redistributeMax :: Bins -> Bins
redistributeMax bins =
  let (maxValue, maxIndex) = argmax bins in
  let bins' = DS.update maxIndex 0 bins in
  redistribute bins' maxValue ((maxIndex + 1) `mod` binsLength)
  where
    argmax :: Foldable t => t Int -> (Int, Int)
    argmax is =
      let (maxValue, maxIndex, _) = foldl f (0, 0, 0) is in
      (maxValue, maxIndex)
      where
        f (maxValue, maxIndex, currentIndex) i =
          if i > maxValue
          then (i, currentIndex, currentIndex + 1)
          else (maxValue, maxIndex, currentIndex + 1)

    redistribute :: Bins -> Int -> Int -> Bins
    redistribute bins amount index
      | amount > 0 = redistribute
          (DS.adjust (+1) index bins)
          (amount - 1)
          ((index + 1) `mod` binsLength)
      | otherwise = bins

    binsLength = DS.length bins

getFile :: String -> IO Bins
getFile path = do
  input <- readFile path
  return $ DS.fromList . map read . words $ input

