# Tesztelési dokumentáció – Kurzusfelvételi rendszer API

A teszteket a `curl` parancssori HTTP kliens végezte a futó alkalmazáson
(`uvicorn main:app --port 9000`). A dokumentációt a `teszt.sh` szkript
generálta: minden kérésnél szerepel a kérés, a várt és a kapott státuszkód,
valamint a válasz törzse. A tesztek a mellékelt `data.json` tesztadataiból
indulnak, és egymásra épülnek (pl. a felvett hallgatóhoz adunk félévet).

Futtatás ideje: 2026-11-11 11:02:00


## GET / (Route)

### Rendszer neve

```bash
curl -X GET "http://127.0.0.1:9000/"
```

- Várt státuszkód: **200**
- Kapott státuszkód: **200** ✅ OK

Válasz törzse:

```json
{
    "Üdvözöl a": "ELTE Tanulmányi Rendszer"
}
```


## POST /addstudent

### Sikeres: új hallgató felvétele (a kisbetűs Neptun-kód nagybetűsre alakul)

```bash
curl -X POST "http://127.0.0.1:9000/addstudent" \
  -H 'Content-Type: application/json' \
  -d '{"id": 4, "name": "Szabó Szilvia", "email": "szilvia.szabo@student.elte.hu", "neptun": "szsz44"}'
```

- Várt státuszkód: **201**
- Kapott státuszkód: **201** ✅ OK

Válasz törzse:

```json
{
    "id": 4,
    "name": "Szabó Szilvia",
    "email": "szilvia.szabo@student.elte.hu",
    "neptun": "SZSZ44"
}
```

### Hibás: már létező azonosító

```bash
curl -X POST "http://127.0.0.1:9000/addstudent" \
  -H 'Content-Type: application/json' \
  -d '{"id": 1, "name": "Teszt Elek", "email": "teszt.elek@student.elte.hu", "neptun": "TEST01"}'
```

- Várt státuszkód: **409**
- Kapott státuszkód: **409** ✅ OK

Válasz törzse:

```json
{
    "detail": "Már létezik hallgató ezzel az ID-val: 1"
}
```

### Hibás: már létező Neptun-kód

```bash
curl -X POST "http://127.0.0.1:9000/addstudent" \
  -H 'Content-Type: application/json' \
  -d '{"id": 5, "name": "Teszt Elek", "email": "teszt.elek@student.elte.hu", "neptun": "abc123"}'
```

- Várt státuszkód: **409**
- Kapott státuszkód: **409** ✅ OK

Válasz törzse:

```json
{
    "detail": "Már létezik hallgató ezzel a Neptun-kóddal: ABC123"
}
```

### Hibás: érvénytelen e-mail és Neptun-kód (séma hiba)

```bash
curl -X POST "http://127.0.0.1:9000/addstudent" \
  -H 'Content-Type: application/json' \
  -d '{"id": 5, "name": "Teszt Elek", "email": "nem-email", "neptun": "AB-12"}'
```

- Várt státuszkód: **422**
- Kapott státuszkód: **422** ✅ OK

Válasz törzse:

```json
{
    "detail": [
        {
            "type": "value_error",
            "loc": [
                "body",
                "email"
            ],
            "msg": "value is not a valid email address: An email address must have an @-sign.",
            "input": "nem-email",
            "ctx": {
                "reason": "An email address must have an @-sign."
            }
        },
        {
            "type": "value_error",
            "loc": [
                "body",
                "neptun"
            ],
            "msg": "Value error, A Neptun-kód pontosan 6 karakter, csak nagybetű (A-Z) és számjegy (0-9) lehet",
            "input": "AB-12",
            "ctx": {
                "error": {}
            }
        }
    ]
}
```

### Hibás: negatív azonosító

```bash
curl -X POST "http://127.0.0.1:9000/addstudent" \
  -H 'Content-Type: application/json' \
  -d '{"id": -1, "name": "Teszt Elek", "email": "teszt.elek@student.elte.hu", "neptun": "TEST01"}'
```

