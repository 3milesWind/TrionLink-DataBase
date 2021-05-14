<%--
  Created by IntelliJ IDEA.
  User: guoyili
  Date: 5/13/21
  Time: 5:01 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.sql.*" contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<html>
<head>
    <title>Title</title>
</head>
<style>
    table {
        font-family: sans-serif;
        border-collapse: collapse;
        width: 50%;
    }
    td, th {
        border: 1px solid black;
        text-align: left;
    }
</style>
<body>
<%!
    String Course = "";
//    String Profs  = "";
    //  String Quarter = "";
    String url = "jdbc:postgresql://localhost:5432/postgres?user=postgres&password=4645";
    boolean is_correct = true;
    String Exception = "";

%>
<%
    try {

        Class.forName("org.postgresql.Driver");
        Connection conn = DriverManager.getConnection(url);
        Course = request.getParameter("Course");
//        Profs = request.getParameter("Profs");
//    Quarter = request.getParameter("Quarter");
//    System.out.println(Course +  " " + Profs + " " + Quarter + " ");
        conn.setAutoCommit(false);
        String sql = "select p.student_id, p.grade from past_course p left outer join section s\n" +
                "on p.course_id = s.courseid and p.sectionid = s.sectionid\n" +
                "where course_id = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1,Course);
        ResultSet rs = ps.executeQuery();
        out.print("<h3> Given student x grade for " + Course + " over years</h3>" );
        out.print("<table>");
        out.println("<tr><th>StudentID</th><th>Grade</th></tr>");
        while (rs.next()) {
            out.println("<tr><th>" + rs.getString(1) + "</th>" +
                    "<th>" +rs.getString(2) + "</th></tr>");
        }
        out.print("</table>");
        conn.commit();
        conn.setAutoCommit(true);
        conn.close();
    } catch (Exception e) {
        is_correct = false;
        Exception = e.toString();
        System.out.println(e.toString());
    }
%>
<%
    if (is_correct == false) {
        out.print("<h3>" + Exception + "</h3>");
    }
%>
<a href="./Report3Index.jsp"><button> other reports </button></a>
<a href="../../report.jsp"><button> Homepage </button></a>
<jsp:include page="../../footer.jsp"/>
</body>
</html>
