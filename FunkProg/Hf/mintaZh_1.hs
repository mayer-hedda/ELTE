module MintaZh_1 where
import Data.Char

-- 1. feladat: Double-triple (1 pont)
doubleTriple :: [a] -> [a]

doubleTriple [] = []
doubleTriple [x] = [x, x, x]
doubleTriple [x, y] = [x, x, y, y]
doubleTriple xs = xs


-- 2. feladat: A rövidebb lista hossza (2 pont)
lengthOfShorter :: [a] -> [b] -> Integer

lengthOfShorter [] _ = 0
lengthOfShorter _ [] = 0
lengthOfShorter (_:xs) (_:ys) = 1 + lengthOfShorter xs ys


-- 3. feladat: Betűk összevonása (3 pont)
compressLetters :: String -> String

compressLetters [] = []
compressLetters [x] = [x]
compressLetters (x:y:xs)
  | isLower x && x == y = toUpper x : compressLetters xs
  | otherwise = x : compressLetters (y:xs)