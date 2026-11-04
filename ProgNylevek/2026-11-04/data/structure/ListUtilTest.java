package data.structure;

import org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;
import java.util.ArrayList;
import static org.junit.jupiter.api.Assertions.assertEquals;

public class ListUtilTest {
    @Test
    public void testDivisors() {
        // Teszt 0 bemenetre
        ArrayList<Integer> expected0 = new ArrayList<>();
        assertEquals(expected0, ListUtil.divisors(0));

        // Teszt 1 bemenetre
        ArrayList<Integer> expected1 = new ArrayList<>();
        expected1.add(1);
        assertEquals(expected1, ListUtil.divisors(1));

        // Teszt 64 bemenetre
        ArrayList<Integer> expected64 = new ArrayList<>();
        expected64.add(1);
        expected64.add(2);
        expected64.add(4);
        expected64.add(8);
        expected64.add(16);
        expected64.add(32);
        expected64.add(64);
        assertEquals(expected64, ListUtil.divisors(64));
    }
}
