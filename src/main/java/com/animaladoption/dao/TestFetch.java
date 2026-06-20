package com.animaladoption.dao;

import java.util.List;
import com.animaladoption.model.Animal;

public class TestFetch {

    public static void main(String[] args) {

        AnimalDAO dao = new AnimalDAO();
        
        

        List<Animal> list = dao.getAllAnimals();

        for (Animal a : list) {
            System.out.println(a.getName() + " - " + a.getBreed());
        }
    }
}