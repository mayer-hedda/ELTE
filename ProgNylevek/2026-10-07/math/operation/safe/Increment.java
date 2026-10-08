package math.operation.safe;

public class Increment {
    public static int increment(int num) {
        if (num == Integer.MAX_VALUE) {
            return num;
        }

        return num + 1;
    }
}
