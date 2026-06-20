<%@ page import="java.sql.*,com.animaladoption.util.*,com.animaladoption.model.*" %>

<%
User u = (User) session.getAttribute("user");

if(u == null || !"ADMIN".equals(u.getRole())){
    response.sendRedirect("login.jsp");
    return;
}

int animals = 0;
int users = 0;
int requests = 0;

try{
    Connection con = DBConnection.getConnection();

    ResultSet rs1 = con.createStatement().executeQuery("SELECT COUNT(*) FROM animals");
    if(rs1.next()) animals = rs1.getInt(1);

    ResultSet rs2 = con.createStatement().executeQuery("SELECT COUNT(*) FROM users");
    if(rs2.next()) users = rs2.getInt(1);

    ResultSet rs3 = con.createStatement().executeQuery("SELECT COUNT(*) FROM adoption_requests");
    if(rs3.next()) requests = rs3.getInt(1);

}catch(Exception e){
    e.printStackTrace();
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Admin Dashboard</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- ICONS -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

<style>
body{
    margin:0;
    font-family:'Segoe UI';
    background:#f4f6f9;
}

/* SIDEBAR */
.sidebar{
    width:240px;
    height:100vh;
    position:fixed;
    background:#111;
    color:white;
    padding-top:20px;
}

.sidebar h4{
    text-align:center;
    margin-bottom:30px;
}

.sidebar a{
    display:block;
    padding:12px 20px;
    color:#ccc;
    text-decoration:none;
    transition:0.3s;
}

.sidebar a:hover{
    background:#007bff;
    color:white;
}

/* MAIN */
.main{
    margin-left:240px;
    padding:20px;
}

/* HEADER */
.header{
    display:flex;
    justify-content:space-between;
    align-items:center;
    margin-bottom:20px;
}

/* CARDS */
.stat-card{
    border-radius:15px;
    padding:20px;
    color:white;
    transition:0.3s;
}

.stat-card:hover{
    transform:translateY(-5px);
}

.bg1{ background:linear-gradient(45deg,#007bff,#00c6ff); }
.bg2{ background:linear-gradient(45deg,#28a745,#85e085); }
.bg3{ background:linear-gradient(45deg,#ffc107,#ffdd57); }

/* ACTION CARDS */
.action-card{
    border-radius:15px;
    padding:20px;
    background:white;
    transition:0.3s;
}

.action-card:hover{
    transform:scale(1.03);
    box-shadow:0 10px 25px rgba(0,0,0,0.1);
}
</style>

</head>

<body>

<!-- SIDEBAR -->
<div class="sidebar">
    <h4>Admin</h4>

    <a href="admin-dashboard.jsp"><i class="fa fa-home"></i> Dashboard</a>
    <a href="animal-list.jsp"><i class="fa fa-paw"></i> Animals</a>
    <a href="admin-requests.jsp"><i class="fa fa-list"></i> Requests</a>
    <a href="add-animal.jsp"><i class="fa fa-plus"></i> Add Animal</a>
    <a href="logout.jsp"><i class="fa fa-sign-out"></i> Logout</a>
</div>

<!-- MAIN CONTENT -->
<div class="main">

    <!-- HEADER -->
    <div class="header">
        <h3>Dashboard Overview</h3>
        <span>Welcome, Admin</span>
    </div>

    <!-- STATS -->
    <div class="row">

        <div class="col-md-4 mb-3">
            <div class="stat-card bg1 shadow">
                <h5><i class="fa fa-paw"></i> Animals</h5>
                <h2><%=animals%></h2>
            </div>
        </div>

        <div class="col-md-4 mb-3">
            <div class="stat-card bg2 shadow">
                <h5><i class="fa fa-users"></i> Users</h5>
                <h2><%=users%></h2>
            </div>
        </div>

        <div class="col-md-4 mb-3">
            <div class="stat-card bg3 shadow">
                <h5><i class="fa fa-file"></i> Requests</h5>
                <h2><%=requests%></h2>
            </div>
        </div>

    </div>

    <!-- ACTION SECTION -->
    <div class="row mt-4">

        <div class="col-md-4 mb-3">
            <div class="action-card text-center">
                <h5>Manage Animals</h5>
                <p>Add, edit, delete pets</p>
                <a href="animal-list.jsp" class="btn btn-primary">Go</a>
            </div>
        </div>

        <div class="col-md-4 mb-3">
            <div class="action-card text-center">
                <h5>View Requests</h5>
                <p>Approve or reject adoption</p>
                <a href="admin-requests.jsp" class="btn btn-warning">View</a>
            </div>
        </div>

        <div class="col-md-4 mb-3">
            <div class="action-card text-center">
                <h5>Add Animal</h5>
                <p>Register new animal</p>
                <a href="add-animal.jsp" class="btn btn-success">Add</a>
            </div>
        </div>

    </div>

</div>

</body>
</html>