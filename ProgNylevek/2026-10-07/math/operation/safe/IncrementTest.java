package math.operation.safe;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.*;

public class IncrementTest {

    @Test
    public void test1() {
        Assertions.assertEquals(1, Increment.increment(0));
    }

    @Test
    public void test2() {
        Assertions.assertEquals(Integer.MIN_VALUE + 1, Increment.increment(Integer.MIN_VALUE));
    }

    @Test
    public void test3() {
        Assertions.assertEquals(Integer.MAX_VALUE, Increment.increment(Integer.MAX_VALUE));
    }

    @Test
    public void test4() {
        Assertions.assertEquals(12346, Increment.increment(12345));
    }

    @Test
    public void test5() {
        Assertions.assertEquals(-54320, Increment.increment(-54321));
    }

    @Test
    public void test6() {
        Assertions.assertEquals(0, Increment.increment(-1));
    }

    @ParameterizedTest
    @CsvSource({
            "0, 1",
            "-2147483648, -2147483647",
            "2147483647, 2147483647",
            "100, 101",
            "-1000, -999",
            "-1, 0"
    })
    public void testIncrement(int num, int expected) {
        Assertions.assertEquals(expected, Increment.increment(num));
    }

}
