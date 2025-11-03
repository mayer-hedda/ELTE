module Chars where

{- # Definiáljunk azt a függvényt mintaillesztés segítségével, amely 'a' vagy 'A' betű esetén igazat, különben hamisat ad. -}
isA :: Char -> Bool

isA 'a' = True
isA 'A' = True
isA _ = False


{- # Definiáljunk azt a függvényt mintaillesztés segítségével, amely egy sortörést ('\n') egy szóközre (' ') cserél! -}
replaceNewline :: Char -> Char

replaceNewline '\n' = ' '
replaceNewline x = x


{- # Definiáljuk azt a függévnyt, amely eldönti, hogy a kapott karakter újsrojel-e ('\n'). -}
isNewline :: Char -> Bool

isNewline '\n' = True
isNewline _ = False


{- # Definiáljuk azt a függvényt, amely eldönti egy karakterről, hogy az magánhangzó-e. 
Elegendő csak az ékezet nélküli magánhangzókkal foglalkozni: a, e, i, o, u -}
isVowel :: Char -> Bool

isVowel 'a' = True
isVowel 'e' = True
isVowel 'i' = True
isVowel 'o' = True
isVowel 'u' = True
isVowel _ = False


{- # Definiáljuk azt a függvényt, amely egy eldönti egy karakterről, hogy az számjegy-e. -}
isDig :: Char -> Bool

isDig '0' = True
isDig '1' = True
isDig '2' = True
isDig '3' = True
isDig '4' = True
isDig '5' = True
isDig '6' = True
isDig '7' = True
isDig '8' = True
isDig '9' = True
isDig _ = False


