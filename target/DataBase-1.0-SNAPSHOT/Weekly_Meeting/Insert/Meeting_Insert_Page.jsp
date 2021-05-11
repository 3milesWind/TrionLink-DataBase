<%--
  Created by IntelliJ IDEA.
  User: AmberWang
  Date: 2021/5/10
  Time: 下午 11:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Weekly Meeting Submission</title>
</head>
<body>
    <h1 align="center">Review Session Insert Entry</h1>
    <form action="Meeting_Insert.jsp" method="post">
        Course ID: <input type="text" name="CourseID" required/>
        <br/> <br/>
        Section ID: <input type="text" name="SectionID" required/>
        <br/> <br/>
        Meeting ID: <input type="text" name="MeetingID" required/>
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
        Day: <input type="checkbox" name="day" value="Monday"/> Monday,
         <input type="checkbox" name="day" value="Tuesday"/> Tuesday,
         <input type="checkbox" name="day" value="Wednesday"/> Wednesday,
         <input type="checkbox" name="day" value="Thursday"/> Thursday,
         <input type="checkbox" name="day" value="Friday"/> Friday
        <br/> <br/>
        Start Time: <input type="text" name="StartTime" required/>
        <br/> <br/>
        End Time: <input type="text" name="EndTime" required/>
        <br/> <br/>
        Room: <input type="text" name="Room" required/>
        <br/> <br/>
        <input type="submit" value="Submit"/>
    </form>
</body>
</html>
