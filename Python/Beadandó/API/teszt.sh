#!/usr/bin/env bash
# A végpontok tesztelése curl segítségével.
# A futó API-t (uvicorn main:app --port 9000) hívja, és a kéréseket, a várt és a
# kapott státuszkódot, valamint a válasz törzsét a TESZTELES.md fájlba írja.
# A data.json eredeti tartalmát a teszt végén visszaállítja.
#
# Használat (az API könyvtárában állva, futó szerver mellett):
#   ./teszt.sh [BASE_URL]

BASE="${1:-http://127.0.0.1:9000}"
DIR="$(cd "$(dirname "$0")" && pwd)"
OUT="$DIR/TESZTELES.md"
DATA="$DIR/data"

cp "$DATA/data.json" "$DATA/data.json.orig"
trap 'mv "$DATA/data.json.orig" "$DATA/data.json"; rm -f "$DATA"/teszt_*.json "$DATA/backup.json"' EXIT

PASS=0
FAIL=0

cat > "$OUT" <<EOF
# Tesztelési dokumentáció – Kurzusfelvételi rendszer API

A teszteket a \`curl\` parancssori HTTP kliens végezte a futó alkalmazáson
(\`uvicorn main:app --port 9000\`). A dokumentációt a \`teszt.sh\` szkript
generálta: minden kérésnél szerepel a kérés, a várt és a kapott státuszkód,
valamint a válasz törzse. A tesztek a mellékelt \`data.json\` tesztadataiból
indulnak, és egymásra épülnek (pl. a felvett hallgatóhoz adunk félévet).

Futtatás ideje: $(date "+%Y-%m-%d %H:%M:%S")

EOF

section() {
    printf '\n## %s\n\n' "$1" >> "$OUT"
}

# t <leírás> <várt státusz> <metódus> <útvonal> [JSON törzs]
t() {
    local desc="$1" expected="$2" method="$3" path="$4" body="$5"
    local resp code result
    if [ -n "$body" ]; then
        resp=$(curl -s -w '\n%{http_code}' -X "$method" "$BASE$path" \
            -H 'Content-Type: application/json' -d "$body")
    else
        resp=$(curl -s -w '\n%{http_code}' -X "$method" "$BASE$path")
    fi
    code="${resp##*$'\n'}"
    resp="${resp%$'\n'*}"
    if [ "$code" = "$expected" ]; then result="✅ OK"; PASS=$((PASS+1)); else result="❌ HIBA"; FAIL=$((FAIL+1)); fi
    {
        printf '### %s\n\n' "$desc"
        printf '```bash\ncurl -X %s "%s%s"' "$method" "$BASE" "$path"
        [ -n "$body" ] && printf " \\\\\n  -H 'Content-Type: application/json' \\\\\n  -d '%s'" "$body"
        printf '\n```\n\n'
        printf -- '- Várt státuszkód: **%s**\n- Kapott státuszkód: **%s** %s\n\n' "$expected" "$code" "$result"
        printf 'Válasz törzse:\n\n```json\n%s\n```\n\n' "$(printf '%s' "$resp" | python3 -m json.tool --no-ensure-ascii 2>/dev/null || printf '%s' "$resp")"
    } >> "$OUT"
    printf '%-6s %s  várt %s, kapott %s  %s\n' "$method" "$path" "$expected" "$code" "$result"
}

section "GET / (Route)"
t "Rendszer neve" 200 GET "/"

section "POST /addstudent"
t "Sikeres: új hallgató felvétele (a kisbetűs Neptun-kód nagybetűsre alakul)" 201 POST "/addstudent" \
  '{"id": 4, "name": "Szabó Szilvia", "email": "szilvia.szabo@student.elte.hu", "neptun": "szsz44"}'
t "Hibás: már létező azonosító" 409 POST "/addstudent" \
  '{"id": 1, "name": "Teszt Elek", "email": "teszt.elek@student.elte.hu", "neptun": "TEST01"}'
t "Hibás: már létező Neptun-kód" 409 POST "/addstudent" \
  '{"id": 5, "name": "Teszt Elek", "email": "teszt.elek@student.elte.hu", "neptun": "abc123"}'
t "Hibás: érvénytelen e-mail és Neptun-kód (séma hiba)" 422 POST "/addstudent" \
  '{"id": 5, "name": "Teszt Elek", "email": "nem-email", "neptun": "AB-12"}'
