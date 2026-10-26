package capitaly;

import static org.junit.Assert.*;
import org.junit.Test;


/**
 *
 * @author mayerhedda
 */
public class StrategyTest {
    
    /**
     * A mohó játékos vásárol, ha van elég pénze, és nem vásárol, ha nincs.
     */
    @Test
    public void mohoVasarolHaVanPenze() {
        Player p = new Greedy("Peti");
 
        assertTrue(p.wantsToBuy(4000));
        assertFalse(p.wantsToBuy(20000));
    }
 
    /**
     * Az óvatos játékos egy körben legfeljebb a tőkéje felét költi el.
     */
    @Test
    public void ovatosLegfeljebbAFeletKolti() {
        Player p = new Careful("Anna");
        p.startTurn(); // keret: 5000
 
        assertTrue(p.wantsToBuy(4000));
        assertFalse(p.wantsToBuy(6000));
    }
 
    /**
     * Az óvatos játékos keretét a vásárlás csökkenti.
     */
    @Test
    public void ovatosKeretetCsokkentiAVasarlas() {
        Player p = new Careful("Anna");
        p.startTurn(); // keret: 5000
        p.buy(new Property(0), 4000); // maradék keret: 1000
 
        assertTrue(p.wantsToBuy(1000));
        assertFalse(p.wantsToBuy(1500));
    }
 
    /**
     * Kevés pénznél az óvatos játékos akkor sem vásárol, ha mohó vásárolna.
     */
    @Test
    public void ovatosKevesPenzzelNemVasarol() {
        Player p = new Careful("Anna");
        p.pay(8500, null); // tőke: 1500
        p.startTurn();     // keret: 750
 
        assertFalse(p.wantsToBuy(1000));
    }
 
    /**
     * A taktikus játékos az első lehetőséget kihagyja, a másodikkal él, a harmadikat ismét kihagyja.
     */
    @Test
    public void taktikusMindenMasodikatKihagyja() {
        Player p = new Tactical("Bela");
 
        assertFalse(p.wantsToBuy(1000));
        assertTrue(p.wantsToBuy(1000));
        assertFalse(p.wantsToBuy(1000));
        assertTrue(p.wantsToBuy(1000));
    }
 
    /**
     * A taktikus játékos pénz nélkül akkor sem vásárol, ha épp élhetne a lehetőséggel.
     */
    @Test
    public void taktikusPenzNelkulNemVasarol() {
        Player p = new Tactical("Bela");
        p.wantsToBuy(1000);
 
        assertFalse(p.wantsToBuy(20000));
    }
}
