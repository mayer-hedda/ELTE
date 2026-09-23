package plane;

public class Circle {
    private double x = 0.0;
    private double y = 0.0;
    private double radius = 1;

    public Circle(double x, double y, double radius) {
        this.x = x;
        this.y = y;
        if (radius <= 0) {
            throw new IllegalArgumentException("Radius cannot be 0 or negative");
        }
        this.radius = radius;
    }

    public double getX() {
        return x;
    }

    public double getY() {
        return y;
    }

    public double getRadius() {
        return radius;
    }

    public void setX(double x) {
        this.x = x;
    }

    public void setY(double y) {
        this.y = y;
    }

    public void setRadius(double radius) {
        if (radius <= 0) {
            throw new IllegalArgumentException("Radius cannot be 0 ornegative");
        }
        this.radius = radius;
    }

    public int getArea() {
        return (int) (Math.PI * radius * radius);
    }
}