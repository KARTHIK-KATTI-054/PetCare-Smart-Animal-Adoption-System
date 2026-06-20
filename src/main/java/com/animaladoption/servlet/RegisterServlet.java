package com.animaladoption.servlet;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;

import com.animaladoption.dao.UserDAO;
import com.animaladoption.model.User;

public class RegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        User u = new User();
        u.setName(name);
        u.setEmail(email);
        u.setPassword(password);

        UserDAO dao = new UserDAO();

        if (dao.registerUser(u)) {
            resp.sendRedirect("login.jsp");
        } else {
            resp.getWriter().println("Registration Failed");
        }
    }
}