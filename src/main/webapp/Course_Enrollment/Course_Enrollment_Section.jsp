<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %><%--
  Created by IntelliJ IDEA.
  User: AmberWang
  Date: 2021/5/2
  Time: 下午 01:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    String Course_ID = "";
    String Section_ID = "";
%>
<%
    String url = "jdbc:postgresql://localhost:5432/postgres?user=postgres&password=4645";
    try {
        Class.forName("org.postgresql.Driver");
        Connection conn = DriverManager.getConnection(url);
        conn.setAutoCommit(false);
        Student_ID = request.getParameter("StudentID");
        Course_ID = request.getParameter("CourseID");
        Section_ID = request.getParameter("SectionID");

        String sql_insert = "INSERT INTO Enrollment VALUES (?,?,?)";
        PreparedStatement st = conn.prepareStatement(sql_insert);
        st.setString(1, Student_ID);
        st.setString(2, Course_ID);
        st.setString(3, Section_ID);
        st.executeUpdate();
        conn.commit();
        conn.setAutoCommit(true);
        st.close();
        conn.close();
    } catch (Exception e) {
        System.out.println(e);
    }
%>

<br/><br>
Successfully inserted !!
<br/><br>
Student ID: <%= Student_ID%>
<br/><br>
Course ID: <%=Course_ID%>
<br/><br>
Section ID: <%=Section_ID%>
<br/><br>
<a href="../Course_Enrollment/Course_Enrollment_Database.jsp"><button> Check Database </button></a>
<a href="./../index.jsp"><button> homepage </button></a>
<jsp:include page="../footer.jsp"/>
</body>
</html>
