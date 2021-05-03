<%--
  Created by IntelliJ IDEA.
  User: AmberWang
  Date: 2021/5/2
  Time: 下午 11:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Units Submission</title>
    <script>
        function fetch()
        {
            var get = document.getElementById("get").value;
            document.getElementById("put").value = get;
        }
    </script>
</head>
<body>
Keep working on one more step to finish
<%! String student_id = "" ;%>
<%! String course_id = "" ;%>
<%! String section_id = "" ;%>
<%! Double min_units = 0.0 ;%>
<%! Double max_units = 0.0 ;%>
<%  student_id = (String)session.getAttribute("student_id");%>
<%  course_id = (String)session.getAttribute("course_id");%>
<%  section_id = (String)session.getAttribute("section_id");%>
<%  min_units = (Double)session.getAttribute("min_units");%>
<%  max_units = (Double)session.getAttribute("max_units");%>
<form action="Course_Enrollment_Section.jsp" method="post">
    Student ID:  <input type="text" value="<%=student_id%>" name="StudentID" readonly/>
    <br/> <br/>
    Course ID: <input type="text" value="<%=course_id%>" name="CourseID" readonly/>
    <br/> <br/>
    Section ID: <input type="text" value="<%=section_id%>" name="SectionID" required/>
    <br/> <br/>
    Units: <input type="range" name="Units" min="<%=min_units%>" max="<%=max_units%>" id="get" onchange="fetch()" required/>
    <input type="text" id="put" /> units
    <br/> <br/>
    <input type="submit" value="Submit"/>
</form>
</body>
</html>
