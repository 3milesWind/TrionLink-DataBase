<%--
  Created by IntelliJ IDEA.
  User: guoyili
  Date: 4/30/21
  Time: 10:45 AM
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
<%!
    String Student_ID = "";
    String Major = "";
    String Minor = "";
    String College = "";
%>
<%
    String url = "jdbc:postgresql://localhost:5432/postgres?user=postgres&password=4645";
    try {
        Class.forName("org.postgresql.Driver");
        Connection conn = DriverManager.getConnection(url);
        conn.setAutoCommit(false);
        Student_ID = request.getParameter("student_id");
        Major = request.getParameter("Major");
        Minor = request.getParameter("Minor");
        College = request.getParameter("College");
        String stu_data = "INSERT into undergraduate Values(?,?,?,?)";
        PreparedStatement st = conn.prepareStatement(stu_data);
        st.setString(1,Student_ID);
        st.setString(2, Major);
        st.setString(3, Minor);
        st.setString(4, College);
        int row = st.executeUpdate();
        conn.commit();
        conn.setAutoCommit(true);
        st.close();
        conn.close();
    } catch (Exception e) {
        System.out.println(e);
    }
%>
<%

%>
<br/><br>
Student ID: <%= Student_ID%>
Successfully inserted !!
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
    }catch (Exception e){
        System.out.println(e);
    }
%>
</table>
<br/><br>
<a href="../Student_DataBase_Info.jsp"><button> Check Database </button></a>
<a href="../../index.jsp"><button> homepage </button></a>
<jsp:include page="../../footer.jsp"/>
</body>
</html>
