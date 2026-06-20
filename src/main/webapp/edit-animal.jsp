<%@ page import="com.animaladoption.dao.*,com.animaladoption.model.*,java.util.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
User u = (User) session.getAttribute("user");
if(u == null || !"ADMIN".equals(u.getRole())){
    response.sendRedirect("login.jsp");
}

int id = Integer.parseInt(request.getParameter("id"));

AnimalDAO dao = new AnimalDAO();
Animal a = dao.getAnimalById(id);
%>

<!DOCTYPE html>
<html>
<head>
<title>Edit Animal</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body{
    background: linear-gradient(to right, #ffecd2, #fcb69f);
    height:100vh;
}

.form-box{
    max-width:600px;
    margin:auto;
    margin-top:50px;
    background:white;
    padding:30px;
    border-radius:15px;
    box-shadow:0 10px 20px rgba(0,0,0,0.2);
    animation: fadeIn 1s ease;
}

@keyframes fadeIn{
    from{opacity:0; transform:translateY(20px);}
    to{opacity:1; transform:translateY(0);}
}

img{
    width:100%;
    height:200px;
    object-fit:cover;
    border-radius:10px;
}
</style>

</head>

<body>

<div class="container">

<div class="form-box">

<h3 class="text-center mb-4">Edit Animal</h3>

<form action="UpdateAnimalServlet" method="post" enctype="multipart/form-data">

<input type="hidden" name="id" value="<%=a.getAnimalId()%>">

<div class="mb-3">
<label>Name</label>
<input type="text" name="name" class="form-control" value="<%=a.getName()%>" required>
</div>

<div class="mb-3">
<label>Type</label>
<input type="text" name="type" class="form-control" value="<%=a.getType()%>">
</div>

<div class="mb-3">
<label>Breed</label>
<input type="text" name="breed" class="form-control" value="<%=a.getBreed()%>">
</div>

<div class="mb-3">
<label>Age</label>
<input type="number" name="age" class="form-control" value="<%=a.getAge()%>">
</div>

<div class="mb-3">
<label>Gender</label>
<input type="text" name="gender" class="form-control" value="<%=a.getGender()%>">
</div>

<div class="mb-3">
<label>Description</label>
<textarea name="description" class="form-control"><%=a.getDescription()%></textarea>
</div>

<div class="mb-3">
<label>Current Image</label>
<img src="images/<%=a.getImage()%>">
</div>

<div class="mb-3">
<label>Change Image</label>
<input type="file" name="image" class="form-control">
</div>

<input type="hidden" name="oldImage" value="<%=a.getImage()%>">

<div class="d-flex justify-content-between">
<a href="animal-list.jsp" class="btn btn-secondary">Back</a>
<button class="btn btn-success">Update</button>
</div>

</form>

</div>

</div>

</body>
</html>