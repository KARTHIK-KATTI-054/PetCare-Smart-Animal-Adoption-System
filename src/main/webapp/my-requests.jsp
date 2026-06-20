<%@ page import="java.sql.*,com.animaladoption.util.*,com.animaladoption.model.*" %>

<%
User u = (User) session.getAttribute("user");

if(u == null){
    response.sendRedirect("login.jsp");
}
%>

<html>
<head>
<title>My Requests</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body {
    background: url('images/bg.jpg') no-repeat center center fixed;
    background-size: cover;
}
</style>

</head>

<body>

<!-- NAVBAR -->
<nav class="navbar navbar-dark bg-dark">
    <div class="container">
        <span class="navbar-brand">My Requests</span>
        <a href="animal-list.jsp" class="btn btn-light"> Back</a>
    </div>
</nav>

<div class="container mt-5">

<div class="card shadow">
<div class="card-body">

<h4 class="text-center mb-4">My Adoption Requests</h4>

<table class="table table-bordered text-center">

<tr class="table-dark">
    <th>Animal</th>
    <th>Message</th>
    <th>Status</th>
</tr>

<%
Connection con = DBConnection.getConnection();

String sql = "SELECT a.name, ar.message, ar.status " +
             "FROM adoption_requests ar " +
             "JOIN animals a ON ar.animal_id = a.animal_id " +
             "WHERE ar.user_id=?";

PreparedStatement ps = con.prepareStatement(sql);
ps.setInt(1, u.getUserId());

ResultSet rs = ps.executeQuery();

while(rs.next()){
%>

<tr>
    <td><%= rs.getString("name") %></td>
    <td><%= rs.getString("message") %></td>

    <td>
        <% String status = rs.getString("status"); %>

        <% if("PENDING".equals(status)){ %>
            <span class="badge bg-warning text-dark">PENDING</span>
        <% } else if("APPROVED".equals(status)){ %>
            <span class="badge bg-success">APPROVED</span>
        <% } else { %>
            <span class="badge bg-danger">REJECTED</span>
        <% } %>
    </td>
</tr>

<%
}
%>

</table>

</div>
</div>

</div>

</body>
</html>