- Várt státuszkód: **422**
- Kapott státuszkód: **422** ✅ OK

Válasz törzse:

```json
{
    "detail": [
        {
            "type": "value_error",
            "loc": [
                "body",
                "id"
            ],
            "msg": "Value error, A(z) id mező nem lehet negatív: -1",
            "input": -1,
            "ctx": {
                "error": {}
            }
        }
    ]
}
```


## POST /addsemester

### Sikeres: félév hozzáadása az új hallgatóhoz

```bash
curl -X POST "http://127.0.0.1:9000/addsemester?studentid=4&term=2026/27/1"
```

- Várt státuszkód: **201**
- Kapott státuszkód: **201** ✅ OK

Válasz törzse:

```json
"Sikeres félév létrehozás."
```

### Hibás: nem létező hallgató

```bash
curl -X POST "http://127.0.0.1:9000/addsemester?studentid=99&term=2026/27/1"
```

- Várt státuszkód: **404**
- Kapott státuszkód: **404** ✅ OK

Válasz törzse:

```json
{
    "detail": "Nem található hallgató a megadott ID-val: 99"
}
```

### Hibás: a hallgatónak már van féléve

```bash
curl -X POST "http://127.0.0.1:9000/addsemester?studentid=1&term=2026/27/2"
```

- Várt státuszkód: **409**
- Kapott státuszkód: **409** ✅ OK

Válasz törzse:

```json
{
    "detail": "A hallgatónak már van féléve: 1"
}
```

### Hibás: rossz félév-formátum

```bash
curl -X POST "http://127.0.0.1:9000/addsemester?studentid=4&term=2026/27/3"
```

- Várt státuszkód: **422**
- Kapott státuszkód: **422** ✅ OK

Válasz törzse:

```json
{
    "detail": "Hibás félév formátum: '2026/27/3'. Elvárt formátum: ÉÉÉÉ/ÉÉ/F, pl. 2026/27/1 (F csak 1 vagy 2 lehet)"
}
```


## POST /enrollcourse

### Sikeres: tárgy felvétele (példa a leírásból)

```bash
curl -X POST "http://127.0.0.1:9000/enrollcourse?studentid=3" \
  -H 'Content-Type: application/json' \
  -d '{"course_id": 301, "code": "IP-18SZAMEA", "name": "Számítógépes architektúrák", "credit": 4, "grade": null}'
```

- Várt státuszkód: **201**
- Kapott státuszkód: **201** ✅ OK

Válasz törzse:

```json
{
    "id": 103,
    "student_id": 3,
    "term": "2026/27/1",
    "courses": [
        {
            "course_id": 301,
            "code": "IP-18SZAMEA",
            "name": "Számítógépes architektúrák",
            "credit": 4,
            "grade": null
        }
    ]
}
```

### Hibás: a tárgy már fel van véve

```bash
curl -X POST "http://127.0.0.1:9000/enrollcourse?studentid=3" \
  -H 'Content-Type: application/json' \
  -d '{"course_id": 301, "code": "IP-18SZAMEA", "name": "Számítógépes architektúrák", "credit": 4, "grade": null}'
```

- Várt státuszkód: **409**
- Kapott státuszkód: **409** ✅ OK

Válasz törzse:

```json
{
    "detail": "A tárgy már fel van véve a félévben: 301"
}
```

### Hibás: a hallgatónak nincs féléve

```bash
curl -X POST "http://127.0.0.1:9000/enrollcourse?studentid=99" \
  -H 'Content-Type: application/json' \
  -d '{"course_id": 302, "code": "IP-18LOGIK", "name": "Logika", "credit": 3, "grade": null}'
```

- Várt státuszkód: **404**
- Kapott státuszkód: **404** ✅ OK

Válasz törzse:

```json
{
    "detail": "Nem található félév a megadott hallgatói ID-hoz: 99"
}
```

### Hibás: a félév túllépné a 30 kreditet (12 + 20)

