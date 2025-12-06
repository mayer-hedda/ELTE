firstSum :: [(Double, Double)] -> Double 

firstSum [] = 0
firstSum ((x, y):xs) = x + firstSum xs


secondSum :: [(Double, Double)] -> Double 

secondSum [] = 0
secondSum ((x, y):xs) = y + secondSum xs


maybeDiv :: [(Double, Double)] -> Maybe Double

maybeDiv xs
    | secondSum xs == 0 = Nothing
    | otherwise = Just (firstSum xs / secondSum xs)
