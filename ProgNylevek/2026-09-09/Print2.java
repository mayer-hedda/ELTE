public class Print2 {
    public static void main(String[] args) {
        String num1 = System.console().readLine("1. szám: ");
        String num2 = System.console().readLine("2. szám: ");

        if (Integer.parseInt(num1) > Integer.parseInt(num2)) {
            // System.out.println("Az első szám nagyobb, mint a második.");
            System.out.println((Integer.parseInt(num1) - Integer.parseInt(num2)) / 2.0);
        } else if (Integer.parseInt(num1) < Integer.parseInt(num2)) {
            System.out.println((Integer.parseInt(num2) - Integer.parseInt(num1)) / 2.0);
        } else {
            System.out.println("A két szám egyenlő.");
        }
    }
}