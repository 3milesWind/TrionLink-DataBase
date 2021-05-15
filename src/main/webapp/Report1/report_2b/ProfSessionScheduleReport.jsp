<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.util.Calendar" %><%--
  Created by IntelliJ IDEA.
  User: AmberWang
  Date: 2021/5/15
  Time: 上午 06:58
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
        String section_id = "";
        String from_month = "";
        String from_date = "";
        String to_month = "";
        String to_date = "";
        String current_year = "2021";
    %>
    <%
        section_id = request.getParameter("sectionid");
        from_month = request.getParameter("fromMonth");
        from_date = request.getParameter("fromDate");
        to_month = request.getParameter("toMonth");
        to_date = request.getParameter("toDate");

        Calendar c = Calendar.getInstance();
        c.set(Integer.parseInt(current_year), Integer.parseInt(from_month)-1, Integer.parseInt(from_date));

        String url = "jdbc:postgresql://localhost:5432/postgres?user=postgres&password=4645";
        try {
            Class.forName("org.postgresql.Driver");
            Connection conn = DriverManager.getConnection(url);
            conn.setAutoCommit(false);

        } catch (Exception e) {
            System.out.println(e);
        }
    %>
</body>
</html>
