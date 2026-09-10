public class Greeting {
    public static void main(String[] args) {
        System.console().printf("What is your name? ");
        String name = System.console().readLine();
        System.console().printf("Hello, %s!", name);
    }
}