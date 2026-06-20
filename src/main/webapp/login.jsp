

<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
<title>Login</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body{
    height:100vh;
    display:flex;
    justify-content:center;
    align-items:center;
    background: linear-gradient(rgba(0,0,0,0.6),rgba(0,0,0,0.6)),
    url('images/login-bg.jpg') center/cover;
}

.login-box{
    background:white;
    padding:30px;
    border-radius:15px;
    width:350px;
    box-shadow:0 10px 30px rgba(0,0,0,0.3);
    animation:fadeIn 1s ease;
}

@keyframes fadeIn{
    from{opacity:0; transform:translateY(20px);}
    to{opacity:1; transform:translateY(0);}
}
</style>

</head>

<body>

<div class="login-box">

<h3 class="text-center mb-3">Login</h3>

<%
String error = request.getParameter("error");
if("1".equals(error)){
%>
<div class="alert alert-danger text-center">
    Invalid Email or Password
</div>
<%
}
%>

<form action="LoginServlet" method="post">

<input type="email" name="email" class="form-control mb-3" placeholder="Email" required>

<input type="password" name="password" class="form-control mb-3" placeholder="Password" required>

<button class="btn btn-dark w-100">Login</button>

</form>

<div class="text-center mt-3">
<a href="register.jsp">Create Account</a>
</div>

</div>

</body>
</html>