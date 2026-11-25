import check.*;
import static check.Use.*;

import module org.junit.jupiter;

@BeforeAll
public static void init() {
    // usedLang = Lang.EN; // uncomment to enforce the message language
    Use.theClass("kitchen.Kitchen")
       .that(hasUsualModifiers());
}

@Test
public void fieldChefs() {
    it.hasField("chefs: array of kitchen.person.Chef")
      .that(hasUsualModifiers())
      .thatHasNo(GETTER, SETTER);
}

@Test
public void fieldFinishedMeals() {
    it.hasField("finishedMeals: ArrayList of kitchen.meals.Meal")
      .that(hasUsualModifiers())
      .thatHas(GETTER)
      .thatHasNo(SETTER);
}

@Test
public void constructor() {
    it.hasConstructor(withArgsLikeFields("chefs"))
      .thatIs(VISIBLE_TO_ALL)
      .thatThrows("IllegalArgumentException", "Ha a `chefs` darabszáma nagyobb mint 3.")
      .info("Létrehoz egy Kitchen példányt a megadott séfekkel. A `finishedMeals` kezdetben legyen üres.")
      .testWith(testCase("constructorExceptionTest"), "Teszteli, hogy 3-nál több séf megadása esetén a megfelelő kivétel dobódik-e.");
}

@Test
public void methodCookMeal() {
    it.hasMethod("cookMeal", withParams("mealsToBeCooked: array of kitchen.meals.Meal"))
      .that(hasUsualModifiers())
      .thatReturnsNothing()
      .info("""
          Megfőzzük a `mealsToBeCooked` ételeket. Ezt úgy érjük el, hogy először a `getCookableMeals` metódus alapján kiszűrjük azokat az ételeket, amik elkészíthetők.
          Aztán minden elkészíthető ételhez addig járjuk be a séfeket, amíg meg nem találjuk azt,
          aki el tudja készíteni az adott ételt.
          Ezután elkészíttetjük vele az ételt és hozzáadjuk a `finishedMeals`-hez.
      """)
      .testWith(testCase("cookMealTest"), """
          A tesztelés legyen a következő:
          1. Hozz létre egy általad tetszőlegesen felparaméterezett séf példányt,
          illetve két étel példányt, egyet, amit a séf el tud készíteni, és egyet, amit nem.
          2. Hozz létre egy konyhát a létrehozott séf példányt felhasználva.
          3. Hívd meg a megfelelő metódust az egyik általad választott étel példányoddal.
          4. Vizsgáld meg, hogy megváltozott-e a `finishedMeals` mérete.
          5. Hívd meg a megfelelő metódust a másik általad választott étel példányoddal.
          6. Vizsgáld meg újra, hogy megváltozott-e a `finishedMeals` mérete.
      """);
}

@Test
public void methodGetCookableMeals() {
    it.hasMethod("getCookableMeals", withParams("mealsToBeCooked: array of kitchen.meals.Meal"))
      .thatIs(INSTANCE_LEVEL, FULLY_IMPLEMENTED, MODIFIABLE, VISIBLE_TO_NONE)
      .thatReturns("ArrayList of kitchen.meals.Meal", "Az elkészíthető ételeket egy ArrayList-ben tárolva.")
      .info("""
          Kiszűri azokat az ételeket a `mealsToBeCooked`-ból, amik elkészíthetőek.
          Egy étel elkészíthető, ha van olyan séf a konyhában, aki el tudja készíteni.
      """);
}

void main() {}


