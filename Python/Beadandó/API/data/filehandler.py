import copy
import json
import os
from typing import Dict, Any


'''
Útmutató a fájl függvényeinek a használatához

Új hallgató hozzáadása:

new_student = {
    "id": 4,  # Egyedi hallgatói azonosító
    "name": "Szabó Szilvia",
    "email": "szilvia.szabo@student.elte.hu",
    "neptun": "SZSZ44"
}

Hallgató hozzáadása a JSON fájlhoz:

add_student(new_student)

Hozzáadunk egy új félévet egy meglévő hallgatóhoz:

new_semester = {
    "id": 104,  # Egyedi félév azonosító
    "student_id": 4,  # Az a hallgató, akihez a félév tartozik
    "term": "2026/27/1",
    "courses": []  # Kezdetben nincs felvett tárgy
}

add_semester(new_semester)

Új tárgy felvétele egy hallgató félévébe:

student_id = 4
new_course = {
    "course_id": 206,
    "code": "IP-18SZAMEA",
    "name": "Számítógépes architektúrák",
    "credit": 4,
    "grade": None
}

add_course_to_semester(student_id, new_course)

Tárgy módosítása (pl. jegy beírása) és törlése a félévből:

update_course_in_semester(student_id, 206, {...a tárgy új adatai...})
remove_course_from_semester(student_id, 206)

Mentés és visszatöltés tetszőleges (a data könyvtárban lévő) JSON fájlba/fájlból:

data = load_json_file("data.json")
save_json_file(data, "backup.json")

A get_file_path() csak egyszerű fájlnevet fogadjon el (könyvtárak nélkül),
.json kiterjesztéssel, és a data könyvtáron belüli elérési utat adja vissza.

A load_json_file_or_empty() ugyanaz, mint a load_json_file(), de nem létező fájl
esetén üres adatállományt ad vissza: {"Students": [], "Semesters": []}

Visszatöltés összefésüléssel (merge):

merged = merge_data(current, backup, keep_extra=True)

 - current: a cél (data.json) jelenlegi tartalma, backup: a mentés tartalma
 - a mentésből csak azok a rekordok kerülnek be, amelyek a célban nincsenek meg:
     hallgató: azonosító (id) alapján,
     félév: hallgató (student_id) alapján,
     tárgy: egy mindkét helyen meglévő félévben a course_id alapján
 - a mindkét helyen meglévő rekordokból a cél (data.json) változata marad meg
 - keep_extra=True: a csak a célban lévő rekordok (hallgató, félév, tárgy) megmaradnak
   keep_extra=False: a csak a célban lévő rekordok törlődnek
 - a bemenő adatokat a függvény nem módosíthatja (másolatot kell készíteni)

A változások összeszámolása (a visszatöltés előtti és utáni állapot összevetése):

changes = diff_counts(old, new)
# {"added":   {"students": 1, "semesters": 1, "courses": 3},
#  "removed": {"students": 0, "semesters": 0, "courses": 0},
#  "updated": {"students": 0, "semesters": 0, "courses": 1}}

 - added: az új állapotban meglévő, a régiben nem szereplő rekordok száma
 - removed: a régi állapotban meglévő, az újból hiányzó rekordok száma
 - updated: a mindkettőben meglévő, de eltérő tartalmú rekordok száma
   (a félévnél a tárgylista nélkül, csak az id és a term számít)
 - a tárgyakat a (student_id, course_id) pár azonosítja

Hogyan használd a fájlt?

Importáld a függvényeket a filehandler.py modulból:

from data.filehandler import (
    add_student,
    add_semester,
    add_course_to_semester,
)

 - Hiba esetén ValueErrort kell dobni, lehetőség szerint ezt a
   kliens oldalon is jelezni kell.

'''

DATA_DIR = os.path.dirname(__file__)
JSON_FILE_PATH = os.path.join(DATA_DIR, "data.json")

def load_json() -> Dict[str, Any]:
    with open(JSON_FILE_PATH, "r", encoding="utf-8") as fajl:
        return json.load(fajl)

def save_json(data: Dict[str, Any]) -> None:
    with open(JSON_FILE_PATH, "w", encoding="utf-8") as fajl:
        json.dump(data, fajl, ensure_ascii=False, indent=2)

def get_file_path(filename: str) -> str:
    # Csak a data könyvtáron belüli .json fájlokat engedjük (pl. ../../main.py nem)
    csak_fajlnev = filename == os.path.basename(filename)
    json_kiterjesztes = filename.endswith(".json") and filename != ".json"
    if not csak_fajlnev or not json_kiterjesztes:
        raise ValueError(f"Csak a data könyvtárban lévő, .json kiterjesztésű fájlnév adható meg: {filename}")
    return os.path.join(DATA_DIR, filename)

def load_json_file(filename: str) -> Dict[str, Any]:
    with open(get_file_path(filename), "r", encoding="utf-8") as fajl:
        try:
            return json.load(fajl)
        except json.JSONDecodeError:
            raise ValueError(f"A fájl nem érvényes JSON: {filename}")

def save_json_file(data: Dict[str, Any], filename: str) -> None:
    with open(get_file_path(filename), "w", encoding="utf-8") as fajl:
        json.dump(data, fajl, ensure_ascii=False, indent=2)

EMPTY_DATA = {"Students": [], "Semesters": []}

