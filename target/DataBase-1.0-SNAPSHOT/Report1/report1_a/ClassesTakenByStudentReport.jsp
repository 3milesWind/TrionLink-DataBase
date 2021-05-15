<%--
  Created by IntelliJ IDEA.
  User: guoyili
  Date: 5/8/21
  Time: 6:46 PM
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
    String ssn = "";
    String student_id = "";
    boolean is_correct = true;
    String wrong = "";
    String url = "jdbc:postgresql://localhost:5432/postgres?user=postgres&password=4645";
%>

<%
    try {
        Class.forName("org.postgresql.Driver");
        Connection conn = DriverManager.getConnection(url);

        // find the student id by ssn
        ssn = request.getParameter("ssn");
        conn.setAutoCommit(false);
        PreparedStatement find_id = conn.prepareStatement("select * from student where ssn = ?");
        find_id.setString(1,ssn);
        ResultSet rs_id = find_id.executeQuery();
        if (!rs_id.next()) {
            System.out.println("Am i here");
            is_correct = false;
            wrong = "Can not find the SSN";
        }
        student_id = rs_id.getString(1);

        // generate the class that student current take
        String sql = "select e.courseid, c.classid,c.title, e.sectionid,e.units from enrollment e left outer join class c\n" +
                "on e.courseid = c.courseId\n" +
                "where e.studentid = ? and c.quarter ='Spring' and c.year = '2021'";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1,student_id);
        ResultSet res = ps.executeQuery();
        out.print("<h3> Current Course taken by " + ssn +  "</h3>");
        out.print("<table>");
        out.println("<tr><th>Couse ID</th>" +
                "<th>Class ID</th>" +
                "<th>Title</th>" +
                "<th>section</th>" +
                "<th>Units</th>" +
                "</tr>");
        while(res.next()) {
            out.print("<tr><th>" + res.getString(1) + "</th>"
                    + "<th>" + res.getString(2) + "</th>"
                    + "<th>" + res.getString(3) + "</th>"
                    + "<th>" + res.getString(4) + "</th>"
                    + "<th>" + res.getString(5) + "</th>"
                    + "</tr>");
        }
        out.print("</table>");
        res.close();
        conn.commit();
        conn.setAutoCommit(true);
        find_id.close();
        rs_id.close();
        ps.close();
        conn.close();
    } catch (Exception e) {
        is_correct = false;
        wrong = e.toString();
        System.out.println(e);
    }
%>
<%if (is_correct == false) {
    out.print("<h3>" + wrong + "</h3>");
}%>
<br/><br/>
<a href="../../report.jsp"><button> Homepage </button></a>
<a href="ClassesTakenByStudent.jsp"><button> Check Others </button></a>
<jsp:include page="../../footer.jsp"/>
</body>
</html>
