<%--
  Created by IntelliJ IDEA.
  User: guoyili
  Date: 4/30/21
  Time: 1:58 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.sql.*" contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%!
    String url = "jdbc:postgresql://localhost:5432/postgres?user=postgres&password=4645";
    String title = "";
    String Department = "";
    String name = "";
%>
<%
    try {
        Class.forName("org.postgresql.Driver");
        Connection conn = DriverManager.getConnection(url);
        // get the request name
        title = request.getParameter("title");
        Department = request.getParameter("Department");
        name = request.getParameter("faculty_name");
        System.out.println(name + title + Department);
        String sql = "Update faculty set title = ?, department = ? where faculty_name = ?";
        conn.setAutoCommit(false);
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1,title);
        ps.setString(2,Department);
        ps.setString(3,name);
        ps.executeUpdate();
        conn.commit();
        conn.setAutoCommit(true);
        ps.close();
    } catch (Exception e) {
        System.out.println(e);
    }
%>
<h3>Successfully updated the information for Faculty </h3>
<a href="./Faculty_Update_Page.jsp"><button> Update More </button></a>
<a href="../Faculty_DataBase.jsp"><button> Check Database </button></a>
<a href="../../index.jsp"><button> Homepage</button></a>
<jsp:include page="../../footer.jsp"/>
</body>
</html>