```bash
curl -X POST "http://127.0.0.1:9000/enrollcourse?studentid=1" \
  -H 'Content-Type: application/json' \
  -d '{"course_id": 303, "code": "IP-18SZAKD", "name": "Szakdolgozat", "credit": 20, "grade": null}'
```

- Várt státuszkód: **400**
- Kapott státuszkód: **400** ✅ OK

Válasz törzse:

```json
{
    "detail": "A félév összkreditje legfeljebb 30 lehet (jelenleg: 32)"
}
```

### Hibás: érvénytelen kredit és jegy (séma hiba)

```bash
curl -X POST "http://127.0.0.1:9000/enrollcourse?studentid=3" \
  -H 'Content-Type: application/json' \
  -d '{"course_id": 304, "code": "IP", "name": "", "credit": 0, "grade": 6}'
```

- Várt státuszkód: **422**
- Kapott státuszkód: **422** ✅ OK

Válasz törzse:

```json
{
    "detail": [
        {
            "type": "value_error",
            "loc": [
                "body",
                "code"
            ],
            "msg": "Value error, A tárgy kódja 3-20 karakter hosszú lehet",
            "input": "IP",
            "ctx": {
                "error": {}
            }
        },
        {
            "type": "value_error",
            "loc": [
                "body",
                "name"
            ],
            "msg": "Value error, A tárgy neve nem lehet üres",
            "input": "",
            "ctx": {
                "error": {}
            }
        },
        {
            "type": "value_error",
            "loc": [
                "body",
                "credit"
            ],
            "msg": "Value error, A kreditérték 1 és 30 közötti egész szám lehet",
            "input": 0,
            "ctx": {
                "error": {}
            }
        },
        {
            "type": "value_error",
            "loc": [
                "body",
                "grade"
            ],
            "msg": "Value error, Az érdemjegy 1 és 5 közötti egész szám lehet (vagy null)",
            "input": 6,
            "ctx": {
                "error": {}
            }
        }
    ]
}
```


## PUT /updatecourse

### Sikeres: érdemjegy beírása

```bash
curl -X PUT "http://127.0.0.1:9000/updatecourse?studentid=1&courseid=203" \
  -H 'Content-Type: application/json' \
  -d '{"course_id": 203, "code": "IP-18PYTH", "name": "Python programozás", "credit": 3, "grade": 5}'
```

- Várt státuszkód: **200**
- Kapott státuszkód: **200** ✅ OK

Válasz törzse:

```json
{
    "id": 101,
    "student_id": 1,
    "term": "2026/27/1",
    "courses": [
        {
            "course_id": 201,
            "code": "IP-18PROGEG",
            "name": "Programozás",
            "credit": 5,
            "grade": 4
        },
        {
            "course_id": 202,
            "code": "IP-18AN1EG",
            "name": "Analízis I.",
            "credit": 4,
            "grade": 3
        },
        {
            "course_id": 203,
            "code": "IP-18PYTH",
            "name": "Python programozás",
            "credit": 3,
            "grade": 5
        }
    ]
}
```

### Hibás: a törzsben lévő course_id eltér a paramétertől

```bash
curl -X PUT "http://127.0.0.1:9000/updatecourse?studentid=1&courseid=203" \
  -H 'Content-Type: application/json' \
  -d '{"course_id": 299, "code": "IP-18PYTH", "name": "Python programozás", "credit": 3, "grade": 5}'
```

- Várt státuszkód: **400**
- Kapott státuszkód: **400** ✅ OK

Válasz törzse:

```json
{
    "detail": "A tárgy azonosítója nem változhat: a paraméter 203, a törzsben 299"
}
```

### Hibás: a tárgy nincs felvéve

```bash
curl -X PUT "http://127.0.0.1:9000/updatecourse?studentid=1&courseid=299" \
  -H 'Content-Type: application/json' \
  -d '{"course_id": 299, "code": "IP-18PYTH", "name": "Python programozás", "credit": 3, "grade": 5}'
```

- Várt státuszkód: **404**
- Kapott státuszkód: **404** ✅ OK

Válasz törzse:

```json
{
    "detail": "A tárgy nincs felvéve a félévben: 299"
}
```

