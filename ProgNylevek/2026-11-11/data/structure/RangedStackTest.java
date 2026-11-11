package data.structure;

import static org.junit.jupiter.api.Assertions.assertEquals;

import java.util.List;

import org.junit.jupiter.api.Test;

public class RangedStackTest {
    @Test
    public void empty() {
        RangedStack<Integer> stack = new RangedStack<>();
        RangedStack<Integer> copy = new RangedStack<>(stack);

        for (RangedStack<Integer> s : List.of(stack, copy)) {
            assertEquals(List.of(), s.pop(0));
            assertEquals(List.of(), s.pop(1));
            assertEquals(List.of(), s.pop(100));
        }
    }

    @Test
    public void testString() {
        RangedStack<String> stack = new RangedStack<>();
        stack.push("2", "4", "6", "8", "10", "12");
        RangedStack<String> copy = new RangedStack<>(stack);

        assertEquals(List.of("12"), stack.pop(1));
        assertEquals(List.of("10", "8"), stack.pop(2));
        assertEquals(List.of("6", "4", "2"), stack.pop(3));
        assertEquals(List.of(), stack.pop(100));

        assertEquals(List.of("12", "10", "8", "6", "4", "2"), copy.pop(100));
        assertEquals(List.of(), copy.pop(100));
    }

    @Test
    public void testInteger() {
        RangedStack<Integer> stack = new RangedStack<>();
        stack.push(2, 4, 6, 8, 10, 12);
        RangedStack<Integer> copy = new RangedStack<>(stack);

        assertEquals(List.of(12), stack.pop(1));
        assertEquals(List.of(10, 8), stack.pop(2));
        assertEquals(List.of(6, 4, 2), stack.pop(3));
        assertEquals(List.of(), stack.pop(100));

        assertEquals(List.of(12, 10, 8, 6, 4, 2), copy.pop(100));
        assertEquals(List.of(), copy.pop(100));
    }
}
