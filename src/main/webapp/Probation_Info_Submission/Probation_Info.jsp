<%--
  Created by IntelliJ IDEA.
  User: guoyili
  Date: 4/30/21
  Time: 1:26 PM
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
<h1 align="center"> Probation Table</h1>
<br/> <br/>
<table>
    <%
        try{
            String url = "jdbc:postgresql://localhost:5432/postgres?user=postgres&password=4645";
            Class.forName("org.postgresql.Driver");
            Connection conn = DriverManager.getConnection(url);
            String sql = "select * from probation where student_id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1,request.getParameter("student_id"));
            ResultSet st = ps.executeQuery();
            out.println("<tr><th>StudentID</th><th>Start_date</th><th>End_date</th><th>Reason</th></tr>");
            while (st.next()) {

                out.print("<tr><th>" + st.getString(1) + "</th>" + "<th>" + st.getString(2)  + "</th>"
                        + "<th>" + st.getString(3) + "</th>" + "<th>" + st.getString(4)  +"</th></tr>");
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
