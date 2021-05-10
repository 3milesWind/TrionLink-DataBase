<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: AmberWang
  Date: 2021/5/10
  Time: 上午 01:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Section Deletion</title>
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
    <h1 align="Center">Information Table</h1>
    <div style="height: 200px; overflow: scroll">
        <table>
            <%
                try {
                    String url = "jdbc:postgresql://localhost:5432/postgres?user=postgres&password=4645";
                    Class.forName("org.postgresql.Driver");
                    Connection conn = DriverManager.getConnection(url);
                    Statement sm = conn.createStatement();
                    ResultSet st = sm.executeQuery("SELECT * FROM Section");
                    out.println("<tr><th>Course ID</th>" +
                            "<th>Class ID</th>" +
                            "<th>Section ID</th>" +
                            "<th>Faculty Name</th>" +
                            "<th>Enrollment Limit</th>" +
                            "<th>Wait List</th>" +
                            " </tr>");
                    while(st.next()) {
                        out.print("<tr><th>" + st.getString(1) + "</th>"
                                + "<th>" + st.getString(2) + "</th>"
                                + "<th>" + st.getString(3) + "</th>"
                                + "<th>" + st.getString(4) + "</th>"
                                + "<th>" + st.getString(5) + "</th>"
                                + "<th>" + st.getString(6) + "</th>"
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
    <P> Please, Input Section ID for Deleting Section</P>
    <form action="Section_Delete.jsp" method="post">
        <br/> <br/>
        Course ID: <input type="text" name="CourseID" required/>
        <br/> <br/>
        Section ID: <input type="text" name="SectionID" required/>
        <br/> <br/>
        <input type="submit" value="Submit"/>
    </form>
</body>
</html>