### Hibás: a módosítás után túllépné a 30 kreditet

```bash
curl -X PUT "http://127.0.0.1:9000/updatecourse?studentid=1&courseid=203" \
  -H 'Content-Type: application/json' \
  -d '{"course_id": 203, "code": "IP-18PYTH", "name": "Python programozás", "credit": 25, "grade": 5}'
```

- Várt státuszkód: **400**
- Kapott státuszkód: **400** ✅ OK

Válasz törzse:

```json
{
    "detail": "A félév összkreditje legfeljebb 30 lehet (jelenleg: 34)"
}
```


## DELETE /dropcourse

### Sikeres: tárgy leadása

```bash
curl -X DELETE "http://127.0.0.1:9000/dropcourse?studentid=3&courseid=301"
```

- Várt státuszkód: **200**
- Kapott státuszkód: **200** ✅ OK

Válasz törzse:

```json
{
    "id": 103,
    "student_id": 3,
    "term": "2026/27/1",
    "courses": []
}
```

### Hibás: nincs ilyen tárgy a félévben

```bash
curl -X DELETE "http://127.0.0.1:9000/dropcourse?studentid=3&courseid=301"
```

- Várt státuszkód: **404**
- Kapott státuszkód: **404** ✅ OK

Válasz törzse:

```json
{
    "detail": "A tárgy nincs felvéve a félévben: 301"
}
```

### Hibás: a hallgatónak nincs féléve

```bash
curl -X DELETE "http://127.0.0.1:9000/dropcourse?studentid=99&courseid=201"
```

- Várt státuszkód: **404**
- Kapott státuszkód: **404** ✅ OK

Válasz törzse:

```json
{
    "detail": "Nem található félév a megadott hallgatói ID-hoz: 99"
}
```


## GET /student

### Sikeres: hallgató lekérdezése

```bash
curl -X GET "http://127.0.0.1:9000/student?studentid=1"
```

- Várt státuszkód: **200**
- Kapott státuszkód: **200** ✅ OK

Válasz törzse:

```json
{
    "id": 1,
    "name": "Kovács Kitti",
    "email": "kitti.kovacs@student.elte.hu",
    "neptun": "ABC123"
}
```

### Hibás: nem létező hallgató

```bash
curl -X GET "http://127.0.0.1:9000/student?studentid=99"
```

- Várt státuszkód: **404**
- Kapott státuszkód: **404** ✅ OK

Válasz törzse:

```json
{
    "detail": "Nem található hallgató a megadott ID-val: 99"
}
```

### Hibás: nem szám azonosító (séma hiba)

```bash
curl -X GET "http://127.0.0.1:9000/student?studentid=abc"
```

- Várt státuszkód: **422**
- Kapott státuszkód: **422** ✅ OK

Válasz törzse:

```json
{
    "detail": [
        {
            "type": "int_parsing",
            "loc": [
                "query",
                "studentid"
            ],
            "msg": "Input should be a valid integer, unable to parse string as an integer",
            "input": "abc"
        }
    ]
}
```


## GET /students

### Sikeres: összes hallgató

```bash
curl -X GET "http://127.0.0.1:9000/students"
```

- Várt státuszkód: **200**
- Kapott státuszkód: **200** ✅ OK

Válasz törzse:

```json
[
    {
        "id": 1,
        "name": "Kovács Kitti",
        "email": "kitti.kovacs@student.elte.hu",
        "neptun": "ABC123"
    },
    {
        "id": 2,
        "name": "Nagy Norbert",
        "email": "norbert.nagy@student.elte.hu",
        "neptun": "XYZ789"
    },
    {
        "id": 3,
        "name": "Tóth Tímea",
        "email": "timea.toth@student.elte.hu",
        "neptun": "Q1W2E3"
    },
    {
        "id": 4,
        "name": "Szabó Szilvia",
        "email": "szilvia.szabo@student.elte.hu",
        "neptun": "SZSZ44"
    }
]
```

### Hibás: nem támogatott HTTP metódus (POST)

