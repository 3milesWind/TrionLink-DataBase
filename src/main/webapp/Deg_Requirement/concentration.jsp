<%--
  Created by IntelliJ IDEA.
  User: guoyili
  Date: 5/2/21
  Time: 2:58 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<h3 align="center">Fill in the department requirement</h3>
<form action="concentration_insert.jsp" method="post">
    concentration name:
    <input  type="text" name="concentration_name"/>
    <br/> <br/>
    Degree Name:
    <select name="degreeName">
        <option>B.S.</option>
        <option>B.A.</option>
        <option>M.S</option>
        <option>M.A</option>
        <option>Phd</option>
    </select>
    Type: <select name="Type">
    <option>Computer Science</option>
    <option>Philosophy</option>
    <option>Mechanical Engineering</option>
    </select>
    <br/> <br/>
    Courses: <input  type="text" name="courses"/>
    <p style="font-size:10px">Example: "CSE132A,CSE132B,CSE232A"</p>
    elective: <input  type="text" name="elective"/>
    <p style="font-size:10px">Example: "CSE132A,CSE132B,CSE232A"</p>
    </select>
    minGPA: <input type="number" name="minGPA" />
    <br/><br/>
    minUnit: <input type="number" name="minUnit" />
    <br/>
    <input type="submit" value="Submit">
</select>
</form>
</body>
</html>
