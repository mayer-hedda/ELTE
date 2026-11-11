from typing import Literal
from schemas.schema import Student, Semester, Course, Statistics, DataStore, ReloadResult, validate_term
from fastapi.responses import JSONResponse
from fastapi import HTTPException, APIRouter
from pydantic import ValidationError
from data.filehandler import add_student, add_semester, add_course_to_semester, update_course_in_semester, remove_course_from_semester, load_json_file, load_json_file_or_empty, save_json_file, merge_data, diff_counts, get_file_path, NotFoundError, ConflictError
from data.filereader import get_student_by_id, get_semester_by_student_id, get_courses_by_student_id, get_all_students, get_statistics, load_json

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


def _validation_message(e: ValidationError) -> str:
    '''A pydantic hibaüzenet első eleme, a "Value error, " előtag nélkül.'''
    msg = e.errors()[0]["msg"]
    return msg.removeprefix("Value error, ")


def _handle_error(e: Exception) -> HTTPException:
    '''A modulok által dobott kivételek átalakítása a megfelelő HTTP státuszkódra.'''
    if isinstance(e, HTTPException):
        return e
    if isinstance(e, NotFoundError):
        return HTTPException(status_code=404, detail=str(e))
    if isinstance(e, ConflictError):
        return HTTPException(status_code=409, detail=str(e))
    if isinstance(e, ValidationError):
        return HTTPException(status_code=400, detail=_validation_message(e))
    if isinstance(e, ValueError):
        return HTTPException(status_code=400, detail=str(e))
    return HTTPException(status_code=500, detail=f"Váratlan szerverhiba: {e}")


def _get_semester_or_404(studentid: int) -> dict:
    try:
        return get_semester_by_student_id(studentid)
    except ValueError:
        raise HTTPException(status_code=404, detail=f"Nem található félév a megadott hallgatói ID-hoz: {studentid}")


def _check_semester(semester: dict, courses: list[dict]) -> None:
    '''A módosított félév ellenőrzése (30 kredites korlát, egyedi course_id) mentés előtt.'''
    try:
        Semester.model_validate({**semester, "courses": courses})
    except ValidationError as e:
        raise HTTPException(status_code=400, detail=_validation_message(e))


@routers.post('/addstudent', response_model=Student, status_code=201)
def addstudent(student: Student) -> Student:
    try:
        new_student = student.model_dump(mode="json")
        add_student(new_student)
        return JSONResponse(content=new_student, status_code=201)
    except Exception as e:
        raise _handle_error(e)


@routers.post('/addsemester', response_model=str, status_code=201)
def addsemester(studentid: int, term: str) -> str:
    try:
        try:
            term = validate_term(term)
        except ValueError as e:
            raise HTTPException(status_code=422, detail=str(e))
        try:
            get_student_by_id(studentid)
        except ValueError:
            raise HTTPException(status_code=404, detail=f"Nem található hallgató a megadott ID-val: {studentid}")

        semesters = load_json()["Semesters"]
        if any(s["student_id"] == studentid for s in semesters):
            raise HTTPException(status_code=409, detail=f"A hallgatónak már van féléve: {studentid}")

        new_id = max((s["id"] for s in semesters), default=0) + 1
        new_semester = Semester(id=new_id, student_id=studentid, term=term, courses=[])
        add_semester(new_semester.model_dump(mode="json"))
        return JSONResponse(content="Sikeres félév létrehozás.", status_code=201)
    except Exception as e:
        raise _handle_error(e)


@routers.post('/enrollcourse', response_model=Semester, status_code=201)
def enrollcourse(studentid: int, course: Course) -> Semester:
    try:
        semester = _get_semester_or_404(studentid)
        if any(c["course_id"] == course.course_id for c in semester["courses"]):
            raise HTTPException(status_code=409, detail=f"A tárgy már fel van véve a félévben: {course.course_id}")
        new_course = course.model_dump(mode="json")
        _check_semester(semester, semester["courses"] + [new_course])

        updated = add_course_to_semester(studentid, new_course)
        return JSONResponse(content=Semester.model_validate(updated).model_dump(mode="json"), status_code=201)
    except Exception as e:
        raise _handle_error(e)


@routers.put('/updatecourse', response_model=Semester)
def updatecourse(studentid: int, courseid: int, course: Course) -> Semester:
    try:
        if course.course_id != courseid:
            raise HTTPException(
                status_code=400,
                detail=f"A tárgy azonosítója nem változhat: a paraméter {courseid}, a törzsben {course.course_id}",
            )
        semester = _get_semester_or_404(studentid)
        if not any(c["course_id"] == courseid for c in semester["courses"]):
            raise HTTPException(status_code=404, detail=f"A tárgy nincs felvéve a félévben: {courseid}")

        new_course = course.model_dump(mode="json")
        courses = [new_course if c["course_id"] == courseid else c for c in semester["courses"]]
        _check_semester(semester, courses)

        updated = update_course_in_semester(studentid, courseid, new_course)
        return JSONResponse(content=Semester.model_validate(updated).model_dump(mode="json"), status_code=200)
    except Exception as e:
        raise _handle_error(e)


