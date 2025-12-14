module FunkProgHf_12 where

-- 1. feladat:
myAll :: (a -> Bool) -> [a] -> Bool

myAll x = and . map x


-- 2. feladat:
applyOnNeighbours :: (a -> a -> b) -> [a] -> [b]

applyOnNeighbours x xs = zipWith x xs (tail xs)