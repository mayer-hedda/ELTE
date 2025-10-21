module Example where

-- 1. feladat: Hegy
mountain :: Integer -> [Integer]

mountain x
    |x <= 0 = []
    |otherwise = [1..x] ++ [x-1, x-2..1]


-- 2. feladat: Hullám
wave :: Integer -> [Integer]

wave x
    |x < 0 = []
    |otherwise = [0..x] ++ [x-1, x-2..(-x)] ++ [(-x)+1..0]