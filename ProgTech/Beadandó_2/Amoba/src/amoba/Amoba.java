package amoba;

import java.awt.BorderLayout;
import java.awt.Dimension;
import java.awt.FlowLayout;
import java.awt.Font;
import javax.swing.BorderFactory;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JTextField;
import javax.swing.SwingConstants;
import javax.swing.SwingUtilities;

/**
 *
 * @author mayerhedda
 */
public class Amoba extends JFrame {
    
    public Amoba() {
        super("Kiszúrós amőba");
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setSize(new Dimension(600, 600));
        setMinimumSize(new Dimension(400, 400));
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

    public static void main(String[] args) {
        SwingUtilities.invokeLater(() -> {
            Amoba window = new Amoba();
            
            // Cím kiírása
            JLabel gameTitle = new JLabel("Kiszúrós amőba", SwingConstants.CENTER);
            gameTitle.setFont(gameTitle.getFont().deriveFont(Font.BOLD, 24f));
            gameTitle.setBorder(BorderFactory.createEmptyBorder(15, 0, 15, 0));
            window.add(gameTitle, BorderLayout.NORTH);
            
            // Játékos nevek bekérése
            JTextField player1NameField = new JTextField(12);
            JTextField player2NameField = new JTextField(12);
            
            JPanel playersPanel = new JPanel(new FlowLayout(FlowLayout.CENTER, 40, 0));
            playersPanel.add(window.createPlayerPanel("Player1", player1NameField));
            playersPanel.add(window.createPlayerPanel("Player2", player2NameField));
            
            JPanel topPanel = new JPanel(new BorderLayout());
            topPanel.add(gameTitle, BorderLayout.NORTH);
            topPanel.add(playersPanel, BorderLayout.CENTER);
            window.add(topPanel, BorderLayout.NORTH);
            
            window.setVisible(true);
        });
    }
    
}
