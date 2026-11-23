package capitaly;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.util.NoSuchElementException;
 
import org.junit.Test;
import static org.junit.Assert.*;


/**
 *
 * @author mayerhedda
 */
public class GameTest {
    private static final String JATEK = "6\nProperty\nService 800\nProperty\nLucky 1500\nProperty\nService 2000\n" + "3\nPeti Greedy\nAnna Careful\nBela Tactical\n";
 
    /**
     * Létrehoz egy ideiglenes fájlt a megadott tartalommal; a teszt végén törlődik.
     *
     * @param content a fájl tartalma
     * @return a fájl elérési útja
     * @throws IOException ha a fájl nem hozható létre
     */
    private static String tempFile(String content) throws IOException {
        File f = File.createTempFile("capitaly", ".txt");
        f.deleteOnExit();
        Files.write(f.toPath(), content.getBytes(StandardCharsets.UTF_8));
        return f.getPath();
    }
 
    /**
     * A kézzel levezetett példa: három kör után Anna nyer 11 000 Petákkal, két ingatlannal.
     */
    @Test
    public void keziPeldaEredmenye() throws IOException {
        Dice dice = new FileDice(tempFile("2 4 2 2 2 2 4 3 2"));
        Game game = new Game(tempFile(JATEK), dice);
 
        Player winner = game.run();
 
        assertEquals("Anna", winner.getName());
        assertEquals(11000, winner.getMoney());
        assertEquals(2, winner.getProperties().size());
 
        Player peti = game.getPlayers().get(0);
        Player bela = game.getPlayers().get(2);
        assertEquals(5000, peti.getMoney());
        assertTrue(peti.getProperties().get(0).hasHouse());
        assertEquals(8500, bela.getMoney());
        assertTrue(bela.getProperties().isEmpty());
    }
 
    /**
     * Ha a többiek kiesnek, az utolsó aktív játékos nyer, és a kiesett ingatlanjai felszabadulnak.
     */
    @Test
    public void utolsoAktivJatekosNyer() throws IOException {
        String jatek = "2\nProperty\nService 20000\n2\nA Greedy\nB Greedy\n";
        // A: 0. mező, megveszi; B: 0. mező, fizet 500-at; A: 1. mező, nem tud fizetni, kiesik.
        Dice dice = new FileDice(tempFile("2 2 1"));
        Game game = new Game(tempFile(jatek), dice);
 
        Player winner = game.run();
        Player a = game.getPlayers().get(0);
 
        assertEquals("B", winner.getName());
        assertEquals(9500, winner.getMoney());
        assertTrue(a.isOut());
        assertTrue(a.getProperties().isEmpty());
    }
 
    /**
     * Ismeretlen mezőtípus esetén a beolvasás IllegalArgumentException kivételt dob.
     */
    @Test(expected = IllegalArgumentException.class)
    public void ismeretlenMezotipus() throws IOException {
        new Game(tempFile("1\nHotel\n1\nA Greedy\n"), new RandomDice());
    }
 
    /**
     * Ismeretlen stratégia esetén a beolvasás IllegalArgumentException kivételt dob.
     */
    @Test(expected = IllegalArgumentException.class)
    public void ismeretlenStrategia() throws IOException {
        new Game(tempFile("1\nProperty\n1\nA Lusta\n"), new RandomDice());
    }
 
    /**
     * Ha a szám helyén szöveg áll, a beolvasás IllegalArgumentException kivételt dob.
     */
    @Test(expected = IllegalArgumentException.class)
    public void hianyzoDij() throws IOException {
        new Game(tempFile("1\nService abc\n1\nA Greedy\n"), new RandomDice());
    }
 
    /**
     * Nem létező fájl esetén FileNotFoundException keletkezik.
     */
    @Test(expected = FileNotFoundException.class)
    public void nemLetezoFajl() throws IOException {
        new Game("nincs_ilyen_fajl.txt", new RandomDice());
    }
 
    /**
     * A fájlból olvasott kocka sorban adja vissza a dobásokat, majd elfogynak.
     */
    @Test
    public void fajlKockaSorrendje() throws IOException {
        Dice dice = new FileDice(tempFile("3 1 6"));
 
        assertEquals(3, dice.roll());
        assertEquals(1, dice.roll());
        assertEquals(6, dice.roll());
        try {
            dice.roll();
            fail("NoSuchElementException kivételt vártam.");
        } catch (NoSuchElementException e) {
            // elvárt viselkedés
        }
    }
 
    /**
     * Az 1–6 tartományon kívüli dobás hibás bemenetnek számít.
     */
    @Test(expected = IllegalArgumentException.class)
    public void ervenytelenDobas() throws IOException {
        new FileDice(tempFile("3 7"));
    }
 
    /**
     * A véletlen kocka mindig 1 és 6 közötti számot ad.
     */
    @Test
    public void veletlenKockaTartomanya() {
        Dice dice = new RandomDice();
        for (int i = 0; i < 1000; i++) {
            int r = dice.roll();
            assertTrue(r >= 1 && r <= 6);
        }
    }
}
