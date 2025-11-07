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
        Lista felépítése:
            - `[]`          =>      [] :: [()]
            - `1 : []`      =>      [1] :: [Integer]
            - `1 : 2 : 3 : 4 : []`      =>      [1, 2, 3, 4] :: [Integer]

        Jellemző listaminták:
            - []                            =>      A lista üres, csak az üres lista illszkedik a mintára
            - [x] vagy (x:[])               =>      Pontosan egy elemet tartalmazó lista
            - [x, y] vagy (x:y:[])          =>      Pontosan két elemet tartalmazó lista
            - [x, y, z] vagy (x:y:z:[])     =>      Pontosan három elemet tartalmazó lista
            ...

            - (x:xs)                        =>      Legalább egy elemű lista
                x     ->      fejelem
                xs    ->      törzs rész (bármi lehet)
            - (x:y:xs)                      =>      Legalább két elemet tartalmazó lista
            - (x:y:z::xs)                   =>      Legalább három elemet tartalmazó lista
            ...
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


{- # Üres-e a lista -}
isEmpty :: [a] -> Bool

isEmpty [] = True
isEmpty _ = False


{- # Pontosan egy elemű-e a lista -}
isSingleton :: [a] -> Bool

isSingleton (_:[]) = True
isSingleton _ = False


{- # Definiáljuk mintaillesztés felhasználásával azt a függvényt, amely eldönti, hogy 1-gyel kezdődik-e a paraméterül kapott lista.

Megjegyzés: A feladatot megoldhatjuk akár esetszétválasztással is, de sokkal szebb ha a vizsgált értéket “beemeljük” a mintába. Gondoljuk meg, hogyan néz ki egy 1-gyel kezdődő lista: 1:[2,3,4]. Ez mintában leírva pl. (1:xs) vagy (1:_) -}
startsWithOne :: [Integer] -> Bool

startsWithOne (1:_) = True
startsWithOne _ = False


{- # Definiáljuk a head előre definiált függvény működésének megfelelő hd függvényt, amely leválasztja a lista első elemét és azt eredményként adja. Értelemszerűen, a függvény csak akkor tud eredményt adni, ha a listának van legalább egy eleme. Ennél a függvénynél is csak mintaillesztés használunk, így a függvény típusa kellően általános tud maradni.

Gondoljuk meg, hogy mit tudunk az üres listával kezdeni! (magyarázat a megjegyzésekben) -}
hd :: [a] -> a

hd (x:xs) = x


{- # A tail függvény egy előre definiált függvény, amely leválasztja a lista első elemét és a fennmaradó részt adja eredményként. A függvény csak akkor tud eredményt adni, ha a listának van legalább egy eleme. A függvény csupán a mintaillesztést használja, így általános típusleírást tudunk hozzá adni.

Definiáljuk a függvényt tl néven, hogy elkerüljük a névütközést.

Gondoljuk meg, hogy mit tudunk az üres listával kezdeni! (magyarázat a megjegyzésekben) -}
tl :: [a] -> [a]

tl (x:xs) = xs


{- # Definiáljuk azt a függvényt, amely egy tetszőleges szót alakít át úgy, hogy az nagybetűvel kezdődjön, amennyiben az betűvel kezdődik. Amennyiben a szó nem betűvel kezdődik, úgy a szót az eredeti formájában hagyjuk meg. A megoldásban használjuk a Data.Char modul toUpper függvényét!

Segítség: Mintaillesztéssel válasszuk szét a lista első elemét a törzsétől, a függvény törzsében pedig “ragasszuk” vissza a nagybetűsített fejelemet a törzsre.

Megjegyzések:
    - A szövegek karakterekből álló listák, így ugyanazokat a mintákat használhatjuk, mint a többi listára.
    - Keressünk rá a dokumentációban a toUpper függvényre és nézzük meg a működését és tulajdonságait. (Hoogle)
    - A függvényt szükséges a modulba importálni: import Data.Char (toUpper) -}
toUpperFirst :: String -> String

toUpperFirst [] = []
toUpperFirst (x:xs) = (toUpper x) : xs


{- # Definiáljuk a számokat tartalmazó lista szorzatát meghatározó függvényt. Az üres tartomány szorzata definíció szerint 1.

Megjegyzés: A függvény egy numerikus értékeket tartalmazó listát kap, aminek a szorzatát képezzük. Korábban láttuk, hogy a szorzás (*) művelete tetszőleges számtípus felett értelmezett, így a függvény típusa ennek megfelelően lett meghatározva. -}
myProduct :: Num a => [a] -> a

myProduct [] = 1
myProduct (x:xs) = x * myProduct xs


{- # Definiáljuk a myLast függvényt, amely egy véges lista utolsó elemét adja meg.

Segítség: Az alapeset megadásához azt kell meggondolnunk, hogy mi az a legrövidebb lista ami esetén meg tudjuk még adni az utolsó elemet. -}
myLast :: [a] -> a

myLast [x] = x
myLast (x:xs) = myLast xs


{- # Adott egy számokat tartalmazó lista. Definiáljuk azt a függvényt, amely megadja a lista legkisebb elemét.

Megjegyzés: Használhatjuk a min függvényt, ami két elem közül a kisebbet adja meg. A feladat megoldása nagyon hasonlít a sum függvénynél látottakra.

Hasonlóan a korábbiakhoz, azt kell észrevenni, hogy a legkisebb elem az aktuális fejelem és a fennmaradó rész legkisebb eleme közül kerül ki. Tehát, ha tudjuk a fennmaradó rész legkisebb elemét, akkor azt a fejelemmel kell összemérni. -}
myMinimum :: [Integer] -> Integer

myMinimum [x] = x
myMinimum (x:xs) = min x (myMinimum xs)


{- # Definiáljuk azt a függvényt, amely egy tetszőleges lista elejéről elhagy n darab elemet. Ugyanúgy, ahogyan a tail függvénynél bemutatásra került, a függvény nem változtatja meg a listát, csupán “belemutat” abba. Ilyen módon olyan hatást keltve, mintha a lista az adott ponton kezdődne.

Segítség:
    - A függvény folyamatosan veszi le a lista elejéről az elemeket, amíg a kapott érték pozitív.
    - Ha a szám nem pozitív, akkor változatlan formában adja vissza a listát.
    - Ügyeljünk arra, hogy az adott érték lehet nagyobb, mint a lista hossza. Ez majd menet közben kiderül, mintaillesztéssel tudjuk kezelni (a listából elfogynak az elemek). Véletlenül se ellenőrizzük a lista hosszát! -}
myDrop :: Int -> [a] -> [a]

myDrop _ [] = []
myDrop x (y:ys)
    |x <= 0 = (y:ys)
    |otherwise = myDrop (x-1) ys


{- # Definiáljuk azt a függvényt, amely eldönti egy elemről, hogy megtalálható-e a listában. A listáról feltehetjük, hogy véges számú elemből áll.

A típusban az Eq a megszorítás azt jelenti, hogy a paraméterül kapott értékekre tudjuk alkalmazni az egyenlőségvizsgálatot (==). -}
myElem :: Eq a => a -> [a] -> Bool

myElem _ [] = False
myElem x (y:ys)
    |x == y = True
    |otherwise = myElem x ys


{- # Definiáljuk azt a függvényt, amely egy tetszőleges lista elejéről leválaszt n darab elemet. Persze, ahogyan azt korábban is megbeszéltük, nem az eredeti listát módosítja, csak felhasználja annak elemeit, hogy egy új listát építsen. A függvény legyen totálisan definiált, azaz minden bemenetre tudjon eredményt adni.

Az alábbi esetekre is figyeljünk:
    - Üres listából szeretnénk elemeket venni.
    - Negatív számú vagy 0 elemet szeretnénk a listából. -}
myTake :: Int -> [a] -> [a]

myTake _ [] = []
myTake x (y:ys)
    |x <= 0 = []
    |otherwise = y : myTake (x-1) ys

{- # Definiáljuk azt a függvényt, amely egy adott e elemet n-szer ismétel. Azaz, egy n elemszámú listát képez az e értékből. -}
myReplicate :: Int -> a -> [a]

myReplicate x y
    |x <= 0 = []
    |otherwise = y : myReplicate (x-1) y


{- # Definiáljuk azt a függvényt, amely egy adott elem végtelen ismétlésével végtelen listát képez! A feladat érdekessége, hogy egy végtelen listát fogunk képezni, így alapeste nem lesz a függvénynek. -}
myRepeat :: a -> [a]

myRepeat x = x : myRepeat x


{- # Definiáljuk azt a műveletet, amely két listát konkatenál, azaz egymás után fűz.

Segítség:
    - Lényegében azt fogjuk csinálni, hogy az első lista elemeiből egy új szerkezetet építünk és a lezáró üres lista helyett a második lista első elemével folytatjuk a sorozatot.
    - A második listát már nem fog kelleni felbontani. Gondoljuk meg, hogy egy üres és egy nem üres listát hogyan tudnánk “összeragasztani”. Az eredményt maga a nemüres lista adja, eredeti formájában. Ez lesz az alapeset. -}
infixr 5 +:+
(+:+) :: [a] -> [a] -> [a]

x +:+ [] = x
[] +:+ x = x
(x:xs) +:+ y = x : (xs +:+ y)


{- # Definiáljuk az isPrefOf függvényt, amely megállapítja, hogy az első lista kezdőszelete-e a másiknak. Az első lista akkor kezdőszelete a másodiknak, ha:
    - az első lista nem lehet hosszabb a másodiknál és
    - az első lista összes eleme ugyanabban a sorrendben megtalálható a második lista elején.

Megjegyzés: A megoldás során szükség lesz mindkét paraméterül kapott lista mintaillesztésére és ezek elemenkénti feldolgozására. Egyesével vegyünk le egy-egy elemet mindkét lista elejéről és ezek összehasonlítása alapján döntsük el a feladatban felett kérdést. -}
isPrefOf :: Eq a => [a] -> [a] -> Bool

isPrefOf [] [] = True
isPrefOf (x:[]) [] = False
isPrefOf [] _ = True
isPrefOf (x:xs) (y:ys)
    |x == y = isPrefOf xs ys
    |otherwise = False


{- # Definiáljuk az két listát összefésülő műveletet! Az eredmény lista elemei a bemenő listák váltogatott elemei lesznek. Előfordulhat olyan eset, hogy valamelyik lista hamarabb fogy el, ekkor a másik maradékát változatlan formában “ragasszuk” az eredmény lista végére.

Segítség:
    - A feladatban két listát kell egyszerre feldolgoznunk, azaz mindkét listát mintaillesztenünk kell.
    - Ne feledkezzünk meg azokról az esetekről, hogy az egyik listában még lehet elem, a másikból viszont elfogyhatott.
    - A (:) segítségével tetszőleges elemet a lista elejére tudunk illeszteni. Pl. 1:2:[3,4] == [1,2,3,4] -}
merge :: [a] -> [a] -> [a]

merge [] x = x
merge x [] = x
merge (x:xs) (y:ys) = x : y : merge xs ys


{- # Definiáljuk azt a függvényt, amely egy listában adott listákat fűz össze. Azaz, egy szintet “kilapít” a listákon.

Megjegyzés: Ne bonyolítsuk túl a mintaillesztést, egyszerűen használjuk a megszokott (x:xs) mintát és használjuk a ++ műveletet az összefűzéshez. -}
myConcat :: [[a]] -> [a]

myConcat [] = []
myConcat (x:xs) = x ++ myConcat xs


{- # Definiáljuk azt a függvényt, amely egy listából elhagyja egy adott elem összes előfordulását. -}
elimElem :: Eq a => a -> [a] -> [a]

elimElem _ [] = []
elimElem x (y:ys)
    |x == y = elimElem x ys
    |otherwise = y : elimElem x ys


{- # Definiáljuk újra azt a függvényt, ami elhagyja az ismétlődéseket a listából. A függvény mindig az elem első előfordulását hagyja meg. A megoldásban használjuk a korábbi elimElem függvényt.

Segítség: Ha egy elem egyszer már belekerült az eredménybe, akkor a fennmaradó részből hagyjuk el az elem ismétlődéseit és ezen a listán dolgozzunk tovább. -}
myNub :: Eq a => [a] -> [a]

myNub [] = []
myNub (x:xs) = x : myNub (elimElem x xs)


{- # Definiáljuk újra azt a függvényt, ami elhagyja az ismétlődéseket a listából. A függvény mindig az elem utolsó előfordulását hagyja meg. A megoldásban használjuk a korábbi elem függvényt.

Segítség: Amikor leválasztunk egy elemet, ellenőrizni kell, hogy a fennmaradó részben megtalálható-e az adott érték (ismétlődés). Amennyiben ez nem teljesül, akkor az elemet beletehetjük az eredmény listába, ellenkező esetben ne foglalkozzunk az elemmel, hiszen “lesz még belőle” a későbbiekben. -}
removeDups :: Eq a => [a] -> [a]

removeDups [] = []
removeDups (x:xs)
    |(x `elem` xs) == False = x : removeDups xs
    |otherwise = removeDups xs


{- # Definiáljuk rekurzívan az enumFromTo függvény Integer-ekre specializált változatát. A függvény az adott kezdőponttól a megadott végpontig előállít egy monoton növekvő sorozatot az alapértelmezett +1 lépésközzel. -}
myEnumFromTo :: Integer -> Integer -> [Integer]

myEnumFromTo x y
    |x > y = []
    |x == y = [x]
    |otherwise = x : myEnumFromTo (x+1) y


{- # Definiáljuk azt a függvényt, ami egy listát adott hosszúságú részlistákra szabdal.

Segítség: Használjuk a take és drop függvényeket. -}
runs :: Int -> [a] -> [[a]]

runs _ [] = []
runs x y = take x y : runs x (drop x y)


{- # Definiáljuk azt a függvényt, ami egy adott “szabásminta” alapján feldarabol egy listát. Amennyiben a leszabott darabok után a lista még tartalmazna elemeket, úgy azt dobjuk el. Amennyiben elfogynak az elemek darabolás közben, úgy a “darabok” legyenek üres listával reprezentálva.

Segítség: Használhatjuk a take és drop függvényeket. NE a lista hossza alapján hozzunk döntéseket! -}
slice :: [Int] -> [a] -> [[a]]

slice [] _ = []
slice (x:xs) y = take x y : slice xs (drop x y)


{- # Definiáljuk az every függvényt, amely veszi egy lista minden n-edik elemét! Az eredményben mindig benne lesz az eredeti lista kezdőeleme.

Segítség: Használhatjuk a drop függvényt. -}
every :: Int -> [a] -> [a]

every _ [] = []
every n (x:xs) = x : every n (drop n (x:xs))


{- # Definiáljuk rekurzívan az enumFrom függvény Integer-ekre specializált változatát. A függvény az adott kezdőponttól kezdve egy monoton növekvő sorozatot állít elő az alapértelmezett +1 lépésközzel. -}
myEnumFrom :: Integer -> [Integer]

myEnumFrom x = x : myEnumFrom (x+1)


{- # Definiáljuk rekurzívan az enumFromThen függvény Integer-ekre specializált változatát. A függvény az adott kezdőponttól a második elemből meghatározható lépésközzel előállít egy végtelen sorozatot. -}
myEnumFromThen :: Integer -> Integer -> [Integer]

myEnumFromThen x y = x : myEnumFromThen y (y + (y-x))