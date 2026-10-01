import org.junit.platform.suite.api.SelectClasses;
import org.junit.platform.suite.api.Suite;

import famous.sequence.FibonacciTest;

@Suite
@SelectClasses({
    FibonacciStructureTest.class,
    FibonacciTest.class
})
public class FibonacciTestSuite {}
