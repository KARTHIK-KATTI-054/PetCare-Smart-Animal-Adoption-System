package com.animaladoption.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.animaladoption.model.User;
import com.animaladoption.util.DBConnection;

@WebServlet("/LoginServlet")

public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String email =
        request.getParameter("email");

        String password =
        request.getParameter("password");

        try {

            Connection con =
            DBConnection.getConnection();

            PreparedStatement ps =
            con.prepareStatement(

            "SELECT * FROM users " +
            "WHERE email=? AND password=?"

            );

            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs =
            ps.executeQuery();

            if(rs.next()){

                User u = new User();

                u.setUserId(
                rs.getInt("user_id"));

                u.setName(
                rs.getString("name"));

                u.setEmail(
                rs.getString("email"));

                u.setRole(
                rs.getString("role"));

                HttpSession session =
                request.getSession();

                session.setAttribute("user", u);

                // ROLE BASED LOGIN

                if("ADMIN".equals(
                    rs.getString("role"))){

                    response.sendRedirect(
                    "admin-dashboard.jsp");

                }else{

                    response.sendRedirect(
                    "user-dashboard.jsp");
                }

            }else{

                response.sendRedirect(
                "login.jsp?error=Invalid");
            }

        }catch(Exception e){

            e.printStackTrace();
        }
    }
}