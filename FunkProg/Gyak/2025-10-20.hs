-- (:) :: a -> [a] -> a[a]

l [] = 0
l x : xs = 

sum [] = 0
sum x : xs = x + sum xs

p [] = 1
p x : xs = x * pxs


myLast :: [a] -> a

myLast [x] = x
myLast (x : xs) = myLast xs


myMinimum :: [Integer] -> Integer

myMinimum [x] = x
myMinimum (x : xs) = x `min` myMinimum xs


myDrop :: Int -> [a] -> [a]

myDrop x y
  |x <= 0 = y
myDrop _ [] = []
myDrop x (y : ys) = myDrop (x-1) ys


myElem :: Eq a => a -> [a] -> Bool

myElem _ [] = False
myElem x (y : ys)
  |x == y = True
  |otherwise = myElem x ys


myTake :: Int -> [a] -> [a]

myTake _ [] = []
myTake x y
  |x <= 0 = []
myTake x (y : ys) = y : myTake (x-1) ys


myReplicate :: Int -> a -> [a]

myReplicate n e
  |n <= 0 = []
myReplicate n e = e : myReplicate (n-1) e


myRepeat :: a -> [a]

myRepeat x = x : myRepeat x