<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %><%--
  Created by IntelliJ IDEA.
  User: AmberWang
  Date: 2021/5/2
  Time: 上午 10:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <%
        String CourseId = "";
        String CourseName = "";
        String Department = "";
        String Prerequisites = "";
        String Gradeoption = "";
        String Lab = "";
        Integer Minunits = 0;
        Integer Maxunits = 0;
    %>
    <%
        String url = "jdbc:postgresql://localhost:5432/postgres?user=postgres&password=4645";
        try {
            Class.forName("org.postgresql.Driver");
            Connection conn = DriverManager.getConnection(url);
            CourseId = request.getParameter("courseid");
            CourseName = request.getParameter("coursename");
            Department = request.getParameter("department");
            Prerequisites = request.getParameter("prerequisites");
            Gradeoption = request.getParameter("gradeoption");
            Lab = request.getParameter("lab");
            Minunits = Integer.valueOf(request.getParameter("minunits"));
            Maxunits = Integer.valueOf(request.getParameter("maxunits"));
            conn.setAutoCommit(false);
            String sql = "update course set course_name = ?, department = ?, prerequisites = ?, gradeoption = ?, lab = ?, minunits = ?, maxunits = ? where courseid = ?";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, CourseName);
            st.setString(2, Department);
            st.setString(3, Prerequisites);
            st.setString(4, Gradeoption);
            st.setString(5, Lab);
            st.setInt(6, Minunits);
            st.setInt(7, Maxunits);
            st.setString(8, CourseId);
            int row = st.executeUpdate();
            conn.commit();
            conn.setAutoCommit(true);
            st.close();

        } catch (Exception e) {
            System.out.println(e);
        }
    %>
    <p>Successful Update Student Information</p>
    <br/><br>
    Course ID: <%=CourseId%>
    <br/><br>
    Department: <%=Department%>
    <br/><br>
    <a href="../Course_DataBase_Info.jsp"><button> Check Database </button></a>
    <jsp:include page="../../footer.jsp"/>
</body>
</html>
