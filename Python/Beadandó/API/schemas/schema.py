import re
from pydantic import BaseModel, EmailStr, Field, field_validator, model_validator
from typing import List, Literal, Optional

'''

Útmutató a fájl használatához:

Az osztályokat a schema alapján ki kell dolgozni.

A schema.py az adatok küldésére és fogadására készített osztályokat tartalmazza.
Az osztályokban az adatok legyenek validálva.
 - az int adatok nem lehetnek negatívak.
 - az email mező csak e-mail formátumot fogadhat el.
 - a Neptun-kód pontosan 6 karakter, csak nagybetű (A-Z) és számjegy (0-9) lehet.
 - a félév (term) formátuma: ÉÉÉÉ/ÉÉ/F, pl. 2026/27/1 (F csak 1 vagy 2 lehet).
 - a tárgy kreditértéke 1 és 30 közötti egész szám.
 - az érdemjegy 1 és 5 közötti egész szám, vagy None (még nincs beírva).
 - egy félévben a felvett tárgyak összkreditje legfeljebb 30 lehet, és egy
   tárgy (course_id) csak egyszer szerepelhet benne (modell szintű validáció,
   lásd: @model_validator a feladatleírásban).
 - a teljes adatállomány (DataStore) legyen ellentmondásmentes (modell szintű validáció):
   egyedi hallgatói azonosítók és Neptun-kódok, egyedi félév-azonosítók, egy hallgatónak
   legfeljebb egy féléve van, és minden félév létező hallgatóhoz tartozik.
 - Hiba esetén ValueErrort kell dobni, lehetőség szerint ezt a
   kliens oldalon is jelezni kell.

'''

UniversityName = 'ELTE Tanulmányi Rendszer'

MAX_CREDITS_PER_SEMESTER = 30


class Course(BaseModel):
    course_id: int
    code: str
    name: str
    credit: int
    grade: Optional[int] = None


class Semester(BaseModel):
    id: int
    student_id: int
    term: str
    courses: List[Course]


class Student(BaseModel):
    id: int
    name: str
    email: str
    neptun: str


class Statistics(BaseModel):
    student_id: int
    term: str
    total_credits: int
    completed_credits: int
    weighted_average: float


class DataStore(BaseModel):
    '''A data.json teljes tartalma - a mentés és visszatöltés ellenőrzéséhez.'''
    Students: List[Student]
    Semesters: List[Semester]


class ChangeCount(BaseModel):
    '''A visszatöltés során megváltozott rekordok száma fajtánként.'''
    students: int
    semesters: int
    courses: int


class ReloadResult(BaseModel):
    '''A /reload végpont válasza.'''
    message: str
    source: str
    dest: str
    mode: str          # -> Literal["replace", "merge"]
    keep_extra: bool
    added: ChangeCount
    removed: ChangeCount
    updated: ChangeCount
