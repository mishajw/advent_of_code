import qualified Data.Sequence as DS
import qualified Data.Set as DSt
import qualified Data.Map.Strict as DM

type Bins = DS.Seq Int

main :: IO ()
main = do
  bins <- getFile "inputs/day6.txt"
  print $ stepsUntilCycle bins
  print $ cycleSize bins

stepsUntilCycle :: Bins -> Int
stepsUntilCycle = stepsUntilCycle' 0 DSt.empty
  where
    stepsUntilCycle' :: Int -> DSt.Set Bins -> Bins -> Int
    stepsUntilCycle' step seen bins =
      let nextBins = redistributeMax bins in
      if DSt.member nextBins seen
      then step + 1
      else stepsUntilCycle' (step + 1) (DSt.insert nextBins seen) nextBins

cycleSize :: Bins -> Int
cycleSize = cycleSize' 0 DM.empty
  where
    cycleSize' :: Int -> DM.Map Bins Int -> Bins -> Int
    cycleSize' step seen bins =
      let nextBins = redistributeMax bins in
      case DM.lookup nextBins seen of
        Just lastStep -> step - lastStep
        Nothing -> cycleSize' (step + 1) (DM.insert nextBins step seen) nextBins

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

