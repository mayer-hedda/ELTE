module Lists where

{-
    Listák:
        - Dinamikus, mert tetszőleges számú eleme lehet. Ez lehet üres, véges, de potenciálisan végtelen is.
        - Polimorf, mert tetszőleges típusú elemekből hozhatunk létre listát. (Ezt hamarosan tárgyaljuk.)
        - Homogén, mert a lista összes elemének azonos típusúnak kell lennie. Azaz, különböző típusú értékek nem keverhetők egy listába.
        - Lehetnek ismétlődések
        - Fontos az elemek sorrendje. Ha két lista ugyanazokból az értékekből áll, ezek csak akkor tekinthetők egyenlőnek, ha az azonos elemek ugyanabban a sorrendben szerepelnek mindkét listában.
        - Tetszőleges mélységben egymásba ágyazhatók, ami a polimorfizmusból következik. Persze a homogenitást szem előtt tartva, azaz minden elemének ugyanolyan típusú listának kell lennie.


        `:t [True, False]`      =>      [True, False] :: [Bool]
        `:t ['H', 'a', 's', 'k', 'e', 'l', 'l']`        =>      ['H', 'a', 's', 'k', 'e', 'l', 'l'] :: [Char]
        `:t [1, 2, 3, 4]`       =>      [1, 2, 3, 4] :: Num a => [a]


        A Haskell nyelvben nincs külön szöveg típus, hanem azt karakterek listájával adjuk meg. A String és a [Char] típusok teljes mértékben csereszabatosak, azaz ugyanazt jelentik. A String elnevezés csupán a kényelem szempontjából használatos.
-}

{-
    Pont-pont kifejezések:
        - Az alap lépésköz +1

        `[1..10]`       =>      [1, 2, 3, 4, 5, 6, 7, 8, 9, 10] :: [Integer]
        `[1,6..20]`     =>      [1, 6, 11, 16] :: [Integer]
        `[10,8..1]`     =>      [10, 8, 6, 4, 2] :: [Integer]
        `[1..]`         =>      végtelen sorozatot eredményez
        `[1,3..]`       =>      végtelen sorozat módosított lépsközzel
        `[0.1, 0.2 .. 3]`       =>      nem csak egész számokra írható pont-pont kifejezés
        `['a'..'z']     =>      "abcdefghijklmnopqrstuvwxyz" :: [Char]
-}

{-
    Alapvető listaműveletek:
        - Lista hossza (length):
            length :: [a] -> Int
            `length [4,7,8]`        =>      3 :: Int
        
        - Lista indexelése (!!):
            (!!) :: [a] -> Int -> a
            `['a','b','c'] !! 1`        =>      'b' :: Char
            `[1..] !! 20`       =>      21 :: Integer

        - Két lista összefűzése (++):
            (++) :: [a] -> [a] -> [a]
            `[1..5] ++ [6..15]`     =>      [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15] :: [Integer]

        - Lista összegzése (sum) - csak számokra értelmezhető:
            sum :: (Foldable t, Num a) => t a -> a
            `sum [1..10]`       =>      55 :: Integer
            `sum [1, 2, 34, 10, 21]`        =>      68 :: Integer

        - Lista elemeinek szorzata (product):
            product :: (Foldable t, Num a) => t a -> a
            `product [1..10]`       =>      3628800 :: Integer
            `product [1, 2, 34, 10, 21]`        =>      14280 :: Integer
-}

{-
    Listák mintaillesztése:
-}


{- # Definiáljuk azt a függvényt, amely egy paraméterül kapott érték és annak negáltja közötti értékekből képezett csökkenő sorozatot ad meg. -}
descending :: Integer -> [Integer]

descending x = [x, (x-1) .. negate x]


{- # Definiáljuk azt a függvényt, ami megadja az n-el osztható számok végtelen sorozatát. Pozitív érték esetén egy monoton növekvő végtelen sorozatot adjon eredményként, ellenkező esetben a sorozat legyen üres. -}
divByN :: Integer -> [Integer]

divByN x
    |x > 0 = [0, x ..]
    |otherwise = []


{- # Definiáljuk azt a függvényt, amely a megadott paraméterek segítségével előállít egy számtani sorozatot (ne foglalkozzunk a felső korlát megadásával) és annak megadja az i-edik elemét. A függvény első két paramétere adja meg a számtani sorozat első két elemét, a harmadik paraméter pedig a kívánt elem sorszáma. Ne feledjük, hogy az indexelés 0-tól kezdődik. -}
ithInSeq :: Integer -> Integer -> Int -> Integer

ithInSeq a b c = [a, b ..] !! (c - 1)


{- # Definiáljuk azt a függvényt, amely megadja az angol ábécé n-edik betűjét. A függvény nagy betűt adjon vissza, ha a logikai paraméter igaz és kisbetűt különben. Ügyeljünk arra, hogy a függvény csak a megfelelő indextartományból (0-25) fogadjon el értékeket. -}
nthLetter :: Int -> Bool -> Char

nthLetter x y
    |y == True = toUpper (['a' .. 'z'] !! x)
    |otherwise = ['a' .. 'z'] !! x


{- # Korábban már definiáltuk rekurzívan a faktoriális függvényt. Definiáljuk most újra ezt pont-pont kifejezés és az előbb bemutatott product függvény felhasználásával. -}
fact :: Integer -> Integer

fact n = product [1..n]


{- # Definiáljuk azt a függvényt, amely megadja, hogy n különböző elemet hányféleképpen lehet sorbarendezni. Feltehetjük, hogy a paraméterül kapott érték pozitív! -}
perm :: Integer -> Integer

perm n = product [1..n]


{- # Definiáljuk azt a függvényt, amely megadja, hogy hányféleképpen választhatunk ki n különböző elemből m elemet? -}
comb :: Integer -> Integer -> Integer

comb n k = fact n `div` (fact (n - k) * fact k)


