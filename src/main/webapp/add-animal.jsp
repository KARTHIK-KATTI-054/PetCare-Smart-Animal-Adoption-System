
<%@ page import="com.animaladoption.model.User" %>

<%
User u = (User) session.getAttribute("user");

if(u == null || !"ADMIN".equals(u.getRole())){
    response.sendRedirect("login.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Animal</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

<style>

body{
    background:linear-gradient(135deg,#dbeafe,#f8fafc);
    font-family:'Segoe UI';
    min-height:100vh;
}

.form-container{
    background:white;
    border-radius:25px;
    padding:40px;
    box-shadow:0 10px 30px rgba(0,0,0,0.12);
}

.page-title{
    font-size:38px;
    font-weight:bold;
    color:#0f172a;
}

.form-control,
.form-select{
    border-radius:12px;
    padding:12px;
    border:1px solid #cbd5e1;
}

.form-control:focus,
.form-select:focus{
    border-color:#2563eb;
    box-shadow:none;
}

.btn-submit{
    background:linear-gradient(45deg,#2563eb,#06b6d4);
    border:none;
    padding:14px;
    font-size:18px;
    font-weight:bold;
    border-radius:14px;
    transition:0.3s;
}

.btn-submit:hover{
    transform:translateY(-3px);
}

.preview-box{
    background:#f8fafc;
    border-radius:18px;
    padding:25px;
    text-align:center;
}

.preview-box img{
    width:100%;
    height:250px;
    object-fit:cover;
    border-radius:16px;
}

.label-title{
    font-weight:600;
    margin-bottom:8px;
    color:#334155;
}

</style>

</head>
<body>

<div class="container py-5">

    <div class="row justify-content-center align-items-center">

        <div class="col-lg-10">

            <div class="form-container">

                <div class="row align-items-center">

                    <div class="col-md-6 mb-4">

                        <h1 class="page-title mb-3">
                            <i class="fa-solid fa-paw"></i>
                            Add New Animal
                        </h1>

                        <p class="text-muted mb-4">
                            Register rescue animals and pets for adoption through PetCare.
                        </p>

                        <form
                        action="AddAnimalServlet"
                        method="post"
                        enctype="multipart/form-data"
                        >

                            <div class="mb-3">
                                <label class="label-title">Animal Name</label>
                                <input type="text" name="name" class="form-control" required>
                            </div>

                            <div class="mb-3">
                                <label class="label-title">Animal Type</label>
                                <select name="type" class="form-select" required>
                                    <option value="">Select Type</option>
                                    <option>Dog</option>
                                    <option>Cat</option>
                                    <option>Bird</option>
                                    <option>Rabbit</option>
                                    <option>Fish</option>
                                    <option>Hamster</option>
                                </select>
                            </div>

                            <div class="mb-3">
                                <label class="label-title">Breed</label>
                                <input type="text" name="breed" class="form-control" required>
                            </div>

                            <div class="row">

                                <div class="col-md-6 mb-3">
                                    <label class="label-title">Age</label>
                                    <input type="number" name="age" class="form-control" required>
                                </div>

                                <div class="col-md-6 mb-3">
                                    <label class="label-title">Gender</label>
                                    <select name="gender" class="form-select" required>
                                        <option>Male</option>
                                        <option>Female</option>
                                    </select>
                                </div>

                            </div>

                            <div class="mb-3">
                                <label class="label-title">Description</label>
                                <textarea
                                name="description"
                                class="form-control"
                                rows="4"
                                required
                                ></textarea>
                            </div>

                            <div class="mb-4">
                                <label class="label-title">Upload Animal Image</label>
                                <input type="file" name="image" class="form-control" required>
                            </div>

                            <button type="submit" class="btn btn-submit text-white w-100">
                                <i class="fa fa-plus-circle"></i>
                                Add Animal
                            </button>

                        </form>

                    </div>

                    <div class="col-md-6">

                        <div class="preview-box">

                            <img
                            src= "C:\Users\KARTHIK KATTI\Downloads\ho.png">

                            <h3 class="mt-4 text-dark">
                                Every Pet Deserves
                                a Loving Home 
                            </h3>

                            <p class="text-muted mt-3">
                                Add pets and rescue animals to help them find caring families through PawCare.
                            </p>

                            <a href="animal-list.jsp" class="btn btn-outline-primary rounded-pill px-4 mt-3">
                                <i class="fa fa-arrow-left"></i>
                                Back to Animal List
                            </a>

                        </div>

                    </div>

                </div>

            </div>

        </div>

    </div>

</div>

</body>
</html>

