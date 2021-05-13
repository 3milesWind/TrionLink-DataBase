<%--
  Created by IntelliJ IDEA.
  User: guoyili
  Date: 4/30/21
  Time: 3:54 PM
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
<h1 align="center"> Faculty Table</h1>
<br/> <br/>
<table>
    <%
        try{
            String url = "jdbc:postgresql://localhost:5432/postgres?user=postgres&password=4645";
            Class.forName("org.postgresql.Driver");
            Connection conn = DriverManager.getConnection(url);
            Statement sm = conn.createStatement();
            ResultSet st = sm.executeQuery("select * from faculty");
            out.println("<tr><th>faculty name</th><th>Title</th><th>Department</th></tr>");
            while (st.next()) {

                out.print("<tr><th>" + st.getString(1) + "</th>" + "<th>" + st.getString(2)  + "</th>"
                        + "<th>" + st.getString(3)  +"</th></tr>");
            }
        }catch (Exception e){
            System.out.println(e);
        }
    %>
</table>
<a href="./../insertPage.jsp"><button> Homepage</button></a>
<jsp:include page="./../footer.jsp"/>
</body>
</html>
