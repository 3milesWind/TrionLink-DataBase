<%--
  Created by IntelliJ IDEA.
  User: guoyili
  Date: 5/1/21
  Time: 12:06 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form action="Thesis_Committee_insert.jsp" method="post">
    Student ID: <input type="text" name="Student_Id" required/>
    <br/> <br/>
    Student Program:
    <select name="Program">
    <option>Master</option>
    <option>PHD</option>
    </select>
    <br/> <br/>
    Faculty First Name: <input type="text" name="First_Name" required/>
    <br/> <br/>
    Faculty Middle Name: <input type="text" name="Middle_Name" />
    <br/> <br/>
    Faculty Last Name: <input type="text" name="Last_Name" required/>
    <br/> <br/>

    Department: <select name="Department">
    <option>CSE</option>
    <option>Math</option>
    <option>Art</option>
    <option>Science</option>
    </select>

</select>
    <br/> <br/>
    <input type="submit" value="Submit"/>
</form>
</body>
</html>
