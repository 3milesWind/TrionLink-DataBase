<%--
  Created by IntelliJ IDEA.
  User: guoyili
  Date: 5/8/21
  Time: 1:47 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.sql.*" contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
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
<%--<h3 align="center">Student Enrolled in Current Quarter</h3>--%>
<%!
    List<String> array = new ArrayList<>();
    String option = "";
%>

<table>
        <%
    String url = "jdbc:postgresql://localhost:5432/postgres?user=postgres&password=4645";
    try {
    Class.forName("org.postgresql.Driver");
    Connection conn = DriverManager.getConnection(url);
    Statement sm = conn.createStatement();
    ResultSet st = sm.executeQuery("select student.* from student " +
            "left outer join Enrollment on student.student_id = enrollment.StudentId" +
            " group by student.student_id");
    out.println("<tr><th>Student SSN</th>" +
    "<th>First Name</th>" +
    "<th>Middle Name</th>" +
    "<th>Last name</th>" +
    "</tr>");
    while(st.next()) {
        if (!array.contains(st.getString(2))) array.add(st.getString(2));
        out.print("<tr><th>" + st.getString(2) + "</th>"
        + "<th>" + st.getString(3) + "</th>"
        + "<th>" + st.getString(4) + "</th>"
        + "<th>" + st.getString(5) + "</th>"
        + "</tr>");
    }

    sm.close();
    st.close();
    conn.close();

    } catch(Exception e) {
    System.out.println(e);
    }%>
    <table/>
    <form method="post" action="ReportStudentSchedule.jsp">
        <h3>Enter Student SSN for report</h3>
        Select SSN: <select name="ssn">
        <% for (int i = 0; i < array.size(); i++) {%>
        <option ><%=array.get(i)%></option>
        <% } %>
    </select>
        <br/><br>
        <input type="submit" value="Submit" />
    </form>
    <a href="../../report.jsp"><button> Homepage </button></a>
    <jsp:include page="../../footer.jsp"/>
</body>
</html>
