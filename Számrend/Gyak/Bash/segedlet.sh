#!/bin/bash
# Ez a "shebang". Megmondja a rendszernek, hogy ezt a fájlt a /bin/bash értelmezővel futtassa.
# Mindig ez legyen az első sor!

# -----------------------------------------------------------------------------
## 1. VÁLTOZÓK ÉS KIÍRÁS (Variables and Output)
# -----------------------------------------------------------------------------

# Változó definiálása: NINCS szóköz az egyenlőségjel körül!
# A változónevek általában csupa nagybetűsek (konvenció, de nem kötelező).
NEV="Világ"

# Változó használata: $ jellel hivatkozunk rá.
# Az 'echo' parancs kiír a képernyőre.
echo "Helló, $NEV!"

# Idézőjelek különbsége:
# A dupla idézőjel (") feldolgozza (expandálja) a változókat.
echo "Dupla idézőjel: Helló, $NEV"

# A szimpla idézőjel (') NEM dolgozza fel a változókat, mindent szövegként kezel.
echo 'Szimpla idézőjel: Helló, $NEV'

# A ${VALTOZO} forma akkor hasznos, ha egybeírnánk mással:
GYUMOLCS="alma"
echo "Szeretem a ${GYUMOLCS}levet." # Működik
# echo "Szeretem a $GYUMOLCSlevet."  # EZ HIBÁS LENNE (a 'GYUMOLCSlevet' változót keresné)

# -----------------------------------------------------------------------------
## 2. PARANCSSORI ARGUMENTUMOK (Built-in Variables)
# -----------------------------------------------------------------------------
# Ezek speciális változók, amiket a rendszer tölt fel.
# Futtasd így: ./script.sh elso_arg "második arg" harmadik

echo "---------------------------------"
echo "Szkript neve: $0"                  # A szkript futtatási neve
echo "Első argumentum: $1"               # Az első paraméter
echo "Második argumentum: $2"             # A második paraméter
echo "Argumentumok száma: $#"             # Hány paramétert adtunk meg
echo "Minden argumentum (egy stringben): $*" # Az összes paraméter egyben
echo "Minden argumentum (külön-külön): $@"  # Az összes paraméter listaként (ez a javasolt)
echo "Az utolsó parancs kilépési kódja: $?" # 0 = sikeres, nem 0 = hiba

# -----------------------------------------------------------------------------
## 3. BEOLVASÁS FELHASZNÁLÓTÓL (User Input)
# -----------------------------------------------------------------------------
echo "---------------------------------"
echo "Kérlek, add meg a neved:"
# A 'read' parancs beolvas egy sort a standard bemenetről és egy változóba menti.
# A -p kapcsolóval "promptot" (kérdést) is kiírhatunk.
read -p "Neved: " FELHASZNALO_NEVE
echo "Szia, $FELHASZNALO_NEVE!"

# -----------------------------------------------------------------------------
## 4. ARITMETIKA (Arithmetic)
# -----------------------------------------------------------------------------
# Aritmetikai műveletekhez a $((...)) formát használjuk.
A=10
B=5

SZUM=$((A + B))
KULONBSEG=$((A - B))
SZORZAT=$((A * B))
HANYADOS=$((A / B))
MARADEK=$((A % B)) # Modulo

echo "---------------------------------"
echo "$A + $B = $SZUM"
echo "$A / $B = $HANYADOS"
echo "$A % $B = $MARADEK"

# Növelés (mint C-ben)
X=1
X=$((X + 1))
# Vagy rövidebben:
((X++))
echo "X értéke most: $X"

# -----------------------------------------------------------------------------
## 5. FELTÉTELEK (Conditionals - if, else, elif)
# -----------------------------------------------------------------------------
# A feltételeket a [ ... ] vagy a [[ ... ]] közé írjuk.
# FONTOS: Mindig legyen szóköz a [ ] jelek belső oldalán!

# ----- Számok összehasonlítása -----
# -eq (egyenlő), -ne (nem egyenlő), -gt (nagyobb), -ge (nagyobb vagy egyenlő)
# -lt (kisebb), -le (kisebb vagy egyenlő)
SZAM=100

echo "---------------------------------"
if [ $SZAM -gt 50 ]; then
    echo "A $SZAM nagyobb, mint 50."
