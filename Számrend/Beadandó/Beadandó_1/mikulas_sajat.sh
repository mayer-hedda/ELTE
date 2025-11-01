#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Hiba: Két paramétert kell megadni a helyes működéshez!" >&2
    echo "Paraméterek sorrendje: $0 <sablon_fájl> <adatbázis_fájl>" >&2
    
    exit 1
fi


SABLON=$1
ADATBAZIS=$2

if [ ! -f "$SABLON" ]; then
    echo "Hiba: A megadott sablonfájl nem található!" >&2
    exit 1
fi

if [ ! -f "$ADATBAZIS" ]; then
    echo "Hiba: A megadott adatbázis fájl nem található!" >&2
    exit 1
fi


while IFS=';' read -r nev cim idopont
do
    sed -e "s/<nev>/$nev/g" \
        -e "s/<cim>/$cim/g" \
        -e "s/<idopont>/$idopont/g" \
        "$SABLON"
done < "$ADATBAZIS"