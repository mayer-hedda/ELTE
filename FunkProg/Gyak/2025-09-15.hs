module Example where
import Data.Char

double x = x*3

-- egysoros komment
{-
többsoros komment
-}

mul:: Int -> Int -> Int
mul x y = x*y


-- Saját not függvény
myNot0 :: Bool -> Bool
myNot0 True = False
myNot0 False = True

myNot1 :: Bool -> Bool
myNot1 True = False
myNot1 x = True

myNot :: Bool -> Bool
myNot True = False
myNot _ = True          -- Ezt nem tudnám először megadni, mert a mintaillesztés miatt egy egyből True-t adna és nem menne tovább


-- Saját and függvény
myAnd :: Bool -> Bool -> Bool
a = myAnd False _ = False

myAnd True True = True
myAnd _ _ = False

myAnd True x = x        -- Azért jobb, met ha az első nem igaz, a másodikra már nem is kell figyelni
myAnd _ _ = False




infixr 2 |:|
(|:|) False False = False
(|:|) _ _ = True


-- Saját xor3 függvény
xor3 :: Bool -> Bool -> Bool -> Bool

xor3 True  True  True  = True
xor3 True  False False = True
xor3 False True  False = True
xor3 False False True  = True
xor3 _     _     _     = False