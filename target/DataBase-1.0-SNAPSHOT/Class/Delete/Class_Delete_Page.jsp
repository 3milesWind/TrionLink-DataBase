<%--
  Created by IntelliJ IDEA.
  User: AmberWang
  Date: 2021/5/2
  Time: 上午 10:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Class & Section Deletion</title>
</head>
<body>
<P> Please, select either class or section to delete</P>
<form action="Class_Delete.jsp" method="post">
    Option: <select name="Option" required>
    <option>Class</option>
    <option>Section</option>
    </select>
    <br/> <br/>
    <input type="submit" value="Submit"/>
</form>
</body>
</html>
