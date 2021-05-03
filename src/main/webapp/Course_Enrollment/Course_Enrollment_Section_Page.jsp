<%--
  Created by IntelliJ IDEA.
  User: AmberWang
  Date: 2021/5/2
  Time: 下午 01:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Section Submission</title>
</head>
<body>
Keep working on one more step to finish
<%! String student_id = "" ;%>
<%! String course_id = "" ;%>
<%! String units = "" ;%>
<%  student_id = (String)session.getAttribute("student_id");%>
<%  course_id = (String)session.getAttribute("course_id");%>
<%  units = (String)session.getAttribute("units");%>
<form action="Course_Enrollment_Section.jsp" method="post">
    Student ID:  <input type="text" value="<%=student_id%>" name="StudentID" readonly/>
    <br/> <br/>
    Course ID: <input type="text" value="<%=course_id%>" name="CourseID" readonly/>
    <br/> <br/>
    Section ID: <input type="text" name="SectionID" required/>
    <br/> <br/>
    Units: <input type="text" value="<%=units%>" name="Units" readonly/>
    <br/> <br/>
    <input type="submit" value="Submit"/>
</form>
</body>
</html>
