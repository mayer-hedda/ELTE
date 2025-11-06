-- 1. feladat: Lista feldarabolása
runs :: Int -> [a] -> [[a]]

runs i [] = []
runs i l = (take i l) : runs i (drop i l)


-- 2. feladat: Számtani sorozat m-től végtelenig adott lépésközzel
myEnumFromThen :: Integer -> Integer -> [Integer]

myEnumFromThen a b = a : myEnumFromThen b (b + b - a)


-- 3. feladat: Nagybetűk megtartása
