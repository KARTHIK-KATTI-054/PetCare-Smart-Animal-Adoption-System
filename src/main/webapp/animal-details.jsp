<%@ page import="com.animaladoption.dao.*,com.animaladoption.model.*" %>

<%
String idStr = request.getParameter("id");
Animal a = null;

if(idStr != null){
    int id = Integer.parseInt(idStr);

    AnimalDAO dao = new AnimalDAO();
    a = dao.getAnimalById(id);
}
%>



<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Animal Details</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body{
    background:#f5f7fb;
}

/* Card */
.details-card{
    border-radius:15px;
    overflow:hidden;
    box-shadow:0 10px 25px rgba(0,0,0,0.1);
}

/* Image */
.animal-img{
    width:100%;
    height:400px;
    object-fit:cover;
}

/* Title */
.title{
    font-weight:700;
}

/* Badge */
.badge{
    font-size:14px;
    padding:6px 12px;
}

/* Button */
.btn-adopt{
    border-radius:10px;
    padding:10px;
    font-weight:600;
}
</style>

</head>

<body>

<!-- NAVBAR -->
<nav class="navbar navbar-dark bg-dark px-4">
    <a href="animal-list.jsp" class="navbar-brand"> Animal Adoption</a>

    <div>
        <a href="animal-list.jsp" class="btn btn-light me-2">Back</a>
        <a href="logout.jsp" class="btn btn-danger">Logout</a>
    </div>
</nav>

<div class="container mt-5">

<% if(a == null){ %>

    <!-- NOT FOUND -->
    <div class="text-center">
        <h2 class="text-danger">*Animal Not Found*</h2>
        <a href="animal-list.jsp" class="btn btn-primary mt-3">Go Back</a>
    </div>

<% } else { %>

<div class="row justify-content-center">

<div class="col-lg-10">

<div class="card details-card">

<div class="row g-0">

    <!-- IMAGE -->
    <div class="col-md-6">
        <img src="images/<%=a.getImage()%>" class="animal-img">
    </div>

    <!-- DETAILS -->
    <div class="col-md-6 p-4">

        <h2 class="title mb-3"><%=a.getName()%></h2>

        <!-- STATUS -->
        <% if("AVAILABLE".equals(a.getStatus())){ %>
            <span class="badge bg-success mb-3">Available</span>
        <% } else { %>
            <span class="badge bg-danger mb-3">Adopted</span>
        <% } %>

        <p><b>Type:</b> <%=a.getType()%></p>
        <p><b>Breed:</b> <%=a.getBreed()%></p>
        <p><b>Age:</b> <%=a.getAge()%></p>
        <p><b>Gender:</b> <%=a.getGender()%></p>

        <p><b>Description:</b><br>
        <%=a.getDescription()%></p>
        <% if("AVAILABLE".equals(a.getStatus())){ %>

   

<% } else { %>

    <button class="btn btn-danger w-100 mt-4" disabled>
        Already Adopted
    </button>

<% } %>

        <hr>

        <!-- ADOPT SECTION -->
        <% 
        User u = (User) session.getAttribute("user");
        %>

        <% if(u != null && !"ADMIN".equals(u.getRole())){ %>

            <% if("AVAILABLE".equals(a.getStatus())){ %>

                <form action="AdoptServlet" method="post">
                    <input type="hidden" name="animalId" value="<%=a.getAnimalId()%>">

                    <input type="text" name="message"
                           class="form-control mb-3"
                           placeholder="Why do you want this pet?" >

                    <button class="btn btn-primary w-100 btn-adopt">
                        Adopt Now 
                    </button>
                </form>

            <% } else { %>

                <button class="btn btn-danger w-100 btn-adopt" disabled>
                    Already Adopted
                </button>

            <% } %>

        <% } else { %>

            <a href="login.jsp" class="btn btn-warning w-100 btn-adopt">
                Login to Adopt 
            </a>

        <% } %>

    </div>

</div>

</div>

</div>

</div>

<% } %>

</div>

</body>
</html>