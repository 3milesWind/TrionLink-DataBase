<%--
  Created by IntelliJ IDEA.
  User: guoyili
  Date: 5/8/21
  Time: 1:47 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.sql.*" contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*"%>
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
<h3 align="center">Student Enrolled in Current Quarter</h3>
<%!
    List<String> student = new ArrayList<>();
    List<String> degree = new ArrayList<>();
    String url = "jdbc:postgresql://localhost:5432/postgres?user=postgres&password=4645";
%>
<table>
    <%
        try {
            Class.forName("org.postgresql.Driver");
            Connection conn = DriverManager.getConnection(url);
            Statement sm = conn.createStatement();
            ResultSet st = sm.executeQuery("select student.* from student right outer join Enrollment \n" +
                    "on student.student_id = enrollment.StudentId\n" +
                    "where student.stu_type = 'Master'\n" +
                    "group by student.student_id");
            out.println("<tr><th>Student SSN</th>" +
                    "<th>First Name</th>" +
                    "<th>Middle Name</th>" +
                    "<th>Last name</th>" +
                    "</tr>");
            while(st.next()) {
                if (!student.contains(st.getString(2))) student.add(st.getString(2));
                out.print("<tr><th>" + st.getString(2) + "</th>"
                        + "<th>" + st.getString(3) + "</th>"
                        + "<th>" + st.getString(4) + "</th>"
                        + "<th>" + st.getString(5) + "</th>"
                        + "</tr>");
            }
            sm.close();
            st.close();
            conn.close();

        } catch(Exception e) {
            System.out.println(e);
        }
    %>
</table>
<br/> <br/>
<table>
    <%
        try {
            Class.forName("org.postgresql.Driver");
            Connection conn = DriverManager.getConnection(url);
            PreparedStatement sm = conn.prepareStatement("select * from degree where Degree_Type like ?");
            sm.setString(1,"M.%");
            ResultSet st = sm.executeQuery();
            out.println("<tr><th>Degree Type</th>" +
                    "<th>Degree Name</th>" +
                    "</tr>");
            while(st.next()) {
                String temp = st.getString(1) + " " + st.getString(2);
                if (!degree.contains(temp)) degree.add(temp);
                out.print("<tr><th>" + st.getString(1) + "</th>"
                        + "<th>" + st.getString(2) + "</th>"
                        + "</tr>");
            }
            sm.close();
            st.close();
            conn.close();

        } catch(Exception e) {
            System.out.println(e);
        }
    %>
</table>
<br/> <br/>
<form method="post" action="DisplayTheReporte.jsp">
    <h3>Enter Student SSN for report</h3>
    <select name="student">
        <%
            for (int i = 0; i < student.size(); i++) {
                out.print("<option name=\"student\">" + student.get(i) + "</option>");
            }
        %>
    </select>
    <br/><br/>
    <select name="degree">
        <%
            for (int i = 0; i < degree.size(); i++) {
                out.print("<option>" + degree.get(i) + "</option>");
            }
        %>
    </select>
    <br/><br/>
    <input type="submit" value="Submit" />
</form>
<a href="../../report.jsp"><button> Homepage </button></a>
<jsp:include page="../../footer.jsp"/>
</body>
</html>
