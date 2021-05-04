<%--
  Created by IntelliJ IDEA.
  User: guoyili
  Date: 5/2/21
  Time: 2:58 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<h3 align="center">Fill in the department requirement</h3>
<form  action="DegreeCate_insert.jsp" method="post">
    Degree Name:
    <select name="degreeName">
        <option>UnderGraduate_Degree</option>
        <option>Master_Degree</option>
        <option>PHD_Degree</option>
    </select>
    <br/> <br/>
    Type: <select name="Type">
    <option>BS</option>
    <option>BA</option>
    <option>BS/MS</option>
    </select>
    <br/> <br/>
    Department: <select name="Department">
    <option>CSE</option>
    <option>Math</option>
    <option>Art</option>
    <option>Science</option>
    </select>
    <br/><br/>
    Minimum units: <input type="number" name="units" required>
    <br/><br/>
    Minimum Average grade:
    <input type="number" name="grade" min="2.0"  max="4.0" step="0.1" required>
    </select>
    <br/><br/>
    concentration:
    <input type="text" name="concentration">
    <br/>
    <p style="font-size:10px">Example: "CSE132A,CSE132B,CSE232A"</p>

    <input type="submit" value="Submit">
</select>
</form>
</body>
</html>
