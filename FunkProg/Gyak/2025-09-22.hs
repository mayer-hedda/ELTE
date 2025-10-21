-- Kizáró vagy

xor :: Bool -> Bool -> Bool
xor True True = False
xor False False = False
xor _ _ = True


-- Implikáció

(-->) :: Bool -> Bool -> Bool
True --> False = False
_ --> _ = True