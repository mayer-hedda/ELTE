/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package teszt;

/**
 *
 * @author mayerhedda
 */
public class Person {
    public String name;
    private int age;
    private int demage;
    private int hp;
    
    public Person () {}
    
    public Person (String name, int age, int demage, int hp) {
        this.name = name;
        this.age = age;
        this.demage = demage;
        this.hp = hp;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public int getDemage() {
        return demage;
    }

    public void setDemage(int demage) {
        this.demage = demage;
    }

    public int getHp() {
        return hp;
    }

    public void setHp(int hp) {
        this.hp = hp;
    }
    
    public void fight(Person p2) {
        p2.setHp(p2.getHp() - this.demage);
    }
}
