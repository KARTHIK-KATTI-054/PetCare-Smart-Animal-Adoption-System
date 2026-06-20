package com.animaladoption.util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    public static Connection getConnection() {
        Connection con = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/animal_adoption",
                "root",
                "karthik@2004"   // ⚠️ put correct password
            );

            System.out.println("DataBase Connected");

        } catch (Exception e) {
            e.printStackTrace(); // VERY IMPORTANT
        }

        return con;
    }
}