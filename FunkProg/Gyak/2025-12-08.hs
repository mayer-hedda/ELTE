{- Definiáljuk azt a függvényt, ami egy listáról eldönti, hogy az tartalmaz-e elemet. Adjuk meg a definíciót a kompozíció műveletével.

Segítség: A függvény neve árulkodik a felhasználandó függvényekről. -}
notNull :: [a] -> Bool

notNull = not . null


{- Definiáljuk az even függvényt a kompozíció és operátor szeletek felhasználásával. -}
myEven :: Integral a => a -> Bool

myEven = (== 0) . (`mod` 2)


{- Definiáljuk azt a függvényt, amely megadja a csak 1-es számjegyekből álló számok végtelen sorozatát, szigorúan monoton növekvő sorrendben.

A sorozat elemei: 1, 11, 111, 1111, …

Segítség: Használjuk az iterate függvényt és próbáljuk a függvénynek szánt műveletet operátorszeletek kompozíciójaként megadni. -}
numbersMadeOfOnes :: [Integer]

numbersMadeOfOnes = iterate ((+1) . (*10)) 1


{- Definiáljuk azt a függvényt, amely megadja a csak 3-as számjegyekből álló számok végtelen sorozatát, szigorúan monoton növekvő sorrendben.

A sorozat elemei: 3, 33, 333, 3333, … -}
numbersMadeOfThrees :: [Integer]

numbersMadeOfThrees = iterate ((+3) . (*10)) 3


{- Definiáljuk azt a függvényt, amely egy szöveg elejéről eldobja a szóközöket.

Segítség: Használhatjuk a dropWhile és a Data.Char modul isSpace függvényét. -}
dropSpaces :: String -> String

dropSpaces = dropWhile isSpace


{- Definiáljuk azt a függvényt, amely a szöveg elejéről és végéről is elhagyja a szóközöket. A megoldásban használjuk az előbb megadott dropSpaces, reverse és kompozíció műveleteket.

Megjegyzés: Feltehetjük, hogy a paraméterül kapott szöveg véges. -}
trim :: String -> String

trim = dropSpaces . reverse . dropSpaces . reverse


{- Definiáljuk azt a függvényt, amely egy adott név kezdőbetűit adja meg. A megoldást kompozícióval adjuk meg.

Segítség:

Nem a nagybetűket kell megadni, hanem a nevek kezdőbetűit.
A feladat megoldásához érdemes külön kezelni a neveket. A felbontáshoz és összeépítéshez használjuk a korábban tanult words és unwords függvényeket. -}
firstLetters :: String -> String

firstLetters = words . (take 1)