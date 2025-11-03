module Integral where

{-
    Haskellben több egésszám típús létezik, de csak 2-vel foglalkozunk:
    
    Int:
        - Fix pontosságú egész típús, adott bitszélességen kerül ábrázolásra
        - Ha meghaladja a megadott bitmennyiséget, abban az esetben túlcsordul és a negatív határtól folytatja

        `minBound :: Int`       =>      -9223372036854775808 :: Int
        `maxBound :: Int`       =>      9223372036854775807 :: Int

    Integer:
        - Tetszőleges pontosságú egész szám
        - Erre nem értelmezhető a minBound és maxBound függvény, mert nincsen felső/alsó korlátja
-}

{-
    Alapvető operátorok:
        - Összeadás:
            `:t (+)`        =>      (+) :: Num a => a -> a -> a

        - Kivonás:
            `:t (-)`        =>      (-) :: Num a => a -> a -> a

        - Szorzás:
            `:t (*)`        =>      (*) :: Num a => a -> a -> a

    
    Alapvető függvények:
        - Hányados képzés:
            `:t div`        =>      div :: Integral a => a -> a -> a

        - Maradékképzés:
            `:t mod`        =>      mod :: Integral a => a -> a -> a
-}

{-
    Kötési erősség:
        Minden operátornál adottnak kell lennie, hogy annak mi a kötési erőssége (gondoljunk az összeadás és a szorzás műveletére matematikából) és a kötési iránya (ha értelmezhető). A kötési erő 0-9 közötti érték, ahol a 0 a leggyengébb, a 9 a legerősebbet jelenti. A kötési irány szerepe, hogy ha több azonos kötési erősségű művelet szerepel egymás mellett, akkor azt milyen szabály mentén kell értelmezni. A kötési irány lehet bal, jobb és nem definiált (amennyiben nem értelmezhető). Ezek az információk természetesen mind benne vannak a dokumentációban, de az interpreterből is lekérdezhetők. Ilyet láthattunk a logikai VAGY műveletnél: infixr 2 ||. A későbbiekben ezt is részletesen megnézzük, hogy most ne vesszünk el túlzottan a részletekben.
-}

{-
    Rekurzió:
        Jellemzően a rekurzív függvény rekurzív függvényág(ak)ból és alapestből fog állni.

        Nézzük meg, hogy a fenti definíció hogyan néz ki Haskell függvényként megadva.
            fact :: Integer -> Integer
            fact 0 = 1
            fact n = n * fact (n-1)
-}


{- # Definiáljuk azt a függvényt, amely megduplázza a paraméterül kapott értéket. -}
double :: Integer -> Integer

double x = 2 * x


{- # Definiáljuk azt a függvényt, amely eldönti egy egész értékeről, hogy páros-e. A függvény even néven előredefiniált, így a jövőben az használandó. -}
isEven :: Integer -> Bool

isEven x = x `mod` 2 == 0


{- # Definiáljuk azt a függvényt, amely eldönti egy egész értékeről, hogy páratlan-e. A függvény odd néven előredefiniált, így a jövőben az használandó. -}
isOdd :: Integer -> Bool

isOdd x = x `mod` 2 == 1


{- # Definiáld azt a függvényt, amely megadja hogy az első paraméterként kapott érték osztója-e a második paraméterként kapott értéknek. -}
divides :: Integer -> Integer -> Bool

divides x y = y `mod` x == 0


{- # Definiáljuk azt a függvényt, amely egy háromszög három oldalai ismeretében eldönti, hogy a háromszög szerkeszthető-e.

Segítség: Egy háromszög akkor szerkeszthető, ha bármelyik két oldal hosszának összege nagyobb mint a harmadik oldal hossza. -}
triangleSides :: Integer -> Integer -> Integer -> Bool

triangleSides a b c = (a + b) > c && (a + c) > b && (b + c) > a


{- # Definiáld azt a függvényt, amely egy évszámról eldönti, hogy szökőév-e vagy sem.

Az évszám szökőév, ha
    - maradék nélkül osztható 4-gyel, de nem osztható 100-zal,
    - kivéve, ha osztható 400-zal.

Megjegyzés: A kód minőségét javítja, ha a korábban definiált függvényeket felhasználjuk. Adjuk meg a definíciót úgy is, hogy az előbbi függvényt felhasználjuk. -}
isLeapYear :: Integer -> Bool

isLeapYear x = (x `mod` 4 == 0 && x `mod` 100 /= 0) || x `mod` 400 == 0


{- # Definiáljuk azt a függvényt, amely egy egész értékről eldönti, hogy az 0-e vagy sem. -}
isZero :: Integer -> Bool

isZero 0 = True
isZero _ = False


{- # Definiáljuk a moduló 3 szorzást mintaillesztéssel! Feltehetjük, hogy paraméterként csak a 0,1 és 2 értékeket kaphatjuk és ezeknek megfelelő értéket ad. Azaz, a két számot összeszorozva az eredmény is a 3-al vett osztási maradék csoportba tartozzon. -}
mul3 :: Int -> Int -> Int

mul3 x y = (x * y) `mod` 3


{- # Reprezentáljuk a hét napjait 0-6 közötti értékekkel. A 0 jelentse a hétfőt, az 1 a keddet, stb.

Definiáljuk azt a függvényt, amely paraméterül kap egy 0-6 közötti értéket és megadja a rá következő nap sorszámát. Ügyeljünk a ciklikusságra, azaz a 6 után a 0 következzen.

Próbáljuk meg először mintaillesztéssel, aztán más módszeren is elgondolkodhatunk. -}
nextDay :: Integer -> Integer

nextDay 6 = 0
nextDay x = x + 1


{- # Definiáljuk azt a rekurzív függvényt, amely egy paraméterül kapott nemnegatív egész értékig előállítja a számok összegét. -}
sumTo :: Integer -> Integer

sumTo 0 = 0
sumTo x = x + sumTo (x-1)


{- # Definiáljuk azt a rekurzív függvényt, amely a paraméterül kapott nemnegatív egész értékig megadja a számok négyzeteinek összegét. Azaz, az n ^ 2, (n - 1) ^ 2, …, 1 számok összegét. A számot megszorozhatjuk önmagával, de használhatjuk a hatványozás műveletét is (^). -}
sumSquaresTo :: Integer -> Integer

sumSquaresTo 0 = 0
sumSquaresTo x = x ^ 2 + sumSquaresTo (x-1)


{- # Definiáljuk azt a rekurzív függvényt, ami egy n egész számnak megadja az i nemnegatív egész kitevős hatványát. A függvény első paramétere a hatványozandó szám, a második pedig a kitevő. -}
powerN :: Integer -> Integer -> Integer

powerN x 1 = x
powerN x y = x * powerN x (y-1)