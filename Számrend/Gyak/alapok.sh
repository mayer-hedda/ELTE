#!/bin/bash

$1          # Ez az első paraméter
valt=5      # Ez az első változó (hibát okoz, ha szóközöket írok, FIGYELNI KELL RÁ)
$RANDOM     # Ez egy random szám 0 és 2^15 -1 között

echo almafa     # Az echo miatt így is string-é alakítja
echo almafa a fán
echo almafa a fán;

echo "$1$2$3"

# % --> modulusz (maradékos osztás)
valt=$((RANDOM % 10))

echo "Kiír valamit"

if [ 5 -eq "${valt}" ]; then
    echo "persze"
else
    echo "mi?"
fi