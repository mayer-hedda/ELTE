package famous.sequence;

public class TriangularNumbers {
    public static int getTriangularNumber(int n) {
        if (n <= 0) {
            return 0;
        }
        int sum = 0;
        for (int i = 1; i <= n; ++i) {
            sum += i;
        }
        return sum;
    }

    public static int getTriangularNumberAlternative(int n) {
        if (n <= 0) {
            return 0;
        }
        return n * (n + 1) / 2;
    }
}