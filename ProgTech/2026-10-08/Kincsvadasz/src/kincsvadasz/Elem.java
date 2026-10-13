/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package kincsvadasz;

/**
 *
 * @author mayerhedda
 */
public abstract class Elem {
    private int sor;
    private int oszlop;
    
    protected Elem(int sor, int oszlop) {
        this.sor = sor;
        this.oszlop = oszlop;
    }

    public int getSor() {
        return sor;
    }

    public int getOszlop() {
        return oszlop;
    }
    
    public void helyez(int sor, int oszlop) {
        this.sor = sor;
        this.oszlop = oszlop;
    }
    
    public abstract char jel();
}
