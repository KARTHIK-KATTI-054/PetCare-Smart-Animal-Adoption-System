# 🐾 PawCare – Smart Animal Adoption System

A full-stack web application that simplifies the pet adoption process by connecting adopters with animals available for adoption. The system provides adoption management, vaccination tracking, email notifications, PDF certificate generation, and admin management features.

---

## 📌 Project Overview

PawCare is a web-based Animal Adoption Management System developed using Java, JSP, Servlets, JDBC, MySQL, Bootstrap, and Apache Tomcat. The platform allows users to browse animals, submit adoption requests, track adoption status, view vaccination schedules, and download adoption certificates.

The application follows the **MVC Architecture (Model-View-Controller)** for better maintainability and scalability.

---

## 🚀 Features

### 👤 User Features
- User Registration & Login
- Browse Available Animals
- Search Animals by Type
- Submit Adoption Requests
- Track Request Status
- View Adopted Pets
- Vaccination Schedule Tracking
- Download Adoption Certificate (PDF)
- View Nearby Vaccination Centers

### 🛠️ Admin Features
- Secure Admin Login
- Add New Animals
- Edit Animal Details
- Delete Animals
- Manage Adoption Requests
- Approve / Reject Requests
- Send Email Notifications
- Monitor Animal Statistics

### 📧 Email Notifications
- Adoption Approval Emails
- Adoption Rejection Emails with Reason

### 📄 PDF Certificate Generation
- Adoption Certificate
- Pet Details
- Owner Details
- Adoption Date
- Certificate ID

### 💉 Vaccination Module
- Vaccination Schedule
- Pet-Type Specific Vaccines
- Due Age Tracking

---

## 🏗️ System Architecture

```text
User
  │
  ▼
JSP Pages (View)
  │
  ▼
Servlets (Controller)
  │
  ▼
DAO Classes (Model)
  │
  ▼
MySQL Database
```

---

## 🛠️ Technologies Used

### Frontend
- HTML5
- CSS3
- Bootstrap 5
- JavaScript
- JSP

### Backend
- Java
- Servlets
- JDBC

### Database
- MySQL

### Server
- Apache Tomcat 9

### APIs & Libraries
- JavaMail API
- iText PDF
- Google Maps API

---

## 📂 Project Structure

```text
animal-adoption-system
│
├── src/main/java
│   └── com.animaladoption
│       ├── dao
│       ├── model
│       ├── servlet
│       └── util
│
├── src/main/webapp
│   ├── images
│   ├── css
│   ├── js
│   ├── login.jsp
│   ├── register.jsp
│   ├── animal-list.jsp
│   ├── admin-dashboard.jsp
│   └── user-dashboard.jsp
│
└── pom.xml
```

---

## 🗄️ Database Tables

### Users

```sql
user_id
name
email
password
role
```

### Animals

```sql
animal_id
name
type
breed
age
gender
description
image
status
```

### Adoption Requests

```sql
request_id
user_id
animal_id
message
status
request_date
```

### Vaccination Schedule

```sql
id
animal_type
vaccine_name
age_due
```

---

## 🔄 Adoption Workflow

```text
Register/Login
       │
       ▼
Browse Animals
       │
       ▼
Submit Adoption Request
       │
       ▼
Admin Review
       │
 ┌─────┴─────┐
 ▼           ▼
Approve    Reject
 ▼           ▼
Email      Email
Sent       Sent
 ▼
Adopted Pet
 ▼
Vaccination Tracker
 ▼
Download Certificate
```

## 🔐 Security Features

- Session Management
- Role-Based Access Control
- Prepared Statements
- SQL Injection Prevention
- Secure Authentication

---

## 🤖 Future Enhancements

- AI Pet Recommendation System
- Rescue Animal Module
- Donation Module
- Appointment Booking System
- QR-Based Adoption Certificate
- Chatbot Integration
- Mobile Application
- Analytics Dashboard

---

## 🎓 Academic Information

**Project Title:** PetCare – Smart Animal Adoption System

**Domain:** Web Application Development

**Architecture:** MVC Architecture

**Database:** MySQL

**Backend:** Java Servlets

**Frontend:** JSP, Bootstrap, JavaScript

---

## 👨‍💻 Developed By

**Karthik M Katti**

Computer Science & Engineering  
S G Balekundri Institute of Technology, Belagavi



