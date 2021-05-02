<%--
  Created by IntelliJ IDEA.
  User: guoyili
  Date: 5/2/21
  Time: 2:31 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<h3 align="center">Create Degree requirement</h3>
<form action="Degree_insert.jsp" method="post">
    Degree Name:
    <select name="degreeName">
        <option>UnderGraduate_Degree</option>
        <option>Master_Degree</option>
        <option>PHD_Degree</option>
    </select>
    <br/> <br/>
    Type: <select name="Type">
    <option>BS</option>
    <option>BA</option>
    <option>BS/MS</option>
    </select>
    <br/> <br/>
    Total Unit: <input type="number" name="Units" min="180">
    <br/> <br/>
    <input type="submit" value="Submit">
</form>
</body>
</html>
