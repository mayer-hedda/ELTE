package point2d;

public class Point {
    public double x;
    public double y;

    public void move(double dx, double dy) {
        this.x += dx;
        this.y += dy;
    }

    public void mirror(Point other) {
        this.x = 2 * other.x - this.x;
        this.y = 2 * other.y - this.y;
    }

    public double distance(Point p) {
        return Math.sqrt((x - p.x) * (x - p.x) + (y - p.y) * (y - p.y));
    }


}