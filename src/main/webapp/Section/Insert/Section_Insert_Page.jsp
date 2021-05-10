<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: AmberWang
  Date: 2021/5/10
  Time: 上午 01:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Section Insertion</title>
</head>
<style>
    table {
        font-family: arial, sans-serif;
        border-collapse: collapse;
        width: 50%;
    }
    td, th {
        border: 1px solid #dddddd;
        text-align: left;
        padding: 5px;
    }
    tr:nth-child(even) {
        background-color: #dddddd;
    }
</style>
<body>
<h1 align="Center">Infomation Table</h1>
<div style="height: 200px; overflow: scroll">
    <table>
        <%
            try {
                String url = "jdbc:postgresql://localhost:5432/postgres?user=postgres&password=4645";
                Class.forName("org.postgresql.Driver");
                Connection conn = DriverManager.getConnection(url);
                Statement sm = conn.createStatement();
                ResultSet st = sm.executeQuery("SELECT * FROM Faculty");
                out.println("<tr><th>Faculty Name</th>" +
                        "<th>Tile</th>" +
                        "<th>Department</th>" +
                        " </tr>");
                while(st.next()) {
                    out.print("<tr><th>" + st.getString(1) + "</th>"
                            + "<th>" + st.getString(2) + "</th>"
                            + "<th>" + st.getString(3) + "</th>"
                            + "</tr>");
                }
                sm.close();
                st.close();
                conn.close();
            } catch (Exception e) {
                System.out.println(e);
            }
        %>
    </table>
</div>
<h1 align="center">Course Insert Entry</h1>
<form action="Section_Insert.jsp" method="post">
    <br/> <br/>
    Course ID: <input type="text" name="CourseID" required/>
    <br/> <br/>
    Class ID: <input type="text" name="ClassID" required/>
    <br/> <br/>
    Section ID: <input type="text" name="SectionID" required/>
    <br/> <br/>
    Faculty Name: <input type="text" name="FacultyName" required/>
    <br/> <br/>
    Enrollment Limit: <input type="text" name="EnrollmentLimit" required/>
    <br/> <br/>
    Wait List: <input type="text" name="WaitList" required/>
    <br/> <br/>
    <input type="submit" value="Submit"/>
</form>
</body>
</html>
