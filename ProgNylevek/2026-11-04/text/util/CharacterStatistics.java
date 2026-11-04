package text.util;

import java.util.HashMap;
import java.util.Map.Entry;

public class CharacterStatistics {
    private HashMap<Character, Integer> charToCount;

    public CharacterStatistics(String text) {
        charToCount = new HashMap<>();
        for (char c : text.toCharArray()) {
            charToCount.put(c, charToCount.getOrDefault(c, 0) + 1);
        }
    }

    public int getCount(char c) {
        return charToCount.getOrDefault(c, 0);
    }

    public String toString() {
        StringBuilder sb = new StringBuilder();
        for (Entry<Character, Integer> entry : charToCount.entrySet()) {
            sb.append(entry.getKey()).append(": ").append(entry.getValue()).append("\n");
        }
        return sb.toString();
    }
}
