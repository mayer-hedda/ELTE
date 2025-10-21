#!/bin/bash

# 3 paraméteres lottó, ami kiírja, hogy melyik találat volt sikeres

randomszam=$((RANDOM % 10 + 1))
echo "A sorsolt szám: $randomszam"

if [ "$1" -eq "$randomszam" ]; then
    echo "$1 találat sikeres volt!"
elif [ "$2" -eq "$randomszam" ]; then
    echo "$2 találat sikeres volt!"
elif [ "$3" -eq "$randomszam" ]; then
    echo "$3 találat sikeres volt!"
else 
    echo "Egyik találat sem sikerült! :c"
fi