package com.animaladoption.dao;

import java.sql.*;
import com.animaladoption.util.DBConnection;

public class AdoptionDAO {

    public boolean addRequest(int userId, int animalId, String message) {

        boolean status = false;

        try {
            Connection con = DBConnection.getConnection();
            
            String check = "SELECT * FROM adoption_requests WHERE user_id=? AND animal_id=?";
            PreparedStatement checkPs = con.prepareStatement(check);

            checkPs.setInt(1, userId);
            checkPs.setInt(2, animalId);

            ResultSet rs = checkPs.executeQuery();

            if(rs.next()){
                return false; // already requested
            }

            String sql = "INSERT INTO adoption_requests(user_id, animal_id, message) VALUES(?,?,?)";
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, userId);
            ps.setInt(2, animalId);
            ps.setString(3, message);

            int i = ps.executeUpdate();

            if(i > 0) status = true;

        } catch(Exception e) {
            e.printStackTrace();
        }

        return status;
    }
    
    
    public ResultSet getAllRequests() {

        ResultSet rs = null;

        try {
            Connection con = DBConnection.getConnection();

            String sql = "SELECT ar.request_id, u.name as user_name, a.name as animal_name, ar.message, ar.status " +
                         "FROM adoption_requests ar " +
                         "JOIN users u ON ar.user_id = u.user_id " +
                         "JOIN animals a ON ar.animal_id = a.animal_id";

            PreparedStatement ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return rs;
    }
    
    public boolean updateRequestStatus(int requestId, String status) {

        boolean result = false;

        try {
            Connection con = DBConnection.getConnection();

            // 1. Update request status
            String sql = "UPDATE adoption_requests SET status=? WHERE request_id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, status);
            ps.setInt(2, requestId);

            int i = ps.executeUpdate();

            // 2. If approved → update animal
            if(status.equals("APPROVED")){

                String getAnimal = "SELECT animal_id FROM adoption_requests WHERE request_id=?";
                PreparedStatement ps2 = con.prepareStatement(getAnimal);
                ps2.setInt(1, requestId);

                ResultSet rs = ps2.executeQuery();

                if(rs.next()){
                    int animalId = rs.getInt("animal_id");

                    String updateAnimal = "UPDATE animals SET status='ADOPTED' WHERE animal_id=?";
                    PreparedStatement ps3 = con.prepareStatement(updateAnimal);
                    ps3.setInt(1, animalId);
                    ps3.executeUpdate();
                }
            }

            if(i > 0) result = true;

        } catch(Exception e){
            e.printStackTrace();
        }

        return result;
    }
}