@routers.delete('/dropcourse', response_model=Semester)
def dropcourse(studentid: int, courseid: int) -> Semester:
    try:
        semester = _get_semester_or_404(studentid)
        if not any(c["course_id"] == courseid for c in semester["courses"]):
            raise HTTPException(status_code=404, detail=f"A tárgy nincs felvéve a félévben: {courseid}")

        updated = remove_course_from_semester(studentid, courseid)
        return JSONResponse(content=Semester.model_validate(updated).model_dump(mode="json"), status_code=200)
    except Exception as e:
        raise _handle_error(e)


@routers.get('/student', response_model=Student)
def student(studentid: int) -> Student:
    try:
        try:
            found = get_student_by_id(studentid)
        except ValueError:
            raise HTTPException(status_code=404, detail=f"Nem található hallgató a megadott ID-val: {studentid}")
        return JSONResponse(content=Student.model_validate(found).model_dump(mode="json"), status_code=200)
    except Exception as e:
        raise _handle_error(e)


@routers.get('/students', response_model=list[Student])
def students() -> list[Student]:
    try:
        all_students = [Student.model_validate(s).model_dump(mode="json") for s in get_all_students()]
        return JSONResponse(content=all_students, status_code=200)
    except Exception as e:
        raise _handle_error(e)


@routers.get('/semester', response_model=list[Course])
def semester(studentid: int) -> list[Course]:
    try:
        try:
            courses = get_courses_by_student_id(studentid)
        except ValueError:
            raise HTTPException(status_code=404, detail=f"Nem található félév a megadott hallgatói ID-hoz: {studentid}")
        content = [Course.model_validate(c).model_dump(mode="json") for c in courses]
        return JSONResponse(content=content, status_code=200)
    except Exception as e:
        raise _handle_error(e)


@routers.get('/getaverage', response_model=Statistics)
def getaverage(studentid: int) -> Statistics:
    try:
        try:
            stats = get_statistics(studentid)
        except ValueError:
            raise HTTPException(status_code=404, detail=f"Nem található félév a megadott hallgatói ID-hoz: {studentid}")
        return JSONResponse(content=Statistics.model_validate(stats).model_dump(mode="json"), status_code=200)
    except Exception as e:
        raise _handle_error(e)


def _check_file_names(source: str, dest: str) -> None:
    '''Közös ellenőrzés a mentéshez és a visszatöltéshez: érvényes, eltérő fájlnevek (400).'''
    try:
        source_path = get_file_path(source)
        dest_path = get_file_path(dest)
    except ValueError as e:
        raise HTTPException(status_code=400, detail=str(e))
    if source_path == dest_path:
        raise HTTPException(status_code=400, detail="A forrás és a cél fájl nem lehet azonos")


def _load_valid_source(source: str) -> DataStore:
    '''A forrásfájl beolvasása és ellenőrzése a DataStore modellel (404 / 422).'''
    try:
        data = load_json_file(source)
    except NotFoundError as e:
        raise HTTPException(status_code=404, detail=str(e))
    except ValueError as e:
        raise HTTPException(status_code=422, detail=str(e))
    try:
        return DataStore.model_validate(data)
    except ValidationError as e:
        raise HTTPException(status_code=422, detail=f"A(z) {source} tartalma hibás: {_validation_message(e)}")


@routers.post('/save', response_model=dict[str, str], status_code=201)
def save(source: str = "data.json", dest: str = "backup.json") -> dict:
    try:
        _check_file_names(source, dest)
        validated = _load_valid_source(source)
        save_json_file(validated.model_dump(mode="json"), dest)
        return JSONResponse(
            content={"message": "Sikeres mentés.", "source": source, "dest": dest},
            status_code=201,
        )
    except Exception as e:
        raise _handle_error(e)


@routers.post('/reload', response_model=ReloadResult)
def reload(source: str = "backup.json", dest: str = "data.json",
           mode: Literal["replace", "merge"] = "replace", keep_extra: bool = True) -> ReloadResult:
    try:
        _check_file_names(source, dest)
        backup = _load_valid_source(source).model_dump(mode="json")

        # A nem létező célfájl üres adatállománynak számít. Hibás célfájl
        # replace módban felülírható (üresnek tekintjük), merge módban viszont
        # nem fésülhető össze (422).
        try:
            current = load_json_file_or_empty(dest)
            current = DataStore.model_validate(current).model_dump(mode="json")
        except (ValidationError, ValueError) as e:
            if mode == "merge":
                detail = _validation_message(e) if isinstance(e, ValidationError) else str(e)
                raise HTTPException(
                    status_code=422,
                    detail=f"A(z) {dest} tartalma hibás, nem fésülhető össze: {detail}",
                )
            current = {"Students": [], "Semesters": []}

        if mode == "replace":
            new_data = backup
        else:
            merged = merge_data(current, backup, keep_extra)
            try:
                new_data = DataStore.model_validate(merged).model_dump(mode="json")
            except ValidationError as e:
                raise HTTPException(
                    status_code=409,
                    detail=f"Az összefésült adatok ellentmondásosak: {_validation_message(e)}",
                )

        changes = diff_counts(current, new_data)
        save_json_file(new_data, dest)

        result = ReloadResult(
            message="Sikeres visszatöltés.",
            source=source,
            dest=dest,
            mode=mode,
            keep_extra=keep_extra,
            **changes,
        )
        return JSONResponse(content=result.model_dump(mode="json"), status_code=200)
    except Exception as e:
        raise _handle_error(e)
