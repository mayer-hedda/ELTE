from typing import Literal
from schemas.schema import Student, Semester, Course, Statistics, DataStore, ReloadResult
from fastapi.responses import JSONResponse
from fastapi import HTTPException, APIRouter
from pydantic import ValidationError
from data.filehandler import add_student, add_semester, add_course_to_semester, update_course_in_semester, remove_course_from_semester, load_json_file, load_json_file_or_empty, save_json_file, merge_data, diff_counts
from data.filereader import get_student_by_id, get_semester_by_student_id, get_courses_by_student_id, get_all_students, get_statistics, load_json

from data.filehandler import get_file_path

'''

Útmutató a fájl használatához:

- Minden route esetén adjuk meg a response_modell értékét (típus)
- Ügyeljünk a típusok megadására
- A függvények visszatérési értéke JSONResponse() legyen
- Minden függvény tartalmazzon hibakezelést, hiba esetén dobjon egy HTTPException-t
- Az adatokat a data.json fájlba kell menteni.
- A HTTP válaszok minden esetben tartalmazzák a
  megfelelő Státus Code-ot, pl. 201 - Created, 200 - OK, 400 - Bad Request,
  404 - Not Found, 409 - Conflict, 422 - Unprocessable Entity

'''

routers = APIRouter()

@routers.post('/addstudent', response_model=Student, status_code=201)
def addstudent(student: Student) -> Student:
    for letezo_hallgato in get_all_students():
        if letezo_hallgato["id"] == student.id:
            raise HTTPException(status_code=409, detail=f"Már létezik hallgató ezzel az ID-val: {student.id}")
        if letezo_hallgato["neptun"] == student.neptun:
            raise HTTPException(status_code=409, detail=f"Már létezik hallgató ezzel a Neptun-kóddal: {student.neptun}")

    uj_hallgato = student.model_dump(mode="json")
    add_student(uj_hallgato)
    return JSONResponse(content=uj_hallgato, status_code=201)

@routers.post('/addsemester', response_model=str, status_code=201)
def addsemester(studentid: int, term: str) -> str:
    felevek = load_json()["Semesters"]
    legnagyobb_azonosito = 0
    for felev in felevek:
        if felev["id"] > legnagyobb_azonosito:
            legnagyobb_azonosito = felev["id"]

    try:
        uj_felev = Semester(id=legnagyobb_azonosito + 1, student_id=studentid, term=term, courses=[])
    except ValidationError as hiba:
        raise HTTPException(status_code=422, detail=hiba.errors()[0]["msg"])

    try:
        get_student_by_id(studentid)
    except ValueError as hiba:
        raise HTTPException(status_code=404, detail=str(hiba))

    for felev in felevek:
        if felev["student_id"] == studentid:
            raise HTTPException(status_code=409, detail=f"A hallgatónak már van féléve: {studentid}")

    add_semester(uj_felev.model_dump(mode="json"))
    return JSONResponse(content="Sikeres félév létrehozás.", status_code=201)

@routers.post('/enrollcourse', response_model=Semester, status_code=201)
def enrollcourse(studentid: int, course: Course) -> Semester:
    try:
        felev = get_semester_by_student_id(studentid)
    except ValueError as hiba:
        raise HTTPException(status_code=404, detail=str(hiba))

    for targy in felev["courses"]:
        if targy["course_id"] == course.course_id:
            raise HTTPException(status_code=409, detail=f"A tárgy már fel van véve a félévben: {course.course_id}")

    uj_targy = course.model_dump(mode="json")
    try:
        Semester.model_validate({**felev, "courses": felev["courses"] + [uj_targy]})
    except ValidationError as hiba:
        raise HTTPException(status_code=400, detail=hiba.errors()[0]["msg"])

    frissitett_felev = add_course_to_semester(studentid, uj_targy)
    return JSONResponse(content=frissitett_felev, status_code=201)

@routers.put('/updatecourse', response_model=Semester)
def updatecourse(studentid: int, courseid: int, course: Course) -> Semester:
    if course.course_id != courseid:
        raise HTTPException(status_code=400, detail=f"A tárgy azonosítója nem változhat: {courseid} helyett {course.course_id} érkezett")

    try:
        felev = get_semester_by_student_id(studentid)
    except ValueError as hiba:
        raise HTTPException(status_code=404, detail=str(hiba))

    uj_targy = course.model_dump(mode="json")
    uj_targylista = []
    fel_van_veve = False
    for targy in felev["courses"]:
        if targy["course_id"] == courseid:
            uj_targylista.append(uj_targy)
            fel_van_veve = True
        else:
            uj_targylista.append(targy)
    if not fel_van_veve:
        raise HTTPException(status_code=404, detail=f"A tárgy nincs felvéve a félévben: {courseid}")

    try:
        Semester.model_validate({**felev, "courses": uj_targylista})
    except ValidationError as hiba:
        raise HTTPException(status_code=400, detail=hiba.errors()[0]["msg"])

    frissitett_felev = update_course_in_semester(studentid, courseid, uj_targy)
    return JSONResponse(content=frissitett_felev, status_code=200)

