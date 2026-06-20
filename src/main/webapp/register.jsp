<html>
<head>
<title>Register</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body{
    background: linear-gradient(120deg,#84fab0,#8fd3f4);
}

.card{
    border-radius:15px;
}
</style>

</head>

<body>

<div class="container d-flex justify-content-center align-items-center" style="height:100vh;">

<div class="card p-4 shadow" style="width:400px;">

<h3 class="text-center">Register</h3>

<form action="RegisterServlet" method="post">

<input type="text" name="name" class="form-control mb-3" placeholder="Name" required>
<input type="email" name="email" class="form-control mb-3" placeholder="Email" required>
<input type="password" name="password" class="form-control mb-3" placeholder="Password" required>

<button class="btn btn-primary w-100">Register</button>

</form>

<br>
<a href="login.jsp" class="text-center">Already have account?</a>

</div>

</div>

</body>
</html>