<%--
  Created by IntelliJ IDEA.
  User: guoyili
  Date: 4/27/21
  Time: 6:14 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.sql.*" contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
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
    try{
        String url = "jdbc:postgresql://localhost:5432/postgres?user=postgres&password=4645";
        Class.forName("org.postgresql.Driver");
        Connection conn = DriverManager.getConnection(url);
        Statement sm = conn.createStatement();
        ResultSet st = sm.executeQuery("select * from student");
        out.println("<tr><th>StudentID</th><th>StudentSSn</th><th>StudentName</th></tr>");
        while (st.next()) {

            out.print("<tr><th>" + st.getString(1) + "</th>" + "<th>" + st.getString(2)  + "</th>"
                    + "<th>" + st.getString(3) + " "  + st.getString(5) + "</th></tr>");
        }
        sm.close();
        st.close();
        conn.close();
    }catch (Exception e){
        System.out.println(e);
    }
%>
</table>
</div>
<P> Please, Input the ID for deleting </P>
<form action="Delete_Student_Entry.jsp" method="post">
    Student ID:<input type="text" name="student_id" placeholder="type Student Id"/>
    <input type="submit" value="Submit"/>
</form>
</body>
</html>
