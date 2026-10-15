/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Main.java to edit this template
 */
package calc;

import java.awt.BorderLayout;
import java.awt.Dimension;
import java.awt.GridLayout;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JTextField;
import javax.swing.SwingUtilities;

/**
 *
 * @author mayerhedda
 */
public class Calc extends JFrame {
    private JButton[] buttons = new JButton[10];
    private JTextField display;
    private JButton equals;
    private JPanel buttonPanel;
    private JButton plus;
        
    public Calc() {
        setTitle("Calc");
        setMinimumSize(new Dimension(200, 200));
        setDefaultCloseOperation(EXIT_ON_CLOSE);
        setLayout(new BorderLayout());
        
        display = new JTextField();
        add(display, BorderLayout.NORTH);
        
        buttonPanel = new JPanel();
        buttonPanel.setLayout(new GridLayout(4, 4, 4, 4));  
        add(buttonPanel, BorderLayout.CENTER);
        
        for(int i = 0; i < 10;i++) {
            int n = 9-i;
            buttons[n] = new JButton();
            buttons[n].setText(String.valueOf(n));
            buttons[n].addActionListener(e -> Press(String.valueOf(n)));
            buttonPanel.add(buttons[n]);
        }
        plus = new JButton("+");
        buttonPanel.add(plus);
        plus.addActionListener(e -> Press("+"));
        
        equals = new JButton("=");
        buttonPanel.add(equals);        
        equals.addActionListener(e -> Press("="));
    }
    
    public void Press(String k) {
        if(k.equals("=")) {
            display.setText(String.valueOf(Evaluate(display.getText())));
        }
        else {
            display.setText(display.getText() + k);
        }
    }
    
    public int Evaluate(String input) {
        String[] numbers = input.split("\\+");
        int ossz = 0;
        for (String n : numbers) {
            ossz += Integer.parseInt(n);
        }
        return ossz;
    }
        
    public static void main(String[] args) {
        // Calc calc = new Calc();
        // calc.setVisible(true);
        
        SwingUtilities.invokeLater(() -> new Calc().setVisible(true));
    }
    
}
