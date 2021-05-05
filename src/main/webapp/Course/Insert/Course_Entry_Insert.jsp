<%@ page import="java.sql.*" %><%--
  Created by IntelliJ IDEA.
  User: AmberWang
  Date: 2021/5/2
  Time: 上午 03:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%!
    String url = "jdbc:postgresql://localhost:5432/postgres?user=postgres&password=4645";
    String course_ID = "";
    String course_name = "";
    String department = "";
    String prerequisites = "";
    String grade_option = "";
    String lab = "";
    String min_units = "";
    String max_units = "";
    boolean is_correct = false;
%>
<%
    try{
        Class.forName("org.postgresql.Driver");
        Connection conn = DriverManager.getConnection(url);

        course_ID = request.getParameter("CourseID");
        course_name = request.getParameter("CourseName");
        department = request.getParameter("Department");
        prerequisites = request.getParameter("Prerequisites");
        grade_option = request.getParameter("GradeOption");
        lab = request.getParameter("Lab");
        min_units = request.getParameter("MinUnits");
        max_units = request.getParameter("MaxUnits");

        String sql = "INSERT INTO Course VALUES (?,?,?,?,?,?,?,?)";
        String sql_ck = "SELECT * FROM Course WHERE CourseId = ?";
        conn.setAutoCommit(false);
        PreparedStatement ck = conn.prepareStatement(sql_ck);
        ck.setString(1, course_ID);
        ResultSet rs = ck.executeQuery();
        if (rs.next()) {
            conn.setAutoCommit(true);
            ck.close();
            System.out.println("Course insert -- no data");
        }else {
            is_correct = true;
            PreparedStatement st = conn.prepareStatement(sql);

            st.setString(1, course_ID);
            st.setString(2, course_name);
            st.setString(3, department);
            st.setString(4, prerequisites);
            st.setString(5, grade_option);
            st.setString(6, lab);
            st.setInt(7, Integer.parseInt(min_units));
            st.setInt(8, Integer.parseInt(max_units));
            st.executeUpdate();
            ck.close();
        }
        conn.commit();
        conn.setAutoCommit(true);
        rs.close();
        conn.close();

    }catch (Exception e){
        System.out.println(e);
    }
%>

<%
    if (is_correct) {
        out.println("<H3><u>Successful Insert new Course into the dataBase</u></b>");
    } else {
        out.println("<H3><u>The Course ID shown below have existed , Please, try again</u></b>");
    }
%>

<br/><br/>
Course ID: <%=course_ID%>
<br/><br/>
Course Name: <%=course_name%>
<br/><br/>
<a href="../Course_DataBase_Info.jsp"><button> Check Database </button></a>
<a href="./../../index.jsp"><button> Homepage </button></a>
<jsp:include page="../../footer.jsp"/>

</body>
</html>
