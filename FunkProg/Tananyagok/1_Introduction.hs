-- 1. Készítsük el a behajtani tilos tábla színezetlen változatát. A felhasznált méretek: 2, 5 és 8

circle 5 <|> rect 8 2


-- 2. Készítsük el a következő alakzatot. A felhasznált méretek: 2, 6, 10, 14 és 20

rect 20 14 <|> rect 6 10 `move` (0, -2)


-- 3. Módosítsuk a korábban bemutatott példát úgy, hogy pont-pont kifejezés felhasználásával 
--    a koncentrikus körök 0.5 egységnyi lépésközzel csökkenjenek.

union[circle i | i <- [5, 4.5.. 1]]


-- 4. Adjuk meg a következő ábrán látható pénzoszlopot. A kör sugara 4.

union[circle 4 `move` (0, i) | i <- [0..4]]


-- 5. Adjuk meg a következő ábrán látható lépcsősort! A lépcső fokához felhasznált értékek: 2 és 1 A felsoroláshoz: -5 és 5

union[rect 2 1 `move` (i, i) | i <- [-5..5]]


-- 6.a) Készítsük el a színes behajtani tilos táblát! A szükséges méretek: 2, 5 és 8

circle 5 `fill` red <|> rect 8 2

-- 6.b) Majd úgy is, hogy a keretek ne látszanak:

circle 5 `fill` red `stroke` red <|> rect 8 2 `stroke` red


-- 7. Készítsük el az alábbi ábrát. A felhasznált méret: 10

(rect 10 10 <|> rect 10 10 `rotate` 45) `rotate` 22.5 `fill` black


