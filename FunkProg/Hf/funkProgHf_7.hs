module FunkProgHf_7 where
import Data.Char

-- 1. feladat: Lista feldarabolása
runs :: Int -> [a] -> [[a]]

runs i [] = []
runs i l = (take i l) : runs i (drop i l)


-- 2. feladat: Számtani sorozat m-től végtelenig adott lépésközzel
myEnumFromThen :: Integer -> Integer -> [Integer]

myEnumFromThen a b = a : myEnumFromThen b (b + b - a)


-- 3. feladat: Nagybetűk megtartása
onlyUppers :: String -> String

onlyUppers "" = []
onlyUppers (x:xs)
    |isUpper x = x : onlyUppers xs
    |otherwise = onlyUppers xs


-- 4. feladat: Rendezett beszúrás (insert)
ordInsert :: Ord a => a -> [a] -> [a]

ordInsert x [] = [x]
ordInsert x (y:ys)
    |x > y = y : ordInsert x ys
    |otherwise = x:y:ys


-- 5. feladat: Lista szuffixumai (tails)
suffixes :: [a] -> [[a]]

suffixes [] = [[]]
suffixes (x:xs) = (x:xs) : suffixes xs