<%--
  Created by IntelliJ IDEA.
  User: guoyili
  Date: 5/2/21
  Time: 4:30 PM
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
    String url = "jdbc:postgresql://localhost:5432/postgres?user=postgres&password=4645";
%>
<h1 align="center"> Degree DataBase</h1>

<table>
    <%
        try{
            Class.forName("org.postgresql.Driver");
            Connection conn = DriverManager.getConnection(url);
            Statement sm = conn.createStatement();
            ResultSet st = sm.executeQuery("select * from degree");
            out.println("<tr><th>Degree name/th>" +
                    "<th>Department</th>" +
                    "<th>Total units</th>" +
                    "<th>lower Division Unit</th>" +
                    "<th>Upper Division Unit</th>" +
                    "<th>Elective Unit</th>" +
                    " </tr>");
            while (st.next()) {

                out.print("<tr><th>" + st.getString(1) + " in " + st.getString(2) + "</th>"
                        + "<th>" + st.getString(3)  + "</th>" +
                        "<th>" +  st.getString(4) +"</th>" +
                        "<th>" +  st.getString(5) +"</th>" +
                        "<th>" +  st.getString(6) +"</th>" +
                        "<th>" +  st.getString(7) +"</th>" +
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
<h1 align="center"> Concentration DataBase</h1>
<table>
    <%
        try{
            Class.forName("org.postgresql.Driver");
            Connection conn = DriverManager.getConnection(url);
            Statement sm = conn.createStatement();
            ResultSet st = sm.executeQuery("select * from concentration");
            out.println("<tr><th>Concentration</th>" +
                    "<th>Degree_Name</th>" +
                    "<th>Degree_Type</th>" +
                    "<th>Courses</th>" +
                    "<th>Elective</th>" +
                    "<th>average_grade</th>" +
                    "<th>minimum_units</th>" +
                    " </tr>");
            while (st.next()) {

                out.print("<tr><th>" + st.getString(1) + "</th>"
                        + "<th>" + st.getString(2)  + "</th>" +
                        "<th>" +  st.getString(3) +"</th>" +
                        "<th>" +  st.getString(4) +"</th>" +
                        "<th>" +  st.getString(5) +"</th>" +
                        "<th>" +  st.getString(6) +"</th>" +
                        "<th>" +  st.getString(7) +"</th>" +
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
<br/><br/><br/>
<a href="./DegreePage.jsp"><button> Enter Degree Info </button></a>
<a href="concentration.jsp"><button> Enter Degree Categories </button></a>
<a href="../index.jsp"><button> Homepage</button></a>
<jsp:include page="../footer.jsp"/>
</body>
</html>
