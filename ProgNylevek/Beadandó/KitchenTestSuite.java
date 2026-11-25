import org.junit.platform.suite.api.*;
import org.junit.jupiter.api.*;

@SelectClasses({
    KitchenTestSuite.StructuralTests.class,
    KitchenTestSuite.FunctionalTests.class,
})
@Suite(failIfNoTests=false) public class KitchenTestSuite {
    @SelectClasses({
        MealTypeStructureTest.class,
        MealStructureTest.class,
        ChefStructureTest.class,
        KitchenStructureTest.class,
    })
    @Suite(failIfNoTests=false) @Tag("structural") public static class StructuralTests {}

    @SelectClasses({
        kitchen.person.ChefTest.class,
        kitchen.KitchenTest.class,
    })
    @Suite(failIfNoTests=false) @Tag("functional") public static class FunctionalTests {}
}

