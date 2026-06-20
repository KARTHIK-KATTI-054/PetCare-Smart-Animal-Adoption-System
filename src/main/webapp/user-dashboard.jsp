<%@ page import="java.sql.*,java.util.*,com.animaladoption.util.*,com.animaladoption.model.*,com.animaladoption.dao.*" %>

<%
User u = (User) session.getAttribute("user");

if(u == null){
    response.sendRedirect("login.jsp");
    return;
}

Connection con = DBConnection.getConnection();

AnimalDAO dao = new AnimalDAO();


// ===============================
// DASHBOARD STATS
// ===============================

PreparedStatement ps1 = con.prepareStatement(
    "SELECT COUNT(*) FROM adoption_requests WHERE user_id=?");

ps1.setInt(1, u.getUserId());

ResultSet rs1 = ps1.executeQuery();

rs1.next();

int total = rs1.getInt(1);


// APPROVED

PreparedStatement ps2 = con.prepareStatement(
    "SELECT COUNT(*) FROM adoption_requests WHERE user_id=? AND status='APPROVED'");

ps2.setInt(1, u.getUserId());

ResultSet rs2 = ps2.executeQuery();

rs2.next();

int approved = rs2.getInt(1);


// PENDING

PreparedStatement ps3 = con.prepareStatement(
    "SELECT COUNT(*) FROM adoption_requests WHERE user_id=? AND status='PENDING'");

ps3.setInt(1, u.getUserId());

ResultSet rs3 = ps3.executeQuery();

rs3.next();

int pending = rs3.getInt(1);


// ===============================
// MY REQUESTS
// ===============================

PreparedStatement ps4 = con.prepareStatement(
    "SELECT ar.*, a.name, a.image FROM adoption_requests ar " +
    "JOIN animals a ON ar.animal_id = a.animal_id " +
    "WHERE ar.user_id=? ORDER BY ar.request_date DESC");

ps4.setInt(1, u.getUserId());

ResultSet rs = ps4.executeQuery();


// ===============================
// VACCINATION SCHEDULE
// ===============================

PreparedStatement psVac = con.prepareStatement(
    "SELECT DISTINCT vs.* FROM vaccination_schedule vs " +
    "JOIN animals a ON vs.animal_type = a.type " +
    "JOIN adoption_requests ar ON ar.animal_id = a.animal_id " +
    "WHERE ar.user_id=? AND ar.status='APPROVED'"
);

psVac.setInt(1, u.getUserId());

ResultSet rsVac = psVac.executeQuery();


// ===============================
// ADOPTED PETS
// ===============================

PreparedStatement psAdopted = con.prepareStatement(
    "SELECT a.* FROM animals a " +
    "JOIN adoption_requests ar ON a.animal_id = ar.animal_id " +
    "WHERE ar.user_id=? AND ar.status='APPROVED'"
);

psAdopted.setInt(1, u.getUserId());

ResultSet rsAdopted = psAdopted.executeQuery();

boolean hasApprovedPet = (approved > 0);

%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<title>User Dashboard</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<style>

body{
    background:#f5f7fb;
}

.card{
    border-radius:12px;
}

.stat{
    font-size:24px;
    font-weight:bold;
}

.pet-img{
    width:60px;
    height:60px;
    object-fit:cover;
    border-radius:8px;
}

</style>

</head>

<body>

<!-- NAVBAR -->

<nav class="navbar navbar-dark bg-dark px-4">

    <span class="navbar-brand">
        Welcome, <%=u.getName()%>
    </span>

    <div>

        <a href="animal-list.jsp" class="btn btn-light me-2">
            Browse Animals
        </a>

        <a href="vaccination-centers.jsp"
           class="btn btn-success me-2">
            Vaccination Centers
        </a>

        <a href="logout.jsp" class="btn btn-danger">
            Logout
        </a>

    </div>

</nav>


<div class="container mt-4">


<!-- STATS -->

