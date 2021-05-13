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
        <option>B.S.</option>
        <option>B.A.</option>
        <option>M.S</option>
        <option>M.A</option>
        <option>Phd</option>
    </select>
    <br/> <br/>
    Type: <select name="Type">
    <option>Computer Science</option>
    <option>Philosophy</option>
    <option>Mechanical Engineering</option>
    </select>
    department: <select name="department">
    <option>CSE</option>
    <option>Math</option>
    <option>Science</option>
    </select>

<%--    <br/> <br/>--%>
<%--    Total Unit: <input type="number" name="Units" min="20">--%>
    <br/> <br/>
    Lower Division Unit: <input type="number" name="lowerDivisonUnit" min="0">
    <br/> <br/>
    Upper Division Unit: <input type="number" name="UpperDivisionUnit" min="0">
    <br/> <br/>
    Elective Unit: <input type="number" name="ElectiveUnit" min="0">
    <br/> <br/>

    <input type="submit" value="Submit">
</form>
</body>
</html>
