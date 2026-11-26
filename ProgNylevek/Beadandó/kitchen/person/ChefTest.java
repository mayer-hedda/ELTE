package kitchen.person;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.CsvSource;
import kitchen.meals.MealType;
import kitchen.meals.Meal;

public class ChefTest {
    @ParameterizedTest
    @CsvSource({
        "PASTRY, PASTRY, true",
        "PASTRY, MEAT,   false",
        "MEAT,   PASTRY, false"
    })
    public void cookMealTest(MealType specialty, MealType mealType, boolean expectedFinished) {
        Chef chef = new Chef("Aladár", specialty);
        Meal meal = new Meal("Étel", mealType);

        chef.cookMeal(meal);

        assertEquals(expectedFinished, meal.isFinished());
    }

    @Test
    public void textualRepresentationTest() {
        Chef chef = new Chef("Aladár", MealType.PASTRY);
        chef.cookMeal(new Meal("Torta", MealType.PASTRY));
        assertEquals("Chef Aladár specializes in PASTRY with current wage: 5000", chef.toString());
    }
}