<div class="row text-center mb-4">

    <div class="col-md-4">
        <div class="card shadow p-3">
            <div>Total Requests</div>
            <div class="stat text-primary"><%=total%></div>
        </div>
    </div>

    <div class="col-md-4">
        <div class="card shadow p-3">
            <div>Approved</div>
            <div class="stat text-success"><%=approved%></div>
        </div>
    </div>

    <div class="col-md-4">
        <div class="card shadow p-3">
            <div>Pending</div>
            <div class="stat text-warning"><%=pending%></div>
        </div>
    </div>

</div>



<!-- MY REQUESTS -->

<div class="card shadow mb-4">

    <div class="card-header bg-dark text-white">
        <h5>My Adoption Requests</h5>
    </div>

    <div class="card-body">

        <table class="table table-bordered table-hover text-center">

            <tr>
                <th>Animal</th>
                <th>Name</th>
                <th>Message</th>
                <th>Status</th>
            </tr>

            <% while(rs.next()){ %>

            <tr>

                <td>
                    <img src="images/<%=rs.getString("image")%>" class="pet-img">
                </td>

                <td>
                    <%=rs.getString("name")%>
                </td>

                <td>
                    <%=rs.getString("message")%>
                </td>

                <td>

                    <%
                    String status = rs.getString("status");

                    if("APPROVED".equals(status)){
                    %>

                        <span class="badge bg-success">
                            Approved
                        </span>

                    <% } else if("REJECTED".equals(status)){ %>

                        <span class="badge bg-danger">
                            Rejected
                        </span>

                    <% } else { %>

                        <span class="badge bg-warning text-dark">
                            Pending
                        </span>

                    <% } %>

                </td>

            </tr>

            <% } %>

        </table>

    </div>

</div>



<!-- VACCINATION SECTION -->

<% if(hasApprovedPet){ %>

<div class="card shadow mb-4">

    <div class="card-header bg-success text-white">
        <h5>Your Vaccination Schedule</h5>
    </div>

    <div class="card-body">

        <table class="table table-bordered text-center">

            <tr>
                <th>Animal Type</th>
                <th>Vaccine</th>
                <th>Recommended Age</th>
            </tr>

            <%
            boolean vaccineFound = false;

            while(rsVac.next()){

                vaccineFound = true;
            %>

            <tr>

                <td><%=rsVac.getString("animal_type")%></td>

                <td><%=rsVac.getString("vaccine_name")%></td>

                <td>
                    Recommended at
                    <%=rsVac.getString("age_due")%>
                </td>

            </tr>

            <% } %>

            <% if(!vaccineFound){ %>

            <tr>

                <td colspan="3" class="text-muted">
                    No vaccination schedule available
                </td>

            </tr>

            <% } %>

        </table>


        <div class="alert alert-warning mt-3">

            !Remember to vaccinate your pet before the next due date.

        </div>

    </div>

</div>

<% } %>



<!-- MY ADOPTED PETS -->

<div class="card shadow mb-5">

    <div class="card-header bg-primary text-white">
        <h5>My Adopted Pets</h5>
    </div>

    <div class="card-body">

        <table class="table table-bordered text-center">

            <tr>
                <th>Animal</th>
                <th>Name</th>
                <th>Type</th>
                <th>Status</th>
                <th>Certificate</th>
            </tr>

            <%
            boolean hasPets = false;

            while(rsAdopted.next()){

                hasPets = true;
            %>

            <tr>

                <td>
                    <img src="images/<%=rsAdopted.getString("image")%>"
                         class="pet-img">
                </td>

                <td>
                    <%=rsAdopted.getString("name")%>
                </td>

                <td>
                    <%=rsAdopted.getString("type")%>
                </td>
                 
                <td>
                    <span class="badge bg-success">
                        Adopted
                    </span>
                </td>
                
                <!-- it is for Download pdf -->
                <td>

    <a href="DownloadCertificateServlet?animalId=<%=rsAdopted.getInt("animal_id")%>"
       class="btn btn-danger btn-sm">

       Download PDF

    </a>

</td>

            </tr>

            <% } %>

            <% if(!hasPets){ %>

            <tr>

                <td colspan="4" class="text-center text-muted">
                    No adopted pets yet
                </td>

            </tr>

            <% } %>

        </table>

    </div>

</div>

</div>

</body>
</html>