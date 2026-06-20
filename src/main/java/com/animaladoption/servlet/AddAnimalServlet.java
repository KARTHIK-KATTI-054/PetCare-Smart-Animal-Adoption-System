package com.animaladoption.servlet;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.animaladoption.dao.AnimalDAO;
import com.animaladoption.model.Animal;

@WebServlet("/AddAnimalServlet")
@MultipartConfig
public class AddAnimalServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {

            // FORM DATA
            String name = request.getParameter("name");
            String type = request.getParameter("type");
            String breed = request.getParameter("breed");
            int age = Integer.parseInt(request.getParameter("age"));
            String gender = request.getParameter("gender");
            String description = request.getParameter("description");
            String status = request.getParameter("status");

            // FILE UPLOAD
            Part filePart = request.getPart("image");
            String fileName = filePart.getSubmittedFileName();

            // PATH
            String uploadPath = getServletContext().getRealPath("/") + "images";

            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }

            // SAVE FILE
            if (fileName != null && !fileName.isEmpty()) {
                filePart.write(uploadPath + File.separator + fileName);
            }

            // SET DATA
            Animal animal = new Animal();
            animal.setName(name);
            animal.setType(type);
            animal.setBreed(breed);
            animal.setAge(age);
            animal.setGender(gender);
            animal.setDescription(description);
            animal.setImage(fileName);
            animal.setStatus(status);

            // SAVE TO DB
            AnimalDAO dao = new AnimalDAO();
            boolean result = dao.addAnimal(animal);

            // RESPONSE
            if (result) {
                response.sendRedirect("animal-list.jsp");
            } else {
                response.getWriter().println("Error adding animal");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}