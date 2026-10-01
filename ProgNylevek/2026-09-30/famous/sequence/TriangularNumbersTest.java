package famous.sequence;

import org.junit.jupiter.api.*;
import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.*;

public class TriangularNumbersTest {
    @Test
    public void Gauss() {
        assertEquals(5050, TriangularNumbers.getTriangularNumberAlternative(100));
    }

    @ParameterizedTest
    @CsvSource({
            "0, 0",
            "1, 1",
            "-1, 0",
            "-100, 0"
    })
    public void singleValues(int index, int expected) {
        assertEquels(expected, TriangularNumbers.getTriangularNumber(index));
    }

    @Test
    public void test1() {
        assertEquals(0, TriangularNumbers.getTriangularNumber(0));
    }

    @Test
    public void test2() {
        assertEquals(1, TriangularNumbers.getTriangularNumber(1));
    }

    @Test
    public void test3() {
        assertEquals(5050, TriangularNumbers.getTriangularNumber(100));
    }

    @Test
    public void test4() {
        assertEquals(0, TriangularNumbers.getTriangularNumber(-1));
    }

    @Test
    public void test5() {
        assertEquals(0, TriangularNumbers.getTriangularNumber(-50));
    }

    @Test
    public void test6() {
        assertEquals(0, TriangularNumbers.getTriangularNumberAlternative(0));
    }

    @Test
    public void test7() {
        assertEquals(1, TriangularNumbers.getTriangularNumberAlternative(1));
    }

    @Test
    public void test8() {
        assertEquals(5050, TriangularNumbers.getTriangularNumberAlternative(100));
    }

    @Test
    public void test9() {
        assertEquals(0, TriangularNumbers.getTriangularNumberAlternative(-1));
    }

    @Test
    public void test10() {
        assertEquals(0, TriangularNumbers.getTriangularNumberAlternative(-50));
    }
}
