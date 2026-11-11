from fastapi import FastAPI
from schemas.schema import UniversityName
from routers.routes import routers as routes_router

'''
Útmutató a fájl használatához:

Ez a fájl a REST API main modulja. A futtatásához telepíteni kell a pip
csomagkezelővel a uvicorn, a fastapi és az e-mail validáláshoz szükséges
pydantic[email] csomagokat:

   pip install uvicorn fastapi "pydantic[email]"

vagy

   pip3 install uvicorn fastapi "pydantic[email]"

Ezután az alkalmazás a következő paranccsal futtatható a terminálban
(az API könyvtárában állva):

   uvicorn main:app --reload --port 9000

A port nem kötelező opció.

A futó alkalmazás a következő URL-en érhető el:

   127.0.0.1:9000

A webes UI pedig az alábbi URL használatával:

   127.0.0.1:9000/docs

A dokumentáció pedig itt:

   127.0.0.1:9000/redoc

'''

app = FastAPI(title=UniversityName)
app.include_router(routes_router)

@app.get('/')
def route():
    return {'Üdvözöl a': UniversityName}
