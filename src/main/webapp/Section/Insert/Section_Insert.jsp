<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
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
    String Course_ID = "";
    String Class_ID = "";
    String Section_ID = "";
    String Faculty_Name = "";
    String Enrollment_Limit = "";
    String Wait_List = "";
    boolean no_course_existed = false;
    boolean no_class_existed = false;
    boolean no_faculty_existed = false;
%>
<%
    String url = "jdbc:postgresql://localhost:5432/postgres?user=postgres&password=4645";
    try {
        Class.forName("org.postgresql.Driver");
        Connection conn = DriverManager.getConnection(url);
        conn.setAutoCommit(false);
        Course_ID = request.getParameter("CourseID");
        Class_ID = request.getParameter("ClassID");
        Section_ID = request.getParameter("SectionID");
        Faculty_Name = request.getParameter("FacultyName");
        Enrollment_Limit = request.getParameter("EnrollmentLimit");
        Wait_List = request.getParameter("WaitList");

        // check if course exists in the database
        PreparedStatement st_ck_1 = conn.prepareStatement("SELECT * FROM Course WHERE CourseId = ?");
        st_ck_1.setString(1, Course_ID);
        ResultSet rs_ck_1 = st_ck_1.executeQuery();
        // check if course exists in the database
        PreparedStatement st_ck_2 = conn.prepareStatement("SELECT * FROM Class WHERE ClassId = ?");
        st_ck_2.setString(1, Class_ID);
        ResultSet rs_ck_2 = st_ck_2.executeQuery();
        // check if faculty name exists
        PreparedStatement st_ck_3 = conn.prepareStatement("SELECT * FROM Faculty WHERE Faculty_name = ?");
        st_ck_3.setString(1, Faculty_Name);
        ResultSet rs_ck_3 = st_ck_3.executeQuery();

        no_course_existed = false;
        no_class_existed = false;
        no_faculty_existed = false;
        if (rs_ck_1.next()) {
            no_course_existed = true;
            System.out.println("Section insert -- no such an course");
        } else if (rs_ck_2.next()) {
            no_class_existed = true;
            System.out.println("Section insert -- no such an class");
        } else if (rs_ck_3.next()) {
            no_faculty_existed = true;
            System.out.println("no such an faculty");
        } else {
            // if all existed, insert
            String sql_insert = "INSERT INTO Section VALUES (?,?,?,?,?,?)";
            PreparedStatement st_insert = conn.prepareStatement(sql_insert);
            st_insert.setString(1, Course_ID);
            st_insert.setString(2, Class_ID);
            st_insert.setString(3, Section_ID);
            st_insert.setString(4, Faculty_Name);
            st_insert.setString(5, Enrollment_Limit);
            st_insert.setString(6, Wait_List);
            st_insert.executeUpdate();
            st_insert.close();
        }
        conn.commit();
        conn.setAutoCommit(true);
        rs_ck_1.close();
        rs_ck_2.close();
        rs_ck_3.close();
        conn.close();
    } catch (Exception e) {
        System.out.println(e);
    }
%>
<br/><br>
<%
    if (no_course_existed) {
        out.println("<H3><u>The course ID shown below does not exists, Please, try again</u></b>");
    } else if (no_class_existed) {
        out.println("<H3><u>The class ID shown below does not exists, Please, try again</u></b>");
    } else if (no_faculty_existed) {
        out.println("<H3><u>The faculty name shown below does not exists, Please, try again</u></b>");
    } else {
        out.println("<H3><u>Successfully insert a new section into the dataBase</u></b>");
    }
%>
<br/><br>
Course ID: <%=Course_ID%>
<br/><br>
Class ID: <%=Class_ID%>
<br/><br>
Section ID: <%=Section_ID%>
<br/><br>
Faculty Name: <%=Faculty_Name%>
<br/><br>
Enrollment Limit: <%=Enrollment_Limit%>
<br/><br>
Wait List: <%=Wait_List%>
<br/><br>
<a href="../Section_Database_Info.jsp"><button> Check Database </button></a>
<a href="./../../index.jsp"><button> Homepage </button></a>
<jsp:include page="../../footer.jsp"/>
</body>
</html>
