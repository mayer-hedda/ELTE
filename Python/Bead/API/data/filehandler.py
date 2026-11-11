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
    pass

def save_json(data: Dict[str, Any]) -> None:
    pass

def get_file_path(filename: str) -> str:
    # Csak a data könyvtáron belüli .json fájlokat engedjük (pl. ../../main.py nem)
    pass

def load_json_file(filename: str) -> Dict[str, Any]:
    pass

def save_json_file(data: Dict[str, Any], filename: str) -> None:
    pass

EMPTY_DATA = {"Students": [], "Semesters": []}

def load_json_file_or_empty(filename: str) -> Dict[str, Any]:
    pass

def merge_data(current: Dict[str, Any], backup: Dict[str, Any], keep_extra: bool = True) -> Dict[str, Any]:
    pass

def diff_counts(old: Dict[str, Any], new: Dict[str, Any]) -> Dict[str, Dict[str, int]]:
    pass

def add_student(student: Dict[str, Any]) -> None:
    pass

def add_semester(semester: Dict[str, Any]) -> None:
    pass

def add_course_to_semester(student_id: int, course: Dict[str, Any]) -> Dict[str, Any]:
    pass

def update_course_in_semester(student_id: int, course_id: int, course: Dict[str, Any]) -> Dict[str, Any]:
    pass

def remove_course_from_semester(student_id: int, course_id: int) -> Dict[str, Any]:
    pass
