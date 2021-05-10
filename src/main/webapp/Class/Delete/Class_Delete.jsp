<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: AmberWang
  Date: 2021/5/2
  Time: 上午 10:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <%!
        String class_id = "";
        boolean is_correct = false;
    %>
    <%
        try {
            String url = "jdbc:postgresql://localhost:5432/postgres?user=postgres&password=4645";
            Class.forName("org.postgresql.Driver");
            Connection conn = DriverManager.getConnection(url);
            conn.setAutoCommit(false);

            class_id = request.getParameter("ClassID");
            String sql_ck = "SELECT * FROM Class WHERE ClassId = ?";
            String sql_de = "DELETE FROM Class WHERE ClassId = ?";

            // check if class id exists
            PreparedStatement ck = conn.prepareStatement(sql_ck);
            ck.setString(1, class_id);
            ResultSet st_ck = ck.executeQuery();
            is_correct = false;
            if (st_ck.next()) {
                is_correct = true;
                PreparedStatement ps = conn.prepareStatement(sql_de);
                ps.setString(1, class_id);
                ps.executeUpdate();
                ps.close();
            } else {
                System.out.println("Class delete -- Class ID did not find");
            }
            conn.commit();
            conn.setAutoCommit(true);
            ck.close();
            st_ck.close();
            conn.close();
        } catch (Exception e) {
            System.out.println(e);
        }
    %>
    <% if(is_correct) {%>
    <h3>Successful Deleted</h3>
    <br/> <br/>
    <a href="./Class_Delete_Page.jsp"><button> Delete More </button></a>
    <a href="../Class_Database_Info.jsp"><button> Check Database </button></a>
    <a href="../../index.jsp"><button> Homepage</button></a>
    <jsp:include page="../../footer.jsp"/>
    <% } else {%>
    <h3>Please, check the class ID. And try again </h3>
    <a href="./Class_Delete_Page.jsp"><button> Re-Enter </button></a>
    <a href="../../index.jsp"><button> HomePage </button></a>
    <jsp:include page="../../footer.jsp"/>
    <% } %>
</body>
</html>
