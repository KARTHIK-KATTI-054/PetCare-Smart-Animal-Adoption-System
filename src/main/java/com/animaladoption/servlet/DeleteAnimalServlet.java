package com.animaladoption.servlet;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;

import com.animaladoption.dao.AnimalDAO;

public class DeleteAnimalServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        AnimalDAO dao = new AnimalDAO();
        dao.deleteAnimal(id);

        response.sendRedirect("animal-list.jsp");
    }
}