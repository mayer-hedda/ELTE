package plane;

public class PublicCircle {
    public double x = 0.0;
    public double y = 0.0;
    public double radius = 1;

    public int getArea() {
        return (int) (Math.PI * radius * radius);
    }
}