```bash
curl -X POST "http://127.0.0.1:9000/students"
```

- Várt státuszkód: **405**
- Kapott státuszkód: **405** ✅ OK

Válasz törzse:

```json
{
    "detail": "Method Not Allowed"
}
```


## GET /semester

### Sikeres: felvett tárgyak listája

```bash
curl -X GET "http://127.0.0.1:9000/semester?studentid=1"
```

- Várt státuszkód: **200**
- Kapott státuszkód: **200** ✅ OK

Válasz törzse:

```json
[
    {
        "course_id": 201,
        "code": "IP-18PROGEG",
        "name": "Programozás",
        "credit": 5,
        "grade": 4
    },
    {
        "course_id": 202,
        "code": "IP-18AN1EG",
        "name": "Analízis I.",
        "credit": 4,
        "grade": 3
    },
    {
        "course_id": 203,
        "code": "IP-18PYTH",
        "name": "Python programozás",
        "credit": 3,
        "grade": 5
    }
]
```

### Sikeres: üres félév esetén üres lista

```bash
curl -X GET "http://127.0.0.1:9000/semester?studentid=4"
```

- Várt státuszkód: **200**
- Kapott státuszkód: **200** ✅ OK

Válasz törzse:

```json
[]
```

### Hibás: nincs félév

```bash
curl -X GET "http://127.0.0.1:9000/semester?studentid=99"
```

- Várt státuszkód: **404**
- Kapott státuszkód: **404** ✅ OK

Válasz törzse:

```json
{
    "detail": "Nem található félév a megadott hallgatói ID-hoz: 99"
}
```


## GET /getaverage

### Sikeres: kreditstatisztika (a leírás példája: 12 / 9 / 3.56)

```bash
curl -X GET "http://127.0.0.1:9000/getaverage?studentid=1"
```

- Várt státuszkód: **200**
- Kapott státuszkód: **200** ✅ OK

Válasz törzse:

```json
{
    "student_id": 1,
    "term": "2026/27/1",
    "total_credits": 12,
    "completed_credits": 9,
    "weighted_average": 3.56
}
```

### Sikeres: jegy nélküli félév esetén az átlag 0.0

```bash
curl -X GET "http://127.0.0.1:9000/getaverage?studentid=4"
```

- Várt státuszkód: **200**
- Kapott státuszkód: **200** ✅ OK

Válasz törzse:

```json
{
    "student_id": 4,
    "term": "2026/27/1",
    "total_credits": 0,
    "completed_credits": 0,
    "weighted_average": 0.0
}
```

### Hibás: nincs félév

```bash
curl -X GET "http://127.0.0.1:9000/getaverage?studentid=99"
```

- Várt státuszkód: **404**
- Kapott státuszkód: **404** ✅ OK

Válasz törzse:

```json
{
    "detail": "Nem található félév a megadott hallgatói ID-hoz: 99"
}
```


## POST /save

### Sikeres: mentés a backup.json fájlba

```bash
curl -X POST "http://127.0.0.1:9000/save?source=data.json&dest=backup.json"
```

- Várt státuszkód: **201**
- Kapott státuszkód: **201** ✅ OK

Válasz törzse:

```json
{
    "message": "Sikeres mentés.",
    "source": "data.json",
    "dest": "backup.json"
}
```

### Hibás: könyvtárat tartalmazó fájlnév

```bash
curl -X POST "http://127.0.0.1:9000/save?source=data.json&dest=../main.json"
```

- Várt státuszkód: **400**
- Kapott státuszkód: **400** ✅ OK

Válasz törzse:

```json
{
    "detail": "Csak egyszerű fájlnév adható meg, könyvtár nélkül: ../main.json"
}
```

### Hibás: nem .json kiterjesztés

```bash
curl -X POST "http://127.0.0.1:9000/save?source=data.json&dest=backup.txt"
```

- Várt státuszkód: **400**
- Kapott státuszkód: **400** ✅ OK

Válasz törzse:

```json
{
    "detail": "Csak .json kiterjesztésű fájl adható meg: backup.txt"
}
```

