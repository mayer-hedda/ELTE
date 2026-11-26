package amoba;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

/**
 *
 * @author mayerhedda
 */
public class Game {
    private final Board board;
    private final Player[] players;
    private int currentIndex = 0;
    private final Random random = new Random();

    private int lastRemovedCount = 0;
    private MoveResult lastResult = MoveResult.CONTINUE;

    public Game(int size, String name1, String name2) {
        board = new Board(size);
        players = new Player[] {
            new Player(name1, 'X'),
            new Player(name2, 'O')
        };
    }

    // A felület ezeken keresztül éri el az adatokat
    public int getSize() { return board.getSize(); }
    public char getCell(int row, int col) { return board.getCell(row, col); }
    public boolean isEmpty(int row, int col) { return board.isEmpty(row, col); }
    public String getCurrentPlayerName() { return getCurrentPlayer().getName(); }
    public char getCurrentPlayerSymbol() { return getCurrentPlayer().getSymbol(); }
    public int getLastRemovedCount() { return lastRemovedCount; }
    public boolean isWon() { return lastResult == MoveResult.WIN; }
    public boolean isDraw() { return lastResult == MoveResult.DRAW; }

    private Player getCurrentPlayer() { return players[currentIndex]; }

    public boolean makeMove(int row, int col) {
        if (!board.isEmpty(row, col)) {
            lastResult = MoveResult.INVALID;
            return false;
        }

        lastRemovedCount = 0;

        char symbol = getCurrentPlayer().getSymbol();
        board.place(row, col, symbol);

        int longest = board.longestLineThrough(row, col);

        if (longest >= 5) {
            lastResult = MoveResult.WIN;
            return true;
        }

        if (longest == 4) {
            removeRandomMarks(symbol, 2, row, col);
            lastRemovedCount = 2;
        } else if (longest == 3) {
            removeRandomMarks(symbol, 1, row, col);
            lastRemovedCount = 1;
        }

        if (board.isFull()) {
            lastResult = MoveResult.DRAW;
            return true;
        }

        currentIndex = 1 - currentIndex;
        lastResult = MoveResult.CONTINUE;
        return true;
    }

    private void removeRandomMarks(char symbol, int count, int keepRow, int keepCol) {
        List<int[]> positions = new ArrayList<>();

        for (int r = 0; r < board.getSize(); r++) {
            for (int c = 0; c < board.getSize(); c++) {
                boolean isNewMark = (r == keepRow && c == keepCol);
                if (board.getCell(r, c) == symbol && !isNewMark) {
                    positions.add(new int[] {r, c});
                }
            }
        }

        for (int i = 0; i < count && !positions.isEmpty(); i++) {
            int index = random.nextInt(positions.size());
            int[] pos = positions.remove(index);
            board.clear(pos[0], pos[1]);
        }
    }
}
