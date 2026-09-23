package plane.but.not.flying;
import plane.PublicCircle;
import plane.Circle;

public class CircleMain {
    public static void main(String[] args) {
        PublicCircle c = new PublicCircle();
        System.out.println("C1 területe: " + c.getArea());

        c.x = 5;
        c.y = 2;
        c.radius = 10;
        System.out.println("C1 területe: " + c.getArea());


        // Circle c2 = new Circle();
        // c2.setX(5);
        // c2.setY(2);
        // c2.setRadius(10);
        // System.out.println("C2 területe: " + c2.getArea());


        Circle c3 = new Circle(5, 2, 10);
        System.out.println("C3 területe: " + c3.getArea());
    }
}