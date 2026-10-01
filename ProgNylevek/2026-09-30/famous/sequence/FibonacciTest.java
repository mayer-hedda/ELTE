package famous.sequence;

import org.junit.jupiter.api.*;
import static org.junit.jupiter.api.Assertions.*;

public class FibonacciTest {

    @Test
    public void test1() {
        assertEquals(1, Fibonacci.fib(1));
    }

    @Test
    public void test2() {
        assertEquals(1, Fibonacci.fib(2));
    }

    @Test
    public void test3() {
        assertEquals(2, Fibonacci.fib(3));
    }

    @Test
    public void test4() {
        assertEquals(55, Fibonacci.fib(10));
    }
}
