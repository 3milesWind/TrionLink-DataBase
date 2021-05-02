<%--
  Created by IntelliJ IDEA.
  User: guoyili
  Date: 4/30/21
  Time: 10:21 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.util.*" contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
Keep working on one more step to finish
<%! String student_id = "" ;%>
<%  student_id = (String)session.getAttribute("student_id");%>
<form action="PHD_Entry_Insert.jsp" method="post">
    Student ID:  <input type="text" value="<%=student_id%>" name="student_id" readonly/>
    <br/> <br/>
    PHD Type: <select name="Type">
    <option>PhD candidates</option>
    <option> pre-candidacy</option>
    </select>
    <br/> <br/>
    Department: <select name="Department">
    <option>CSE</option>
    <option>Math</option>
    <option>Art</option>
    <option>Science</option>
    </select>
    <input type="submit" value="Submit">
</form>
</body>
</html>
