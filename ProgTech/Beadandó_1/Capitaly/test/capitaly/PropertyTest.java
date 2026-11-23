package capitaly;

import static org.junit.Assert.*;
import org.junit.Before;
import org.junit.Test;


/**
 *
 * @author mayerhedda
 */
public class PropertyTest {
    private Property property;
    private Player peti;
    private Player anna;
 
    /**
     * Minden teszt előtt egy gazdátlan ingatlant és két mohó játékost hoz létre.
     */
    @Before
    public void setUp() {
        property = new Property(0);
        peti = new Greedy("Peti");
        anna = new Greedy("Anna");
    }
 
    /**
     * Gazdátlan ingatlanra lépve a mohó játékos megveszi 1000 Petákért.
     */
    @Test
    public void gazdatlanIngatlantMegveszi() {
        property.onStep(peti);
 
        assertSame(peti, property.getOwner());
        assertEquals(9000, peti.getMoney());
        assertTrue(peti.getProperties().contains(property));
    }
 
    /**
     * A saját, ház nélküli ingatlanra újra rálépve a tulajdonos házat épít 4000 Petákért.
     */
    @Test
    public void sajatIngatlanraHazatEpit() {
        property.onStep(peti);
        property.onStep(peti);
 
        assertTrue(property.hasHouse());
        assertEquals(5000, peti.getMoney());
        assertEquals(1, peti.getProperties().size());
    }
 
    /**
     * Ha már van ház, a tulajdonos nem fizet újra.
     */
    @Test
    public void masodikHazatNemEpit() {
        property.onStep(peti);
        property.onStep(peti);
        property.onStep(peti);
 
        assertEquals(5000, peti.getMoney());
    }
 
    /**
     * Más ház nélküli ingatlanára lépve 500 Peták bérleti díjat kell fizetni a tulajdonosnak.
     */
    @Test
    public void berletiDijHazNelkul() {
        property.onStep(peti);
        property.onStep(anna);
 
        assertEquals(9500, anna.getMoney());
        assertEquals(9500, peti.getMoney());
        assertSame(peti, property.getOwner());
    }
 
    /**
     * Más házas ingatlanára lépve 2000 Peták bérleti díjat kell fizetni a tulajdonosnak.
     */
    @Test
    public void berletiDijHazzal() {
        property.onStep(peti);
        property.onStep(peti);
        property.onStep(anna);
 
        assertEquals(8000, anna.getMoney());
        assertEquals(7000, peti.getMoney());
    }
 
    /**
     * Ha a játékosnak nincs elég pénze, nem vásárol.
     */
    @Test
    public void penzNelkulNemVasarol() {
        peti.pay(9500, null);
        property.onStep(peti);
 
        assertNull(property.getOwner());
        assertEquals(500, peti.getMoney());
    }
 
    /**
     * Alaphelyzetbe állítás után az ingatlan gazdátlan és ház nélküli.
     */
    @Test
    public void resetUtanGazdatlan() {
        property.onStep(peti);
        property.onStep(peti);
        property.reset();
 
        assertNull(property.getOwner());
        assertFalse(property.hasHouse());
    }
}
