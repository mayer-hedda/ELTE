## Követelmények:

- röpZH (20 pont)
- beadandó (legyen meg)
- zh (70 pont)

---

# StructureTest puska – mit jelentenek a kulcsszavak?

## 1. Módosítók (`.thatIs(...)`, `.that(...)`)

| Kulcsszó | Java-ban | Mezőnél | Metódusnál | Osztálynál |
|---|---|---|---|---|
| `INSTANCE_LEVEL` | **nincs** `static` | `private int x;` | `public void f()` | sima (nem `static` belső) osztály |
| `USABLE_WITHOUT_INSTANCE` | `static` | `static int x;` (osztályszintű) | `static Book decode(...)` | – |
| `MODIFIABLE` | **nincs** `final` | értéke változhat | felülírható (override) | lehet belőle leszármazni |
| `NOT_MODIFIABLE` | `final` | konstans / csak egyszer kap értéket | nem írható felül | nem lehet belőle leszármazni |
| `FULLY_IMPLEMENTED` | **nincs** `abstract` | (mezőnél nincs jelentése, csak ki van írva) | van törzse `{ ... }` | példányosítható |
| `NOT_IMPLEMENTED` | `abstract` | – | `abstract void f();` (nincs törzs) | `abstract class` |
| `VISIBLE_TO_ALL` | `public` | `public` | `public` | `public` |
| `VISIBLE_TO_SUBCLASSES` | `protected` | `protected` | `protected` | – |
| `VISIBLE_TO_PACKAGE` | *(nincs módosító)* | `int x;` | `void f()` | `class X` |
| `VISIBLE_TO_NONE` | `private` | `private` | `private` | – |

**Gyakori kombinációk:**

| Teszt | Java kód |
|---|---|
| `INSTANCE_LEVEL, FULLY_IMPLEMENTED, NOT_MODIFIABLE, VISIBLE_TO_NONE` (mező) | `private final String name;` |
| `USABLE_WITHOUT_INSTANCE, FULLY_IMPLEMENTED, NOT_MODIFIABLE, VISIBLE_TO_NONE` (mező) | `private static final int PAY = 5000;` |
| `USABLE_WITHOUT_INSTANCE, FULLY_IMPLEMENTED, NOT_MODIFIABLE, VISIBLE_TO_ALL` (mező) | `public static final String DEFAULT_TITLE = "...";` |
| `INSTANCE_LEVEL, FULLY_IMPLEMENTED, MODIFIABLE, VISIBLE_TO_SUBCLASSES` (mező) | `protected int pageCount;` |
| `INSTANCE_LEVEL, FULLY_IMPLEMENTED, MODIFIABLE, VISIBLE_TO_NONE` (metódus) | `private int getWage() { ... }` |
| `USABLE_WITHOUT_INSTANCE, FULLY_IMPLEMENTED, MODIFIABLE, VISIBLE_TO_ALL` (metódus) | `public static Book decode(String input) { ... }` |

## 2. `hasUsualModifiers()` – a "szokásos" módosítók

Attól függ, **mire** van írva:

| Mire | Mit jelent | Java példa |
|---|---|---|
| Osztály (`theClass`) | `public`, nem `static`, nem `final`, nem `abstract` | `public class Chef { ... }` |
| Enum (`theEnum`) | `public` | `public enum MealType { ... }` |
| Mező (`hasField`) | **`private`**, nem `static`, nem `final` | `private int finishedMeals;` |
| Konstruktor (`hasConstructor`) | `public` | `public Chef(...)` |
| Metódus (`hasMethod`) | **`public`**, nem `static`, nem `final`, nem `abstract` | `public void cookMeal(Meal meal)` |

> Tipp: mező → `private`, minden más → `public`.

## 3. Mit kell létrehozni (`Use.the...`, `it.has...`)

