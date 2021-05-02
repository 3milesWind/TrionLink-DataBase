<%--
  Created by IntelliJ IDEA.
  User: AmberWang
  Date: 2021/5/2
  Time: 上午 03:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Course Deletion</title>
</head>
<body>
<P> Please, Input Name for Deleting Course</P>
<form action="Course_Delete.jsp" method="post">
    Course ID: <input type="text" name="CourseID" required/>
    <br/> <br/>
    <input type="submit" value="Submit"/>
</form>
</body>
</html>