### Hibás: azonos forrás és cél

```bash
curl -X POST "http://127.0.0.1:9000/save?source=data.json&dest=data.json"
```

- Várt státuszkód: **400**
- Kapott státuszkód: **400** ✅ OK

Válasz törzse:

```json
{
    "detail": "A forrás és a cél fájl nem lehet azonos"
}
```

### Hibás: nem létező forrásfájl

```bash
curl -X POST "http://127.0.0.1:9000/save?source=nincs.json&dest=teszt_x.json"
```

- Várt státuszkód: **404**
- Kapott státuszkód: **404** ✅ OK

Válasz törzse:

```json
{
    "detail": "A fájl nem található: nincs.json"
}
```

### Hibás: ellentmondásos tartalom (nem létező hallgató féléve)

```bash
curl -X POST "http://127.0.0.1:9000/save?source=teszt_hibas.json&dest=teszt_x.json"
```

- Várt státuszkód: **422**
- Kapott státuszkód: **422** ✅ OK

Válasz törzse:

```json
{
    "detail": "A(z) teszt_hibas.json tartalma hibás: Nem létező hallgatóhoz tartozó félév(ek), student_id: [9]"
}
```


## POST /reload

### Sikeres: merge, keep_extra=true (a törölt tárgy visszakerül, az új hallgató marad)

```bash
curl -X POST "http://127.0.0.1:9000/reload?source=backup.json&dest=data.json&mode=merge&keep_extra=true"
```

- Várt státuszkód: **200**
- Kapott státuszkód: **200** ✅ OK

Válasz törzse:

```json
{
    "message": "Sikeres visszatöltés.",
    "source": "backup.json",
    "dest": "data.json",
    "mode": "merge",
    "keep_extra": true,
    "added": {
        "students": 0,
        "semesters": 0,
        "courses": 1
    },
    "removed": {
        "students": 0,
        "semesters": 0,
        "courses": 0
    },
    "updated": {
        "students": 0,
        "semesters": 0,
        "courses": 0
    }
}
```

### Sikeres: merge, keep_extra=false (a csak data.json-ban lévő hallgató törlődik)

```bash
curl -X POST "http://127.0.0.1:9000/reload?source=backup.json&dest=data.json&mode=merge&keep_extra=false"
```

- Várt státuszkód: **200**
- Kapott státuszkód: **200** ✅ OK

Válasz törzse:

```json
{
    "message": "Sikeres visszatöltés.",
    "source": "backup.json",
    "dest": "data.json",
    "mode": "merge",
    "keep_extra": false,
    "added": {
        "students": 0,
        "semesters": 0,
        "courses": 0
    },
    "removed": {
        "students": 1,
        "semesters": 0,
        "courses": 0
    },
    "updated": {
        "students": 0,
        "semesters": 0,
        "courses": 0
    }
}
```

### Sikeres: replace (a módosított jegy visszaáll a mentés szerintire)

```bash
curl -X POST "http://127.0.0.1:9000/reload?source=backup.json&dest=data.json&mode=replace"
```

- Várt státuszkód: **200**
- Kapott státuszkód: **200** ✅ OK

Válasz törzse:

```json
{
    "message": "Sikeres visszatöltés.",
    "source": "backup.json",
    "dest": "data.json",
    "mode": "replace",
    "keep_extra": true,
    "added": {
        "students": 0,
        "semesters": 0,
        "courses": 0
    },
    "removed": {
        "students": 0,
        "semesters": 0,
        "courses": 0
    },
    "updated": {
        "students": 0,
        "semesters": 0,
        "courses": 1
    }
}
```

### Sikeres: nem létező célfájl üres adatállománynak számít

```bash
curl -X POST "http://127.0.0.1:9000/reload?source=backup.json&dest=teszt_uj.json&mode=merge"
```

- Várt státuszkód: **200**
- Kapott státuszkód: **200** ✅ OK

Válasz törzse:

