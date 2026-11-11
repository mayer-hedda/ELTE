import check.*;
import static check.Use.*;

import module org.junit.jupiter;

public class RangedStackStructureTest {
    @BeforeAll
    public static void init() {
        Use.withTypeArg("E")
            .theClass("data.structure.RangedStack")
            .thatIs(FULLY_IMPLEMENTED, INSTANCE_LEVEL, VISIBLE_TO_ALL);
    }

    @Test
    public void fieldElems() {
        it.hasField("elems: LinkedList of E")
            .thatIs(INSTANCE_LEVEL, MODIFIABLE, VISIBLE_TO_NONE)
            .thatHasNo(GETTER, SETTER);
    }

    @Test
    public void constructor01() {
        it.hasConstructor(withNoArgs())
            .thatIs(VISIBLE_TO_ALL)
            .that(createsEmpty("elems"));
    }

    @Test
    public void constructor02() {
        it.hasConstructor(withParams("other: RangedStack of E"))
            .thatIs(VISIBLE_TO_ALL);
    }

    @Test
    public void methodPop() {
        it.hasMethod("pop", withParams("count: int"))
            .thatIs(FULLY_IMPLEMENTED, INSTANCE_LEVEL, VISIBLE_TO_ALL)
            .thatReturns("ArrayList of E");
    }

    @Test
    public void methodPush() {
        it.hasMethod("push", withParams("elems: vararg of E"))
            .thatIs(FULLY_IMPLEMENTED, INSTANCE_LEVEL, VISIBLE_TO_ALL)
            .thatReturnsNothing();
    }
}

