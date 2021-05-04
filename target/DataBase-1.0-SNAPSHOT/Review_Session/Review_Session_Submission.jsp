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
    Meeting ID: <input type="text" name="MeetingID" required/>
    <br/> <br/>
    Section ID: <input type="text" name="SectionID" required/>
    <br/> <br/>
    Required: <select name="Required" required>
    <option>Yes</option>
    <option>No</option>
    </select>
    <br/> <br/>
    Type: <select name="Type" required>
    <option>LE</option>
    <option>DI</option>
    <option>LA</option>
    </select>
    <br/> <br/>
    Time: <input type="text" name="Time" required/>
    <br/> <br/>
    Date: <input type="text" name="Date" required/>
    <br/> <br/>
    Room: <input type="text" name="Room" required/>
    <br/> <br/>
    <input type="submit" value="Submit"/>
</form>
</body>
</html>
