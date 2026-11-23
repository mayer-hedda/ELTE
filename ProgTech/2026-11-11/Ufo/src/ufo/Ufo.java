/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Main.java to edit this template
 */
package ufo;

import java.awt.Dimension;
import javax.swing.ImageIcon;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.WindowConstants;

/**
 *
 * @author mayerhedda
 */
public class Ufo extends JFrame {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                Ufo ufo = new Ufo();
                ufo.setVisible(true);
                ufo.setTitle("UFO");
                ufo.setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);
                ufo.setSize(new Dimension(400, 400));
                
                ImageIcon img = new ImageIcon("ufo.png");
                JLabel ufoLabel = new JLabel(img);
                ufo.add(ufoLabel);
            }
        });
    }
    
}
