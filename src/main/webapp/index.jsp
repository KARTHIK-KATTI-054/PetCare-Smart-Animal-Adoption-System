<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>Animal Adoption</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body {
    background: #f5f7fb;
}

/* Navbar */
.navbar {
    background: linear-gradient(45deg, #0d6efd, #6610f2);
}

/* Hero */
.hero {
    min-height: 90vh;
    display: flex;
    align-items: center;
}

.hero h1 {
    font-size: 48px;
    font-weight: bold;
}

.hero p {
    color: #555;
}

/* Buttons */
.btn-main {
    padding: 10px 25px;
    border-radius: 25px;
}

/* About */
.about {
    margin-top: 60px;
}

/* Category Cards */
.category-card {
    background: #fff;
    padding: 20px;
    border-radius: 15px;
    transition: 0.3s;
    cursor: pointer;
}

.category-card img {
    width: 80px;
    margin-bottom: 10px;
    transition: 0.3s;
}

.category-card:hover {
    transform: translateY(-8px);
    box-shadow: 0 12px 25px rgba(0,0,0,0.15);
}

.category-card:hover img {
    transform: scale(1.2) rotate(5deg);
}

/* Rescue */
.rescue-section {
    background: #ffffff;
    padding: 60px 20px;
}

.rescue-card {
    padding: 20px;
    border-radius: 12px;
    transition: 0.3s;
}

.rescue-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 10px 25px rgba(0,0,0,0.1);
}

/* Footer */
footer {
    margin-top: 40px;
}
</style>

</head>

<body>

<!-- NAVBAR -->
<nav class="navbar navbar-dark px-4">
    <span class="navbar-brand"> Animal Adoption</span>

    <div>
        <a href="login.jsp" class="btn btn-light me-2">Login</a>
        <a href="register.jsp" class="btn btn-warning">Register</a>
    </div>
</nav>

<!-- HERO -->
<div class="container hero">
    <div class="row w-100 align-items-center">

        <div class="col-md-6">
            <h1>Let’s Help Together 🐾</h1>
            <p>
                Give a loving home to animals in need.  
                Adopt, care, and make a difference today.
            </p>

            <a href="animal-list.jsp" class="btn btn-primary btn-main me-3">
                Browse Animals
            </a>

            <a href="register.jsp" class="btn btn-outline-dark btn-main">
                Get Started
            </a>
        </div>

        <div class="col-md-6 text-center">
            <img src="images/home.png" width="400">
        </div>

    </div>
</div>

<!-- ABOUT -->
<div class="container text-center about">
    <h2>About Animal Adoption</h2>
    <p class="text-muted w-75 mx-auto">
        Animal adoption gives abandoned pets a second chance at life. 
        It reduces shelter overcrowding and brings joy to families. 
        By adopting, you’re not just getting a pet—you’re saving a life.
    </p>
</div>

<!-- CATEGORIES -->
<div class="container mt-5 text-center">
    <h2 class="mb-4">Explore Categories</h2>

    <div class="row">

       <div class="col-md-3">
    <a href="animal-list.jsp?type=Dog" class="text-decoration-none">

        <div class="category-card text-center p-3 shadow-sm">

            <img src="<%=request.getContextPath()%>/images/dog.png"
                 style="width:80px; height:80px; object-fit:contain;">

            <h5 class="mt-2">Dogs</h5>

        </div>

    </a>
</div>

       <div class="col-md-3">
    <a href="animal-list.jsp?type=Dog" class="text-decoration-none">

        <div class="category-card text-center p-3 shadow-sm">

            <img src="<%=request.getContextPath()%>/images/cat.png"
                 style="width:80px; height:80px; object-fit:contain;">

            <h5 class="mt-2">Cats</h5>

        </div>

    </a>
</div>

       <div class="col-md-3">
    <a href="animal-list.jsp?type=Dog" class="text-decoration-none">

        <div class="category-card text-center p-3 shadow-sm">

            <img src="<%=request.getContextPath()%>/images/bird.png"
                 style="width:80px; height:80px; object-fit:contain;">

            <h5 class="mt-2">Birds</h5>

        </div>

    </a>
</div>

        <div class="col-md-3">
    <a href="animal-list.jsp?type=Dog" class="text-decoration-none">

        <div class="category-card text-center p-3 shadow-sm">

            <img src="<%=request.getContextPath()%>/images/rabbit.png"
                 style="width:80px; height:80px; object-fit:contain;">

            <h5 class="mt-2">Small Pets</h5>

        </div>

    </a>
</div>

    </div>
</div>

<!-- RESCUE -->
<div class="rescue-section text-center mt-5">

    <h2 class="mb-4">🐾 How to Rescue Animals</h2>
    <p class="text-muted mb-5">
        Follow these simple steps to help animals in need.
    </p>

    <div class="container">
        <div class="row">

            <div class="col-md-4">
                <div class="rescue-card">
                    <h5>📍 Identify</h5>
                    <p>Find injured or abandoned animals.</p>
                </div>
            </div>

            <div class="col-md-4">
                <div class="rescue-card">
                    <h5>📞 Contact</h5>
                    <p>Reach local shelters or rescue teams.</p>
                </div>
            </div>

            <div class="col-md-4">
                <div class="rescue-card">
                    <h5>🏡 Provide Care</h5>
                    <p>Offer food, shelter, and medical help.</p>
                </div>
            </div>

        </div>
    </div>

</div>

<!-- FOOTER -->
<footer class="text-center p-3 bg-dark text-light">
    © 2026 Animal Adoption | Made with ❤️
</footer>

</body>
</html>