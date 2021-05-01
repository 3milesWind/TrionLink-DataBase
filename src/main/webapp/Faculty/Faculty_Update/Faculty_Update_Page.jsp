<%--
  Created by IntelliJ IDEA.
  User: guoyili
  Date: 4/30/21
  Time: 3:03 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<P> Please, Input Name for Faculty </P>
<form action="Faculty_Find_Info.jsp" method="post">
  First Name: <input type="text" name="First_Name" required/>
  <br/> <br/>
  Middle Name: <input type="text" name="Middle_Name" />
  <br/> <br/>
  Last Name: <input type="text" name="Last_Name" required/>
  <br/> <br/>
  <input type="submit" value="Submit"/>
</form>
</body>
</html>
