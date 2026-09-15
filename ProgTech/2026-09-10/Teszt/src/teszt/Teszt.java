/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Main.java to edit this template
 */
package teszt;

/**
 *
 * @author mayerhedda
 */
public class Teszt {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        Person p1 = new Person("Előd", 18, 30, 100);
        Person p2 = new Person("Aladár", 20, 35, 110);
        
        new GUI(p1, p2).setVisible(true);
    }
    
}
