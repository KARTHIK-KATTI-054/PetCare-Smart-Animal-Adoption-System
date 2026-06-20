package com.animaladoption.util;

import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class EmailUtil {

    // YOUR GMAIL
    private static final String FROM_EMAIL = "karthikkatti777@gmail.com";

    // APP PASSWORD
    private static final String PASSWORD = "plti wnds plfq mhze";

    public static void sendEmail(String toEmail,
                                 String subject,
                                 String body) {

        Properties props = new Properties();

        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props,
            new Authenticator() {

                protected PasswordAuthentication
                getPasswordAuthentication() {

                    return new PasswordAuthentication(
                            FROM_EMAIL,
                            PASSWORD
                    );
                }
            });

        try {

            Message message = new MimeMessage(session);

            message.setFrom(
                new InternetAddress(FROM_EMAIL)
            );

            message.setRecipients(
                Message.RecipientType.TO,
                InternetAddress.parse(toEmail)
            );

            message.setSubject(subject);

            message.setText(body);

            Transport.send(message);

            System.out.println("Email Sent Successfully");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}