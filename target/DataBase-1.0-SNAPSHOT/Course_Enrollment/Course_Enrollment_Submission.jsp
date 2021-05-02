<%--
  Created by IntelliJ IDEA.
  User: AmberWang
  Date: 2021/5/2
  Time: 下午 12:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Course Enrollment Submission</title>
</head>
<body>
<h1 align="center">Course Enrollment Submission</h1>
<form action="Course_Enrollment_Insert.jsp" method="post">
    <br/> <br/>
    Student ID: <input type="text" name="StudentID" required/>
    <br/> <br/>
    Course ID: <input type="text" name="CourseID" required/>
    <br/> <br/>
    Quarter: <input type="text" name="Quarter" required/>
    <br/> <br/>
    Year: <input type="text" name="Year" required/>
    <br/> <br/>
    <input type="submit" value="Submit"/>
</form>
</body>
</html>
