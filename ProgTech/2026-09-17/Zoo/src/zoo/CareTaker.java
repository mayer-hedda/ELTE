/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package zoo;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author mayerhedda
 */
public class CareTaker {
    private final List<Animal> animals = new ArrayList<>();
    
    public void takeCareOf(Animal animal) {
        animals.add(animal);
    }
}
