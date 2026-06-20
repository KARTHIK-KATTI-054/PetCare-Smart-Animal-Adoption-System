package com.animaladoption.dao;

import com.animaladoption.model.Animal;

public class TestInsert {

    public static void main(String[] args) {

        Animal a = new Animal();
        a.setName("Tommy");
        a.setType("Dog");
        a.setBreed("Labrador");
        a.setAge(3);
        a.setGender("Male");
        a.setDescription("Very friendly dog");
        a.setImage("dog.jpg");
        a.setStatus("AVAILABLE");

        AnimalDAO dao = new AnimalDAO();

        if (dao.addAnimal(a)) {
            System.out.println("Animal Added Successfully!");
        } else {
            System.out.println("Failed!");
        }
    }
}