t "Hibás: negatív azonosító" 422 POST "/addstudent" \
  '{"id": -1, "name": "Teszt Elek", "email": "teszt.elek@student.elte.hu", "neptun": "TEST01"}'

section "POST /addsemester"
t "Sikeres: félév hozzáadása az új hallgatóhoz" 201 POST "/addsemester?studentid=4&term=2026/27/1"
t "Hibás: nem létező hallgató" 404 POST "/addsemester?studentid=99&term=2026/27/1"
t "Hibás: a hallgatónak már van féléve" 409 POST "/addsemester?studentid=1&term=2026/27/2"
t "Hibás: rossz félév-formátum" 422 POST "/addsemester?studentid=4&term=2026/27/3"

section "POST /enrollcourse"
t "Sikeres: tárgy felvétele (példa a leírásból)" 201 POST "/enrollcourse?studentid=3" \
  '{"course_id": 301, "code": "IP-18SZAMEA", "name": "Számítógépes architektúrák", "credit": 4, "grade": null}'
t "Hibás: a tárgy már fel van véve" 409 POST "/enrollcourse?studentid=3" \
  '{"course_id": 301, "code": "IP-18SZAMEA", "name": "Számítógépes architektúrák", "credit": 4, "grade": null}'
t "Hibás: a hallgatónak nincs féléve" 404 POST "/enrollcourse?studentid=99" \
  '{"course_id": 302, "code": "IP-18LOGIK", "name": "Logika", "credit": 3, "grade": null}'
t "Hibás: a félév túllépné a 30 kreditet (12 + 20)" 400 POST "/enrollcourse?studentid=1" \
  '{"course_id": 303, "code": "IP-18SZAKD", "name": "Szakdolgozat", "credit": 20, "grade": null}'
t "Hibás: érvénytelen kredit és jegy (séma hiba)" 422 POST "/enrollcourse?studentid=3" \
  '{"course_id": 304, "code": "IP", "name": "", "credit": 0, "grade": 6}'

section "PUT /updatecourse"
t "Sikeres: érdemjegy beírása" 200 PUT "/updatecourse?studentid=1&courseid=203" \
  '{"course_id": 203, "code": "IP-18PYTH", "name": "Python programozás", "credit": 3, "grade": 5}'
t "Hibás: a törzsben lévő course_id eltér a paramétertől" 400 PUT "/updatecourse?studentid=1&courseid=203" \
  '{"course_id": 299, "code": "IP-18PYTH", "name": "Python programozás", "credit": 3, "grade": 5}'
t "Hibás: a tárgy nincs felvéve" 404 PUT "/updatecourse?studentid=1&courseid=299" \
  '{"course_id": 299, "code": "IP-18PYTH", "name": "Python programozás", "credit": 3, "grade": 5}'
t "Hibás: a módosítás után túllépné a 30 kreditet" 400 PUT "/updatecourse?studentid=1&courseid=203" \
  '{"course_id": 203, "code": "IP-18PYTH", "name": "Python programozás", "credit": 25, "grade": 5}'

section "DELETE /dropcourse"
t "Sikeres: tárgy leadása" 200 DELETE "/dropcourse?studentid=3&courseid=301"
t "Hibás: nincs ilyen tárgy a félévben" 404 DELETE "/dropcourse?studentid=3&courseid=301"
t "Hibás: a hallgatónak nincs féléve" 404 DELETE "/dropcourse?studentid=99&courseid=201"

section "GET /student"
t "Sikeres: hallgató lekérdezése" 200 GET "/student?studentid=1"
t "Hibás: nem létező hallgató" 404 GET "/student?studentid=99"
t "Hibás: nem szám azonosító (séma hiba)" 422 GET "/student?studentid=abc"

section "GET /students"
t "Sikeres: összes hallgató" 200 GET "/students"
t "Hibás: nem támogatott HTTP metódus (POST)" 405 POST "/students"

section "GET /semester"
t "Sikeres: felvett tárgyak listája" 200 GET "/semester?studentid=1"
t "Sikeres: üres félév esetén üres lista" 200 GET "/semester?studentid=4"
t "Hibás: nincs félév" 404 GET "/semester?studentid=99"

section "GET /getaverage"
# Az 1-es hallgató 203-as tárgyának jegyét a fenti teszt 5-re írta, ezért
# először visszaállítjuk null-ra, hogy a leírásban szereplő példát kapjuk.
curl -s -o /dev/null -X PUT "$BASE/updatecourse?studentid=1&courseid=203" -H 'Content-Type: application/json' \
  -d '{"course_id": 203, "code": "IP-18PYTH", "name": "Python programozás", "credit": 3, "grade": null}'
