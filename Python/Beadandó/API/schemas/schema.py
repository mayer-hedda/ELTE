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

NEPTUN_PATTERN = r"[A-Z0-9]{6}"
TERM_PATTERN = r"\d{4}/\d{2}/[12]"


def validate_non_negative(value: int, field_name: str) -> int:
    '''Közös ellenőrzés az int típusú azonosítókhoz.'''
    if value < 0:
        raise ValueError(f"A(z) {field_name} mező nem lehet negatív: {value}")
    return value


def validate_term(value: str) -> str:
    '''A félév formátuma: ÉÉÉÉ/ÉÉ/F, ahol F csak 1 vagy 2 lehet (pl. 2026/27/1).'''
    value = value.strip()
    if not re.fullmatch(TERM_PATTERN, value):
        raise ValueError(
            f"Hibás félév formátum: '{value}'. Elvárt formátum: ÉÉÉÉ/ÉÉ/F, pl. 2026/27/1 (F csak 1 vagy 2 lehet)"
        )
    return value


class Course(BaseModel):
    course_id: int
    code: str
    name: str
    credit: int
    grade: Optional[int] = None

    @field_validator("course_id")
    @classmethod
    def validate_course_id(cls, value: int) -> int:
        return validate_non_negative(value, "course_id")

    @field_validator("code")
    @classmethod
    def validate_code(cls, value: str) -> str:
        value = value.strip()
        if not 3 <= len(value) <= 20:
            raise ValueError("A tárgy kódja 3-20 karakter hosszú lehet")
        return value

    @field_validator("name")
    @classmethod
    def validate_name(cls, value: str) -> str:
        value = value.strip()
        if not value:
            raise ValueError("A tárgy neve nem lehet üres")
        return value

    @field_validator("credit")
    @classmethod
    def validate_credit(cls, value: int) -> int:
        if not 1 <= value <= MAX_CREDITS_PER_SEMESTER:
            raise ValueError(f"A kreditérték 1 és {MAX_CREDITS_PER_SEMESTER} közötti egész szám lehet")
        return value

    @field_validator("grade")
    @classmethod
    def validate_grade(cls, value: Optional[int]) -> Optional[int]:
        if value is None:
            return value
        if not 1 <= value <= 5:
            raise ValueError("Az érdemjegy 1 és 5 közötti egész szám lehet (vagy null)")
        return value


class Semester(BaseModel):
    id: int
    student_id: int
    term: str
    courses: List[Course] = Field(default_factory=list)

    @field_validator("id", "student_id")
    @classmethod
    def validate_ids(cls, value: int, info) -> int:
        return validate_non_negative(value, info.field_name)

    @field_validator("term")
    @classmethod
    def validate_term_field(cls, value: str) -> str:
        return validate_term(value)

    @model_validator(mode="after")
    def validate_courses(self) -> "Semester":
        course_ids = [course.course_id for course in self.courses]
        duplicates = sorted({cid for cid in course_ids if course_ids.count(cid) > 1})
        if duplicates:
            raise ValueError(f"Egy tárgy csak egyszer szerepelhet a félévben, ismétlődő course_id: {duplicates}")
        total = sum(course.credit for course in self.courses)
        if total > MAX_CREDITS_PER_SEMESTER:
            raise ValueError(
                f"A félév összkreditje legfeljebb {MAX_CREDITS_PER_SEMESTER} lehet (jelenleg: {total})"
            )
        return self


class Student(BaseModel):
    id: int
    name: str
    email: EmailStr
    neptun: str

    @field_validator("id")
    @classmethod
    def validate_id(cls, value: int) -> int:
        return validate_non_negative(value, "id")

    @field_validator("name")
    @classmethod
    def validate_name(cls, value: str) -> str:
        value = value.strip()
        if not value:
            raise ValueError("A hallgató neve nem lehet üres")
        return value

    @field_validator("neptun")
    @classmethod
    def validate_neptun(cls, value: str) -> str:
        value = value.strip().upper()
        if not re.fullmatch(NEPTUN_PATTERN, value):
            raise ValueError("A Neptun-kód pontosan 6 karakter, csak nagybetű (A-Z) és számjegy (0-9) lehet")
        return value


class Statistics(BaseModel):
    student_id: int
    term: str
    total_credits: int
    completed_credits: int
    weighted_average: float

    @field_validator("student_id", "total_credits", "completed_credits")
    @classmethod
    def validate_non_negative_ints(cls, value: int, info) -> int:
        return validate_non_negative(value, info.field_name)

    @field_validator("term")
    @classmethod
    def validate_term_field(cls, value: str) -> str:
        return validate_term(value)

    @field_validator("weighted_average")
    @classmethod
    def validate_average(cls, value: float) -> float:
        if value != 0.0 and not 1.0 <= value <= 5.0:
            raise ValueError("A kreditsúlyozott átlag 0.0, vagy 1 és 5 közötti érték lehet")
        return round(value, 2)


class DataStore(BaseModel):
    '''A data.json teljes tartalma - a mentés és visszatöltés ellenőrzéséhez.'''
    Students: List[Student]
    Semesters: List[Semester]

    @model_validator(mode="after")
    def validate_consistency(self) -> "DataStore":
        student_ids = [s.id for s in self.Students]
        duplicate_ids = sorted({i for i in student_ids if student_ids.count(i) > 1})
        if duplicate_ids:
            raise ValueError(f"Ismétlődő hallgatói azonosító(k): {duplicate_ids}")

        neptuns = [s.neptun for s in self.Students]
        duplicate_neptuns = sorted({n for n in neptuns if neptuns.count(n) > 1})
        if duplicate_neptuns:
            raise ValueError(f"Ismétlődő Neptun-kód(ok): {duplicate_neptuns}")

        semester_ids = [s.id for s in self.Semesters]
        duplicate_semesters = sorted({i for i in semester_ids if semester_ids.count(i) > 1})
        if duplicate_semesters:
            raise ValueError(f"Ismétlődő félév-azonosító(k): {duplicate_semesters}")

        owners = [s.student_id for s in self.Semesters]
        multiple = sorted({i for i in owners if owners.count(i) > 1})
        if multiple:
            raise ValueError(f"Egy hallgatónak legfeljebb egy féléve lehet, több félév tartozik ehhez: {multiple}")

        missing = sorted(set(owners) - set(student_ids))
        if missing:
            raise ValueError(f"Nem létező hallgatóhoz tartozó félév(ek), student_id: {missing}")
        return self


class ChangeCount(BaseModel):
    '''A visszatöltés során megváltozott rekordok száma fajtánként.'''
    students: int = Field(ge=0)
    semesters: int = Field(ge=0)
    courses: int = Field(ge=0)


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
