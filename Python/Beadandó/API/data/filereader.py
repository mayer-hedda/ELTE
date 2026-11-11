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
    '''A data.json teljes tartalmának beolvasása.'''
    try:
        with open(JSON_FILE_PATH, "r", encoding="utf-8") as file:
            data = json.load(file)
    except FileNotFoundError:
        raise ValueError("Az adatfájl (data.json) nem található")
    except json.JSONDecodeError as e:
        raise ValueError(f"Az adatfájl (data.json) nem érvényes JSON: {e}")
    if not isinstance(data, dict):
        raise ValueError("Az adatfájl (data.json) szerkezete hibás")
    data.setdefault("Students", [])
    data.setdefault("Semesters", [])
    return data

def get_student_by_id(student_id: int) -> Dict[str, Any]:
    '''Egy hallgató rekordja azonosító alapján (ValueError, ha nincs ilyen).'''
    for student in load_json()["Students"]:
        if student["id"] == student_id:
            return student
    raise ValueError(f"Nem található hallgató a megadott ID-val: {student_id}")

def get_semester_by_student_id(student_id: int) -> Dict[str, Any]:
    '''A hallgató félévének teljes rekordja (ValueError, ha nincs féléve).'''
    for semester in load_json()["Semesters"]:
        if semester["student_id"] == student_id:
            return semester
    raise ValueError(f"Nem található félév a megadott hallgatói ID-hoz: {student_id}")

def get_courses_by_student_id(student_id: int) -> List[Dict[str, Any]]:
    '''A hallgató félévében felvett tárgyak listája (üres félévnél üres lista).'''
    return get_semester_by_student_id(student_id).get("courses", [])

def get_all_students() -> List[Dict[str, Any]]:
    '''Az összes hallgató (félévek nélkül).'''
    return load_json()["Students"]

def get_statistics(student_id: int) -> Dict[str, Any]:
    '''A hallgató kreditstatisztikája a félévében felvett tárgyak alapján.'''
    semester = get_semester_by_student_id(student_id)
    courses = semester.get("courses", [])

    total_credits = sum(course["credit"] for course in courses)
    completed_credits = sum(
        course["credit"] for course in courses
        if course.get("grade") is not None and course["grade"] >= 2
    )
    graded = [course for course in courses if course.get("grade") is not None]
    graded_credits = sum(course["credit"] for course in graded)
    if graded_credits > 0:
        weighted_average = round(
            sum(course["credit"] * course["grade"] for course in graded) / graded_credits, 2
        )
    else:
        weighted_average = 0.0

    return {
        "student_id": student_id,
        "term": semester["term"],
        "total_credits": total_credits,
        "completed_credits": completed_credits,
        "weighted_average": weighted_average,
    }
