#!/bin/bash

szavazatok=$1

# Fájl beolvasása
while IFS= read -r sor; do
    echo "$sor"
done < $szavazatok
