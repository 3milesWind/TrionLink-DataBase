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
        String sql = "Delete from faculty where faculty_name = ?";
        conn.setAutoCommit(false);
        PreparedStatement ck = conn.prepareStatement(sql_ck);
        name = FirstName + " " + middleName + " " + LastName;
        name = name.toLowerCase();
        ck.setString(1, name);
        ResultSet st = ck.executeQuery();
        if (st.next()) {
            is_correct = true;
            PreparedStatement ps =conn.prepareStatement(sql);
            ps.setString(1,name);
            ps.executeUpdate();
            ps.close();
        } else {
            System.out.println("Faculty name did not find");
        }
        conn.commit();
        conn.setAutoCommit(true);
        ck.close();
        st.close();
    } catch (Exception e) {
        System.out.println(e);
    }
%>
<% if(is_correct) {%>
<h3>Successful Updated</h3>
<% } else {%>
<h3>Please,check the faculty's name. And try again </h3>
<% } %>
<a href="./Faculty_Delete_Page.jsp"><button> Delete More </button></a>
<a href="../Faculty_DataBase.jsp"><button> Check Database </button></a>
<a href="../../insertPage.jsp"><button> Homepage</button></a>
<jsp:include page="../../footer.jsp"/>
</body>
</html>
