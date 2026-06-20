package com.animaladoption.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.animaladoption.util.DBConnection;
import java.sql.ResultSet;

import com.animaladoption.util.EmailUtil;

@WebServlet("/ApproveServlet")
public class ApproveServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int requestId = Integer.parseInt(request.getParameter("id"));

            Connection con = DBConnection.getConnection();

            // Approve request
            PreparedStatement ps1 = con.prepareStatement(
                "UPDATE adoption_requests SET status='APPROVED' WHERE request_id=?"
            );
            ps1.setInt(1, requestId);
            ps1.executeUpdate();

            // Get animal id
            PreparedStatement ps2 = con.prepareStatement(
                "SELECT animal_id FROM adoption_requests WHERE request_id=?"
            );
            ps2.setInt(1, requestId);

            ResultSet rs = ps2.executeQuery();

            if (rs.next()) {
            	
            	// GET USER EMAIL
            	PreparedStatement ps4 =
            	con.prepareStatement(
            	"SELECT u.email " +
            	"FROM users u " +
            	"JOIN adoption_requests ar " +
            	"ON u.user_id = ar.user_id " +
            	"WHERE ar.request_id=?"
            	);

            	ps4.setInt(1, requestId);

            	ResultSet rs2 = ps4.executeQuery();

            	String email = "";

            	if(rs2.next()){
            	    email = rs2.getString("email");
            	}
            	
                int animalId = rs.getInt("animal_id");

                // Update animal status
                PreparedStatement ps3 = con.prepareStatement(
                    "UPDATE animals SET status='ADOPTED' WHERE animal_id=?"
                );
                ps3.setInt(1, animalId);
                ps3.executeUpdate();
                EmailUtil.sendEmail(
                	    email,
                	    "Adoption Approved 🐾",
                	    "Congratulations! Your adoption request has been approved."
                	);
            }

            response.sendRedirect("admin-requests.jsp");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}