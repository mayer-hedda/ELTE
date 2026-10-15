package array.util;

public class ArrayUtil {
    public void ArrayUtil() {
    }

    public static int max(int[] array) {
        if (array.length == 0) {
            return 0;
        }

        int result = Integer.MIN_VALUE;
        for (int i = 0; i < array.length; i++) {
            if (array[i] > result) {
                result = array[i];
            }
        }

        return result;
    }

    public static int max2(int[] array) {
        if (array.length == 0) {
            return 0;
        }

        int result = Integer.MIN_VALUE;
        for (int i = 0; i < array.length; i++) {
            result = (array[i] > result) ? array[i] : result;
        }

        return result;
    }

    public static int max3(int[] array) {
        if (array.length == 0) {
            return 0;
        }

        int result = Integer.MIN_VALUE;
        for (int i = 0; i < array.length; i++) {
            result = Math.max(array[i], result);
        }

        return result;
    }

    public static int max4(int[] array) {
        if (array.length == 0) {
            return 0;
        }

        int result = Integer.MIN_VALUE;
        for (int item : array) {
            result = Math.max(item, result);
        }

        return result;
    }

    public static int[] minMax(int[] array) {
        if (array.length == 0) {
            return new int[] { 0, 0 };
        }

        int[] result = { Integer.MAX_VALUE, Integer.MIN_VALUE };
        for (int item : array) {
            result[0] = Math.min(item, result[0]);
            result[1] = Math.max(item, result[1]);
        }

        return result;
    }
}
