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


class NotFoundError(ValueError):
    """Nem létező rekord vagy fájl (a végpontokban 404)."""


class ConflictError(ValueError):
    """Ütközés a meglévő adatokkal (a végpontokban 409)."""


def _read_file(path: str, display_name: str) -> Dict[str, Any]:
    try:
        with open(path, "r", encoding="utf-8") as file:
            data = json.load(file)
    except FileNotFoundError:
        raise NotFoundError(f"A fájl nem található: {display_name}")
    except json.JSONDecodeError as e:
        raise ValueError(f"A fájl nem érvényes JSON ({display_name}): {e}")
    if not isinstance(data, dict):
        raise ValueError(f"A fájl szerkezete hibás ({display_name}): JSON objektumot vártunk")
    return data


def _write_file(data: Dict[str, Any], path: str) -> None:
    # Előbb ideiglenes fájlba írunk, majd átnevezzük, így írási hiba esetén
    # sem sérül meg a meglévő fájl tartalma.
    tmp_path = path + ".tmp"
    try:
        with open(tmp_path, "w", encoding="utf-8") as file:
            json.dump(data, file, ensure_ascii=False, indent=2)
        os.replace(tmp_path, path)
    finally:
        if os.path.exists(tmp_path):
            os.remove(tmp_path)


def load_json() -> Dict[str, Any]:
    data = _read_file(JSON_FILE_PATH, "data.json")
    data.setdefault("Students", [])
    data.setdefault("Semesters", [])
    return data

def save_json(data: Dict[str, Any]) -> None:
    _write_file(data, JSON_FILE_PATH)

def get_file_path(filename: str) -> str:
    # Csak a data könyvtáron belüli .json fájlokat engedjük (pl. ../../main.py nem)
    if not isinstance(filename, str) or not filename.strip():
        raise ValueError("A fájlnév nem lehet üres")
    if filename != os.path.basename(filename) or "/" in filename or "\\" in filename \
            or filename in (".", ".."):
        raise ValueError(f"Csak egyszerű fájlnév adható meg, könyvtár nélkül: {filename}")
    if not filename.lower().endswith(".json") or filename.lower() == ".json":
        raise ValueError(f"Csak .json kiterjesztésű fájl adható meg: {filename}")
    path = os.path.abspath(os.path.join(DATA_DIR, filename))
    if os.path.dirname(path) != os.path.abspath(DATA_DIR):
        raise ValueError(f"Csak a data könyvtárban lévő fájl adható meg: {filename}")
    return path

def load_json_file(filename: str) -> Dict[str, Any]:
    return _read_file(get_file_path(filename), filename)

def save_json_file(data: Dict[str, Any], filename: str) -> None:
    _write_file(data, get_file_path(filename))

EMPTY_DATA = {"Students": [], "Semesters": []}

def load_json_file_or_empty(filename: str) -> Dict[str, Any]:
    try:
        return load_json_file(filename)
    except NotFoundError:
        return copy.deepcopy(EMPTY_DATA)

def merge_data(current: Dict[str, Any], backup: Dict[str, Any], keep_extra: bool = True) -> Dict[str, Any]:
    current = copy.deepcopy(current)
    backup = copy.deepcopy(backup)

    # Hallgatók: id alapján párosítunk, mindkét helyen meglévőnél a cél változata marad.
    backup_students = {s["id"]: s for s in backup.get("Students", [])}
    current_student_ids = {s["id"] for s in current.get("Students", [])}
    students = [s for s in current.get("Students", []) if keep_extra or s["id"] in backup_students]
    students += [s for sid, s in backup_students.items() if sid not in current_student_ids]

    # Félévek: student_id alapján párosítunk, a tárgylistát course_id alapján fésüljük össze.
    backup_semesters = {s["student_id"]: s for s in backup.get("Semesters", [])}
    current_semester_owners = {s["student_id"] for s in current.get("Semesters", [])}
    semesters = []
    for semester in current.get("Semesters", []):
        backup_semester = backup_semesters.get(semester["student_id"])
        if backup_semester is None:
            if keep_extra:
                semesters.append(semester)
            continue
        backup_courses = {c["course_id"]: c for c in backup_semester.get("courses", [])}
        current_course_ids = {c["course_id"] for c in semester.get("courses", [])}
        courses = [c for c in semester.get("courses", []) if keep_extra or c["course_id"] in backup_courses]
        courses += [c for cid, c in backup_courses.items() if cid not in current_course_ids]
        semester["courses"] = courses
        semesters.append(semester)
    semesters += [s for owner, s in backup_semesters.items() if owner not in current_semester_owners]

    return {"Students": students, "Semesters": semesters}

