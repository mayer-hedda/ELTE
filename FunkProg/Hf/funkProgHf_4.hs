module Example where

-- 1. feladat: Egyszerüsített dátum helyessége
isValidDateSimple :: Integer -> Integer -> Bool

isValidDateSimple x y
    | x `elem` [1, 3, 5, 7, 8, 10, 12] = y <= 31 && y >= 1
    | x `elem` [4, 6, 9, 11] = y <= 30 && y >= 1
    | x == 2 = y <= 28 && y >= 1
    | otherwise = False


-- 2. feladat: Fibonacci számok
fibonacci :: Int -> Int

fibonacci 0 = 0
fibonacci 1 = 1
fibonacci x = fibonacci (x-1) + fibonacci(x-2)


-- Opcionális feladat: Dátum pontos helyessége
isLeapYear :: Integer -> Bool

isLeapYear x = (x `mod` 4 == 0 && x `mod` 100 /= 0) || x `mod` 400 == 0


isValidDate :: Integer -> Integer -> Integer -> Bool

isValidDate y m d
    | m `elem` [1, 3, 5, 7, 8, 10, 12] = d <= 31 && d >= 1
    | m `elem` [4, 6, 9, 11] = d <= 30 && d >= 1
    | m == 2 = (isLeapYear y && d <= 29 && d >= 1) || (not (isLeapYear y) && d <= 28 && d >= 1)
    | otherwise = False