{- # Definiáljuk azt a függvényt, amely eldönti egy listáról hogy adott elemszámnál több elemet tartalmaz-e. A megoldásban használjunk mintaillesztést és rekurziót, de véletlenül se használjuk a length függvényt. -}
isLongerThan :: [a] -> Integer -> Bool

isLongerThan [] n
  |n < 0 = True
  |otherwise = False
isLongerThan (x:xs) n
  |n < 0 = True
  |otherwise = isLongerThan xs (n-1)


{- # Definiáljuk azt a függvényt, ami egy szövegből csak a nagybetűket tartja meg. A megoldást a szöveg/lista rekurzív bejárásával adjuk meg.

Megjegyzés: A megoldásban szükség lehet a Data.Char modul isUpper függvényére. -}
onlyUppers :: String -> String

onlyUppers [] = []
onlyUppers (x:xs)
  |isUpper x == True = x : onlyUppers xs
  |otherwise = onlyUppers xs


{- # Definiáljuk azt a függvényt, amely egy listában megadja egy keresett elem pozícióit/indexeit. Az indexelést 0-tól kezdjük.

Segítség: A feladatot egy segédfüggvénnyel tudjuk megoldani, ami a lista bejárása során számon tartja az aktuális elem indexét.

Megjegyzés: Az Eq a azt jelenti, hogy a paraméterül kapott értékek egyenlősége vizsgálható (==). -}
elemIds :: Eq a => a -> [a] -> [Int]

