package amoba;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Dimension;
import java.awt.FlowLayout;
import java.awt.Font;
import java.awt.GridLayout;
import java.awt.Insets;
import javax.swing.BorderFactory;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JTextField;
import javax.swing.SwingConstants;
import javax.swing.SwingUtilities;

/**
 *
 * @author mayerhedda
 */
public class Amoba extends JFrame {

    // Kezdőképernyő
    private JTextField player1NameField;
    private JTextField player2NameField;
    private JPanel startPanel;

    // Játékképernyő
    private Game game;
    private JButton[][] cellButtons;
    private JLabel statusLabel;

    public Amoba() {
        super("Kiszúrós amőba");
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setMinimumSize(new Dimension(400, 400));

        // Cím kiírása
        JLabel gameTitle = new JLabel("Kiszúrós amőba", SwingConstants.CENTER);
        gameTitle.setFont(gameTitle.getFont().deriveFont(Font.BOLD, 24f));
        gameTitle.setBorder(BorderFactory.createEmptyBorder(15, 0, 15, 0));

        // Játékos nevek bekérése
        player1NameField = new JTextField(12);
        player2NameField = new JTextField(12);

        JPanel playersPanel = new JPanel(new FlowLayout(FlowLayout.CENTER, 40, 0));
        playersPanel.add(createPlayerPanel("Player1", player1NameField));
        playersPanel.add(createPlayerPanel("Player2", player2NameField));

        // Pályaméret gombok
        JPanel buttonsPanel = new JPanel(new GridLayout(3, 1, 0, 10));
        for (int size : new int[] {6, 10, 14}) {
            JButton button = new JButton(size + "×" + size);
            button.setFont(button.getFont().deriveFont(Font.BOLD, 13f));
            button.setPreferredSize(new Dimension(200, 50));
            button.addActionListener(e -> startNewGame(size));
            buttonsPanel.add(button);
        }

        JPanel sizePanel = new JPanel(new FlowLayout(FlowLayout.CENTER));
        sizePanel.setBorder(BorderFactory.createEmptyBorder(80, 0, 0, 0));
        sizePanel.add(buttonsPanel);

        // Kezdőképernyő összerakása
        startPanel = new JPanel(new BorderLayout());
        startPanel.add(gameTitle, BorderLayout.NORTH);
        startPanel.add(playersPanel, BorderLayout.CENTER);
        startPanel.add(sizePanel, BorderLayout.SOUTH);

        showStartScreen();
        setLocationRelativeTo(null);
    }

    private JPanel createPlayerPanel(String name, JTextField field) {
        JLabel label = new JLabel(name, SwingConstants.CENTER);
        label.setFont(label.getFont().deriveFont(Font.BOLD, 12f));

        JPanel panel = new JPanel(new BorderLayout(0, 5));
        panel.add(label, BorderLayout.NORTH);
        panel.add(field, BorderLayout.CENTER);
        return panel;
    }

    private void showStartScreen() {
        getContentPane().removeAll();
        add(startPanel, BorderLayout.NORTH);
        setSize(new Dimension(500, 500));
        revalidate();
        repaint();
    }

    private void startNewGame(int size) {
        String name1 = nameOrDefault(player1NameField, "Player1");
        String name2 = nameOrDefault(player2NameField, "Player2");
        game = new Game(size, name1, name2);

        // Állapotsor
        statusLabel = new JLabel("", SwingConstants.CENTER);
        statusLabel.setFont(statusLabel.getFont().deriveFont(Font.BOLD, 16f));
        statusLabel.setBorder(BorderFactory.createEmptyBorder(10, 0, 10, 0));

        // Tábla
        JPanel boardPanel = new JPanel(new GridLayout(size, size));
        cellButtons = new JButton[size][size];

        for (int r = 0; r < size; r++) {
            for (int c = 0; c < size; c++) {
                JButton cell = new JButton();
                cell.setPreferredSize(new Dimension(40, 40));
                cell.setFont(cell.getFont().deriveFont(Font.BOLD, 18f));
                cell.setMargin(new Insets(0, 0, 0, 0));
                cell.setFocusPainted(false);

                final int row = r;
                final int col = c;
                cell.addActionListener(e -> handleCellClick(row, col));

                cellButtons[r][c] = cell;
                boardPanel.add(cell);
            }
        }

        // Vissza a főmenübe
        JButton backButton = new JButton("Főmenü");
        backButton.addActionListener(e -> showStartScreen());
        JPanel bottomPanel = new JPanel(new FlowLayout(FlowLayout.CENTER));
        bottomPanel.add(backButton);

        // Képernyőcsere
        getContentPane().removeAll();
        add(statusLabel, BorderLayout.NORTH);
        add(boardPanel, BorderLayout.CENTER);
        add(bottomPanel, BorderLayout.SOUTH);

        updateStatus();
        pack();
        setLocationRelativeTo(null);
        revalidate();
        repaint();
    }

    private void handleCellClick(int row, int col) {
        if (!game.makeMove(row, col)) {
            return;
        }

        refreshBoard();

        if (game.isWon()) {
            JOptionPane.showMessageDialog(this, game.getCurrentPlayerName() + " nyert!");
            startNewGame(game.getSize());
        } else if (game.isDraw()) {
            JOptionPane.showMessageDialog(this, "Döntetlen!");
            startNewGame(game.getSize());
        } else {
            updateStatus();
        }
    }

    private void refreshBoard() {
        for (int r = 0; r < game.getSize(); r++) {
            for (int c = 0; c < game.getSize(); c++) {
                JButton cell = cellButtons[r][c];

                if (game.isEmpty(r, c)) {
                    cell.setText("");
                } else {
                    char symbol = game.getCell(r, c);
                    cell.setText(String.valueOf(symbol));
                    cell.setForeground(symbol == 'X' ? Color.BLUE : Color.RED);
                }
            }
        }
    }

    private void updateStatus() {
        String text = "Következik: " + game.getCurrentPlayerName()
                + " (" + game.getCurrentPlayerSymbol() + ")";

        if (game.getLastRemovedCount() > 0) {
            text = "Kiszúrás! " + game.getLastRemovedCount() + " jel törölve. " + text;
        }

        statusLabel.setText(text);
    }

    private String nameOrDefault(JTextField field, String defaultName) {
        String name = field.getText().trim();
        return name.isEmpty() ? defaultName : name;
    }

    public static void main(String[] args) {
        SwingUtilities.invokeLater(() -> new Amoba().setVisible(true));
    }
}
