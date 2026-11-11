import json
import os
from typing import Dict, Any, List

'''
Útmutató a fájl használatához:

Hallgató adatainak lekérdezése:

student_id = 1
student = get_student_by_id(student_id)
print(f"Hallgató adatai: {student}")

Hallgató félévének (teljes rekord) lekérdezése:

semester = get_semester_by_student_id(student_id)
print(f"Hallgató féléve: {semester}")

Hallgató félévében felvett tárgyak lekérdezése:

courses = get_courses_by_student_id(student_id)
print(f"Felvett tárgyak: {courses}")

Összes hallgató lekérdezése:

students = get_all_students()
print(f"Összes hallgató: {students}")

Hallgató kreditstatisztikájának lekérdezése:

stats = get_statistics(student_id)
print(f"Statisztika: {stats}")

A statisztika számítása:
 - total_credits: az összes felvett tárgy kreditjének összege
 - completed_credits: a legalább 2-es jeggyel rendelkező tárgyak kreditjének összege
 - weighted_average: a jeggyel rendelkező tárgyak kreditsúlyozott átlaga,
   két tizedesjegyre kerekítve: sum(kredit * jegy) / sum(kredit)
   (ha egyetlen tárgynak sincs jegye, az értéke 0.0)

Hogyan futtasd?

Importáld a függvényeket a filereader.py modulból:

from data.filereader import (
    get_student_by_id,
    get_semester_by_student_id,
    get_courses_by_student_id,
    get_all_students,
    get_statistics
)

 - Hiba esetén ValueErrort kell dobni, lehetőség szerint ezt a
   kliens oldalon is jelezni kell.

'''

# A JSON fájl elérési útja
JSON_FILE_PATH = os.path.join(os.path.dirname(__file__), "data.json")

def load_json() -> Dict[str, Any]:
    with open(JSON_FILE_PATH, "r", encoding="utf-8") as fajl:
        return json.load(fajl)

def get_student_by_id(student_id: int) -> Dict[str, Any]:
    for hallgato in load_json()["Students"]:
        if hallgato["id"] == student_id:
            return hallgato
    raise ValueError(f"Nem található hallgató a megadott ID-val: {student_id}")

def get_semester_by_student_id(student_id: int) -> Dict[str, Any]:
    for felev in load_json()["Semesters"]:
        if felev["student_id"] == student_id:
            return felev
    raise ValueError(f"Nem található félév a megadott hallgatói ID-hoz: {student_id}")

def get_courses_by_student_id(student_id: int) -> List[Dict[str, Any]]:
    felev = get_semester_by_student_id(student_id)
    return felev["courses"]

def get_all_students() -> List[Dict[str, Any]]:
    return load_json()["Students"]

def get_statistics(student_id: int) -> Dict[str, Any]:
    felev = get_semester_by_student_id(student_id)

    osszes_kredit = 0
    teljesitett_kredit = 0
    jeggyel_rendelkezo_kredit = 0
    sulyozott_jegyek_osszege = 0
    for targy in felev["courses"]:
        osszes_kredit += targy["credit"]
        if targy["grade"] is not None:
            jeggyel_rendelkezo_kredit += targy["credit"]
            sulyozott_jegyek_osszege += targy["credit"] * targy["grade"]
            if targy["grade"] >= 2:
                teljesitett_kredit += targy["credit"]

    if jeggyel_rendelkezo_kredit > 0:
        sulyozott_atlag = round(sulyozott_jegyek_osszege / jeggyel_rendelkezo_kredit, 2)
    else:
        sulyozott_atlag = 0.0

    return {
        "student_id": student_id,
        "term": felev["term"],
        "total_credits": osszes_kredit,
        "completed_credits": teljesitett_kredit,
        "weighted_average": sulyozott_atlag,
    }
