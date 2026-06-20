<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>Nearby Vaccination Centers</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<style>

body{
    background:#f5f7fb;
}

.map-container{
    width:100%;
    height:500px;
    border-radius:15px;
    overflow:hidden;
    box-shadow:0 5px 20px rgba(0,0,0,0.2);
}

.hero{
    background:linear-gradient(45deg,#198754,#20c997);
    color:white;
    padding:40px;
    border-radius:15px;
}

</style>

</head>

<body>

<div class="container mt-5">
   
   <div class="mb-3">

    <a href="user-dashboard.jsp"
       class="btn btn-dark">

       Back to Dashboard

    </a>

</div>

    <!-- HEADER -->

    <div class="hero text-center mb-4">

        <h1> Nearby Vaccination Centers</h1>

        <p>
            Find nearby pet hospitals, vet clinics,
            and vaccination centers near your location.
        </p>

        <button class="btn btn-light btn-lg mt-3"
                onclick="findCenters()">

            Find Nearby Centers

        </button>

    </div>

    <!-- MAP -->

    <div class="map-container">

        <iframe
            id="mapFrame"
            width="100%"
            height="100%"
            style="border:0;"
            loading="lazy"
            allowfullscreen>
        </iframe>

    </div>

</div>


<script>

function findCenters(){

    if(navigator.geolocation){

        navigator.geolocation.getCurrentPosition(

            function(position){

                let lat = position.coords.latitude;
                let lng = position.coords.longitude;

                // REAL GOOGLE MAPS SEARCH
                let url =
                "https://www.google.com/maps/search/veterinary+clinic/@"
                + lat + "," + lng + ",15z";

                // OPEN NEW TAB
                window.open(url, "_blank");

            },

            function(error){

                alert("Location access denied or unavailable.");

            }

        );

    }else{

        alert("Geolocation is not supported.");

    }

}

</script>

</body>
</html>