t "Sikeres: kreditstatisztika (a leírás példája: 12 / 9 / 3.56)" 200 GET "/getaverage?studentid=1"
t "Sikeres: jegy nélküli félév esetén az átlag 0.0" 200 GET "/getaverage?studentid=4"
t "Hibás: nincs félév" 404 GET "/getaverage?studentid=99"

section "POST /save"
t "Sikeres: mentés a backup.json fájlba" 201 POST "/save?source=data.json&dest=backup.json"
t "Hibás: könyvtárat tartalmazó fájlnév" 400 POST "/save?source=data.json&dest=../main.json"
t "Hibás: nem .json kiterjesztés" 400 POST "/save?source=data.json&dest=backup.txt"
t "Hibás: azonos forrás és cél" 400 POST "/save?source=data.json&dest=data.json"
t "Hibás: nem létező forrásfájl" 404 POST "/save?source=nincs.json&dest=teszt_x.json"
printf '{"Students": [{"id": 1, "name": "A", "email": "a@b.hu", "neptun": "AAA111"}], "Semesters": [{"id": 1, "student_id": 9, "term": "2026/27/1", "courses": []}]}' > "$DATA/teszt_hibas.json"
t "Hibás: ellentmondásos tartalom (nem létező hallgató féléve)" 422 POST "/save?source=teszt_hibas.json&dest=teszt_x.json"

section "POST /reload"
# A mentés után új hallgatót veszünk fel, és töröljük a 2-es hallgató egyik tárgyát,
# így a visszatöltés eredménye jól látható.
curl -s -o /dev/null -X POST "$BASE/addstudent" -H 'Content-Type: application/json' \
  -d '{"id": 6, "name": "Kiss Kornél", "email": "kornel.kiss@student.elte.hu", "neptun": "KK0606"}'
curl -s -o /dev/null -X DELETE "$BASE/dropcourse?studentid=2&courseid=205"
t "Sikeres: merge, keep_extra=true (a törölt tárgy visszakerül, az új hallgató marad)" 200 POST "/reload?source=backup.json&dest=data.json&mode=merge&keep_extra=true"
t "Sikeres: merge, keep_extra=false (a csak data.json-ban lévő hallgató törlődik)" 200 POST "/reload?source=backup.json&dest=data.json&mode=merge&keep_extra=false"
curl -s -o /dev/null -X PUT "$BASE/updatecourse?studentid=1&courseid=203" -H 'Content-Type: application/json' \
  -d '{"course_id": 203, "code": "IP-18PYTH", "name": "Python programozás", "credit": 3, "grade": 2}'
t "Sikeres: replace (a módosított jegy visszaáll a mentés szerintire)" 200 POST "/reload?source=backup.json&dest=data.json&mode=replace"
t "Sikeres: nem létező célfájl üres adatállománynak számít" 200 POST "/reload?source=backup.json&dest=teszt_uj.json&mode=merge"
printf '{"Students": [{"id": 7, "name": "Ütköző Ödön", "email": "odon@student.elte.hu", "neptun": "ABC123"}], "Semesters": []}' > "$DATA/teszt_utkozo.json"
t "Hibás: összefésüléskor ütköző Neptun-kód" 409 POST "/reload?source=teszt_utkozo.json&dest=data.json&mode=merge"
t "Hibás: sémának nem megfelelő forrásfájl (data.json nem változik)" 422 POST "/reload?source=teszt_hibas.json&dest=data.json"
t "Hibás: nem létező forrásfájl" 404 POST "/reload?source=nincs.json&dest=data.json"
t "Hibás: könyvtárat tartalmazó fájlnév" 400 POST "/reload?source=../backup.json&dest=data.json"
t "Hibás: azonos forrás és cél" 400 POST "/reload?source=data.json&dest=data.json"
t "Hibás: érvénytelen mode érték" 422 POST "/reload?source=backup.json&dest=data.json&mode=append"
t "Ellenőrzés: a hibás visszatöltések után a data.json változatlan" 200 GET "/students"

printf '\n## Összesítés\n\nSikeres ellenőrzés: **%d**, eltérés: **%d**\n' "$PASS" "$FAIL" >> "$OUT"
echo "Összesen: $PASS OK, $FAIL HIBA  ->  $OUT"
