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
<form action="Undergraduate_Entry_Insert.jsp" method="post">
    Student ID:  <input type="text" value="<%=student_id%>" name="student_id" readonly/>
    <br/> <br/>
    What is Student major: <input type="text" name="Major" required/>
    <br/> <br/>
    what id Student Minor: <input type="text" name="Minor" />
    <br/> <br/>
    college: <select name="College">
    <option>Warren</option>
    <option>Six</option>
    <option>Seven</option>
</select>
    <input type="submit" value="Submit">
</form>
</body>
</html>
