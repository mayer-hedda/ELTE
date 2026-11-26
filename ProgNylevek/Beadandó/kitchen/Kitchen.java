package kitchen;

import kitchen.person.Chef;
import kitchen.meals.Meal;
import java.util.ArrayList;

public class Kitchen {
    private Chef[] chefs;
    private ArrayList<Meal> finishedMeals;

    public Kitchen(Chef[] chefs) {
        if(chefs.length > 3) {
            throw new IllegalArgumentException("3-nál több szakács nem adható meg!");
        }
        this.chefs = chefs;
        this.finishedMeals = new ArrayList<Meal>();
    }

    public ArrayList<Meal> getFinishedMeals() {
        return this.finishedMeals;
    }

    public void cookMeal(Meal[] mealsToBeCooked) {
        ArrayList<Meal> cookableMeals = this.getCookableMeals(mealsToBeCooked);
        for(int i = 0; i < cookableMeals.size(); i++) {
            for(int j = 0; j < this.chefs.length; j++) {
                if (this.chefs[j].canCookMeal(cookableMeals.get(i))) {
                    this.chefs[j].cookMeal(cookableMeals.get(i));
                    this.finishedMeals.add(cookableMeals.get(i));
                    break;
                }
            }
        }
    }

    private ArrayList<Meal> getCookableMeals(Meal[] mealsToBeCooked) {
        ArrayList<Meal> cookableMeals = new ArrayList<Meal>();
        for (int i = 0; i < mealsToBeCooked.length; i++) {
            for (int j = 0; j < this.chefs.length; j++) {
                if(this.chefs[j].canCookMeal(mealsToBeCooked[i])) {
                    cookableMeals.add(mealsToBeCooked[i]);
                    break;
                }
            }
        }
        return cookableMeals;
    }
}