| Teszt | Java kód |
|---|---|
| `Use.theClass("kitchen.person.Chef")` | `kitchen/person/Chef.java`, benne `package kitchen.person;` és `public class Chef` |
| `Use.theEnum("kitchen.meals.MealType").ofEnumElements("MEAT", "PASTRY")` | `public enum MealType { MEAT, PASTRY }` (**ebben a sorrendben!**) |
| `Use.theInterface("x.Y")` | `public interface Y` |
| `Use.theClass("x.Y", withParent("x.Z"))` | `public class Y extends Z` |
| `Use.theClass("x.Y", withInterface("x.I"))` | `public class Y implements I` |
| `Use.theCheckedException("x.MyExc")` | `public class MyExc extends Exception` |
| `Use.theUncheckedException("x.MyExc")` | `public class MyExc extends RuntimeException` |
| `Use.withTypeArg("T").theClass("data.Organiser")` | generikus osztály: `public class Organiser<T>` |
| `it.hasField("name: String")` | `String name;` mező (név: típus formátum) |
| `it.hasField("specialty: kitchen.meals.MealType")` | `MealType specialty;` (+ `import kitchen.meals.MealType;` ha más csomag) |
| `it.hasMethod("cookMeal", withParams("meal: kitchen.meals.Meal"))` | `cookMeal(Meal meal)` |
| `it.hasConstructor(...)` | konstruktor (lásd lent a paramétereket) |
| `it.hasDefaultConstructor()` / `hasNoArgConstructor()` | paraméter nélküli konstruktor |

## 4. Paraméterlisták

| Teszt | Jelentés | Példa |
|---|---|---|
| `withParams("a: String", "b: int")` | pontosan ezek a paraméterek, ebben a sorrendben | `f(String a, int b)` |
| `withNoParams()` / `withNoArgs()` | nincs paraméter | `f()` |
| `withArgsLikeFields()` (üres) | nincs paraméter | `getPrice()` |
| `withArgsLikeFields("name", "specialty")` | a megadott **mezők típusával és nevével**, ebben a sorrendben | `Chef(String name, MealType specialty)` |
| `withArgsLikeAllFields()` | az **összes példány (nem static) mező**, deklarációs sorrendben | `Book(String author, String title, int pageCount)` |

> Figyelj: a mezők deklarálási sorrendje számít a `withArgsLikeAllFields()`-nél!

## 5. Visszatérési érték, kivételek

| Teszt | Java kód |
|---|---|
| `.thatReturnsNothing()` | `void` |
| `.thatReturns("int")` | `int` a visszatérési típus |
| `.thatReturns("boolean", "leírás...")` | `boolean`, a 2. szöveg csak magyarázat, hogy mit adjon vissza |
| `.thatThrows("IllegalArgumentException", "Ha ...")` | az adott esetben `throw new IllegalArgumentException(...)` |
| `.thatCanRaise(...)` | ezt a kivételt dobhatja |

## 6. Getter, setter, egyéb

| Teszt | Java kód |
|---|---|
| `.thatHas(GETTER)` | `public Típus getNev() { return nev; }` (boolean-nál lehet `isNev()`) |
| `.thatHas(SETTER)` | `public void setNev(Típus nev) { this.nev = nev; }` |
| `.thatHasNo(GETTER, SETTER)` | **NE** legyen getter / setter! (ha írsz, hibát dob) |
| `it.has(TEXTUAL_REPRESENTATION)` | `@Override public String toString()` – az `.info(...)` adja meg a pontos formátumot |
| `EQUALITY_CHECK` | `@Override equals(Object o)` + `hashCode()` |
| `NATURAL_ORDERING` | `implements Comparable<X>` + `compareTo(X other)` |
| `INHERITED` | ősből örökölt / felülírt metódus (`@Override`) |
| `DEFAULT_CONSTRUCTOR` | paraméter nélküli konstruktor |
| `.withInitialValue(5000)` | a mező kezdőértéke ez legyen |

## 7. Szöveges részek

| Teszt | Mit jelent |
|---|---|
| `.info("...")` | **a feladat leírása** – mit csináljon a metódus, kezdőértékek (pl. „Értéke legyen 5000.”), toString formátum. Mindig olvasd el! |
| `.testWith(testCase("cookMealTest"), "...")` | a megadott nevű **tesztmetódust neked kell megírni** a tesztosztályba (JUnit), a szöveg leírja, mit teszteljen |

## 8. Gyors ellenőrzőlista

1. Csomag (`package`) és mappa egyezik az osztály teljes nevével.
2. Mezők: alapból `private`; `NOT_MODIFIABLE` → `final`; `USABLE_WITHOUT_INSTANCE` → `static`.
3. `static final` mező kezdőértéke az `.info`-ból jön.
4. Konstruktor paraméterek sorrendje = `withArgsLikeFields(...)` sorrendje.
5. `thatHasNo(GETTER, SETTER)` → ne írj gettert/settert.
6. `thatThrows` → ellenőrizd a feltételt és dobd a kivételt.
7. `toString` formátuma pontosan egyezzen az `.info` példájával.
8. Enum elemek sorrendje egyezzen.
