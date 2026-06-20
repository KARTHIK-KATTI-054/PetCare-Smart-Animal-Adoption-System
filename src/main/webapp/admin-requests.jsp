<%@ page import="java.sql.*,com.animaladoption.util.*" %>

<%
Connection con = DBConnection.getConnection();

String sql = "SELECT ar.request_id, u.name, a.name AS animal, ar.status " +
             "FROM adoption_requests ar " +
             "JOIN users u ON ar.user_id=u.user_id " +
             "JOIN animals a ON ar.animal_id=a.animal_id";

PreparedStatement ps = con.prepareStatement(sql);
ResultSet rs = ps.executeQuery();
%>

<html>
<head>
<title>Requests</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<nav class="navbar navbar-dark bg-dark">
<div class="container">
<span class="navbar-brand">Adoption Requests</span>
<a href="admin-dashboard.jsp" class="btn btn-light"> Back</a>
</div>
</nav>
</head>

<body>

<div class="container mt-5">

<h2>Adoption Requests</h2>

<table class="table table-bordered">

<tr>
<th>User</th>
<th>Animal</th>
<th>Status</th>
<th>Action</th>
</tr>

<%
while(rs.next()){
%>

<tr>
<td><%=rs.getString("name")%></td>
<td><%=rs.getString("animal")%></td>
<td><%=rs.getString("status")%></td>

<td>


   <a href="ApproveServlet?id=<%=rs.getInt("request_id")%>" 
   class="btn btn-success btn-sm">
   Approve
</a>

<button class="btn btn-danger btn-sm"
data-bs-toggle="modal"
data-bs-target="#rejectModal<%=rs.getInt("request_id")%>">
Reject
</button>

<!-- REJECT MODAL -->
<div class="modal fade"
id="rejectModal<%=rs.getInt("request_id")%>">

<div class="modal-dialog">

<div class="modal-content">

<form action="RejectServlet" method="post">

    <input type="hidden"
           name="requestId"
           value="<%=rs.getInt("request_id")%>">

    <input type="text"
           name="reason"
           class="form-control mb-2"
           placeholder="Reject reason"
           required>

    <button class="btn btn-danger btn-sm">
        Reject
    </button>

</form>

</div>
</div>
</div>

   

</td>
</tr>

<%
}
%>

</table>

</div>

<script src=
"https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js">
</script>

</body>
</html>