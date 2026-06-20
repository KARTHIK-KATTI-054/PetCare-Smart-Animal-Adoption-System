<%@ page import="java.util.*,com.animaladoption.dao.*,com.animaladoption.model.*" %>

<html>
<head>
    <title>Animal List</title>
</head>
<body>

<h2>Available Animals</h2>

<table border="1">
<tr>
    <th>Name</th>
    <th>Type</th>
    <th>Breed</th>
    <th>Age</th>
    <th>Gender</th>
</tr>

<%
AnimalDAO dao = new AnimalDAO();
List<Animal> list = dao.getAllAnimals();

for(Animal a : list){
%>

<tr>
    <td><%= a.getName() %></td>
    <td><%= a.getType() %></td>
    <td><%= a.getBreed() %></td>
    <td><%= a.getAge() %></td>
    <td><%= a.getGender() %></td>
</tr>

<%
}
%>

</table>

</body>
</html>