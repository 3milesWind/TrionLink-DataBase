<%--
  Created by IntelliJ IDEA.
  User: guoyili
  Date: 5/30/21
  Time: 12:08 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.sql.*" contentType="text/html;charset=UTF-8" language="java" %>
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
    String Course = "";
    String Profs  = "";
    String Quarter = "";
    String url = "jdbc:postgresql://localhost:5432/postgres?user=postgres&password=4645";
    boolean is_correct = true;
    String year = "";
    String Exception = "";
%>
<%
    try {
        Class.forName("org.postgresql.Driver");
        Connection conn = DriverManager.getConnection(url);
//        conn.setAutoCommit(false);
        String sql = "select * from CPQG ";
        Statement st = conn.createStatement();
        ResultSet rs = st.executeQuery(sql);
        out.print("<h3> Testing update <h3>");
        out.print("<table>");
        out.println("<tr><th>Course ID</th><th>SectionId</th><th>Faculty_name</th>" +
                "<th>A</th>" +
                "<th>B</th>" +
                "<th>C</th>" +
                "<th>D</th>" +
                "<th>Other</th>" +
                "</tr>");
        while (rs.next()) {
            out.println("<tr>" +
                    "<th>" + rs.getString(1) + "</th>" +
                    "<th>" +rs.getString(4) + "</th>" +
                    "<th>" +rs.getString(5) + "</th>" +
                    "<th>" +rs.getString(6) + "</th>" +
                    "<th>" +rs.getString(7) + "</th>" +
                    "<th>" +rs.getString(8) + "</th>" +
                    "<th>" +rs.getString(9) + "</th>" +
                    "<th>" +rs.getString(10) + "</th>" +
                    "</tr>");
        }
        out.print("</table>");
         sql = "select * from CPG ";
         rs = st.executeQuery(sql);
        out.print("<h3> Testing update <h3>");
        out.print("<table>");
        out.println("<tr><th>Course ID</th><th>Faculty_name</th>" +
                "<th>A</th>" +
                "<th>B</th>" +
                "<th>C</th>" +
                "<th>D</th>" +
                "<th>Other</th>" +
                "</tr>");
        while (rs.next()) {
            out.println("<tr>" +
                    "<th>" + rs.getString(1) + "</th>" +
                    "<th>" +rs.getString(2) + "</th>" +
                    "<th>" +rs.getString(3) + "</th>" +
                    "<th>" +rs.getString(4) + "</th>" +
                    "<th>" +rs.getString(5) + "</th>" +
                    "<th>" +rs.getString(6) + "</th>" +
                    "<th>" +rs.getString(7) + "</th>" +
                    "</tr>");
        }
        out.print("</table>");
    } catch (Exception e) {
        is_correct = false;
        Exception = e.toString();
        System.out.println(e);
    }
%>
<% if (is_correct == false ) {
    out.print("<h3>" + Exception + "<h3>");
} %>
</body>
</html>
