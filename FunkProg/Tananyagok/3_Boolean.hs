module Boolean where

{-
    Logikai tagadás művelet
        - `:t not`      =>      not :: Bool -> Bool
        - `:t (&&)`     =>      (&&) :: Bool -> Bool -> Bool
        - `:t (||)`     =>      (||) :: Bool -> Bool -> Bool
-}

{-
    Mintaillesztés:
        - Megadási sorrendben történik a kiértékelés
-}

{-
    Összehasonlító operátorok:
        == : egyenlőségvizsgálat,
        /= : nem egyenlőek az értékek,
        > : nagyobb,
        < : kisebb,
        >= : nagyobb vagy egyenlő,
        <= : kisebb vagy egyenlő.

    FONTOS: csak két azonos típúst tudunk összehasonlítani, másképpen hibát kapunk
-}


{- # Saját NOT függvény deffiniálása külön módokon: -}
-- 1.: esetek felsorolásával
myNot0 :: Bool -> Bool

myNot0 True = False
myNot0 False = True

-- 2.: változóval
myNot1 :: Bool -> Bool

myNot1 True = False
myNot1 n = True         -- Minden más esetben True-t ad vissza és akár használhatnám a változót a jobb oldalon is

-- 3.: joker/wildcard használatával
myNot2 :: Bool -> Bool

myNot2 True = False
myNot2 _ = True         -- Minden más esetben True-t ad vissza


{- # Saját AND függvény deffiniálása különböző módokon: -}
-- 1. esetek felsorolásával
myAnd0 :: Bool -> Bool -> Bool

myAnd0 True True = True
myAnd0 False False = False
myAnd0 True False = False
myAnd0 False True = False

-- 2. változóval
myAnd1 :: Bool -> Bool -> Bool

myAnd1 True True = True
myAnd1 x y = False

-- 3. jokerrel
myAnd2 :: Bool -> Bool -> Bool

myAnd2 True True = True
myAnd2 _ _ = False

-- 4. kicsit egyszerűbben
myAnd :: Bool -> Bool -> Bool

myAnd True x = x            -- Lusta kiértékelési stratégia miatt ha az első nem igaz, akkor egyből továbbmegy
myAnd _ _ = False


{- # Saját VAGY függvény deffiniálása: -}
{- Amennyiben egy létező függvényt szeretnénk újradeffiniálni, a modul elején el kell rejteni azt: `import Prelude hiding ((||))` -}
(|:|) :: Bool -> Bool -> Bool

(|:|) False x = x
(|:|) _ _ = True


{- # Saját KIZÁRÓ VAGY függvény deffiniálása: -}
xor :: Bool -> Bool -> Bool

xor True True = False
xor False False = False
xor _ _ = True


{- # Implikáció -}
infix 1 -->                     -- Azt jelzi, hogy a művelet nem asszociatív, 1-es a kötési ereje és `-->` a jelen
(-->) :: Bool -> Bool -> Bool

True --> x = x
_ --> _ = True