```json
{
    "message": "Sikeres visszatöltés.",
    "source": "backup.json",
    "dest": "teszt_uj.json",
    "mode": "merge",
    "keep_extra": true,
    "added": {
        "students": 4,
        "semesters": 4,
        "courses": 5
    },
    "removed": {
        "students": 0,
        "semesters": 0,
        "courses": 0
    },
    "updated": {
        "students": 0,
        "semesters": 0,
        "courses": 0
    }
}
```

### Hibás: összefésüléskor ütköző Neptun-kód

```bash
curl -X POST "http://127.0.0.1:9000/reload?source=teszt_utkozo.json&dest=data.json&mode=merge"
```

- Várt státuszkód: **409**
- Kapott státuszkód: **409** ✅ OK

Válasz törzse:

```json
{
    "detail": "Az összefésült adatok ellentmondásosak: Ismétlődő Neptun-kód(ok): ['ABC123']"
}
```

### Hibás: sémának nem megfelelő forrásfájl (data.json nem változik)

```bash
curl -X POST "http://127.0.0.1:9000/reload?source=teszt_hibas.json&dest=data.json"
```

- Várt státuszkód: **422**
- Kapott státuszkód: **422** ✅ OK

Válasz törzse:

```json
{
    "detail": "A(z) teszt_hibas.json tartalma hibás: Nem létező hallgatóhoz tartozó félév(ek), student_id: [9]"
}
```

### Hibás: nem létező forrásfájl

```bash
curl -X POST "http://127.0.0.1:9000/reload?source=nincs.json&dest=data.json"
```

- Várt státuszkód: **404**
- Kapott státuszkód: **404** ✅ OK

Válasz törzse:

```json
{
    "detail": "A fájl nem található: nincs.json"
}
```

### Hibás: könyvtárat tartalmazó fájlnév

```bash
curl -X POST "http://127.0.0.1:9000/reload?source=../backup.json&dest=data.json"
```

- Várt státuszkód: **400**
- Kapott státuszkód: **400** ✅ OK

Válasz törzse:

```json
{
    "detail": "Csak egyszerű fájlnév adható meg, könyvtár nélkül: ../backup.json"
}
```

### Hibás: azonos forrás és cél

```bash
curl -X POST "http://127.0.0.1:9000/reload?source=data.json&dest=data.json"
```

- Várt státuszkód: **400**
- Kapott státuszkód: **400** ✅ OK

Válasz törzse:

```json
{
    "detail": "A forrás és a cél fájl nem lehet azonos"
}
```

### Hibás: érvénytelen mode érték

```bash
curl -X POST "http://127.0.0.1:9000/reload?source=backup.json&dest=data.json&mode=append"
```

- Várt státuszkód: **422**
- Kapott státuszkód: **422** ✅ OK

Válasz törzse:

```json
{
    "detail": [
        {
            "type": "literal_error",
            "loc": [
                "query",
                "mode"
            ],
            "msg": "Input should be 'replace' or 'merge'",
            "input": "append",
            "ctx": {
                "expected": "'replace' or 'merge'"
            }
        }
    ]
}
```

### Ellenőrzés: a hibás visszatöltések után a data.json változatlan

```bash
curl -X GET "http://127.0.0.1:9000/students"
```

- Várt státuszkód: **200**
- Kapott státuszkód: **200** ✅ OK

Válasz törzse:

```json
[
    {
        "id": 1,
        "name": "Kovács Kitti",
        "email": "kitti.kovacs@student.elte.hu",
        "neptun": "ABC123"
    },
    {
        "id": 2,
        "name": "Nagy Norbert",
        "email": "norbert.nagy@student.elte.hu",
        "neptun": "XYZ789"
    },
    {
        "id": 3,
        "name": "Tóth Tímea",
        "email": "timea.toth@student.elte.hu",
        "neptun": "Q1W2E3"
    },
    {
        "id": 4,
        "name": "Szabó Szilvia",
        "email": "szilvia.szabo@student.elte.hu",
        "neptun": "SZSZ44"
    }
]
```


## Összesítés

Sikeres ellenőrzés: **50**, eltérés: **0**
