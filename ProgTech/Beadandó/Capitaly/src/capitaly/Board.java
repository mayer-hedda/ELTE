package capitaly;

import java.util.ArrayList;
import java.util.List;


/**
 *
 * @author mayerhedda
 */
public class Board {
    private final List<Field> fields = new ArrayList<>();
 
    /**
     * Létrehoz egy üres pályát.
     */
    public Board() { }
 
    /**
     * Hozzáad egy mezőt a pálya végéhez.
     *
     * @param f a hozzáadandó mező
     */
    public void addField(Field f) {
        fields.add(f);
    }
 
    /**
     * Visszaadja a megadott pozíción lévő mezőt.
     *
     * @param i a mező indexe (0-tól számozva)
     * @return az {@code i}-edik mező
     * @throws IndexOutOfBoundsException ha az index kívül esik a pályán
     */
    public Field getField(int i) {
        return fields.get(i);
    }
 
    /**
     * Visszaadja a pálya hosszát, vagyis a mezők számát.
     *
     * @return a mezők száma
     */
    public int size() {
        return fields.size();
    }
}
