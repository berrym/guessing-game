module Main where

-- Random number guessing game

import GuessingGameLib

main :: IO ()
main = do
  secret <- genSecret limit
  takeTurn secret (1, limit) ("Get a number between 1 and " ++ show limit)
  where limit = 100
