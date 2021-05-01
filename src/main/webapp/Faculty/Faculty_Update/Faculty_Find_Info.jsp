<%--
  Created by IntelliJ IDEA.
  User: guoyili
  Date: 4/30/21
  Time: 3:05 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.sql.*" contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.Locale" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%!
    String url = "jdbc:postgresql://localhost:5432/postgres?user=postgres&password=4645";
    String FirstName = "";
    String LastName ="";
    String middleName = "";
    String Title = "";
    String Department = "";
    String name = "";
    boolean is_correct = false;
%>
<%
    try {
        Class.forName("org.postgresql.Driver");
        Connection conn = DriverManager.getConnection(url);
        // get the request name
        FirstName = request.getParameter("First_Name");
        middleName = request.getParameter("Middle_Name");
        LastName = request.getParameter("Last_Name");
        String sql_ck = "Select * from faculty where faculty_name = ?";
        conn.setAutoCommit(false);
        PreparedStatement ck = conn.prepareStatement(sql_ck);
        name = FirstName + " " + middleName + " " + LastName;
        name = name.toLowerCase();
        ck.setString(1, name);
        ResultSet st = ck.executeQuery();
        if (st.next()) {
            is_correct = true;
            Title = st.getString(2);
            Department = st.getString(3);
            ck.close();
        } else {
            System.out.println("Faculty did not find");
        }
        conn.commit();
        conn.setAutoCommit(true);
        st.close();
    } catch (Exception e) {
        System.out.println(e);
    }
%>
<% if(is_correct) {%>
<h3>Please, Update the faculty Information </h3>
<form action="Faculty_Update.jsp" method="post">
    <input value="<%=name%>" name="faculty_name" readonly />
    <br/> <br/>
    Title: <select name="title" value = "<%=Title%>">
    <option>Lecturer</option>
    <option>Assistant Professor</option>
    <option>Associate Professor</option>
    <option>Professor</option>
    </select>
    <br/> <br/>
    Department: <select name="Department" value = "<%=Department%>">
    <option>CSE</option>
    <option>Math</option>
    <option>Art</option>
    <option>Science</option>
    </select>
    <input type="submit" value="Submit">
</form>
<jsp:include page="../../footer.jsp"/>
<% } else {%>
<h3>Please,check the faculty's name. And try again </h3>
<a href="Faculty_Update_Page.jsp"><button> Re-Enter </button></a>
<a href="../../index.jsp"><button> HomePage </button></a>
<jsp:include page="../../footer.jsp"/>
<% } %>
</body>
</html>
