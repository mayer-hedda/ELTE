package kitchen;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;
import kitchen.person.Chef;
import kitchen.meals.Meal;
import kitchen.meals.MealType;

public class KitchenTest {
    @Test
    public void constructorExceptionTest() {
        Chef chef1 = new Chef("Aladár", MealType.MEAT);
        Chef chef2 = new Chef("Baltazár", MealType.FISH);
        Chef chef3 = new Chef("Előd", MealType.VEGETABLE);
        Chef chef4 = new Chef("Dénes", MealType.SAUCE);

        Chef[] chefs = {chef1, chef2, chef3, chef4};

        assertThrows(IllegalArgumentException.class, () -> new Kitchen(chefs));
    }

    @Test
    public void cookMealTest() {
        Chef chef = new Chef("Aladár", MealType.MEAT);

        Meal goodMeal = new Meal("Pörkölt", MealType.MEAT);
        Meal badMeal = new Meal("Harcsa", MealType.FISH);

        Kitchen konyha = new Kitchen(new Chef[]{chef});

        int prevFinishedMeals = konyha.getFinishedMeals().size();
        konyha.cookMeal(new Meal[]{goodMeal});
        assertEquals(prevFinishedMeals + 1, konyha.getFinishedMeals().size());

        konyha.cookMeal(new Meal[]{badMeal});
        assertEquals(prevFinishedMeals + 1, konyha.getFinishedMeals().size());
    }
}