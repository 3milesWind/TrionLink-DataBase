<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %><%--
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
    <%! Integer min_units = 0 ;%>
    <%! Integer max_units = 0 ;%>
    <%! String grade_option = "" ;%>
    <%  student_id = (String)session.getAttribute("student_id");%>
    <%  course_id = (String)session.getAttribute("course_id");%>
    <%  section_id = (String)session.getAttribute("section_id");%>
    <%  min_units = (Integer)session.getAttribute("min_units");%>
    <%  max_units = (Integer)session.getAttribute("max_units");%>
    <%
        String url = "jdbc:postgresql://localhost:5432/postgres?user=postgres&password=4645";
        try {
            Class.forName("org.postgresql.Driver");
            Connection conn = DriverManager.getConnection(url);
            String sql_st = "SELECT GradeOption FROM Course WHERE CourseId = ?";
            PreparedStatement ck = conn.prepareStatement(sql_st);
            ck.setString(1, course_id);
            ResultSet rs = ck.executeQuery();
            if (rs.next()) {
                grade_option = rs.getString(1);
            }
            rs.close();
            ck.close();
            conn.close();
        } catch (Exception e) {
            System.out.println(e);
        }
    %>
    <form action="Course_Enrollment_Unit.jsp" method="post">
        Student ID:  <input type="text" value="<%=student_id%>" name="StudentID" readonly/>
        <br/> <br/>
        Course ID: <input type="text" value="<%=course_id%>" name="CourseID" readonly/>
        <br/> <br/>
        Section ID: <input type="text" value="<%=section_id%>" name="SectionID" required/>
        <br/> <br/>
        Units: <input type="range" name="Units" min="<%=min_units%>" max="<%=max_units%>" id="get" onchange="fetch()" required/>
        <input type="text" id="put" /> units
        <br/> <br/>
        Grade Option:
        <% if (grade_option.equals("Letter or S/U")) { %>
        <select name="GradeOption" required>
            <option>Letter</option>
            <option>S/U</option>
        </select>
        <% } else { %>
        <input type="text" value="<%=grade_option%>" name="GradeOption" readonly required/>
        <% } %>
        <br/> <br/>
        <input type="submit" value="Submit"/>
    </form>
</body>
</html>
