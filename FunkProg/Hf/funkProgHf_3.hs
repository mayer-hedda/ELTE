module Example where

-- 1. feladat:
indexOfArg :: Integer -> Integer -> Integer -> Integer

indexOfArg 0 _ _ = 1
indexOfArg _ 0 _ = 2
indexOfArg _ _ 0 = 3
indexOfArg _ _ _ = -1


-- 2. feladat:
evenSum :: Integer -> Integer -> Integer -> Bool

evenSum a b c = (a + b + c) `mod` 2 == 0