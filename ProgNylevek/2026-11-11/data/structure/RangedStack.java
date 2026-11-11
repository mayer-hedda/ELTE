package data.structure;

import java.util.ArrayList;
import java.util.LinkedList;

public class RangedStack<E> {
    private LinkedList<E> elems;

    public RangedStack() {
        elems = new LinkedList<>();
    }

    public RangedStack(RangedStack<E> other) {
        elems = new LinkedList<>(other.elems);
    }

    public ArrayList<E> pop(int count) {
        ArrayList<E> result = new ArrayList<>();
        for (int i = 0; i < count && !elems.isEmpty(); i++) {
            result.add(elems.removeLast());
        }
        return result;
    }

    @SafeVarargs
    public final void push(E... elems) {
        for (E elem : elems) {
            this.elems.addLast(elem);
        }
    }
}
