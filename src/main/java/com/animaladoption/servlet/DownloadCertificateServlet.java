package com.animaladoption.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.animaladoption.model.User;
import com.animaladoption.util.DBConnection;

import com.itextpdf.text.Document;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Font;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Element;
import com.itextpdf.text.Image;
import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Chunk;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.Phrase;

import com.itextpdf.text.pdf.PdfWriter;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.draw.LineSeparator;

@WebServlet("/DownloadCertificateServlet")

public class DownloadCertificateServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
        request.getSession();

        User u =
        (User) session.getAttribute("user");

        if(u == null){

            response.sendRedirect("login.jsp");
            return;
        }

        int animalId =
        Integer.parseInt(
        request.getParameter("animalId"));

        try {

            Connection con =
            DBConnection.getConnection();

            PreparedStatement ps =
            		con.prepareStatement(

            		"SELECT a.*, ar.request_date " +
            		"FROM animals a " +

            		"JOIN adoption_requests ar " +
            		"ON a.animal_id = ar.animal_id " +

            		"WHERE a.animal_id=? " +
            		"AND ar.user_id=? " +
            		"AND ar.status='Approved' " +

            		"ORDER BY ar.request_id DESC LIMIT 1"

            		);

            ps.setInt(1, animalId);
            ps.setInt(2, u.getUserId());

            ResultSet rs =
            ps.executeQuery();

            if(!rs.next()){

                return;
            }

            /* RESET RESPONSE */

            response.reset();

            response.setContentType(
            "application/pdf");

            response.setHeader(
            "Content-Disposition",
            "attachment; filename=AdoptionCertificate.pdf"
            );

            /* CREATE DOCUMENT */

            Document document =
            new Document(PageSize.A4.rotate());

            PdfWriter.getInstance(
                document,
                response.getOutputStream()
            );

            document.open();

            /* PAGE BORDER */

            Rectangle rect =
            new Rectangle(
                document.left(),
                document.bottom(),
                document.right(),
                document.top()
            );

            rect.setBorder(Rectangle.BOX);

            rect.setBorderWidth(5);

            rect.setBorderColor(
                new BaseColor(0, 51, 102)
            );

            document.add(rect);

            /* FONTS */

            Font titleFont =
            new Font(
                Font.FontFamily.TIMES_ROMAN,
                20,
                Font.BOLD,
                new BaseColor(0,51,102)
            );

            Font headingFont =
            new Font(
                Font.FontFamily.HELVETICA,
                14,
                Font.BOLD,
                new BaseColor(153,102,0)
            );

            Font normalFont =
            new Font(
                Font.FontFamily.HELVETICA,
                13,
                Font.NORMAL,
                BaseColor.BLACK
            );

            Font smallFont =
            new Font(
                Font.FontFamily.HELVETICA,
                11,
                Font.NORMAL,
                BaseColor.DARK_GRAY
            );

            /* TITLE */

            Paragraph title =
            new Paragraph(
                "PETCARE ADOPTION CERTIFICATE",
                titleFont
            );

            title.setAlignment(
                Element.ALIGN_CENTER
            );

            document.add(title);

            document.add(
                new Paragraph(" ")
            );

            /* LINE */

            LineSeparator ls =
            new LineSeparator();

            document.add(
                new Chunk(ls)
            );

            document.add(
                new Paragraph(" ")
            );

            /* PET IMAGE */

            String imagePath =

            getServletContext()
            .getRealPath("/") +

            "images/" +
            rs.getString("image");

            Image petImage =
            Image.getInstance(imagePath);

            petImage.scaleToFit(160,160);

            petImage.setAlignment(
                Element.ALIGN_CENTER
            );

            document.add(petImage);

            document.add(
                new Paragraph(" ")
            );

            /* CERTIFICATE TEXT */

            Paragraph certify =
            new Paragraph(

            "This certificate is proudly presented to",

            headingFont

            );

            certify.setAlignment(
                Element.ALIGN_CENTER
            );

            document.add(certify);

            

            /* USER NAME */

            Paragraph adopter =
            new Paragraph(

            u.getName(),

            new Font(
                Font.FontFamily.TIMES_ROMAN,
                22,
                Font.BOLDITALIC,
                new BaseColor(0,51,102)
            )

            );

            adopter.setAlignment(
                Element.ALIGN_CENTER
            );

            document.add(adopter);

           

            /* ADOPTION TEXT */

            Paragraph adoptText =
            new Paragraph(

            "for successfully adopting",

            normalFont

            );

            adoptText.setAlignment(
                Element.ALIGN_CENTER
            );

            document.add(adoptText);

           
            /* PET NAME */

            Paragraph petName =
            new Paragraph(

            rs.getString("name"),

            new Font(
                Font.FontFamily.TIMES_ROMAN,
                18,
                Font.BOLD,
                new BaseColor(153,102,0)
            )

            );

            petName.setAlignment(
                Element.ALIGN_CENTER
            );

            document.add(petName);

          

            /* CERTIFICATE ID */

            Paragraph certId =
            new Paragraph(

            "Certificate ID : PWC-" +
            animalId + "-" +
            u.getUserId(),

            smallFont

            );

            certId.setAlignment(
                Element.ALIGN_CENTER
            );

            document.add(certId);

            document.add(
                new Paragraph(" ")
            );

            /* DETAILS TABLE */

            PdfPTable table =
            new PdfPTable(2);

            table.setWidthPercentage(70);

            PdfPCell c1 =
            new PdfPCell(
            new Phrase(
            "Animal Type",
            headingFont
            ));

            PdfPCell c2 =
            new PdfPCell(
            new Phrase(
            rs.getString("type"),
            normalFont
            ));

            PdfPCell c3 =
            new PdfPCell(
            new Phrase(
            "Breed",
            headingFont
            ));

            PdfPCell c4 =
            new PdfPCell(
            new Phrase(
            rs.getString("breed"),
            normalFont
            ));

            PdfPCell c5 =
            new PdfPCell(
            new Phrase(
            "Adoption Date",
            headingFont
            ));

            PdfPCell c6 =
            new PdfPCell(
            new Phrase(
            rs.getString("request_date"),
            normalFont
            ));

            table.addCell(c1);
            table.addCell(c2);

            table.addCell(c3);
            table.addCell(c4);

            table.addCell(c5);
            table.addCell(c6);

            document.add(table);

            

            /* THANK YOU */

            Paragraph thanks =
            new Paragraph(

            "Thank you for giving a loving forever home to this pet.",

            headingFont

            );

            thanks.setAlignment(
                Element.ALIGN_CENTER
            );

            document.add(thanks);

            

            Paragraph msg =
            new Paragraph(

            "Your kindness helps build a better world for animals.",

            smallFont

            );

            msg.setAlignment(
                Element.ALIGN_CENTER
            );

            document.add(msg);

           

            document.add(
                new Paragraph(" ")
            );

            /* SIGNATURE */

            Paragraph sign =
            new Paragraph(

            "Authorized Signature\nPetCare Team",

            normalFont

            );

            sign.setAlignment(
                Element.ALIGN_RIGHT
            );

            document.add(sign);

            /* CLOSE DOCUMENT */

            document.close();

        }
        catch(Exception e){

            e.printStackTrace();
        }
    }
}