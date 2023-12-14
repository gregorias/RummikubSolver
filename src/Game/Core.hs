-- | Core primitives for representing a Rummikub game.
module Game.Core (
  -- * Data types
  Color (..),
  Value,
  minValue,
  maxValue,
  allValues,
  Tile (..),
  Set,
) where

import Closed (Closed, unsafeClosed)

-- | The color of a tile.
data Color = Red | Blue | Yellow | Black deriving stock (Bounded, Enum, Eq, Show)

type Value = Closed 1 13

minValue :: Int
minValue = fromIntegral $ minBound @Value

maxValue :: Int
maxValue = fromIntegral $ maxBound @Value

allValues :: [Closed 1 13]
allValues = [minBound .. maxBound]

-- | A single tile in the game.
data Tile = ValueTile (Value, Color) | Joker deriving stock (Eq, Show)

instance Bounded Tile where
  minBound = ValueTile (minBound, minBound)

  maxBound = Joker

instance Enum Tile where
  fromEnum (ValueTile (v, c)) =
    fromEnum c
      * maxValue
      + fromIntegral v
      - 1
  fromEnum Joker = 4 * maxValue

  toEnum n
    | n < 0 || n > 4 * maxValue = Joker
    | n == 4 * maxValue = Joker
    | otherwise = ValueTile (unsafeClosed (fromIntegral v), c)
   where
    v :: Int
    v = n `mod` maxValue + 1
    c = toEnum $ n `div` maxValue

type Set = [Tile]
