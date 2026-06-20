package com.animaladoption.servlet;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;

import com.animaladoption.dao.AdoptionDAO;
import com.animaladoption.model.User;

public class AdoptServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int animalId = Integer.parseInt(request.getParameter("animalId"));
        String message = request.getParameter("message");

        User user = (User) request.getSession().getAttribute("user");

        int userId = user.getUserId();

        AdoptionDAO dao = new AdoptionDAO();
        dao.addRequest(userId, animalId, message);

        response.sendRedirect("animal-list.jsp");
    }
}