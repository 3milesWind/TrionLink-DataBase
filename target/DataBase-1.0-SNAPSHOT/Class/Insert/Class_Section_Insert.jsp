<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: AmberWang
  Date: 2021/5/3
  Time: 下午 08:54
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
    String Title = "";
    String Quarter = "";
    String Year = "";
    String NumberSec = "";
    String Section_ID = "";
    String Class_ID = "";
    String Instructor = "";
    String Enrollment_Limit = "";
    String Wait_List = "";
    boolean no_instructor_existed = false;
%>
<%
    String url = "jdbc:postgresql://localhost:5432/postgres?user=postgres&password=4645";
    try {
        Class.forName("org.postgresql.Driver");
        Connection conn = DriverManager.getConnection(url);
        conn.setAutoCommit(false);
        Course_ID = (String)session.getAttribute("course_id");
        Title = (String)session.getAttribute("title");
        Quarter = (String)session.getAttribute("quarter");
        Year = (String)session.getAttribute("year");
        NumberSec = (String)session.getAttribute("numbersec");
        Section_ID = request.getParameter("SectionID");
        Class_ID = request.getParameter("ClassID");
        Instructor = request.getParameter("Instructor");
        Enrollment_Limit = request.getParameter("EnrollmentLimit");
        Wait_List = request.getParameter("WaitList");

        // check if instructor exists
        PreparedStatement st_ck_instr = conn.prepareStatement("SELECT * FROM Faculty WHERE Faculty_name = ?");
        st_ck_instr.setString(1, Instructor);
        ResultSet rs_ck = st_ck_instr.executeQuery();

        no_instructor_existed = false;
        if (rs_ck.next()) {
            // if all correct, then insert
            // insert into class table
            String sql_insert_class = "INSERT INTO Class VALUES (?,?,?,?,?,?)";
            PreparedStatement st_class = conn.prepareStatement(sql_insert_class);
            st_class.setString(1, Class_ID);
            st_class.setString(2, Course_ID);
            st_class.setString(3, Title);
            st_class.setString(4, Quarter);
            st_class.setString(5, Year);
            st_class.setString(6, NumberSec);
            st_class.executeUpdate();
            st_class.close();
            // insert into section table
            String sql_insert_sec = "INSERT INTO Section VALUES (?,?,?,?,?)";
            PreparedStatement st_sec = conn.prepareStatement(sql_insert_sec);
            st_sec.setString(1, Section_ID);
            st_sec.setString(2, Class_ID);
            st_sec.setString(3, Instructor);
            st_sec.setString(4, Enrollment_Limit);
            st_sec.setString(5, Wait_List);
            st_sec.executeUpdate();
            st_sec.close();
        } else { // resubmit again
            no_instructor_existed = true;
            System.out.println("no such an instructor");
            System.out.println("Section insert -- no data");
        }
        conn.commit();
        conn.setAutoCommit(true);
        rs_ck.close();
        conn.close();
    } catch (Exception e) {
        System.out.println(e);
    }
%>

<br/><br>
<%
    if (no_instructor_existed) {
        out.println("<H3><u>The instructor shown below does not exists, Please, try again</u></b>");
    }
    else {
        out.println("<H3><u>Successful Insert new Section into the dataBase</u></b>");
    }
%>
<br/><br>
Section ID: <%=Section_ID%>
<br/><br>
Class ID: <%=Class_ID%>
<br/><br>
Instructor: <%=Instructor%>
<br/><br>
Enrollment Limit: <%=Enrollment_Limit%>
<br/><br>
Wait List: <%=Wait_List%>
<br/><br>
<a href="../Class_Database_Info.jsp"><button> Check Database </button></a>
<a href="./../../index.jsp"><button> Homepage </button></a>
<jsp:include page="../../footer.jsp"/>
</body>
</html>
