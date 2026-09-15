package org.example;

public class Person {
    private String nev;
    private int eletkor;
    private String nem;

    public Person(String nev, int eletkor, String nem) {
        this.nev = nev;
        this.eletkor = eletkor;
        this.nem = nem;
    }

    public Person () {

    }

    public String getNev() {
        return nev;
    }

    public static void harc(Person p1, Person p2) {
        if (p1.eletkor > p2.eletkor) {
            System.out.println(p1.nev + " nyert!");
        } else if (p1.eletkor < p2.eletkor) {
            System.out.println(p2.nev + " nyert!");
        } else {
            System.out.println("Döntetlen!");
        }
    }
}
