package com.animaladoption.servlet;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;

import com.animaladoption.dao.AdoptionDAO;

public class UpdateRequestServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int requestId = Integer.parseInt(request.getParameter("id"));
        String status = request.getParameter("status");

        AdoptionDAO dao = new AdoptionDAO();
        dao.updateRequestStatus(requestId, status);

        response.sendRedirect("admin-requests.jsp");
    }
}