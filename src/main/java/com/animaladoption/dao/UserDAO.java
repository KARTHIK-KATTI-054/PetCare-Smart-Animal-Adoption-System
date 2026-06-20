package com.animaladoption.dao;

import java.sql.*;

import com.animaladoption.model.User;
import com.animaladoption.util.DBConnection;

public class UserDAO {

    // REGISTER
    public boolean registerUser(User u) {
        boolean status = false;

        try {
            Connection con = DBConnection.getConnection();

            String sql = "INSERT INTO users(name,email,password,role) VALUES(?,?,?,?)";
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, u.getName());
            ps.setString(2, u.getEmail());
            ps.setString(3, u.getPassword());
            ps.setString(4, "USER");

            int i = ps.executeUpdate();

            if (i > 0) status = true;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }

    // LOGIN
    public User login(String email, String password){

        User u = null;

        try{
            Connection con = DBConnection.getConnection();

            String sql = "SELECT * FROM users WHERE email=? AND password=?";
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if(rs.next()){
                u = new User();
                u.setUserId(rs.getInt("user_id"));
                u.setName(rs.getString("name"));
                u.setEmail(rs.getString("email"));
                u.setRole(rs.getString("role"));
            }

        }catch(Exception e){
            e.printStackTrace();
        }

        return u;
    }}