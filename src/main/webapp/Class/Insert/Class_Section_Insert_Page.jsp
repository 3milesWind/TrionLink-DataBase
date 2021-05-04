<%--
  Created by IntelliJ IDEA.
  User: AmberWang
  Date: 2021/5/3
  Time: 下午 08:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Section Insertion</title>
</head>
<body>
Keep working on one more step to finish
<%! String Class_ID = "" ;%>
<%  Class_ID = (String)session.getAttribute("class_id");%>
<form action="Class_Section_Insert.jsp" method="post">
    Section ID: <input type="text" name="SectionID" required/>
    <br/> <br/>
    Class ID: <input type="text" value="<%=Class_ID%>" name="ClassID" readonly/>
    <br/> <br/>
    Instructor: <input type="text" name="Instructor" required/>
    <br/> <br/>
    Enrollment Limit: <input type="text" name="EnrollmentLimit" required/>
    <br/> <br/>
    Wait list: <input type="text" name="WaitList" required/>
    <br/> <br/>
    <input type="submit" value="Submit"/>
</form>
</body>
</html>