def diff_counts(old: Dict[str, Any], new: Dict[str, Any]) -> Dict[str, Dict[str, int]]:
    def students_of(data: Dict[str, Any]) -> Dict[Any, Any]:
        return {s["id"]: s for s in data.get("Students", [])}

    def semesters_of(data: Dict[str, Any]) -> Dict[Any, Any]:
        # A félévnél csak az id és a term számít, a tárgylista nem.
        return {s["student_id"]: (s.get("id"), s.get("term")) for s in data.get("Semesters", [])}

    def courses_of(data: Dict[str, Any]) -> Dict[Any, Any]:
        return {
            (s["student_id"], c["course_id"]): c
            for s in data.get("Semesters", [])
            for c in s.get("courses", [])
        }

    def compare(old_map: Dict[Any, Any], new_map: Dict[Any, Any]) -> Dict[str, int]:
        return {
            "added": len(new_map.keys() - old_map.keys()),
            "removed": len(old_map.keys() - new_map.keys()),
            "updated": sum(1 for key in old_map.keys() & new_map.keys() if old_map[key] != new_map[key]),
        }

    kinds = {
        "students": compare(students_of(old), students_of(new)),
        "semesters": compare(semesters_of(old), semesters_of(new)),
        "courses": compare(courses_of(old), courses_of(new)),
    }
    return {
        change: {kind: counts[change] for kind, counts in kinds.items()}
        for change in ("added", "removed", "updated")
    }

def _find_semester(data: Dict[str, Any], student_id: int) -> Dict[str, Any]:
    for semester in data["Semesters"]:
        if semester["student_id"] == student_id:
            return semester
    raise NotFoundError(f"Nem található félév a megadott hallgatói ID-hoz: {student_id}")

def add_student(student: Dict[str, Any]) -> None:
    data = load_json()
    for existing in data["Students"]:
        if existing["id"] == student["id"]:
            raise ConflictError(f"Már létezik hallgató ezzel az ID-val: {student['id']}")
        if existing["neptun"].upper() == student["neptun"].upper():
            raise ConflictError(f"Már létezik hallgató ezzel a Neptun-kóddal: {student['neptun']}")
    data["Students"].append(student)
    save_json(data)

def add_semester(semester: Dict[str, Any]) -> None:
    data = load_json()
    if not any(s["id"] == semester["student_id"] for s in data["Students"]):
        raise NotFoundError(f"Nem található hallgató a megadott ID-val: {semester['student_id']}")
    for existing in data["Semesters"]:
        if existing["student_id"] == semester["student_id"]:
            raise ConflictError(f"A hallgatónak már van féléve: {semester['student_id']}")
        if existing["id"] == semester["id"]:
            raise ConflictError(f"Már létezik félév ezzel az ID-val: {semester['id']}")
    semester.setdefault("courses", [])
    data["Semesters"].append(semester)
    save_json(data)

def add_course_to_semester(student_id: int, course: Dict[str, Any]) -> Dict[str, Any]:
    data = load_json()
    semester = _find_semester(data, student_id)
    if any(c["course_id"] == course["course_id"] for c in semester["courses"]):
        raise ConflictError(f"A tárgy már fel van véve a félévben: {course['course_id']}")
    semester["courses"].append(course)
    save_json(data)
    return semester

def update_course_in_semester(student_id: int, course_id: int, course: Dict[str, Any]) -> Dict[str, Any]:
    if course.get("course_id") != course_id:
        raise ValueError(f"A tárgy azonosítója nem változhat: {course_id} != {course.get('course_id')}")
    data = load_json()
    semester = _find_semester(data, student_id)
    for index, existing in enumerate(semester["courses"]):
        if existing["course_id"] == course_id:
            semester["courses"][index] = course
            save_json(data)
            return semester
    raise NotFoundError(f"A tárgy nincs felvéve a félévben: {course_id}")

def remove_course_from_semester(student_id: int, course_id: int) -> Dict[str, Any]:
    data = load_json()
    semester = _find_semester(data, student_id)
    remaining = [c for c in semester["courses"] if c["course_id"] != course_id]
    if len(remaining) == len(semester["courses"]):
        raise NotFoundError(f"A tárgy nincs felvéve a félévben: {course_id}")
    semester["courses"] = remaining
    save_json(data)
    return semester
