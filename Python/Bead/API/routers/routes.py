#from typing import Literal
#from schemas.schema import Student, Semester, Course, Statistics, DataStore, ReloadResult
from fastapi.responses import JSONResponse
from fastapi import HTTPException, APIRouter
#from pydantic import ValidationError
#from data.filehandler import add_student, add_semester, add_course_to_semester, update_course_in_semester, remove_course_from_semester, load_json_file, load_json_file_or_empty, save_json_file, merge_data, diff_counts
#from data.filereader import get_student_by_id, get_semester_by_student_id, get_courses_by_student_id, get_all_students, get_statistics, load_json

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

@routers.post('/addstudent')
def addstudent(student):
    pass

@routers.post('/addsemester')
def addsemester(studentid: int, term: str) -> str:
    pass

@routers.post('/enrollcourse')
def enrollcourse(studentid: int, course):
    pass

@routers.put('/updatecourse')
def updatecourse(studentid: int, courseid: int, course):
    pass

@routers.delete('/dropcourse')
def dropcourse(studentid: int, courseid: int):
    pass

@routers.get('/student')
def student(studentid: int):
    pass

@routers.get('/students')
def students():
    pass

@routers.get('/semester')
def semester(studentid: int):
    pass

@routers.get('/getaverage')
def getaverage(studentid: int):
    pass

@routers.post('/save')
def save(source: str = "data.json", dest: str = "backup.json"):
    pass

@routers.post('/reload')
def reload(source: str = "backup.json", dest: str = "data.json", mode: str = "replace", keep_extra: bool = True):
    pass
