print("Hello world!")

# nev = input("Mi a neved? ")
# print(f"Hello {nev}!")

# kedvencszam = int(input("Mi a kedvenc számod? "))
# print(f"A kedvenc számod duplája: {kedvencszam * 2}")

print("hello", "word", sep=";")
print("hello", "word", end="!")

rang = range(1, 5, 1)
print(list(rang))

# DRY - Don't Repeat Yourself :)


def hello():
    print("Hello world!")

hello()

nev = input("Mi a neved? ")
def hello_nev(nev):
    print(f"Hello {nev}!")

hello_nev(nev)


def multiplyWithType(szam : int) -> int:
    return szam * 2

print(hello_nev("Hedda"))
print(multiplyWithType(5))


def greetings(name, hello = "Hello"):
    print(f"{hello} {name}!")

greetings("Hedda")
greetings("Hedda", "Szia")


szamok = [1, 2, 3, 4, 5]
for szam in szamok:
    print(szam * 2)

print(szamok[1:4])
print(szamok[1:4:2])
print(szamok[1:4:-1])
print(szamok[::4])

tizedes = 14.324323
print(f"{tizedes:.2f}")


szamok.append(6)
print(szamok)
szamok.insert(0, 0)
print(szamok)
szamok.remove(3)
print(szamok)


szamok2 = [80, 90]
szamok.extend(szamok2)
print(szamok)
ertek = szamok.pop()
print(ertek)

# lifo - last in first out
# fifo - first in first out


point = (10, 20)
x, y = point
print(x, y)


halmaz = [10, 20, 30, 10, 20]
print(set(halmaz))

a = (10)
b = (10,)

print(type(a))
print(type(b))


halmaz1 = {10, 20, 30}
halmaz2 = {20, 30, 40}
print(halmaz1 | halmaz2)
print(halmaz1 & halmaz2)


student = {
    "name": "Hedda",
    "age": 20,
    "grades": [5, 4, 5, 3]
}

print(student["name"])
print(student["age"])
print(student["grades"])
print(student["grades"][0])
print(student.get("name"))      # kezeli, ha nincs ilyen kulcs
print(student.get("address", "Nincs ilyen kulcs"))  # kezeli, ha nincs ilyen kulcs
print(student.keys())
print(student.values())
print(student.items())



students = [
    {
        "name": "Hedda",
        "age": 20,
        "grades": [5, 4, 5, 3]
    },
    {
        "name": "John",
        "age": 22,
        "grades": [4, 4, 5, 5]
    }
]



print('1' in szamok)