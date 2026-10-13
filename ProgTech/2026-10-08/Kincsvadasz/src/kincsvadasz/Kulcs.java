/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package kincsvadasz;

/**
 *
 * @author mayerhedda
 */
public class Kulcs extends Targy implements gyujtheto {
    public Kulcs(int sor, int oszlop, String nev, int ertek) {
        super(sor, oszlop, nev, ertek);
    }
    
    @Override
    public char jel() {
        return 'K';
    }
}
