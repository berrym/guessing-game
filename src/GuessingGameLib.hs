module GuessingGameLib
  (
    genSecret,
    takeTurn
  ) where

-- Random number guessing game lib

import System.Random

-- Generate the random "secret" number
genSecret :: Int -> IO Int
genSecret max_secret = do
  secret <- randomRIO (0, max_secret)
  return secret

-- Get a guess from the player
getGuess :: IO Int
getGuess = do
  guess <- getLine
  return $ read guess

-- Second step in processing a players' guess
turnStep :: Int -> Int -> Int -> IO ()
turnStep secret guess limit
  | guess > secret = takeTurn secret limit ("Too high!\nGuess a number between 1 and " ++ show limit) 
  | guess < secret = takeTurn secret limit ("Too low!\nGuess a number between 1 and " ++ show limit)
  | otherwise = putStrLn ("Correct! The secret number is " ++ show secret ++ ".")

-- Begin a players' turn
takeTurn :: Int -> Int -> String -> IO ()
takeTurn secret limit prompt = do
  putStrLn prompt
  guess <- getGuess
  turnStep secret guess limit