@routers.delete('/dropcourse', response_model=Semester)
def dropcourse(studentid: int, courseid: int) -> Semester:
    try:
        frissitett_felev = remove_course_from_semester(studentid, courseid)
    except ValueError as hiba:
        raise HTTPException(status_code=404, detail=str(hiba))
    return JSONResponse(content=frissitett_felev, status_code=200)

@routers.get('/student', response_model=Student)
def student(studentid: int) -> Student:
    try:
        hallgato = get_student_by_id(studentid)
    except ValueError as hiba:
        raise HTTPException(status_code=404, detail=str(hiba))
    return JSONResponse(content=hallgato, status_code=200)

@routers.get('/students', response_model=list[Student])
def students() -> list[Student]:
    try:
        hallgatok = get_all_students()
    except (OSError, ValueError) as hiba:
        raise HTTPException(status_code=500, detail=f"Az adatok nem olvashatók: {hiba}")
    return JSONResponse(content=hallgatok, status_code=200)

@routers.get('/semester', response_model=list[Course])
def semester(studentid: int) -> list[Course]:
    try:
        targyak = get_courses_by_student_id(studentid)
    except ValueError as hiba:
        raise HTTPException(status_code=404, detail=str(hiba))
    return JSONResponse(content=targyak, status_code=200)

@routers.get('/getaverage', response_model=Statistics)
def getaverage(studentid: int) -> Statistics:
    try:
        statisztika = get_statistics(studentid)
    except ValueError as hiba:
        raise HTTPException(status_code=404, detail=str(hiba))
    return JSONResponse(content=statisztika, status_code=200)

@routers.post('/save', response_model=dict[str, str], status_code=201)
def save(source: str = "data.json", dest: str = "backup.json") -> dict:
    try:
        forras_eleresi_ut = get_file_path(source)
        cel_eleresi_ut = get_file_path(dest)
    except ValueError as hiba:
        raise HTTPException(status_code=400, detail=str(hiba))
    if forras_eleresi_ut == cel_eleresi_ut:
        raise HTTPException(status_code=400, detail="A forrás és a cél fájl nem lehet azonos")

    try:
        adatok = DataStore.model_validate(load_json_file(source))
    except FileNotFoundError:
        raise HTTPException(status_code=404, detail=f"A fájl nem található: {source}")
    except ValidationError as hiba:
        raise HTTPException(status_code=422, detail=hiba.errors()[0]["msg"])
    except ValueError as hiba:
        raise HTTPException(status_code=422, detail=str(hiba))

    save_json_file(adatok.model_dump(mode="json"), dest)
    valasz = {"message": "Sikeres mentés.", "source": source, "dest": dest}
    return JSONResponse(content=valasz, status_code=201)

@routers.post('/reload', response_model=ReloadResult)
def reload(source: str = "backup.json", dest: str = "data.json",
           mode: Literal["replace", "merge"] = "replace", keep_extra: bool = True) -> ReloadResult:
    try:
        forras_eleresi_ut = get_file_path(source)
        cel_eleresi_ut = get_file_path(dest)
    except ValueError as hiba:
        raise HTTPException(status_code=400, detail=str(hiba))
    if forras_eleresi_ut == cel_eleresi_ut:
        raise HTTPException(status_code=400, detail="A forrás és a cél fájl nem lehet azonos")

    try:
        mentett_adatok = DataStore.model_validate(load_json_file(source)).model_dump(mode="json")
    except FileNotFoundError:
        raise HTTPException(status_code=404, detail=f"A fájl nem található: {source}")
    except ValidationError as hiba:
        raise HTTPException(status_code=422, detail=hiba.errors()[0]["msg"])
    except ValueError as hiba:
        raise HTTPException(status_code=422, detail=str(hiba))

    try:
        jelenlegi_adatok = load_json_file_or_empty(dest)
    except ValueError as hiba:
        raise HTTPException(status_code=422, detail=str(hiba))

    if mode == "replace":
        uj_adatok = mentett_adatok
    else:
        osszefesult_adatok = merge_data(jelenlegi_adatok, mentett_adatok, keep_extra)
        try:
            uj_adatok = DataStore.model_validate(osszefesult_adatok).model_dump(mode="json")
        except ValidationError as hiba:
            raise HTTPException(status_code=409, detail=hiba.errors()[0]["msg"])

    valtozasok = diff_counts(jelenlegi_adatok, uj_adatok)
    save_json_file(uj_adatok, dest)

    eredmeny = ReloadResult(
        message="Sikeres visszatöltés.",
        source=source,
        dest=dest,
        mode=mode,
        keep_extra=keep_extra,
        added=valtozasok["added"],
        removed=valtozasok["removed"],
        updated=valtozasok["updated"],
    )
    return JSONResponse(content=eredmeny.model_dump(mode="json"), status_code=200)
