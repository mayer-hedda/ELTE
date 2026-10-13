/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package kincsvadasz;

/**
 *
 * @author mayerhedda
 */
public abstract class Targy extends Elem {
    
    private final String nev;
    private final int ertek;
    
    public Targy(int sor, int oszlop, String nev, int ertek) {
        super(sor, oszlop);
        this.nev = nev;
        this.ertek = ertek;
    }

    public String getNev() {
        return nev;
    }

    public int getErtek() {
        return ertek;
    }
    
    
}
