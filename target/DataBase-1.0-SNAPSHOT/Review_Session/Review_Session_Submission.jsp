<%--
  Created by IntelliJ IDEA.
  User: AmberWang
  Date: 2021/5/3
  Time: 上午 07:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Review Session Submission</title>
</head>
<body>
<h1 align="center">Review Session Insert Entry</h1>
<form action="Review_Session_Insert.jsp" method="post">
    Course ID: <input type="text" name="CourseID" required/>
    <br/> <br/>
    Section ID: <input type="text" name="SectionID" required/>
    <br/> <br/>
    Date: <input type="text" name="Date" required/>
    <br/> <br/>
    Start Time: <input type="text" name="StartTime" required/>
    <br/> <br/>
    End Time: <input type="text" name="EndTime" required/>
    <br/> <br/>
    Building: <input type="text" name="Building" required/>
    <br/> <br/>
    Room: <input type="text" name="Room" required/>
    <br/> <br/>
    <input type="submit" value="Submit"/>
</form>
</body>
</html>
