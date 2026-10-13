/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package kincsvadasz;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author mayerhedda
 */
class Palya {
    private final int sorok;
    private final int oszlopok;
    
    private final boolean[][] fal;
    
    private final List<Elem> elemek = new ArrayList<>();

    public Palya(int sorok, int oszlopok, boolean[][] fal) {
        this.sorok = sorok;
        this.oszlopok = oszlopok;
        this.fal = fal;
    }
    
}
