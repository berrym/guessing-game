module GuessingGameLib
  (
    genSecret,
    getGuess,
    turnStep,
    takeTurn
  ) where

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
turnStep :: Int -> Int -> (Int, Int) -> IO ()
turnStep secret guess (low, high)
  | guess > secret = takeTurn secret (low, guess - 1) "Too high!"
  | guess < secret = takeTurn secret (guess + 1, high) "Too low!"
  | otherwise = putStrLn ("Correct! The secret number is " ++ show secret ++ ".")

-- Begin a players' turn
takeTurn :: Int -> (Int, Int) -> String -> IO ()
takeTurn secret limits prompt = do
  putStrLn prompt
  guess <- getGuess
  turnStep secret guess limits
