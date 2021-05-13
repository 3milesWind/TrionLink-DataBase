<%--
  Created by IntelliJ IDEA.
  User: AmberWang
  Date: 2021/5/2
  Time: 上午 10:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Class Insertion</title>
</head>
<body>
<h1 align="center">Class Insert Entry</h1>
<form action="Class_Entry_Insert.jsp" method="post">
    Class ID: <input type="text" name="ClassID" required/>
    <br/> <br/>
    Course ID: <input type="text" name="CourseID" required/>
    <br/> <br/>
    Title: <input type="text" name="Title" required/>
    <br/> <br/>
    Quarter: <select name="Quarter">
    <option>Spring</option>
    <option>Summer</option>
    <option>Fall</option>
    <option>Winter</option>
    </select>
    <br/> <br/>
    Year: <input type="text" name="Year" required/>
    <br/> <br/>
    Number of Sections: <input type="text" name="NumberSec" required/>
    <br/> <br/>
    Next Offer Time: <select name="NextOfferQuarter">
    <option>Spring</option>
    <option>Summer</option>
    <option>Fall</option>
    <option>Winter</option>
    </select> quarter, <input type="text" name="NextOfferYear" required/> year
    <br/> <br/>
    <input type="submit" value="Submit"/>
</form>
</body>
</html>
