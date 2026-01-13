module FunkcProgVizsga where
import Data.List

-- 1. Feltételes összegzés szomszédok alapján (2 pont)
-- Definiáld azt a függvényt, amely bejárva egy listát összeadja azokat az elemeket, amelyek nagyobbak a közvetlen utánuk álló szomszédjuknál. Amennyiben nincs jobboldali szomszéd vagy a szomszéd nagyobb vagy egyenlő az adott elemnél, úgy azt nem vesszük bele az összegbe.

-- Segítségek:
--      Használjuk ki, hogy mintaillesztéssel egyszerre több elemet tudunk leválasztani egy lista elejéről.
--      Ha több elemet választunk le a lista elejéről, gondoljuk meg, hogy nem lesz-e szükség a következő lépésben valamelyikre, nem-e kell tovább vinni azt.
conditionalSum :: (Num a, Ord a) => [a] -> a

conditionalSum [] = 0
conditionalSum (x:[]) = 0
conditionalSum (x:y:xs)
    |x > y = x + conditionalSum (y:xs)
    |otherwise = conditionalSum (y:xs)



-- 2. Második elem duplikálása (2 pont)
-- Adott egy listákat tartalmazó lista. Definiáld azt a függvényt, amely minden olyan listában, amely legalább két elemet tartalmaz, megduplázza a második elemet. Amennyiben a listának nincs legalább két eleme, úgy azt hagyja változatlanul.

-- Segítség: Gondolkodhatunk segédfüggvényben, ami az egyes listákra megoldja a kitűzött feladatot.
dupSecond :: [[a]] -> [[a]]

dupSecond [] = []
-- dupSecond (x:xs) = (dupSecondHelper x) ++ dupSecond xs


dupSecondHelper :: [a] -> [a]

dupSecondHelper [] = []
dupSecondHelper (x:[]) = (x:[])
dupSecondHelper (x:y:xs) = (x:y:y:xs)



-- 3. Maradékosan egyező elemek száma (2 pont)
-- Definiáld azt a függvényt, amely két egész számokból álló listát és egy n egész számot vár paraméterül. A függvény határozza meg, hogy hány olyan pozíció van a két listában (párhuzamosan haladva, elsőt az elsővel, másodikat a másodikkal párosítva, stb.), ahol mindkét elem n-nel vett osztási maradéka megegyezik. Feltehető, hogy a két lista közül az egyik véges.
modNSequences :: Integral a => [a] -> [a] -> a -> Int

modNSequences [] [] _ = 0
modNSequences [] _ _ = 0
modNSequences _ [] _ = 0
modNSequences (x:xs) (y:ys) n
    |x `mod` n == y `mod` n = 1 + modNSequences xs ys n
    |otherwise = modNSequences xs ys n



-- 4. Keresés bizonytalan értékek között (2 pont)
-- Definiáld azt a függvényt, amely egy predikátumot (feltételt) és Maybe a típusú elemekből álló listát kap paraméterül. A függvény keresse meg az első olyan Just konstruktorba csomagolt elemet, amelyre a p feltétel teljesül. Amennyiben van ilyen eleme a listának, úgy az eredményt egy Just konstruktorba csomagolva adja meg, ellenkező esetben az eredmény legyen Nothing.

-- Segítség: Használjunk mintaillesztést.
searchMaybe :: (a -> Bool) -> [Maybe a] -> Maybe a

searchMaybe _ [] = Nothing
searchMaybe p (y:ys)
    -- |p y = y
    |otherwise = searchMaybe p ys



-- 5. Lista vágása amíg nem teljesül (2 pont)
-- Definiáld azt a függvényt, amely egy predikátumot (feltételt) és egy listát vár paraméterül. A függvény addig dobálja el az elemeket a lista elejéről, amíg a megmaradt listára a megadott feltétel igaz nem lesz. Amint a feltétel teljesül, a függvény visszaadja a lista aktuális állapotát.

