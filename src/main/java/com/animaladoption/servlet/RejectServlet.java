package com.animaladoption.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.animaladoption.util.DBConnection;
import com.animaladoption.util.EmailUtil;

@WebServlet("/RejectServlet")

public class RejectServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        int requestId =
        Integer.parseInt(request.getParameter("requestId"));

        String reason =
        request.getParameter("reason");

        try {

            Connection con =
            DBConnection.getConnection();

            // REJECT REQUEST
            PreparedStatement ps =
            con.prepareStatement(
            "UPDATE adoption_requests " +
            "SET status='REJECTED' " +
            "WHERE request_id=?"
            );

            ps.setInt(1, requestId);

            ps.executeUpdate();

            // GET ANIMAL ID
            PreparedStatement ps2 =
            con.prepareStatement(
            "SELECT animal_id,user_id " +
            "FROM adoption_requests " +
            "WHERE request_id=?"
            );

            ps2.setInt(1, requestId);

            ResultSet rs =
            ps2.executeQuery();

            int animalId = 0;
            int userId = 0;

            if(rs.next()){

                animalId =
                rs.getInt("animal_id");

                userId =
                rs.getInt("user_id");
            }

            // MAKE ANIMAL AVAILABLE AGAIN
            PreparedStatement ps3 =
            con.prepareStatement(
            "UPDATE animals " +
            "SET status='AVAILABLE' " +
            "WHERE animal_id=?"
            );

            ps3.setInt(1, animalId);

            ps3.executeUpdate();

            // GET USER EMAIL
            PreparedStatement ps4 =
            con.prepareStatement(
            "SELECT email FROM users " +
            "WHERE user_id=?"
            );

            ps4.setInt(1, userId);

            ResultSet rs2 =
            ps4.executeQuery();

            String email = "";

            if(rs2.next()){

                email =
                rs2.getString("email");
            }

            // SEND EMAIL
            EmailUtil.sendEmail(
                email,
                "Adoption Request Rejected",
                "Sorry, your request was rejected.\n\nReason: "
                + reason
            );

            response.sendRedirect(
            "admin-requests.jsp");

        } catch(Exception e){

            e.printStackTrace();
        }
    }
}