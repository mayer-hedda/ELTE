package kitchen.person;

import kitchen.meals.MealType;
import kitchen.meals.Meal;

public class Chef {
    private final String name;
    private final MealType specialty;
    private int finishedMeals;
    private static final int payPerFinishedMeals = 5000;

    public Chef(String name, MealType specialty) {
        if(name == null || name.isEmpty()) {
            throw new IllegalArgumentException("A szakács nevét kötelező megadni!");
        }
        if(specialty == null) {
            throw new IllegalArgumentException("A szakács specialitását kötelező megadni!");
        }

        this.name = name;
        this.specialty = specialty;
        this.finishedMeals = 0;
    }

    public void cookMeal(Meal meal) {
        if(this.canCookMeal(meal)) {
            meal.setFinished(true);
            this.finishedMeals++;
        }
    }

    public boolean canCookMeal(Meal meal) {
        if(meal.getType() == this.specialty) {
            return true;
        }
        return false;
    }

    private int getWage() {
        return payPerFinishedMeals * this.finishedMeals;
    }

    @Override
    public String toString() {
        return "Chef " + name + " specializes in " + specialty + " with current wage: " + getWage();
    }
}