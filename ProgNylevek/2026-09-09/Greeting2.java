public class Greeting2 {
    public static void main(String[] args) {
        if (args.length > 0) {
            System.console().printf("Hello, %s!", args[0]);
        } else {
            System.console().printf("What is your name? ");
            String name = System.console().readLine();
            System.console().printf("Hello, %s!", name);
        }
    }
}