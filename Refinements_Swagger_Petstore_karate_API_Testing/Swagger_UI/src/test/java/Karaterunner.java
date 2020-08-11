import com.intuit.karate.KarateOptions;
import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import org.junit.Test;

import static org.junit.Assert.assertTrue;

@KarateOptions(tags = {"~@ignore"})
public class Karaterunner {
    @Test
    public void testParallel() {
        Results results = Runner.parallel(getClass(), 2, "target/surefire-reports");
        assertTrue(results.getErrorMessages(), results.getFailCount() == 0);
    }
}