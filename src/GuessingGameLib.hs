module GuessingGameLib
  (
    genSecret,
    gameLoop
  ) where

-- Random number guessing game lib

import System.Random
import Text.Read

-- Generate the random "secret" number
genSecret :: Int -> IO Int
genSecret max_secret = do
  secret <- randomRIO (1, max_secret)
  return secret

-- Get a guess from the player
getGuess :: IO Int
getGuess = do
  guess <- getLine
  case readMaybe guess of
    Just x -> return x
    Nothing -> putStrLn("Invalid input! Try again.") >> getGuess

-- Second step in processing a players' guess
checkResult :: Int -> Int -> Int -> IO ()
checkResult secret guess limit
  | guess > secret = gameLoop secret limit ("Too high!\nGuess a number between 1 and " ++ show limit) 
  | guess < secret = gameLoop secret limit ("Too low!\nGuess a number between 1 and " ++ show limit)
  | otherwise = putStrLn("Correct! The secret number is " ++ show secret ++ ".")

-- Main game loop
gameLoop :: Int -> Int -> String -> IO ()
gameLoop secret limit prompt = do
  putStrLn prompt
  guess <- getGuess
  checkResult secret guess limit
