-- base case
f :: Int -> Int
f 1 = 1

-- recursive case
f x = x * f(x - 1)