/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Main.java to edit this template
 */
package zoo;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author mayerhedda
 */
public class Zoo {
    private final Restaurant restaurant;
    private final List<Animal> animals = new ArrayList<>();
    
    public Zoo() {
        this.restaurant = new Restaurant();
    }
}

