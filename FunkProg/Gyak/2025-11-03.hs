-- Több lista összefűzése
myConcat :: [[a]] -> [a]

myConcat [] = []
myConcat (x:xs) = x ++ myConcat xs


-- Lista feldarabolása
runs :: Int -> [a] -> [[a]]

runs i [] = []
runs i l = (take i l) : runs i (drop i l)


-- Számtani sorozat m-től végtelenig adott lépésközzel (enumFromThen)
myEnumFromThen :: Integer -> Integer -> [Integer]

myEnumFromThen a b = a : myEnumFromThen b (b + b - a)


-- 2 hatványai n kitevőig
powersOf2 :: Int -> [Integer]

powersOf2 n = [2 ^ n | n <- [0..n]]


-- False és True felváltva
oddEven :: Int -> [Bool]

oddEven 0 = []
oddEven n = [n `mod` 2 == 0 | n <- [1..n]]


-- Elem n-szeri ismétlése (replicate)
myReplicate :: Int -> a -> [a]

myReplicate n e = [e | n <- [1..n]]


-- Nagy 2 hatvány keresés
powerOfTwo :: Integer -> Integer

powerOfTwo n = head [2 ^ i | i <- [0..], (2 ^ i) > n]


-- 2 hatvány kitevő keresés
exponentOf2 :: Integer -> Integer

exponentOf2 n = head [i | i <- [0..], (3 ^ i) > n]


-- Prímvizsgálat
isPrime :: Integer -> Bool

-- isPrime x = length (divisors x) == 2
isPrime x = length [i | i <- [1..x], x `mod` i == 0] == 2


-- n-nél kisebb prímek listája
primesToN :: Integer -> [Integer]

primesToN n = [n | n <- [1..n], length (divisors n) == 2]