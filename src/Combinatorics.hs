module Combinatorics (generateCombinations) where

-- | Generates all combinations without repetition of given length.
generateCombinations ::
  -- | source list
  [a] ->
  -- | size of combinations
  Int ->
  -- | possible combinations
  [[a]]
generateCombinations [] n
  | n == 0 = [[]]
  | otherwise = []
generateCombinations (s : ss) n
  | n < 0 = []
  | n == 0 = [[]]
  | otherwise =
      map (s :) (generateCombinations ss (n - 1))
        ++ generateCombinations ss n
