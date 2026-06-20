package com.animaladoption.servlet;
import javax.servlet.annotation.MultipartConfig;

import java.io.File;
import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

import com.animaladoption.dao.AnimalDAO;
import com.animaladoption.model.Animal;

@WebServlet("/UpdateAnimalServlet")
@MultipartConfig
public class UpdateAnimalServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String type = request.getParameter("type");
        String breed = request.getParameter("breed");
        int age = Integer.parseInt(request.getParameter("age"));
        String gender = request.getParameter("gender");
        String description = request.getParameter("description");

        String oldImage = request.getParameter("oldImage");

        Part filePart = request.getPart("image");
        String fileName = filePart.getSubmittedFileName();

        String uploadPath = getServletContext().getRealPath("/") + "images";

        String finalImage = oldImage;

        if(fileName != null && !fileName.isEmpty()){
            filePart.write(uploadPath + File.separator + fileName);
            finalImage = fileName;
        }

        Animal a = new Animal();
        a.setAnimalId(id);
        a.setName(name);
        a.setType(type);
        a.setBreed(breed);
        a.setAge(age);
        a.setGender(gender);
        a.setDescription(description);
        a.setImage(finalImage);

        AnimalDAO dao = new AnimalDAO();
        dao.updateAnimal(a);

        response.sendRedirect("animal-list.jsp");
    }
}