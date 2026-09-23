package pointless;
import point2d.Point;

class AnotherMain {
    public static void main(String[] args) {
        // point2d.Point p1 = new point2d.Point();
        Point p1 = new Point();
        p1.x = 3;
        p1.y = 4;
        System.out.println("p1.x = (" + p.x + ", p1.y " + p.y + ")");
        System.out.println("p distance from origo: " + p.distance(new Point()));
        p.move(2, 1);
        System.out.println("p = (" + p.x + ", " + p.y + ")");
        p.mirror(new Point());
        System.out.println("p = (" + p.x + ", " + p.y + ")");
    }
}
    