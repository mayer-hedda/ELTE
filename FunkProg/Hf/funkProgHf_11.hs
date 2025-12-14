module FunkProgHf_11 where

import Data.Char (isDigit, digitToInt)


-- 1. feladat:
maybeSum :: [Maybe Int] -> Int

maybeSum [] = 0
maybeSum (Nothing : xs) = maybeSum xs
maybeSum (Just x : xs) = x + maybeSum xs


-- 2. feladat:
readIntHelper :: Integer -> String -> Maybe Integer
readIntHelper acc [] = Just acc
readIntHelper acc (x:xs)
  | isDigit x = readIntHelper (acc * 10 + toInteger (digitToInt x)) xs
  | otherwise = Nothing

readInt :: String -> Maybe Integer
readInt = readIntHelper 0