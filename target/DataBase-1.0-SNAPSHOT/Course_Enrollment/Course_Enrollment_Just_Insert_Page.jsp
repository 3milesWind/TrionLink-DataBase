<%@ page import="java.sql.*" %><%--
  Created by IntelliJ IDEA.
  User: AmberWang
  Date: 2021/5/13
  Time: 上午 02:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Enrollment Insertion Page</title>
</head>
<body>
    Keep working on one more step to finish
    <%! String student_id = "" ;%>
    <%! String course_id = "" ;%>
    <%! String section_id = "" ;%>
    <%! String units = "" ;%>
    <%! String grade_option = "" ;%>
    <%  student_id = (String)session.getAttribute("student_id");%>
    <%  course_id = (String)session.getAttribute("course_id");%>
    <%  section_id = (String)session.getAttribute("section_id");%>
    <%  units = (String)session.getAttribute("units");%>
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
    <form action="Course_Enrollment_Just_Insert.jsp" method="post">
        Student ID: <input type="text" value="<%=student_id%>" name="StudentID" readonly/>
        <br/> <br/>
        Course ID: <input type="text" value="<%=course_id%>" name="CourseID" readonly/>
        <br/> <br/>
        Section ID: <input type="text" value="<%=section_id%>" name="SectionID" readonly/>
        <br/> <br/>
        Units: <input type="text" value="<%=units%>" name="Units" readonly/>
        <br/> <br/>
        Grade Option:
        <% if (grade_option.equals("Letter or S/U")) { %>
        <select name="GradeOption">
            <option>Letter</option>
            <option>S/U</option>
        </select>
        <% } else { %>
        <input type="text" value="<%=grade_option%>" name="GradeOption" readonly/>
        <% } %>

        <br/> <br/>
    </form>

</body>
</html>
