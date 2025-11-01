#!/bin/bash

# Ellenőrizzük, hogy a felhasználó megadott-e pontosan két paramétert.
if [ "$#" -ne 2 ]; then
    # Hibaüzenet a standard error kimenetre (>&2)
    echo "Hiba: Pontosan két paraméter szükséges!" >&2
    echo "Használat: $0 <sablon_fájl> <adatbázis_fájl>" >&2
    exit 1
fi

# Változókba tesszük a paramétereket az olvashatóság kedvéért
SABLON_FAJL=$1
ADAT_FAJL=$2

# Ellenőrizzük, hogy a megadott fájlok léteznek-e
if [ ! -f "$SABLON_FAJL" ]; then
    echo "Hiba: A sablonfájl ($SABLON_FAJL) nem található!" >&2
    exit 1
fi

if [ ! -f "$ADAT_FAJL" ]; then
    echo "Hiba: Az adatbázisfájl ($ADAT_FAJL) nem található!" >&2
    exit 1
fi

# Az adatfájl olvasása soronként
# Az IFS (Internal Field Separator) beállítása pontosvesszőre,
# hogy a 'read' parancs helyesen válassza szét az adatokat.
while IFS=';' read -r nev cim idopont
do
    # Ellenőrizzük, hogy a sor nem volt-e üres
    # (ez kiküszöböli pl. a fájl végén lévő üres sorokat)
    if [ -n "$nev" ]; then
        # A 'sed' paranccsal végezzük el a cseréket.
        # Minden helyőrzőre (-e) külön cserét végzünk.
        # Az eredmény a standard kimenetre kerül.
        sed -e "s/<nev>/$nev/g" \
            -e "s/<cim>/$cim/g" \
            -e "s/<idopont>/$idopont/g" \
            "$SABLON_FAJL"
        
        # Elválasztó vonal a levelek között a jobb átláthatóságért
        echo
        echo "----------------------------------------------------"
        echo
    fi
done < "$ADAT_FAJL" # A ciklus bemenete az adatfájl