import check.*;
import static check.Use.*;

import module org.junit.jupiter;

@BeforeAll
public static void init() {
    // usedLang = Lang.EN; // uncomment to enforce the message language
    Use.theClass("kitchen.meals.Meal")
       .that(hasUsualModifiers());
}

@Test
public void fieldName() {
    it.hasField("name: String")
      .thatIs(INSTANCE_LEVEL, FULLY_IMPLEMENTED, NOT_MODIFIABLE, VISIBLE_TO_NONE)
      .thatHas(GETTER)
      .thatHasNo(SETTER);
}

@Test
public void fieldType() {
    it.hasField("type: MealType")
      .thatIs(INSTANCE_LEVEL, FULLY_IMPLEMENTED, NOT_MODIFIABLE, VISIBLE_TO_NONE)
      .thatHas(GETTER)
      .thatHasNo(SETTER);
}

@Test
public void fieldIsFinished() {
    it.hasField("isFinished: boolean")
      .that(hasUsualModifiers())
      .thatHasNo(GETTER, SETTER);
}

@Test
public void constructor() {
    it.hasConstructor(withArgsLikeFields("name", "type"))
      .thatIs(VISIBLE_TO_ALL)
      .thatThrows("IllegalArgumentException", "Ha a `type` `null`, vagy ha a `name` üres vagy `null`.")
      .info("Létrehoz egy Meal példányt a megadott típussal és névvel. Az `isFinished` kezdetben legyen `false`.");
}

@Test
public void methodSetFinished() {
    it.hasMethod("setFinished", withArgsLikeFields("isFinished"))
      .that(hasUsualModifiers())
      .thatReturnsNothing();
}

@Test
public void methodIsFinished() {
    it.hasMethod("isFinished", withNoParams())
      .that(hasUsualModifiers())
      .thatReturns("boolean");
}

void main() {}


