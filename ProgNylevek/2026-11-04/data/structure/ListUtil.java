package data.structure;

import java.util.ArrayList;

public class ListUtil {
    public static ArrayList<Integer> divisors(int n) {
        ArrayList<Integer> result = new ArrayList<>();
        if (n == 0) {
            return result;
        }
        for (int i = 1; i <= n; i++) {
            if (n % i == 0) {
                result.add(i);
            }
        }
        return result;
    }
}
