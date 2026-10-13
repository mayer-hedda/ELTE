/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package kincsvadasz;

import java.util.Random;

/**
 *
 * @author mayerhedda
 */
public enum Irany {
    FEL(-1, 0),
    LE(1, 0),
    BALRA(0, -1),
    JOBBRA(0, 1);
    
    private final int dSor;
    private final int dOszlop;

    Irany(int dSor, int dOszlop) {
        this.dSor = dSor;
        this.dOszlop = dOszlop;
    }

    public int getdSor() {
        return dSor;
    }

    public int getdOszlop() {
        return dOszlop;
    }

    public static Irany veletlen(Random rnd) {
        return values()[rnd.nextInt(values().length)];
    }
}
