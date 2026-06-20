
<%@ page import="java.sql.*,java.util.*,com.animaladoption.util.*,com.animaladoption.model.*" %>

<%
User u = (User) session.getAttribute("user");



if(u == null){
    response.sendRedirect("login.jsp");
    return;
}

String dashboardPage = "";

if("ADMIN".equals(u.getRole())){

    dashboardPage = "admin-dashboard.jsp";

}
else{

    dashboardPage = "user-dashboard.jsp";

}

Connection con = DBConnection.getConnection();

String type = request.getParameter("type");

PreparedStatement ps;

if(type != null && !type.equals("")){

    ps = con.prepareStatement(

    "SELECT * FROM animals " +

    "WHERE status='AVAILABLE' " +
    "AND type=? " +

    "ORDER BY animal_id DESC"

    );

    ps.setString(1, type);

}
else{

    ps = con.prepareStatement(

    "SELECT * FROM animals " +

    "WHERE status='AVAILABLE' " +

    "ORDER BY animal_id DESC"

    );

}

ResultSet rs = ps.executeQuery();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Animal List</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

<style>

body{
    background:#f4f7fb;
    font-family:'Segoe UI';
}

.navbar{
    background:linear-gradient(45deg,#0f172a,#1e293b);
}

.navbar-brand{
    color:white !important;
    font-size:24px;
    font-weight:bold;
}

.page-title{
    font-size:38px;
    font-weight:bold;
    color:#0f172a;
}

.animal-card{
    border:none;
    border-radius:20px;
    overflow:hidden;
    transition:0.3s;
    background:white;
}

.animal-card:hover{
    transform:translateY(-8px);
    box-shadow:0 15px 35px rgba(0,0,0,0.15);
}

.animal-image{
    width:100%;
    height:250px;
    object-fit:cover;
}

.badge-custom{
    background:#22c55e;
    padding:8px 14px;
    border-radius:30px;
    font-size:13px;
}

.info-text{
    color:#64748b;
    font-size:14px;
}

.btn-custom{
    border-radius:12px;
    padding:10px 18px;
    font-weight:600;
}

.card-title{
    font-weight:bold;
    color:#0f172a;
}

.top-section{
    background:white;
    border-radius:20px;
    padding:30px;
    box-shadow:0 5px 20px rgba(0,0,0,0.08);
    
    .user-welcome{

    color:white;
    background:rgba(255,255,255,0.15);

    padding:10px 18px;

    border-radius:30px;

    font-size:15px;
}
}

</style>

</head>
<body>

<nav class="navbar navbar-expand-lg">
    <div class="container">
        <a class="navbar-brand" href="#">
            <i class="fa-solid fa-paw"></i> PetCare
        </a>

     <div class="d-flex align-items-center gap-3">

    <span class="text-white fw-bold">

        <i class="fa fa-user-circle"></i>

        Welcome,
        <%=u.getName()%>

    </span>

    <a href="<%=dashboardPage%>"
    class="btn btn-light">

        <i class="fa fa-arrow-left"></i>
        Dashboard

    </a>

</div>
    </div>
</nav>

<div class="container py-5">

  <div class="row mb-4">

    <div class="col-md-6 mx-auto">

        <form method="get" action="animal-list.jsp">

            <div class="input-group shadow-sm">

                <select
                name="type"
                class="form-select">

                    <option value="">
                        All Animals
                    </option>

                    <option value="Dog">
                        Dogs
                    </option>

                    <option value="Cat">
                        Cats
                    </option>

                    <option value="Bird">
                        Birds
                    </option>

                    <option value="Rabbit">
                        Rabbits
                    </option>

             

                    <option value="Hamster">
                        Hamsters
                    </option>

                </select>

                <button class="btn btn-primary">

                    <i class="fa fa-search"></i>
                    Search

                </button>

            </div>

        </form>

    </div>

</div>

   <% if("ADMIN".equals(u.getRole())){ %>

    <!-- TOP SECTION -->

    <div class="top-section mb-5 d-flex justify-content-between align-items-center flex-wrap">

        <div>
            <h1 class="page-title">
                <i class="fa-solid fa-dog"></i>
                Animal Management
            </h1>

            <p class="text-muted mt-2">
                Manage, update and monitor all animals available for adoption.
            </p>
        </div>

       <% if("ADMIN".equals(u.getRole())){ %>

<div>
    <a href="add-animal.jsp"
    class="btn btn-success btn-lg rounded-pill px-4">

        <i class="fa fa-plus"></i>
        Add Animal

    </a>
</div>

<% } %>

    </div>

<% } %>

    <div class="row g-4">

    <% while(rs.next()){ %>

        <div class="col-md-4">

            <div class="card animal-card shadow-sm h-100">

                <img
                src="images/<%=rs.getString("image")%>"
                class="animal-image"
                >

                <div class="card-body p-4">

                    <div class="d-flex justify-content-between align-items-center mb-3">

                        <h4 class="card-title mb-0">
                            <%=rs.getString("name")%>
                        </h4>

                        <span class="badge badge-custom text-white">
                            <%=rs.getString("status")%>
                        </span>

                    </div>

                    <p class="info-text">
                        <i class="fa-solid fa-paw"></i>
                        <b>Type:</b>
                        <%=rs.getString("type")%>
                    </p>

                    <p class="info-text">
                        <i class="fa-solid fa-dna"></i>
                        <b>Breed:</b>
                        <%=rs.getString("breed")%>
                    </p>

                    <p class="info-text">
                        <i class="fa-solid fa-cake-candles"></i>
                        <b>Age:</b>
                        <%=rs.getInt("age")%> Years
                    </p>

                    <p class="info-text">
                        <i class="fa-solid fa-venus-mars"></i>
                        <b>Gender:</b>
                        <%=rs.getString("gender")%>
                    </p>

                    <p class="text-muted mt-3">
                        <%=rs.getString("description")%>
                    </p>

                </div>

                <div class="card-footer bg-white border-0 p-4">

                    <% if("ADMIN".equals(u.getRole())){ %>

<div class="d-flex gap-2">

    <a
    href="edit-animal.jsp?id=<%=rs.getInt("animal_id")%>"
    class="btn btn-warning btn-custom w-100"
    >
        Edit
    </a>

    <a
    href="DeleteAnimalServlet?id=<%=rs.getInt("animal_id")%>"
    class="btn btn-danger btn-custom w-100"
    >
        Delete
    </a>

</div>

<% } else { %>

<a
href="animal-details.jsp?id=<%=rs.getInt("animal_id")%>"
class="btn btn-primary w-100 btn-custom"
>
    View Details
</a>

<% } %>

                </div>

            </div>

        </div>

    <% } %>

    </div>

</div>

</body>
</html>

