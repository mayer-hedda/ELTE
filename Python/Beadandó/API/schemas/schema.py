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

    @field_validator("course_id")
    @classmethod
    def azonosito_ellenorzes(cls, azonosito: int) -> int:
        if azonosito < 0:
            raise ValueError(f"A course_id nem lehet negatív: {azonosito}")
        return azonosito

    @field_validator("code")
    @classmethod
    def kod_ellenorzes(cls, kod: str) -> str:
        if len(kod) < 3 or len(kod) > 20:
            raise ValueError("A tárgy kódja 3-20 karakter hosszú lehet")
        return kod

    @field_validator("name")
    @classmethod
    def nev_ellenorzes(cls, nev: str) -> str:
        if nev.strip() == "":
            raise ValueError("A tárgy neve nem lehet üres")
        return nev

    @field_validator("credit")
    @classmethod
    def kredit_ellenorzes(cls, kredit: int) -> int:
        if kredit < 1 or kredit > MAX_CREDITS_PER_SEMESTER:
            raise ValueError(f"A kreditérték 1 és {MAX_CREDITS_PER_SEMESTER} közötti egész szám lehet")
        return kredit

    @field_validator("grade")
    @classmethod
    def jegy_ellenorzes(cls, jegy: Optional[int]) -> Optional[int]:
        if jegy is None:
            return jegy
        if jegy < 1 or jegy > 5:
            raise ValueError("Az érdemjegy 1 és 5 közötti egész szám lehet")
        return jegy


class Semester(BaseModel):
    id: int
    student_id: int
    term: str
    courses: List[Course]

    @field_validator("id", "student_id")
    @classmethod
    def azonosito_ellenorzes(cls, azonosito: int, info) -> int:
        if azonosito < 0:
            raise ValueError(f"A(z) {info.field_name} nem lehet negatív: {azonosito}")
        return azonosito

    @field_validator("term")
    @classmethod
    def felev_ellenorzes(cls, felev: str) -> str:
        if re.fullmatch(r"\d{4}/\d{2}/[12]", felev) is None:
            raise ValueError(f"Hibás félév formátum: {felev}, elvárt formátum: ÉÉÉÉ/ÉÉ/F, pl. 2026/27/1")
        return felev

    @model_validator(mode="after")
    def targyak_ellenorzese(self) -> "Semester":
        targy_azonositok = []
        osszkredit = 0
        for targy in self.courses:
            if targy.course_id in targy_azonositok:
                raise ValueError(f"Egy tárgy csak egyszer szerepelhet a félévben: {targy.course_id}")
            targy_azonositok.append(targy.course_id)
            osszkredit += targy.credit

        if osszkredit > MAX_CREDITS_PER_SEMESTER:
            raise ValueError(f"A félév összkreditje legfeljebb {MAX_CREDITS_PER_SEMESTER} lehet (a módosítással: {osszkredit})")
        return self


class Student(BaseModel):
    id: int
    name: str
    email: EmailStr
    neptun: str

    @field_validator("id")
    @classmethod
    def azonosito_ellenorzes(cls, azonosito: int) -> int:
        if azonosito < 0:
            raise ValueError(f"Az id nem lehet negatív: {azonosito}")
        return azonosito

    @field_validator("neptun")
    @classmethod
    def neptun_ellenorzes(cls, neptun_kod: str) -> str:
        neptun_kod = neptun_kod.upper()
        if re.fullmatch(r"[A-Z0-9]{6}", neptun_kod) is None:
            raise ValueError("A Neptun-kód pontosan 6 karakter, csak nagybetű (A-Z) és számjegy (0-9) lehet")
        return neptun_kod


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

    @model_validator(mode="after")
    def adatok_ellenorzese(self) -> "DataStore":
        hallgato_azonositok = []
        neptun_kodok = []
        for hallgato in self.Students:
            if hallgato.id in hallgato_azonositok:
                raise ValueError(f"Ismétlődő hallgatói azonosító: {hallgato.id}")
            if hallgato.neptun in neptun_kodok:
                raise ValueError(f"Ismétlődő Neptun-kód: {hallgato.neptun}")
            hallgato_azonositok.append(hallgato.id)
            neptun_kodok.append(hallgato.neptun)

        felev_azonositok = []
        felevek_hallgatoi = []
        for felev in self.Semesters:
            if felev.id in felev_azonositok:
                raise ValueError(f"Ismétlődő félév-azonosító: {felev.id}")
            if felev.student_id in felevek_hallgatoi:
                raise ValueError(f"Egy hallgatónak legfeljebb egy féléve lehet: {felev.student_id}")
            if felev.student_id not in hallgato_azonositok:
                raise ValueError(f"Nem létező hallgatóhoz tartozó félév: {felev.student_id}")
            felev_azonositok.append(felev.id)
            felevek_hallgatoi.append(felev.student_id)
        return self


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
    mode: Literal["replace", "merge"]
    keep_extra: bool
    added: ChangeCount
    removed: ChangeCount
    updated: ChangeCount
