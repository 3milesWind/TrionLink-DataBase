<%--
  Created by IntelliJ IDEA.
  User: guoyili
  Date: 5/1/21
  Time: 2:24 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
Past Course Form
<form action="Past_Course_Insert.jsp" method="post">
    Student ID: <input type="text" name="Student_Id" required/>
    <br/> <br/>
    Course ID: <input type="text" name="Course_Id" required/>
    <br/> <br/>
    Units: <input type="number" name="Units" required/>
    <br/> <br/>
    Section <input type="text" name="Section_ID" required/>
    <br/> <br/>
    Quarter:
    <select name="quarter">
        <option value="Winter">Winter</option>
        <option value="Spring">Spring</option>
        <option value="Summer">Summer</option>
        <option value="Fall">Fall</option>
    </select>
    Years: <select name="year">
    <option value="2020">2020</option>
    <option value="2019">2019</option>
    <option value="2018">2018</option>
    <option value="2017">2017</option>
    <option value="2016">2016</option>
    <option value="2015">2015</option>
    </select>
    <br/><br/>
    Grade: <select name="grade">
    <option value="A+">A+</option>
    <option value="A">A</option>
    <option value="A-">A-</option>
    <option value="B+">B+</option>
    <option value="B">B+</option>
    <option value="B-">B-</option>
    <option value="C+">C+</option>
    <option value="C">C</option>
    <option value="C-">C-</option>
    <option value="D">D</option>
    <option value="D">F</option>
    <option value="incomplete">incomplete</option>
    <option value="S/U">S/U</option>
    </select>
    <input type="submit" value="Submit"/>
</form>
</body>
</html>
