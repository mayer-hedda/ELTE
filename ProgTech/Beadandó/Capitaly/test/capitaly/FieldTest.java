package capitaly;

import static org.junit.Assert.*;
import org.junit.Test;


/**
 *
 * @author mayerhedda
 */
public class FieldTest {
    
    /**
     * Szolgáltatás mezőn a játékos befizeti a díjat a banknak.
     */
    @Test
    public void szolgaltatasLevonjaADijat() {
        Player p = new Greedy("Peti");
        new Service(800).onStep(p);
 
        assertEquals(9200, p.getMoney());
        assertFalse(p.isOut());
    }
 
    /**
     * Ha a játékos nem tudja kifizetni a szolgáltatás díját, kiesik.
     */
    @Test
    public void szolgaltatasMiattKiesik() {
        Player p = new Greedy("Peti");
        new Service(20000).onStep(p);
 
        assertTrue(p.isOut());
    }
 
    /**
     * Szerencse mezőn a játékos megkapja a nyereményt.
     */
    @Test
    public void szerencseJovairja() {
        Player p = new Greedy("Peti");
        new Lucky(1500).onStep(p);
 
        assertEquals(11500, p.getMoney());
    }
}
