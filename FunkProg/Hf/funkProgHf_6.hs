signOfHead :: [Integer] -> Integer

signOfHead (x : xs)
    |x > 0 = 1
    |x < 0 = -1
    |otherwise = 0


range :: [Integer] -> [Integer]

range [] = []
range [a] = [a..]
range [a, b] = [a, b ..]
range (a : b : c : _) = [a, b .. c]