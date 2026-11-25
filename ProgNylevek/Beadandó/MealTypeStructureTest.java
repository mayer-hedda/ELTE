import check.*;
import static check.Use.*;

import module org.junit.jupiter;

@Test
public void elements() {
    Use.theEnum("kitchen.meals.MealType")
       .ofEnumElements("MEAT", "PASTRY", "FISH", "SAUCE", "VEGETABLE")
       .that(hasUsualModifiers());
}

void main() {}


