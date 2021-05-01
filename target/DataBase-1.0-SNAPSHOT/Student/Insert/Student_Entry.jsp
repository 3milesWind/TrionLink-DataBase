<%--
  Created by IntelliJ IDEA.
  User: guoyili
  Date: 4/27/21
  Time: 1:10 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<h1 align="center">Student Entry</h1>
<form action="Student_Entry_Insert.jsp" method="post">
    Student ID: <input type="text" name="Student_Id" required/>
    <br/> <br/>
    SSN: <input type="text" name="SSN" size="8"/>
    <br/> <br/>
    First Name: <input type="text" name="First_Name" required/>
    <br/> <br/>
    Middle Name: <input type="text" name="Middle_Name" />
    <br/> <br/>
    Last Name: <input type="text" name="Last_Name" required/>
    <br/> <br/>

    Residency: <select name="Residency">
    <option>California resident</option>
    <option>Foreign</option>
    <option>Non-CA US</option>
    </select>
    <br/> <br/>
        Enrollment:  <select name="Enrollment">
        <option>Current enrolled</option>
        <option>non enrolled</option>
    </select>

    <br/> <br/>
    StudentType: <select name="StudentType">
    <option>Undergraduate</option>
    <option>Master</option>
    <option>PHD</option>
    </select>
    <br/> <br/>
    <input type="submit" value="Submit"/>
</form>
</body>
</html>
