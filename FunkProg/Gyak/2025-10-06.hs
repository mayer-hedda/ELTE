-- Időpont érvényesség ellenőrzése
validTime :: Integer -> Integer -> Bool

validTime h m
    | h >= 0 && h <= 23 && m >= 0 && m <= 59 = True
    | otherwise = False


-- Másodfokú egyenlet gyökeinek száma
numOfSolutions :: Integer -> Integer -> Integer -> Integer

numOfSolutions a b c
    | (b ** 2) - 4*a*c


-- A π közelítése Leibniz-féle sorral (nehéz feladat) -- Házi
-- leibniz :: Integer -> Double
-- lh :: Integer -> 

-- leibniz x = lh


-- Számok összeadása 1-től n-ig
-- s x = sh x 0


-- ----- LISTÁK -----
-- Csökkenő sorozat
descending :: Integer -> [Integer]

descending x = [x, (x-1)..(x*(-1))]


-- n-el osztható számok
divByN :: Integer -> [Integer]

divByN x
    |x > 0 = [0, x..]
    |otherwise = []


-- Számtani sorozat i-edik eleme
ithInSeq :: Integer -> Integer -> Int -> Integer

ithInSeq x y z = [x, y..] !! (z-1)


-- Ábécé n-edik betűje
nthLetter :: Int -> Bool -> Char

nthLetter x y
    |y == True && (x >= 0 || x <= 25) = ['A'..'Z'] !! x
    |y == False && (x >= 0 || x <= 25) = ['a'.. 'z'] !! x


-- Faktoriális függvény
fact :: Integer -> Integer

fact n = product [1..n]


-- n elem sorbarendezéseinek a száma
perm :: Integer -> Integer


s x = sh x 0

sh 0 a = a
sh x a = sh (x - 1) (a + x)

-- Szóval az sh függvény összeadja az x-et és az a-t
-- ezért ha például az s x -nél az x = 3, akkor az felírható úgy, hogy x + 0
-- itt az x = 3 az a = 0
-- Tehát --> s 3 = sh 3 0 

-- Itt az a változóm, egy számláló, ami tárolja, hogy éppen mi az aktuális számom
-- Ezt azért kezdjük 0-tól, mert legelőször nincsen semmink, és először ehhez adjuk hozzá az adott számot
-- Ezért csinálunk egy alap esetet, amikor azt mondjuk, hogy ha az x = 0 akkor csak adjuk vissza az a-t 
-- (Vagy ha x = 1 akkor mindig az a + 1-et adjuk vissza)
-- Tehát --> sh 0 a = a

-- Az alapeset után csinálunk egy általános esetet, ami egy rekurzív függvényhívás lesz
-- Ha az x = 3, akkor ez így fog kinézni:
    -- sh 3 0 = sh 2 3      --> itt már úgy hívom meg mégegyszer az sh-t, hogy az a-hoz hozzáadtam az aktuális x-et
    -- sh 2 3 = sh 1 5      --> itt is növeltem az a értékét az x értékével
    -- sh 1 5 = sh 0 6      --> ismét növelem az a értékét
    -- sh 0 6 = 6           --> ez már az alapesetünk, ahol az x = 0, ezért csak visszaadjuk az a értékét

    -- Tehát az sh 3 0 értéke 6 lesz, és ezt az értéket átadjuk az s x -nek

-- Tehát s x = 6


