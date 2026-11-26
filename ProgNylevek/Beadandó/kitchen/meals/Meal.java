package kitchen.meals;

public class Meal {
    private final String name;
    private final MealType type;
    private boolean isFinished;

    public Meal(String name, MealType type) {
        if(name == null || name.isEmpty()) {
            throw new IllegalArgumentException("Az étel nevének megadása kötelező!");
        }
        if(type == null) {
            throw new IllegalArgumentException("Az étel típusának megadása kötelező!");
        }
        this.name = name;
        this.type = type;
        this.isFinished = false;
    }

    public String getName() {
        return this.name;
    }

    public MealType getType() {
        return this.type;
    }

    public void setFinished(boolean isFinished) {
        this.isFinished = isFinished;
    }

    public boolean isFinished() {
        return this.isFinished;
    }
}