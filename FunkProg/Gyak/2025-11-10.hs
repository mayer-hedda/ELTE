{- 
    Taple:
        - (2, [])
        - (2, "abc")
        - (2, [3, 4])
 -}

--
{- Órák és percek -}
time :: [(Int, Int)]

time = [(a, b) | a <- [0..23], b <- [0..59]]

--
{- Dominók -}
dominoes :: Integer -> [(Integer, Integer)]

dominoes n = [(a, b) | a <- [0..n], b <- [0..n], a <= b]

--
{- Monoton növekvő sorozat -}
monotonousSeq :: Int -> [Int]

monotonousSeq n = [a | a <- [1..n], b <- [1..a]]

--
{- Sorszámozás -}
indexString :: [Char] -> [(Integer, Char)] -- String -> [(Integer, Char)]

indexString x = zip [1..] x

--
{- Hegy függvény -}
mountain :: Integer -> [Integer]

mountain 0 = []
mountain n = concat [1..n-2] [n..2]

--
{-  -}
second :: (a, b) -> b

second (a, b) = b

--
{-  -}
swap :: (a, b) -> (b, a)

swap (a, b) = (b, a)

--
{-  -}
mirrorP :: (Integer, Integer) -> (Integer, Integer) -> (Integer, Integer)

mirrorP (p, q) (x, y) = (p-(x-p), q-(y-q))

--
{-  -}
distance :: (Double, Double) -> (Double, Double) -> Double

