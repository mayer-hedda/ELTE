module Guards where

{-
    Esetszétválasztás:
        min x y
            | x <= y  =  x
            | x >  y  =  y

        VAGY

        min x y
            | x <= y  =  x
            | otherwise  =  y

        
        Szintaxis:
            | őrfeltétel = kifejezés

            Az esetszétválasztás szemantikája: Az őrfeltételeket, a mintákhoz hasonlóan, fentről lefelé vizsgáljuk. 
            A függvény eredményét az első igaz őrfeltéthez tartozó függvényág törzse lesz.

        
        `otherwise == True`     =>      True :: Bool
-}


{- # Definiáljuk az abszolút érték függvényt. -}
myAbs :: Integer -> Integer

myAbs x
    |x < 0 = negate x
    |otherwise = x


{- # Definiáljuk azt a függvényt, amely egy egész számnak megadja az előjelét. Pozitív szám esetén 1-et, negatív szám esetén -1-et, különben pedig 0-t adjon. -}
sign :: Integer -> Integer

sign x 
    |x < 0 = -1
    |x > 0 = 1
    |otherwise = 0


{- # Definiáljunk az swapUpperLower függvényt, amely a kisbetűt a megfelelő nagybetűre alakítja, és fordítva.

A megoldásban szükségünk lehet a Data.Char modul függvényeire: isUpper, isLower, toUpper és toLower. Keressünk ezekre rá a dokumentációban Hoogle és nézzük meg hogyan működnek.

A függvények használatához szükséges a Data.Char modul importálása. Ezt az alábbi importok valamelyikével tudjuk megtenni, másoljuk az egyiket a modulunk elejére (a modul fejléce után közvetlenül): -}
import Data.Char -- a teljes modult importálja
import Data.Char (isUpper, isLower, toUpper, toLower) -- csak a megadott függvényeket importálja
swapUpperLower :: Char -> Char

swapUpperLower x
    |isUpper x = toLower x
    |otherwise = toUpper x


{- # A korábbi feladatsorban a faktoriális függvényen keresztül vezettük be a rekurziót. Idézzük fel ezt a definíciót:

fact :: Integer -> Integer
fact 0 = 1
fact n = n * fact (n-1)

Ez a definíció csak nemnegatív értékekre tud eredményt adni. Gondoljuk meg, hogy mi történik, ha egy negatív értékre alkalmazzuk a függvényt. (Negatív érték esetén tovább csökkentgeti a paraméterül kapott értéket és mínusz végtelenig teszi ezt, azaz sosem érjük el a megállási feltételünket a 0-t.)

Adjunk a definícióhoz egy őrfeltételt, hogy a függvény csak nemnegatív értékekre működjön. Persze, ezzel egy parciálisan definiált függvényt kapunk (van olyan egész érték, amire nem ad eredményt), de legalább nem kerül a függvény végtelen rekurzióba. Nézzük meg a teszteseteket, ebből látszik hogyan kezeletlen eset lesz a negatív szám esetén (Exception: … Non-exhaustive patterns in function …). -}
fact :: Integer -> Integer

fact 0 = 1
fact n 
    |n > 0 = n * fact (n-1)


{- # Definiáljuk azt a rekurzív függvényt, amely egy paraméterül kapott n egész értékig előállítja a számok összegét (0 és n között). Ha a paraméterül kapott érték nem pozitív, akkor az összeg legyen 0. -}
sumTo :: Integer -> Integer

sumTo x
    |x <= 0 = 0
    |otherwise = x + sumTo (x - 1)


{- # Definiáljuk azt a rekurzív függvényt, amely két paraméterül kapott n és m egész érték között előállítja a számok összegét. A paraméterekről nem feltételezhetünk semmit, azaz az első lehet kisebb mint a második, a második kisebb mint az első, esetleg egyenlőek.

Segítség: Gondolkodhatunk abban, hogy definiálunk egy segédfüggvényt, amely már “jól” kapja meg a paramétereket (a megfelelő sorrendben) és ez a függvény végzi el az összegzést. Ez a módszer teljesen elfogadott és a jövőben is gyakran használjuk. -}
sumBetween :: Integer -> Integer -> Integer

sumBetween x y
    |x > y = sumBetweenHelper y x
    |otherwise = sumBetweenHelper x y

sumBetweenHelper :: Integer -> Integer -> Integer

sumBetweenHelper x y
    |x == y = y
    |otherwise = x + sumBetween (x + 1) y


{- # Definiáljuk azt a rekurzív függvényt, amely paraméterül kap két egész értéket n és m egész érték között megadja a számok négyzeteinek összegét, amennyiben ez nem üres tartományt definiál. Azaz, az n ^ 2, (n + 1) ^ 2, …, m ^ 2 számok összegét. A számot megszorozhatjuk önmagával, de használhatjuk a hatványozás műveletét is (^). -}
sumSquaresFromTo :: Integer -> Integer -> Integer

sumSquaresFromTo x y
    |x > y = 0
    |x == y = y ^ 2
    |otherwise = (x ^ 2) + sumSquaresFromTo (x + 1) y


{- # Definiáljuk a négyzetre emelés műveletét a szorzás segítségével. Ez a függvény segédfüggvénye lesz a következő feladatnak. -}
sqr :: Integer -> Integer

sqr x = x * x


{- # Korábban megadtunk egy egyszerű rekurzív definíciót a hatványozás művelethez. Ezt úgy adtuk meg, hogy az n-edik hatványt n-szeri szorzással fejeztük ki. A jelenlegi feladatban javítunk a hatványozás hatékonyságán, mégpedig úgy, hogy megpróbáljuk a szorzások számát redukálni.

A gyorsítás abban jelentkezik, hogy páros kitevő esetén csak a kitevő felének megfelelő hatványt számoljuk ki és azt megszorozzuk önmagával az sqr függvény segítségével. A matematikai léírásban az sqr az előbb megadott függvényre hivatkozik. Fontos, hogy ezt használjuk is! -}
pwr :: Integer -> Integer -> Integer

pwr x n
    |n == 0 = 1
    |n `mod` 2 == 1 = x * x ^ (n - 1)
    |otherwise = sqr x ^ (n `div` 2)


{- # Definiáld azt a függvényt, amely 0-100 intervallumba eső pontszám alapján meghatározza az érdemjegyet az alábbiak alapján: -}
grading :: Integer -> Integer

grading x
    |x <= 100 && x >= 90 = 5
    |x >= 80 = 4
    |x >= 70 = 3
    |x >= 60 = 2
    |otherwise = 1


{- # Definiáld azt a függvényt, amely egy másodfokú egyenlet a, b, és c együtthatóit kapja (ax2 + bx + c = 0), és megmondja, hogy hány valós gyöke van az egyenletnek.

A valós gyökök száma a diszkriminánstól (D = b^2 − 4ac) függ:
    - D>0: 2 valós gyök
    - D=0: 1 valós gyök
    - D<0: 0 valós gyök
-}
numOfSolutions :: Integer -> Integer -> Integer -> Integer

numOfSolutions a b c
    |(b ^ 2) - 4 * a * c > 0 = 2
    |(b ^ 2) - 4 * a * c == 0 = 1
    |otherwise = 0


{- # Definiáld azt a függvényt, amely két egész számot vár (órát és percet) és megvizsgálja, hogy a kapott értékek érvényes időpontot adnak-e. Érvényes időpontnak tekintjük, ha a első paraméter 0−23 közé, a második 0−59 közé esik. -}
validTime :: Integer -> Integer -> Bool

validTime h m
    |h >= 0 && h <= 23 && m >= 0 && m <= 59 = True
    |otherwise = False


{- # Definiáljuk azt a függvényt, amely megadja π közelítő értékét a Leibniz-féle sor részleges előállításával! A képlet a következő:

Természetesen ezt mi csak közelítjük, azaz, a paraméterül kapott n első elem összegét fogjuk venni.

A megoldáshoz szükségünk lesz egy segédfüggvényre, amely:
    - számon tartja, hogy hány tagot képeztünk eddig,
    - számon tartja a tört érték nevezőjét és előjelét,
    - lépésenként állítja elő a törtet a számon tartott nevező felhasználásával és
    - rekurzívan halad tovább, karban tartva a paramétereket következő lépéshez: lépésszám, nevező és annak előjele.

(A fenti segédfüggvény és paraméterei csak egy ajánlás, attól szabadon el lehet térni.)

FONTOS: Ne feledjük a segédfüggvény eredményét 4-gyel megszorozni, hogy a π értéket kapjuk. -}
leibniz :: Integer -> Double

leibniz n = 4 * leibnizAcc n 1 1 0

leibnizAcc :: Integer -> Double -> Double -> Double -> Double

leibnizAcc 0 _ _ acc = acc
leibnizAcc n denom sign acc = leibnizAcc (n - 1) (denom + 2) (-sign) (acc + sign / denom)