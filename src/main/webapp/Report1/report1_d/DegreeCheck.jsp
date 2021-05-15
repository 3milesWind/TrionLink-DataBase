<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %><%--
  Created by IntelliJ IDEA.
  User: AmberWang
  Date: 2021/5/15
  Time: 上午 02:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <%!
        String ssn = "";
        String student_id = "";
        String degree_name = "";
        String major = "";
        boolean degree_major_not_match = false;
    %>
    <%
        String url = "jdbc:postgresql://localhost:5432/postgres?user=postgres&password=4645";
        try {
            Class.forName("org.postgresql.Driver");
            Connection conn = DriverManager.getConnection(url);
            ssn = request.getParameter("ssn");
            // get rid of degree type
            degree_name = (request.getParameter("degree")).substring(5);

            String sql_get_student_id = "SELECT student_id FROM Undergraduate WHERE ";
            // find student id using ssn

            // find if degree matches student's major


        } catch (Exception e) {
            System.out.println(e);
        }

    %>
</body>
</html>
