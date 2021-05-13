<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: AmberWang
  Date: 2021/5/13
  Time: 上午 09:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<style>
    table {
        font-family: sans-serif;
        border-collapse: collapse;
        width: 100%;
    }
    td, th {
        border: 1px solid black;
        text-align: left;
    }
</style>
<body>
    <%!
        String ssn = "";
        String student_id = "";

        boolean is_correct = true;
        String wrong = "";
    %>
    <%
        String url = "jdbc:postgresql://localhost:5432/postgres?user=postgres&password=4645";
        try {
            is_correct = true;
            Class.forName("org.postgresql.Driver");
            Connection conn = DriverManager.getConnection(url);
            conn.setAutoCommit(false);
            String sql_find_stu = "SELECT Section.classid, Past_course.sectionid, Past_course.student_id, Past_course.units, Past_course.grade, Past_course.taken_quarter FROM Past_course INNER JOIN Section ON Section.SectionId = Past_course.SectionId";
            String sql_merge_stu = "SELECT Student.ssn, a.* FROM (" + sql_find_stu + ") AS a INNER JOIN Student ON Student.Student_id = a.student_id";
            String sql_sear_ssn = "SELECT b.classid, b.student_id, b.units, b.grade, b.taken_quarter FROM (" + sql_merge_stu + ") AS b WHERE b.ssn = ?";
            ssn = request.getParameter("ssn");

            PreparedStatement ps = conn.prepareStatement(sql_sear_ssn);
            ps.setString(1, ssn);
            ResultSet rs = ps.executeQuery();

        } catch (Exception e) {
            is_correct = false;
            wrong = e.toString();
            System.out.println(e);
        }
    %>
</body>
</html>