elif [ $SZAM -eq 50 ]; then
    echo "A $SZAM egyenlő 50-nel."
else
    echo "A $SZAM kisebb, mint 50."
fi # Az 'if' végét 'fi'-vel (if visszafelé) jelezzük.

# ----- Szövegek (stringek) összehasonlítása -----
# == vagy = (egyenlő), != (nem egyenlő)
# A [[ ... ]] használata javasolt stringeknél, mert biztonságosabb.
SZO="kutya"

if [[ $SZO == "kutya" ]]; then
    echo "A szó 'kutya'."
fi

if [[ $SZO != "macska" ]]; then
    echo "A szó nem 'macska'."
fi

# Üres string ellenőrzése (-z = zero length)
URES_SZO=""
if [[ -z $URES_SZO ]]; then
    echo "A URES_SZO változó üres."
fi

# Nem üres string ellenőrzése (-n = non-zero length)
if [[ -n $SZO ]]; then
    echo "A SZO változó nem üres."
fi

# ----- Fájl/Könyvtár ellenőrzések -----
# -e (létezik-e), -f (létezik ÉS fájl-e), -d (létezik ÉS könyvtár-e)
# -r (olvasható-e), -w (írható-e), -x (futtatható-e)

FAJLNEV="teszt.txt"
touch $FAJLNEV # Létrehozunk egy üres fájlt

if [ -f $FAJLNEV ]; then
    echo "A '$FAJLNEV' létezik és egy fájl."
else
    echo "A '$FAJLNEV' nem létezik vagy nem fájl."
fi

if [ -d /etc ]; then
    echo "Az '/etc' könyvtár létezik."
fi

rm $FAJLNEV # Töröljük a tesztfájlt

# ----- Logikai operátorok -----
# && (ÉS), || (VAGY)
# [ ... ] esetén: -a (ÉS), -o (VAGY)
# [[ ... ]] esetén: && (ÉS), || (VAGY)

KOR=25
if [[ $KOR -gt 18 && $KOR -lt 65 ]]; then
    echo "A kor 18 és 65 között van."
fi

# -----------------------------------------------------------------------------
## 6. CASE ELÁGAZÁS (Case Statement)
# -----------------------------------------------------------------------------
# Akkor hasznos, ha egy változót sok lehetséges értékkel kell összevetni.
# Tisztább, mint egy hosszú if-elif-elif... sorozat.

echo "---------------------------------"
read -p "Mit szeretnél enni (alma/banán/narancs)? " ETEL

case $ETEL in
    alma)
        echo "Az alma piros vagy zöld."
        ;; # Fontos a lezáró ;;
    banán)
        echo "A banán sárga."
        ;;
    narancs)
        echo "A narancs narancssárga."
        ;;
    *) # A '*' a "minden más" esetet (default) jelenti
        echo "Ilyen ételt nem ismerek."
        ;;
esac # A 'case' végét 'esac' (case visszafelé) jelzi.

# -----------------------------------------------------------------------------
## 7. CIKLUSOK (Loops)
# -----------------------------------------------------------------------------

# ----- FOR ciklus (lista bejárása) -----
# Bejár egy listát (szóközzel elválasztott elemek)
echo "---------------------------------"
echo "FOR ciklus (lista):"
for ALLAT in kutya macska madár
do
    echo "Állat: $ALLAT"
done # A 'do' végét 'done' jelzi.

# ----- FOR ciklus (C-stílusú) -----
# Számolás 1-től 5-ig
echo "FOR ciklus (C-stílusú):"
for (( i=1; i<=5; i++ ))
do
    echo "Szám: $i"
done

# ----- WHILE ciklus (amíg a feltétel igaz) -----
# Amíg a feltétel igaz, addig fut.
echo "WHILE ciklus:"
SZAMLALO=0
while [ $SZAMLALO -lt 3 ]
do
    echo "Számláló: $SZAMLALO"
    ((SZAMLALO++)) # Növeljük a számlálót
done

