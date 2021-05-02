<%--
  Created by IntelliJ IDEA.
  User: AmberWang
  Date: 2021/5/2
  Time: 上午 03:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Course Insertion</title>
</head>
<body>
<h1 align="center">Faculty Insert Entry</h1>
<form action="Course_Entry_Insert.jsp" method="post">
    Course ID: <input type="text" name="CourseID" required/>
    <br/> <br/>
    Course Name: <input type="text" name="CourseName" required/>
    <br/> <br/>
    Department: <select name="Department">
    <option>CSE</option>
    <option>Math</option>
    <option>Art</option>
    <option>Science</option>
    </select>
    <br/> <br/>
    Prerequisites: <input type="text" name="Prerequisites"/>
    <br/> <br/>
    Grade Option: <select name="GradeOption" required>
    <option>P/NP</option>
    <option>Letter</option>
    <option>P/NP or Letter</option>
    </select>
    <br/> <br/>
    Lab: <select name="Lab" required>
    <option>Yes</option>
    <option>No</option>
    </select>
    <br/> <br/>
    Min. Units: <input type="text" name="MinUnits" required/>
    <br/> <br/>
    Max. Units: <input type="text" name="MaxUnits" required/>
    <br/> <br/>
    <input type="submit" value="Submit"/>
</form>
</body>
</html>
