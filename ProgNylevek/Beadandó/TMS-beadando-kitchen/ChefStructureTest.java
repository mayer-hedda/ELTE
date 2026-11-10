import check.*;
import static check.Use.*;

import module org.junit.jupiter;

@BeforeAll
public static void init() {
    // usedLang = Lang.EN; // uncomment to enforce the message language
    Use.theClass("kitchen.person.Chef")
       .that(hasUsualModifiers());
}

@Test
public void fieldName() {
    it.hasField("name: String")
      .thatIs(INSTANCE_LEVEL, FULLY_IMPLEMENTED, NOT_MODIFIABLE, VISIBLE_TO_NONE)
      .thatHasNo(GETTER, SETTER);
}

@Test
public void fieldSpecialty() {
    it.hasField("specialty: kitchen.meals.MealType")
      .thatIs(INSTANCE_LEVEL, FULLY_IMPLEMENTED, NOT_MODIFIABLE, VISIBLE_TO_NONE)
      .thatHasNo(GETTER, SETTER);
}

@Test
public void fieldFinishedMeals() {
    it.hasField("finishedMeals: int")
      .that(hasUsualModifiers())
      .thatHasNo(GETTER, SETTER);
}

@Test
public void fieldPayPerFinishedMeals() {
    it.hasField("payPerFinishedMeals: int")
      .thatIs(USABLE_WITHOUT_INSTANCE, FULLY_IMPLEMENTED, NOT_MODIFIABLE, VISIBLE_TO_NONE)
      .thatHasNo(GETTER, SETTER)
      .info("Értéke legyen 5000.");
}

@Test
public void constructor() {
    it.hasConstructor(withArgsLikeFields("name", "specialty"))
      .thatIs(VISIBLE_TO_ALL)
      .thatThrows("IllegalArgumentException", "Ha a `specialty` `null`, vagy ha a `name` üres vagy `null`.")
      .info("""
          Létrehoz egy Chef példányt a megadott specialitással és névvel.
          A `finishedMeals` kezdetben legyen 0.
      """);
}

@Test
public void methodCookMeal() {
    it.hasMethod("cookMeal", withParams("meal: kitchen.meals.Meal"))
      .that(hasUsualModifiers())
      .thatReturnsNothing()
      .info("Ha a `meal` típusa megegyezik a séf specialitásával, akkor a `meal`-t készre állítjuk, és hozzáadunk egyet a `finishedMeals`-hez.")
      .testWith(testCase("cookMealTest"), """
          paraméteres teszteset, amely vizsgálja, hogy a megfelelő specialitás esetén a `meal` készre vált-e.
          Példák:
          - PASTRY specialitású séf PASTRY ételt próbál főzni -> a meal készre vált.
          - PASTRY specialitású séf MEAT ételt próbál főzni -> a meal nem vált készre.
          - MEAT specialitású séf PASTRY ételt próbál főzni -> a meal nem vált készre.
      """);
}

@Test
public void methodCanCookMeal() {
    it.hasMethod("canCookMeal", withParams("meal: kitchen.meals.Meal"))
      .that(hasUsualModifiers())
      .thatReturns("boolean", "A `meal` típusa megegyezik-e a séf specialitásával.");
}

@Test
public void methodGetWage() {
    it.hasMethod("getWage", withNoParams())
      .thatIs(INSTANCE_LEVEL, FULLY_IMPLEMENTED, MODIFIABLE, VISIBLE_TO_NONE)
      .thatReturns("int", "A séf bére, ami a `payPerFinishedMeals` és `finishedMeals` szorzata.");
}

@Test
public void text() {
    it.has(TEXTUAL_REPRESENTATION)
      .info("A séf neve, specialitása és aktuális bére.")
      .info("""
          Példa szöveg, ahol a séf neve Example, a specialitása PASTRY és a bére 5000:
          Chef Example specializes in PASTRY with current wage: 5000
      """)
      .testWith(testCase("textualRepresentationTest"), "Ellenőrzi, hogy a szöveges reprezentáció a megadott formátumnak megfelelően működik.");
}

void main() {}


