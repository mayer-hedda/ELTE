package data.structure;

import java.util.HashMap;

public class MultiSet<E> {
    private HashMap<E, Integer> elemToCount;

    @SafeVarargs
    public MultiSet(E... elems) {
        elemToCount = new HashMap<>();
        for (E elem : elems) {
            add(elem);
        }
    }

    public int add(E elem) {
        int count = 1 + elemToCount.getOrDefault(elem, 0);
        elemToCount.put(elem, count);
        return count;
    }

    public int getCount(E elem) {
        return elemToCount.getOrDefault(elem, 0);
    }

    public MultiSet<E> intersect(MultiSet<E> otherMultiSet) {
        MultiSet<E> intersection = new MultiSet<>();
        for (E key : elemToCount.keySet()) {
            if (!otherMultiSet.elemToCount.containsKey(key)) {
                continue;
            }
            int count1 = elemToCount.get(key);
            int count2 = otherMultiSet.elemToCount.get(key);
            intersection.elemToCount.put(key, Math.min(count1, count2));
        }
        return intersection;
    }

    public int countExcept(HashSet<E> notCounted) {
        int count = 0;
        for (Map.Entry<E, Integer> entry : elemToCount.entrySet()) {
            if (!notCounted.contains(entry.getKey())) {
                count += entry.getValue();
            }
        }
        return count;
    }

    public int size() {
        int size = 0;
        for (Map.Entry<E, Integer> entry : elemToCount.entrySet()) {
            size += entry.getValue();
        }
        return size;
    }
}