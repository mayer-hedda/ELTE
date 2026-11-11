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
    pass

def get_student_by_id(student_id: int) -> Dict[str, Any]:
    pass

def get_semester_by_student_id(student_id: int) -> Dict[str, Any]:
    pass

def get_courses_by_student_id(student_id: int) -> List[Dict[str, Any]]:
    pass

def get_all_students() -> List[Dict[str, Any]]:
    pass

def get_statistics(student_id: int) -> Dict[str, Any]:
    pass
