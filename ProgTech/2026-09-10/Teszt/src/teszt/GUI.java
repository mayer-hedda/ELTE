/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package teszt;

import java.util.Random;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;

/**
 *
 * @author mayerhedda
 */
public class GUI extends JFrame {
    private JLabel Player1Label;
    private JButton Player1FightButton;
    private Person p1;
    private Person p2;
    private JPanel panel;
    
    private int fightCount = 0;
    
    public GUI (Person player1, Person player2) {
        p1 = player1;
        p2 = player2;
        
        setTitle("Duel");
        setSize(500, 300);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLocationRelativeTo(null);
        
        createGUI();
    }
    
    private void createGUI () {
        panel = new JPanel();
        panel.setLayout(null);
        //panel.setVisible(true);
        
        Player1Label = new JLabel();
        Player1Label.setText(p1.name);
        Player1Label.setBounds(50, 50, 150, 30);
        //panel.add(Player1Label);
        
        Player1FightButton = new JButton();
        Player1FightButton.setText("Fight");
        Player1FightButton.setBounds(50, 100, 100, 30);
        Player1FightButton.addActionListener((e) -> {
            fightCount++;
            System.out.println("Start the " + fightCount + ". fight!");
            
            Random random = new Random();
            
            Person attacker;
            Person defender;
            
            if (random.nextBoolean()) {
                attacker = p1;
                defender = p2;
            } else {
                attacker = p2;
                defender = p1;
            }
            
            attacker.fight(defender);
            
            System.out.println("\t" + p1.getName() + " hp: " + p1.getHp());
            System.out.println("\t" + p2.getName() + " hp: " + p2.getHp());
            
            if (p1.getHp() <= 0) {
                JOptionPane.showMessageDialog(
                    this,
                    p2.getName() + " win!",
                    "Game Over",
                    JOptionPane.WARNING_MESSAGE
                );
                System.exit(0);
            } else if (p2.getHp() <= 0) {
                JOptionPane.showMessageDialog(
                    this,
                    p1.getName() + " win!",
                    "Game Over",
                    JOptionPane.WARNING_MESSAGE
                );
                System.exit(0);
            }
            /*
            if (fightCount == 10) {
                //dispose();          // Bezárja az ablakot, de a futásnak nem lesz vége
                                
                JOptionPane.showMessageDialog(
                        this,
                        "A program le fog állni!",
                        "Game Over",
                        JOptionPane.WARNING_MESSAGE
                );
                
                System.exit(0);
            }
            */
        });
        panel.add(Player1FightButton);
        
        add(panel);
    }
}
