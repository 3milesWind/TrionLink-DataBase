<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %><%--
  Created by IntelliJ IDEA.
  User: AmberWang
  Date: 2021/5/2
  Time: 上午 10:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%!
    String Option = "";
    boolean is_correct = false;
%>
<%
    try {
        String url = "jdbc:postgresql://localhost:5432/postgres?user=postgres&password=4645";
        Class.forName("org.postgresql.Driver");
        Connection conn = DriverManager.getConnection(url);
        conn.setAutoCommit(false);
        Option = request.getParameter("Option");

        if (Option.equals("Class")) {
            response.sendRedirect("./Class_Deletion/Class_Delete_Class_Delete_Page.jsp");
        } else if (Option.equals("Section")) {
            response.sendRedirect("./Section_Deletion/Class_Delete_Section_Delete_Page.jsp");
        }

    } catch (Exception e) {

    }
%>
</body>
</html>
