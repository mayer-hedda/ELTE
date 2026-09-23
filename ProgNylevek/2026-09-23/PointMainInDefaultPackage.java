import point2d.Point;

public class PointMainInDefaultPackage {
    public static void main(String[] args) {
        Point p = new Point();
        p.x = 3;
        p.y = 4;
        System.out.println("p = (" + p.x + ", " + p.y + ")");
        System.out.println("p distance from origo: " + p.distance(new Point()));
        p.move(2, 1);
        System.out.println("p = (" + p.x + ", " + p.y + ")");
        p.mirror(new Point());
        System.out.println("p = (" + p.x + ", " + p.y + ")");
    }
}