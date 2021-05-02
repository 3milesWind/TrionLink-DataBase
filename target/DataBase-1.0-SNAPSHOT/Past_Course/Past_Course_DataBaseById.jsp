<%--
  Created by IntelliJ IDEA.
  User: guoyili
  Date: 5/1/21
  Time: 1:03 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.sql.*" contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<style>
    table {
        font-family: sans-serif;
        border-collapse: collapse;
        width: 100%;
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
<table>
    <%
        try{
            String student_id = request.getParameter("student_id");
            String url = "jdbc:postgresql://localhost:5432/postgres?user=postgres&password=4645";
            Class.forName("org.postgresql.Driver");
            Connection conn = DriverManager.getConnection(url);
            PreparedStatement sm = conn.prepareStatement("select * from past_course where student_id = ?");
            sm.setString(1,student_id);
            ResultSet st = sm.executeQuery();
            out.println("<H3 align=\"center\">Student DataBase</h3>");
            out.println("<tr><th>StudentID</th><th>CourseID</th><th>SectionID</th><th>Quarter</th><th>Grade</th></tr>");
            while (st.next()) {

                out.print("<tr><th>" + st.getString(1) + "</th>" + "<th>" + st.getString(2)  + "</th>"
                        + "<th>" + st.getString(3) + "</th>" + "<th>" + st.getString(4)  +"</th>" +
                        "<th>" + st.getString(5)  +"</th></tr>");
            }
        }catch (Exception e){
            System.out.println(e);
        }
    %>
</table>
<a href="../index.jsp"><button>back HomePage</button></a>
<jsp:include page="./../footer.jsp"/>
</body>
</html>
