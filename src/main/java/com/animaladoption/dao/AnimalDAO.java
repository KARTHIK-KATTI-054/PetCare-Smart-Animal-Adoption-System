package com.animaladoption.dao;

import java.sql.Connection;

import com.animaladoption.model.Vaccination;
import java.sql.PreparedStatement;

import com.animaladoption.model.Animal;
import com.animaladoption.util.DBConnection;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class AnimalDAO {

    public boolean addAnimal(Animal a) {
    	
    	
        boolean status = false;

        try {
            Connection con = DBConnection.getConnection();

            String sql = "INSERT INTO animals(name, type, breed, age, gender, description, image, status) VALUES(?,?,?,?,?,?,?,?)";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, a.getName());
            ps.setString(2, a.getType());
            ps.setString(3, a.getBreed());
            ps.setInt(4, a.getAge());
            ps.setString(5, a.getGender());
            ps.setString(6, a.getDescription());
            ps.setString(7, a.getImage());
            ps.setString(8, a.getStatus());

            int i = ps.executeUpdate();

            if (i > 0) {
                status = true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }
    
    public List<Animal> getAllAnimals() {
        List<Animal> list = new ArrayList<>();

        try {
            Connection con = DBConnection.getConnection();

            String sql = "SELECT * FROM animals WHERE status='AVAILABLE'";

            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Animal a = new Animal();

                a.setAnimalId(rs.getInt("animal_id"));
                a.setName(rs.getString("name"));
                a.setType(rs.getString("type"));
                a.setBreed(rs.getString("breed"));
                a.setAge(rs.getInt("age"));
                a.setGender(rs.getString("gender"));
                a.setDescription(rs.getString("description"));
                a.setImage(rs.getString("image"));
                a.setStatus(rs.getString("status"));

                list.add(a);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    
    
    public boolean deleteAnimal(int id) {

        boolean status = false;

        try {
            Connection con = DBConnection.getConnection();

            String sql = "DELETE FROM animals WHERE animal_id=?";
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, id);

            int i = ps.executeUpdate();

            if (i > 0) {
                status = true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }
    
    
    
    public List<Animal> getAnimalsByType(String type) {
        List<Animal> list = new ArrayList<>();

        try {
            Connection con = DBConnection.getConnection();

            String sql = "SELECT * FROM animals WHERE type=? AND status='AVAILABLE'";
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, type);   // ✅ FIXED

            ResultSet rs = ps.executeQuery();

            while(rs.next()){
                Animal a = new Animal();
                
                a.setAnimalId(rs.getInt("animal_id"));
                a.setName(rs.getString("name"));
                a.setType(rs.getString("type"));
                a.setBreed(rs.getString("breed"));
                a.setAge(rs.getInt("age"));
                a.setGender(rs.getString("gender"));
                a.setDescription(rs.getString("description"));
                a.setImage(rs.getString("image"));
                a.setStatus(rs.getString("status"));

                list.add(a);
            }

        } catch(Exception e){
            e.printStackTrace();
        }

        return list;
    }
    
    public List<Animal> searchAnimals(String type, String breed) {

        List<Animal> list = new ArrayList<>();

        try {
            Connection con = DBConnection.getConnection();

            String sql = "SELECT * FROM animals WHERE type LIKE ? AND breed LIKE ?";
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, "%" + (type == null ? "" : type) + "%");
            ps.setString(2, "%" + (breed == null ? "" : breed) + "%");

            ResultSet rs = ps.executeQuery();

            while(rs.next()){
                Animal a = new Animal();

                a.setAnimalId(rs.getInt("animal_id"));
                a.setName(rs.getString("name"));
                a.setType(rs.getString("type"));
                a.setBreed(rs.getString("breed"));
                a.setAge(rs.getInt("age"));
                a.setGender(rs.getString("gender"));
                a.setDescription(rs.getString("description"));
                a.setImage(rs.getString("image"));
                a.setStatus(rs.getString("status"));

                list.add(a);
            }

        } catch(Exception e){
            e.printStackTrace();
        }

        return list;
    }
    
    public Animal getAnimalById(int id) {
        Animal a = null;

        try {
            Connection con = DBConnection.getConnection();

            String sql = "SELECT * FROM animals WHERE animal_id=?";
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                a = new Animal();
                

                a.setAnimalId(rs.getInt("animal_id"));
                a.setName(rs.getString("name"));
                a.setType(rs.getString("type"));
                a.setBreed(rs.getString("breed"));
                a.setAge(rs.getInt("age"));
                a.setGender(rs.getString("gender"));
                a.setDescription(rs.getString("description"));
                a.setImage(rs.getString("image"));
                a.setStatus(rs.getString("status"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return a;
    }
    
    
    public List<Vaccination> getVaccinationsByUser(int userId){

        List<Vaccination> list = new ArrayList<>();

        try{

            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(

                "SELECT * FROM pet_vaccinations WHERE user_id=?"

            );

            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            while(rs.next()){

                Vaccination v = new Vaccination();

                v.setVaccinationId(rs.getInt("vaccination_id"));
                v.setUserId(rs.getInt("user_id"));
                v.setAnimalId(rs.getInt("animal_id"));

                v.setVaccineName(rs.getString("vaccine_name"));

                v.setVaccinationDate(
                    rs.getString("vaccination_date")
                );

                v.setNextDueDate(
                    rs.getString("next_due_date")
                );

                v.setStatus(rs.getString("status"));

                list.add(v);
            }

        }catch(Exception e){
            e.printStackTrace();
        }

        return list;
    }
    
    
    public void updateAnimal(Animal a){

        try{

            Connection con =
            DBConnection.getConnection();

            PreparedStatement ps =
            con.prepareStatement(

            "UPDATE animals SET " +

            "name=?, " +
            "type=?, " +
            "breed=?, " +
            "age=?, " +
            "gender=?, " +
            "description=?, " +
            "image=? " +

            "WHERE animal_id=?"

            );

            ps.setString(1, a.getName());
            ps.setString(2, a.getType());
            ps.setString(3, a.getBreed());
            ps.setInt(4, a.getAge());
            ps.setString(5, a.getGender());
            ps.setString(6, a.getDescription());
            ps.setString(7, a.getImage());

            ps.setInt(8, a.getAnimalId());

            ps.executeUpdate();

        }
        catch(Exception e){

            e.printStackTrace();
        }
    }
    
    
    
   
}