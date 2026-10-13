/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package kincsvadasz;

/**
 *
 * @author mayerhedda
 */
public abstract class Leny extends Elem {
    private int eletero;

    public Leny(int sor, int oszlop) {
        super(sor, oszlop);
    }
    
    public boolean el() {
        return eletero > 0;
    };
    
    public void serul(int sebzes) {
        eletero = Math.max(0, eletero - sebzes);
    }
    
    public abstract Irany kovetkezoLepes(Palya palya);
}
