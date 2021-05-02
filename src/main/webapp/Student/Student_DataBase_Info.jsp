<%--
  Created by IntelliJ IDEA.
  User: guoyili
  Date: 4/27/21
  Time: 5:50 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.sql.*" contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
</head>
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
<body>
<h1 align="center"> Student DataBase</h1>
<table>
    <%
        String url = "jdbc:postgresql://localhost:5432/postgres?user=postgres&password=4645";
        try{
            Class.forName("org.postgresql.Driver");
            Connection conn = DriverManager.getConnection(url);
            Statement sm = conn.createStatement();
            ResultSet st = sm.executeQuery("select * from student");
            out.println("<tr><th>StudentID</th>" +
                        "<th>StudentSSn</th>" +
                        "<th>StudentName</th>" +
                        "<th>Residency</th>" +
                        "<th>Enrollment</th>" +
                        "<th>Type</th>" +
                        " </tr>");
            while (st.next()) {

                out.print("<tr><th>" + st.getString(1) + "</th>"
                        + "<th>" + st.getString(2)  + "</th>"
                        + "<th>" + st.getString(3) + " " +  st.getString(4)  +  " " + st.getString(5) + "</th>" +
                        "<th>" +  st.getString(6) +"</th>" +
                        "<th>" +  st.getString(7) +"</th>" +
                        "<th>" +  st.getString(8) +"</th>" +
                        "</tr>");
            }
            sm.close();
            st.close();
            conn.close();
        }catch (Exception e){
            System.out.println(e);
        }
    %>
</table>
<h1 align="center"> Undergraduate Table</h1>
<br/> <br/>
<table>
    <%
        try{
            Class.forName("org.postgresql.Driver");
            Connection conn = DriverManager.getConnection(url);
            Statement sm = conn.createStatement();
            ResultSet st = sm.executeQuery("select * from undergraduate");
            out.println("<tr><th>StudentID</th><th>Major</th><th>Minor</th><th>College</th></tr>");
            while (st.next()) {

                out.print("<tr><th>" + st.getString(1) + "</th>" + "<th>" + st.getString(2)  + "</th>"
                        + "<th>" + st.getString(3) + "</th>" + "<th>" + st.getString(4)  +"</th></tr>");
            }
            sm.close();
            st.close();
            conn.close();
        }catch (Exception e){
            System.out.println(e);
        }
    %>
</table>
<h1 align="center"> Master Table</h1>
<br/> <br/>
<table>
    <%
        try{
            Class.forName("org.postgresql.Driver");
            Connection conn = DriverManager.getConnection(url);
            Statement sm = conn.createStatement();
            ResultSet st = sm.executeQuery("select * from Master");
            out.println("<tr><th>StudentID</th><th>type</th><th>Department</th><th>Thesis</th></tr>");
            while (st.next()) {

                out.print("<tr><th>" + st.getString(1) + "</th>" + "<th>" + st.getString(2)  + "</th>"
                        + "<th>" + st.getString(3) + "</th>" + "<th>" + st.getString(4)  +"</th></tr>");
            }
            sm.close();
            st.close();
            conn.close();
        }catch (Exception e){
            System.out.println(e);
        }
    %>
</table>
<h1 align="center"> PHD Table</h1>
<br/> <br/>
<table>
    <%
        try{
            Class.forName("org.postgresql.Driver");
            Connection conn = DriverManager.getConnection(url);
            Statement sm = conn.createStatement();
            ResultSet st = sm.executeQuery("select * from phd");
            out.println("<tr><th>StudentID</th><th>Department</th><th>Type</th><th>advisor</th><th>Thesis</th><th>Diff_dep_Thesis</th></tr>");
            while (st.next()) {

                out.print("<tr><th>" + st.getString(1) + "</th>" + "<th>" + st.getString(2)  + "</th>"
                        + "<th>" + st.getString(3) + "</th>"
                        + "<th>" + st.getString(4) + "</th>"
                        + "<th>" + st.getString(5) + "</th>"
                        + "<th>" + st.getString(6)  +"</th></tr>");
            }
            sm.close();
            st.close();
            conn.close();
        }catch (Exception e){
            System.out.println(e);
        }
    %>
</table>
<a href="../index.jsp"><button>back HomePage</button></a>
<jsp:include page="./../footer.jsp"/>
</body>
</html>
