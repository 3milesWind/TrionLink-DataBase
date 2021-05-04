<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: AmberWang
  Date: 2021/5/2
  Time: 上午 10:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%!
    String course_id = "";
    boolean is_correct = false;
%>
<%
    try {
        String url = "jdbc:postgresql://localhost:5432/postgres?user=postgres&password=4645";
        Class.forName("org.postgresql.Driver");
        Connection conn = DriverManager.getConnection(url);
        conn.setAutoCommit(false);

        course_id = request.getParameter("CourseID");
        String sql = "DELETE FROM Course WHERE CourseId = ?";
        String sql_ck = "SELECT * FROM Course WHERE CourseId = ?";

        PreparedStatement ck = conn.prepareStatement(sql_ck);
        ck.setString(1, course_id);
        ResultSet st = ck.executeQuery();
        if (st.next()) {
            is_correct = true;
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, course_id);
            ps.executeUpdate();
            ps.close();
        } else {
            is_correct = false;
            System.out.println("Course ID did not find");
        }
        conn.commit();
        conn.setAutoCommit(true);
        ck.close();
        st.close();
        conn.close();
    } catch (Exception e) {
        System.out.println(e);
    }
%>

<% if(is_correct) {%>
    <h3>Successful Deleted</h3>
    <br/> <br/>
    <a href="./Course_Delete_Page.jsp"><button> Delete More </button></a>
    <a href="../Course_DataBase_Info.jsp"><button> Check Database </button></a>
    <a href="../../index.jsp"><button> Homepage</button></a>
    <jsp:include page="../../footer.jsp"/>
<% } else {%>
    <h3>Please, check the course ID. And try again </h3>
    <a href="Course_Delete_Page.jsp"><button> Re-Enter </button></a>
    <a href="../../index.jsp"><button> HomePage </button></a>
    <jsp:include page="../../footer.jsp"/>
<% } %>


</body>
</html>
