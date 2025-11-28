data Pair a b = P a b deriving (Eq)

instance (Show a, Show b) => Show (Pair a b) where
    -- show (P x y) = "(" ++ show x ++ ", " ++ show y ++ ")"
    show (P x y) = show (x, y)