# ----- UNTIL ciklus (amíg a feltétel hamis) -----
# Ritkábban használt, a while ellentettje. Amíg a feltétel HAMIS, addig fut.
echo "UNTIL ciklus:"
SZAMLALO=5
until [ $SZAMLALO -eq 0 ]
do
    echo "Visszaszámlálás: $SZAMLALO"
    ((SZAMLALO--))
done

# ----- Ciklusvezérlés: break és continue -----
echo "Ciklusvezérlés:"
for j in 1 2 3 4 5
do
    if [ $j -eq 2 ]; then
        continue # Kihagyja a ciklusmag többi részét, és a következő elemre ugrik
    fi
    if [ $j -eq 4 ]; then
        break # Azonnal kilép a ciklusból
    fi
    echo "j = $j"
done

# -----------------------------------------------------------------------------
## 8. FÜGGVÉNYEK (Functions)
# -----------------------------------------------------------------------------
# Kódrészletek újrafelhasználására valók.

# Függvény definiálása (két gyakori mód):
# function udvozol { ... }
# VAGY (javasolt):
udvozol() {
    echo "Helló a függvényből!"
}

# Függvény hívása (egyszerűen a nevével):
echo "---------------------------------"
echo "Függvény hívása:"
udvozol

# ----- Függvények argumentumokkal és "visszatérési értékkel" -----
# A függvények ugyanúgy kapják az argumentumokat, mint a szkript: $1, $2, $#, ...
# A függvényeknek NINCS valódi visszatérési értékük (mint pl. C-ben).
# Két mód van az "eredmény" közlésére:
# 1. 'return' paranccsal egy KILÉPÉSI KÓDOT (0-255) adhatnak vissza (sikeres/hiba).
# 2. Az 'echo' paranccsal kiírják az eredményt, amit a hívó fél "elkap". (EZ A GYAKORI)

# 2. példa: Eredmény visszaadása 'echo'-val
osszead() {
    # $1 és $2 a függvénynek adott első és második paraméter
    HELYI_SZUM=$(( $1 + $2 ))
    echo $HELYI_SZUM # "Visszaadjuk" az eredményt a standard kimenetre
}

# Az eredmény "elkapása" parancs-helyettesítéssel: $(...)
EREDMENY=$(osszead 10 20)
echo "10 + 20 összege (függvényből): $EREDMENY"

# -----------------------------------------------------------------------------
## 9. PARANCS HELYETTESÍTÉS (Command Substitution)
# -----------------------------------------------------------------------------
# Lehetővé teszi, hogy egy parancs kimenetét egy változóban tároljuk.
# A $(parancs) formát használjuk (a régebbi `parancs` forma kerülendő).

echo "---------------------------------"
DATUM=$(date "+%Y-%m-%d %H:%M:%S")
echo "A pontos dátum és idő: $DATUM"

AKTUALIS_MAPPA_TARTALMA=$(ls -l)
echo "Aktuális mappa tartalma:"
# Idézőjelek közé kell tenni, hogy a sortörések megmaradjanak!
echo "$AKTUALIS_MAPPA_TARTALMA"

# -----------------------------------------------------------------------------
## 10. TÖMBÖK (Arrays)
# -----------------------------------------------------------------------------
# Változók, amik több értéket is tárolhatnak.

# Tömb definiálása
ZOLDSEGEK=("répa" "hagyma" "paradicsom" "paprika")

echo "---------------------------------"
# Egy elem elérése (indexelés 0-tól indul!)
echo "A tömb első eleme: ${ZOLDSEGEK[0]}"
echo "A tömb harmadik eleme: ${ZOLDSEGEK[2]}"

# Az összes elem elérése
echo "Az összes zöldség: ${ZOLDSEGEK[@]}"

# Az elemek száma
echo "Zöldségek száma: ${#ZOLDSEGEK[@]}"

# Elemek bejárása for ciklussal
echo "Zöldségek listája:"
for zoldseg in "${ZOLDSEGEK[@]}" # Fontos az idézőjel, ha szóközös elemek vannak
do
    echo "- $zoldseg"
done

# -----------------------------------------------------------------------------
echo "---------------------------------"
echo "A szkript futása befejeződött."
# A 'exit 0' jelzi a rendszernek, hogy a szkript sikeresen lefutott.
# Ha elhagyjuk, automatikusan az utolsó parancs kilépési kódjával tér vissza.
exit 0