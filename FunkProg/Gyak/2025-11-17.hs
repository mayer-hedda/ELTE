module Example where

import Data.Char


{- Másoljuk be egy modulba a típus és a függvény definíciót. Próbáljuk ki a függvényt az összes lehetséges értékkel. -}
data Answer = No | Maybe | Yes deriving (Show)

toString :: Answer -> String
toString No = "No"
toString Maybe = "Maybe"
toString Yes = "Yes"


{- Definiáljunk egy felsorolási típust Day néven, ami a hét napjait fogja reprezentálni. 
A konstruktorai a következők legyenek: Mon, Tue, Wed, Thu, Fri, Sat és Sun
Kérjük meg a fordítót, hogy példányosítsa a Show típusosztályt a típusunkra. -}
data Day = Mon | Tue | Wed | Thu | Fri | Sat | Sun deriving (Show, Eq, Enum) 

{- Definiáljuk azt a függvényt, amely eldönti egy napról, hogy az hétvége-e. -}
isWeekend :: Day -> Bool

isWeekend Sat = True
isWeekend Sun = True
isWeekend _ = False


{- Definiáljuk azt a függvényt, ami megadja egy nap rákövetkezőjét. A tesztelésnél összehasonlítjuk a napokat, ehhez szükségünk van az egyenlőségvizsgálatra. Kérjük meg a fordítót, hogy az Eq típusosztályt is példányosítsa a Day típusra. -}
tomorrow :: Day -> Day

tomorrow Mon = Tue
tomorrow Tue = Wed
tomorrow Wed = Thu
tomorrow Thu = Fri
tomorrow Fri = Sat
tomorrow Sat = Sun
tomorrow Sun = Mon


{- Az előző függvényen egyszerűsíteni tudunk, ha megkérjük a fordítót az Enum típusosztály példányosítására is. Ebben az esetben megkapjuk a succ függvényt, amely egy napnak meg tudja adni a rákövetkezőjét.

Ez a hét első hat napjára teljesen jól működik, egyedül a vasárnap esetén tapasztalunk hibát. Így nem tudjuk csupán ennek a függvénynek a felhasználásával megoldani a ciklikusságot, azaz, hogy a vasárnap után a hétfő következzen. Mintaillesztéssel viszont ki tudjuk emelni, mint speciális esetet. Így megadhatjuk, hogy a vasárnap után a hétfő következik és minden egyéb esetben a succ függvényt használjuk. -}
betterTomorrow :: Day -> Day

betterTomorrow Sun = Mon
betterTomorrow x = succ x



{- Definiáljuk az amerikai időpontnak reprezentációra felhasználható USTime típust. A típusnak két konstruktora lesz(AM és PM), amely a délelőtti és a délutáni időpontokat ábrázolja. Mindkét konstruktornak két adattagja lesz, az első az órát a második a percet adja meg. Kérjük meg a fordítót, hogy példányosítsa a típusunkat az Eq és Show típusosztályokra. -}
data USTime = AM Int Int | PM Int Int deriving (Eq, Show)


{- Definiáljunk egy saját függvényt, amely a USTime típus értékeit konvertálja szöveggé az alábbi formátumban.

    - AM 10 15 → "10.15 am"
    - PM 2 30 → "2.30 pm"
    
Segítség: A számok szöveggé alakítására használjuk a show túlterhelt függvényt. -}
showUSTime :: USTime -> String

showUSTime (AM ora perc) = (show ora) ++ "." ++ (show perc) ++ " am"
showUSTime (PM ora perc) = (show ora) ++ "." ++ (show perc) ++ " pm"