-- Megjegyzés: A teszteléshez szükséges importálni a Data.List modult.
dropUntil :: ([a] -> Bool) -> [a] -> [a]

dropUntil _ [] = []
dropUntil p (x:xs)
    |p (x:xs) = (x:xs)
    |otherwise = dropUntil p xs



-- 6. Felbonthatóság (2 pont)
-- Definiáld azt a függvényt, amely egy pozitív egész számot (n) és egy pozitív egész számok listáját várja paraméterül. A függvény döntse el, hogy a szám teljesen felbontható-e a listában található számok szorzatára. A folyamat során egy adott osztóval annyiszor osztunk, ahányszor csak lehetséges, majd továbblépünk a lista következő elemére. Feltehetjük, hogy az osztók listájában csak prímszámok vannak, így elkerülhetjük a félrevezető eseteket.

-- A lépéseket addig kell ismételni, amíg el nem érjük az 1-es értéket. Ha az adott számot már nem tudjuk tovább osztani, mert nincs több olyan szám a listában, ami osztaná, akkor az eredmény legyen hamis.

-- Segítség: Ne feledjük, hogyha osztható az aktuális értékkel a szám, akkor az osztóra szükség lehet a következő lépésnél is.
canBeFactorised :: Integer -> [Integer] -> Bool

canBeFactorised 1 _ = True
canBeFactorised _ [] = False
canBeFactorised n (x:xs)
    |n `mod` x == 0 = canBeFactorised (n `div` x) (x:xs)
    |otherwise = canBeFactorised n xs



-- 7. Térképészet (3 pont)
-- Definiáld a Place algebrai adatszerkezetet, amelynek az adatkonstruktorai a következők:

-- Lake :: Double -> Place, a paraméter a tó mélységét megadó nemnegatív érték.
-- Mountain :: Double -> Place, a paraméter a hegy magasságát megadó nemnegatív érték.
-- Cave :: Double -> Place, a paraméter a barlang hosszát megadó nemnegatív érték.
-- Kérjük meg a fordítót, hogy automatikusan példányosítsa a Show és Eq típusosztályokat.

-- Legmélyebb tó:
-- Definiáld azt a függvényt, amely a listában megkapott értékek közül megadja, hogy milyen mély a legmélyebb tó. Az eredményt egy Just konstruktorba csomagolva adja meg amennyiben van legalább egy tó, különben az eredmény legyen Nothing. A mélységek pozitív értékekként adottak, ahol minél nagyobb az érték, annál mélyebb tavat határoz meg. Feltehetjük, hogy a lista véges.



-- 8. Legnagyobb maradék (3 pont)
-- Definiáljuk azt a függvényt, amely egy pozitív egész számokból álló listában megkeresi, hogy melyik két szomszédos érték osztási maradéka (modulo osztás) a legnagyobb (első elem az osztandó, a jobboldali szomszéd az osztó). Az eredménye egy rendezett pár legyen a Just konstruktorba csomagolva. Ha több ilyen páros is létezik, úgy az utolsót adjuk vissza ezek közül. Amennyiben a paraméterül kapott lista nem rendelkezik elegendő elemmel, az eredmény legyen Nothing.

-- Segítség:
-- Gondolkodhatunk segédfüggvényben és végrekurzióban.
-- Feltehetjük, hogy kezdetben a lista első két eleme adja a legnagyobb osztási maradékot.
-- Használhatunk magasabb rendű függvényeket is.
-- Ha több elemet választunk le a lista elejéről, gondoljuk meg, hogy nem lesz-e szükség a következő lépésben valamelyikre, nem-e kell tovább vinni azt.
largestRemainder :: Integral a => [a] -> Maybe (a,a)

largestRemainder [] = Nothing
largestRemainder (x:[]) = Nothing
largestRemainder (x:y:[]) = Just (x, y)
largestRemainder (x:y:xs) 
    -- |x `mod` y > (largestRemainder (y:xs)) = Just (x, y)
    |otherwise = largestRemainder (y:xs)