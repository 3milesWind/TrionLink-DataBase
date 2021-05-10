<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="javax.xml.transform.Result" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: AmberWang
  Date: 2021/5/10
  Time: 上午 01:12
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
    String section_id = "";
    boolean course_not_existed = false;
    boolean course_section_not_existed = false;
%>
<%
    try {
        String url = "jdbc:postgresql://localhost:5432/postgres?user=postgres&password=4645";
        Class.forName("org.postgresql.Driver");
        Connection conn = DriverManager.getConnection(url);
        conn.setAutoCommit(false);
        course_id = request.getParameter("CourseID");
        section_id = request.getParameter("SectionID");
        String sql_ck_1 = "SELECT * FROM Course WHERE CourseId = ?";
        String sql_ck_2 = "SELECT * FROM Section WHERE CourseId = ? AND SectionId = ?";
        String sql_de = "DELETE FROM Section WHERE CourseId = ? AND SectionId = ?";
        // check if course ID exists
        PreparedStatement ck_1 = conn.prepareStatement(sql_ck_1);
        ck_1.setString(1, course_id);
        ResultSet rs_1 = ck_1.executeQuery();

        // check if (courseID, SectionID) exists
        PreparedStatement ck_2 = conn.prepareStatement(sql_ck_2);
        ck_2.setString(1, course_id);
        ck_2.setString(2, section_id);
        ResultSet rs_2 = ck_2.executeQuery();

        course_not_existed = false;
        course_section_not_existed = false;
        if (!rs_1.next()) {
            course_not_existed = true;
            System.out.println("Section delete -- no such an course");
        } else if (!rs_2.next()) {
            course_section_not_existed = true;
            System.out.println("Section delete -- no such an (courseID, sectionID)");
        } else {
            // otherwise, delete it
            PreparedStatement ps = conn.prepareStatement(sql_de);
            ps.setString(1, course_id);
            ps.setString(2, section_id);
            ps.executeUpdate();
            ps.close();
        }
        conn.commit();
        conn.setAutoCommit(true);
        rs_1.close();
        rs_2.close();
        conn.close();
    } catch (Exception e) {
        System.out.println(e);
    }
%>
<% if(course_not_existed) {%>
<h3>Please, check the course ID. And try again</h3>
<br/> <br/>
<a href="./Section_Delete_Page.jsp"><button> Re-Submit </button></a>
<a href="../../index.jsp"><button> Homepage </button></a>
<jsp:include page="../../footer.jsp"/>
<% } else if (course_section_not_existed){%>
<h3>Please, check the course ID and section ID. And try again </h3>
<a href="./Section_Delete_Page.jsp"><button> Re-Submit </button></a>
<a href="../../index.jsp"><button> HomePage </button></a>
<jsp:include page="../../footer.jsp"/>
<% } else {%>
<h3>Successfully delete.</h3>
<br/> <br/>
<a href="./Section_Delete_Page.jsp"><button> Delete More </button></a>
<a href="../Section_Database_Info.jsp"><button> Check Database </button></a>
<a href="../../index.jsp"><button> Homepage </button></a>
<jsp:include page="../../footer.jsp"/>
<% } %>
</body>
</html>
