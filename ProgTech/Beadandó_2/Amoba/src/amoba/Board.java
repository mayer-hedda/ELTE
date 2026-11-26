package amoba;

/**
 *
 * @author mayerhedda
 */
public class Board {
    public static final char EMPTY = ' ';

    private final int size;
    private final char[][] cells;

    public Board(int size) {
        this.size = size;
        cells = new char[size][size];
        for (int i = 0; i < size; i++) {
            for (int j = 0; j < size; j++) {
                cells[i][j] = EMPTY;
            }
        }
    }

    public int getSize() { return size; }
    public char getCell(int row, int col) { return cells[row][col]; }
    
    public boolean isEmpty(int row, int col) { 
        return cells[row][col] == EMPTY; 
    }
    
    public void place(int row, int col, char symbol) {
        cells[row][col] = symbol; 
    }
    
    public void clear(int row, int col) { 
        cells[row][col] = EMPTY; 
    }

    public boolean isFull() {
        for(int i = 0; i < size; i++) {
            for(int j = 0; j < size; j++) {
                if(cells[i][j] == EMPTY) {
                    return false;
                }
            }
        }
        
        return true;
    }

    public int longestLineThrough(int row, int col) {
        char symbol = cells[row][col];
        if (symbol == EMPTY) {
            return 0;
        }

        int[][] directions = { {0, 1}, {1, 0}, {1, 1}, {1, -1} };
        int longest = 0;

        for (int[] d : directions) {
            int length = 1
                    + countInDirection(row, col, d[0], d[1], symbol)
                    + countInDirection(row, col, -d[0], -d[1], symbol);
            longest = Math.max(longest, length);
        }

        return longest;
    }

    private int countInDirection(int row, int col, int dRow, int dCol, char symbol) {
        int count = 0;
        int r = row + dRow;
        int c = col + dCol;

        while (isInside(r, c) && cells[r][c] == symbol) {
            count++;
            r += dRow;
            c += dCol;
        }

        return count;
    }

    private boolean isInside(int row, int col) {
        return row >= 0 && row < size && col >= 0 && col < size;
    }
}
