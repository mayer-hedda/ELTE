package capitaly;

import static org.junit.Assert.*;
import org.junit.Test;


/**
 *
 * @author mayerhedda
 */
public class PlayerTest {
    
    /**
     * Új játékos 10 000 Petákkal, a 0. mezőn, ingatlan nélkül indul.
     */
    @Test
    public void kezdoAllapot() {
        Player p = new Greedy("Peti");
 
        assertEquals(Player.START_MONEY, p.getMoney());
        assertEquals(0, p.getPosition());
        assertFalse(p.isOut());
        assertTrue(p.getProperties().isEmpty());
    }
 
    /**
     * A pálya végén túllépve a játékos elölről folytatja.
     */
    @Test
    public void lepesKorbeEr() {
        Player p = new Greedy("Peti");
        p.move(4, 6);
        p.move(3, 6);
 
        assertEquals(1, p.getPosition());
    }
 
    /**
     * Sikeres fizetéskor a pénz átkerül a kedvezményezetthez.
     */
    @Test
    public void sikeresFizetes() {
        Player a = new Greedy("A");
        Player b = new Greedy("B");
 
        assertTrue(a.pay(3000, b));
        assertEquals(7000, a.getMoney());
        assertEquals(13000, b.getMoney());
    }
 
    /**
     * Ha nincs elég pénz, a fizetés sikertelen, és a játékos kiesik.
     */
    @Test
    public void sikertelenFizetesKiesest() {
        Player a = new Greedy("A");
        Player b = new Greedy("B");
 
        assertFalse(a.pay(15000, b));
        assertTrue(a.isOut());
        assertEquals(10000, b.getMoney());
    }
 
    /**
     * Kieséskor a játékos ingatlanjai gazdátlanok lesznek, a házak elvesznek.
     */
    @Test
    public void kiesesKorIngatlanokFelszabadulnak() {
        Player p = new Greedy("Peti");
        Property prop = new Property(0);
        prop.onStep(p);
        prop.onStep(p);
 
        p.goBankrupt();
 
        assertTrue(p.isOut());
        assertTrue(p.getProperties().isEmpty());
        assertNull(prop.getOwner());
        assertFalse(prop.hasHouse());
    }
}
