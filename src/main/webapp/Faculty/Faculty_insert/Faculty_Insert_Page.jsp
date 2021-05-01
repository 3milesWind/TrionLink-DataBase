<%--
  Created by IntelliJ IDEA.
  User: guoyili
  Date: 4/30/21
  Time: 1:52 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<h1 align="center">Faculty Insert Entry</h1>
<form action="Faculty_Entry_Insert.jsp" method="post">
    First Name: <input type="text" name="First_Name" required/>
    <br/> <br/>
    Middle Name: <input type="text" name="Middle_Name" />
    <br/> <br/>
    Last Name: <input type="text" name="Last_Name" required/>
    <br/> <br/>
    Title: <select name="title">
    <option>Lecturer</option>
    <option>Assistant Professor</option>
    <option>Associate Professor</option>
    <option>Professor</option>
    </select>
    <br/> <br/>
    Department: <select name="Department">
    <option>CSE</option>
    <option>Math</option>
    <option>Art</option>
    <option>Science</option>
</select>


    <br/> <br/>
    <input type="submit" value="Submit"/>
</form>
</body>
</html>
