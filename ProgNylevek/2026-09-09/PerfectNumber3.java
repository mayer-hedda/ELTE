public class PerfectNumber3 {
    public static void main(String[] args) {
        if (args.length == 0) {
            System.out.println("Please provide a number as a command line argument.");
            return;
        }

        int n = Integer.parseInt(args[0]);
        int result = 0;

        for (int i = 1; i <= n; i++) {
            int sum = 0;

            for (int j = 1; j < i; j++) {
                if (i % j == 0) {
                    sum += j;
                }
            }
            if (sum == i) {
                result++;
            }
        }
        
        if (result == 0) {
            System.out.println("There are no perfect numbers up to " + n + ".");
        } else {
            System.out.println("The number of perfect numbers up to " + n + " is: " + result);
        }
    }
}