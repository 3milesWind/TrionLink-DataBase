<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %><%--
  Created by IntelliJ IDEA.
  User: AmberWang
  Date: 2021/5/13
  Time: 上午 01:09
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
        String class_id = "";

        boolean is_correct = true;
        String wrong = "";
    %>
    <H3>Students Currently Taking This Class</H3>
    <table>
        <%
            String url = "jdbc:postgresql://localhost:5432/postgres?user=postgres&password=4645";
            try {
                Class.forName("org.postgresql.Driver");
                Connection conn = DriverManager.getConnection(url);
                conn.setAutoCommit(false);

                class_id = request.getParameter("classId");

                String sql_find_stu = "SELECT * FROM Enrollment INNER JOIN Section ON Enrollment.SectionId = Section.SectionId";
            } catch (Exception e) {
                is_correct = false;
                wrong = e.toString();
                System.out.println(e);
            }
        %>
    </table>
    <%
        if (is_correct == false) {
            out.print("<h3>" + wrong + "</h3>");
        }
        is_correct = true;
        wrong = "";
    %>
    <H3>Students Have Taken This Class Before</H3>
    <table>
        <%
            try {
                Class.forName("org.postgresql.Driver");
                Connection conn = DriverManager.getConnection(url);
                conn.setAutoCommit(false);

                class_id = request.getParameter("classId");

            } catch (Exception e) {
                is_correct = false;
                wrong = e.toString();
                System.out.println(e);
            }
        %>
    </table>

    <br/><br/>
    <a href="../../report.jsp"><button> Homepage </button></a>
    <a href="StudentsTakingClass.jsp"><button> Check Others </button></a>
    <jsp:include page="../../footer.jsp"/>
</body>
</html>
