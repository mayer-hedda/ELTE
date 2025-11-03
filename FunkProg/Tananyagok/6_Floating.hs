module Floating where

{-
    Lebegőpontos számok:
        - Float: egyszeres pontosságú
            `1 / 3 :: Float`        =>      0.33333334 :: Float

        - Double: dupla pontosságú (ezt fogjuk használni a félévben)
            `1 / 3 :: Double`       =>      0.3333333333333333 :: Double

        `4.2`       =>      4.2 :: Double
        `42e-1`     =>      4.2 :: Double
        `4200e-3`   =>      4.2 :: Double
        `0.042e2`   =>      4.2 :: Double


        FONTOS: 
            - Nem mindig pontosak a lebegőpontos számok
                `1.1 - 1.0 :: Double`       =>      0.10000000000000009 :: Double
            
            - Nem kell mindig kiírni a tizedespont utáni részt, amennyiben az 0
-}

{-
    Alapvető műveletek:
        - Összeadás:
            `:t (+)`        =>      (+) :: Num a => a -> a -> a

        - Kivonás:
            `:t (-)`        =>      (-) :: Num a => a -> a -> a

        - Szorzás:
            `:t (*)`        =>      (*) :: Num a => a -> a -> a

        - Osztás:
            `:t (/)`        =>      (/) :: Fractional a => a -> a -> a

        - Hatványozás (Nem lehet a kitevő negatív, csak egész számokkal működik):
            `:t (^)`        =>      (^) :: (Integral b, Num a) => a -> b -> a

        - Hatványozás (Itt lehet a kitevő negatív, csak egész számokkal működik):
            `:t (^^)`       =>      (^^) :: (Fractional a, Integral b) => a -> b -> a

        - Hatványoszás (Csak lebegőpontos számokkal működik):
            `:t (**)`       =>      (**) :: Floating a => a -> a -> a

        - Negálás:
            `-42.5`         =>      -42.5 :: Double
            `negate 42.5`   =>      -42.5 :: Double

        - Gyökvonás:
            `:t sqrt`       =>      sqrt :: Floating a => a -> a
-}


{- # Definiáld azt a függvényt, ami megadja egy r sugarú gömb térfogatát!

Megjegyzés: Használjuk a pi függvényt, amely a π értékét adja meg kellő pontossággal. A gömb térfogata 4r^3π/3 képlettel adható meg. -}
sphereVolume :: Double -> Double

sphereVolume r = (4 * (r ^ 3) * pi) / 3