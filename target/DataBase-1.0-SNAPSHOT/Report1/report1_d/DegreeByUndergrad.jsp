<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %><%--
  Created by IntelliJ IDEA.
  User: AmberWang
  Date: 2021/5/14
  Time: 下午 01:27
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
        List<String> arr_ssn = new ArrayList<>();
        List<String> arr_first = new ArrayList<>();
        List<String> arr_middle = new ArrayList<>();
        List<String> arr_last = new ArrayList<>();

        List<String> arr_degree_type = new ArrayList<>();
        List<String> arr_degree_name = new ArrayList<>();
    %>
    <%
        String url = "jdbc:postgresql://localhost:5432/postgres?user=postgres&password=4645";
        try {
            Class.forName("org.postgresql.Driver");
            Connection conn = DriverManager.getConnection(url);
            Statement sm = conn.createStatement();

            // get ssn without duplicates
            String sql_get_ssn = "SELECT Student.ssn FROM Student INNER JOIN Enrollment ON Enrollment.Student_Id = Student.Student_Id GROUP BY Student.ssn";
            String sql_get_name = "SELECT a.ssn, firstname, middlename, lastname FROM (" + sql_get_ssn + ") AS a INNER JOIN Student ON a.ssn = Student.ssn";


        } catch (Exception e) {

        }
    %>
</body>
</html>