def load_json_file_or_empty(filename: str) -> Dict[str, Any]:
    try:
        return load_json_file(filename)
    except FileNotFoundError:
        return copy.deepcopy(EMPTY_DATA)

def merge_data(current: Dict[str, Any], backup: Dict[str, Any], keep_extra: bool = True) -> Dict[str, Any]:
    cel = copy.deepcopy(current)
    mentes = copy.deepcopy(backup)

    mentett_hallgato_azonositok = []
    for hallgato in mentes["Students"]:
        mentett_hallgato_azonositok.append(hallgato["id"])

    cel_hallgato_azonositok = []
    hallgatok = []
    for hallgato in cel["Students"]:
        cel_hallgato_azonositok.append(hallgato["id"])
        if keep_extra or hallgato["id"] in mentett_hallgato_azonositok:
            hallgatok.append(hallgato)
    for hallgato in mentes["Students"]:
        if hallgato["id"] not in cel_hallgato_azonositok:
            hallgatok.append(hallgato)

    mentett_felevek = {}
    for felev in mentes["Semesters"]:
        mentett_felevek[felev["student_id"]] = felev

    cel_felevek_hallgatoi = []
    felevek = []
    for felev in cel["Semesters"]:
        cel_felevek_hallgatoi.append(felev["student_id"])
        mentett_felev = mentett_felevek.get(felev["student_id"])
        if mentett_felev is None:
            if keep_extra:
                felevek.append(felev)
            continue

        mentett_targy_azonositok = []
        for targy in mentett_felev["courses"]:
            mentett_targy_azonositok.append(targy["course_id"])

        cel_targy_azonositok = []
        targyak = []
        for targy in felev["courses"]:
            cel_targy_azonositok.append(targy["course_id"])
            if keep_extra or targy["course_id"] in mentett_targy_azonositok:
                targyak.append(targy)
        for targy in mentett_felev["courses"]:
            if targy["course_id"] not in cel_targy_azonositok:
                targyak.append(targy)

        felev["courses"] = targyak
        felevek.append(felev)
    for felev in mentes["Semesters"]:
        if felev["student_id"] not in cel_felevek_hallgatoi:
            felevek.append(felev)

    return {"Students": hallgatok, "Semesters": felevek}

def diff_counts(old: Dict[str, Any], new: Dict[str, Any]) -> Dict[str, Dict[str, int]]:
    regi = {"students": {}, "semesters": {}, "courses": {}}
    uj = {"students": {}, "semesters": {}, "courses": {}}
    for adatok, rekordok in ((old, regi), (new, uj)):
        for hallgato in adatok["Students"]:
            rekordok["students"][hallgato["id"]] = hallgato
        for felev in adatok["Semesters"]:
            rekordok["semesters"][felev["student_id"]] = (felev["id"], felev["term"])
            for targy in felev["courses"]:
                rekordok["courses"][(felev["student_id"], targy["course_id"])] = targy

    eredmeny = {"added": {}, "removed": {}, "updated": {}}
    for fajta in ("students", "semesters", "courses"):
        hozzaadott = 0
        modositott = 0
        for azonosito in uj[fajta]:
            if azonosito not in regi[fajta]:
                hozzaadott += 1
            elif regi[fajta][azonosito] != uj[fajta][azonosito]:
                modositott += 1

        torolt = 0
        for azonosito in regi[fajta]:
            if azonosito not in uj[fajta]:
                torolt += 1

        eredmeny["added"][fajta] = hozzaadott
        eredmeny["removed"][fajta] = torolt
        eredmeny["updated"][fajta] = modositott
    return eredmeny

def add_student(student: Dict[str, Any]) -> None:
    adatok = load_json()
    adatok["Students"].append(student)
    save_json(adatok)

def add_semester(semester: Dict[str, Any]) -> None:
    adatok = load_json()
    adatok["Semesters"].append(semester)
    save_json(adatok)

def add_course_to_semester(student_id: int, course: Dict[str, Any]) -> Dict[str, Any]:
    adatok = load_json()
    for felev in adatok["Semesters"]:
        if felev["student_id"] == student_id:
            felev["courses"].append(course)
            save_json(adatok)
            return felev
    raise ValueError(f"Nem található félév a megadott hallgatói ID-hoz: {student_id}")

def update_course_in_semester(student_id: int, course_id: int, course: Dict[str, Any]) -> Dict[str, Any]:
    adatok = load_json()
    for felev in adatok["Semesters"]:
        if felev["student_id"] == student_id:
            for sorszam in range(len(felev["courses"])):
                if felev["courses"][sorszam]["course_id"] == course_id:
                    felev["courses"][sorszam] = course
                    save_json(adatok)
                    return felev
            raise ValueError(f"A tárgy nincs felvéve a félévben: {course_id}")
    raise ValueError(f"Nem található félév a megadott hallgatói ID-hoz: {student_id}")

def remove_course_from_semester(student_id: int, course_id: int) -> Dict[str, Any]:
    adatok = load_json()
    for felev in adatok["Semesters"]:
        if felev["student_id"] == student_id:
            for targy in felev["courses"]:
                if targy["course_id"] == course_id:
                    felev["courses"].remove(targy)
                    save_json(adatok)
                    return felev
            raise ValueError(f"A tárgy nincs felvéve a félévben: {course_id}")
    raise ValueError(f"Nem található félév a megadott hallgatói ID-hoz: {student_id}")
