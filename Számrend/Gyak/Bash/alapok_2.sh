#!/bin/bash

#? ----- ELÁGAZÁSOK -----
# # Számoknál: eq, ne, lt, gt, le, ge
# if [ 3 -eq 3 ]; then
#     echo PERSZE
# fi

# # Szövegnél: =, !=, <, >
# if [ "asd" = "asd" ]; then
#     echo PERSZE
# fi

# # and: -a, &&
# a=5
# if [ $a -eq 5 -a "egy" = "egy" ]; then
#     echo PERSZE
# fi

# if [[ $a -eq 5 && "egy" = "egy" ]]; then
#     echo PERSZE
# fi

# # or: -o, ||
# if [ $a -eq 5 -o "egy" = "egy" ]; then
#     echo PERSZE
# fi

# if [[ $a -eq 5 || "egy" = "egy" ] ]; then
#     echo PERSZE
# fi


#? ----- ÉRTÉKADÁS ----- 
# # A két opció ugyanaz csinálja
# a=`expr 5 + 9`      # Függvényként használjuk
# b=$((5 + 2))        # Rövidített változat

# # Egy fájlhoz hozzáad 1-et és visszaírja a file-ba
# c=`cat file`; expr $c + 1>file      # Hivatalos verzió

# echo $a
# echo $b


#? ----- FOR CIKLUS -----
# for i in {0..100}
# do 
#     echo $i
# done


#? ----- FÁJLBA ÍRÁS -----
# # > : Kiírja a fájlba (módosítja a fájl tartalmát)
# # < : Beolvas a fájlból
# # >> : Kiírja a fájlba (hozzáfűzi az előző tartalomhoz)
# for i in {0..100}
# do 
#     echo -n $(($RANDOM % 1000))         # -n: nem tesz minden sor után sortörést
# done > file.txt                         # Kiírja a file-ba


#? ----- KERESÉS FÁJLBAN -----
# # 14
# # sed, tr, grep
sed -i 's/14/YIPPEEEE/g' file.txt       # s: kicserélem, 14: a 14-et keresem, YIPPEEEE: erre cserélem ki, g: globális

tr 'A-Z' 'a-z' < file.txt               # nagybetűket átváltja kisbetűvé