<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: AmberWang
  Date: 2021/5/3
  Time: 上午 07:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%!
    String meeting_ID = "";
    String section_ID = "";
    String required = "";
    String type = "";
    String time = "";
    String date = "";
    String room = "";
    boolean is_correct = false;
//    boolean no_course_existed = false;
    boolean no_section_existed = false;
%>
<%
    String url = "jdbc:postgresql://localhost:5432/postgres?user=postgres&password=4645";
    try {
        Class.forName("org.postgresql.Driver");
        Connection conn = DriverManager.getConnection(url);
        conn.setAutoCommit(false);
        meeting_ID = request.getParameter("MeetingID");
        section_ID = request.getParameter("SectionID");
        required = request.getParameter("Required");
        type = request.getParameter("Type");
        time = request.getParameter("Time");
        date = request.getParameter("Date");
        room = request.getParameter("Room");
        String sql_insert = "INSERT INTO Meeting VALUES (?,?,?,?,?,?,?)";
//        String sql_ck_course = "SELECT * FROM Course WHERE CourseId = ?";
        String sql_ck_section = "SELECT * FROM Section WHERE SectionId = ?";

//        // check if course exists
//        PreparedStatement ck_course = conn.prepareStatement(sql_ck_course);
//        ck_course.setString(1, course_ID);
//        ResultSet rs_course = ck_course.executeQuery();
        // check if section exists
        PreparedStatement ck_section = conn.prepareStatement(sql_ck_section);
        ck_section.setString(1, section_ID);
        ResultSet rs_section = ck_section.executeQuery();

//        no_course_existed = false;
        no_section_existed = false;
        is_correct = false;
//        if (! rs_course.next()) {
//            no_course_existed = true;
//            System.out.println("no such a course");
//            System.out.println("Review session insert -- no data");
//        } else
        if (! rs_section.next()) {
            no_section_existed = true;
            System.out.println("no such a section");
            System.out.println("Review session insert -- no data");
        } else {
            is_correct = true;
            PreparedStatement st = conn.prepareStatement(sql_insert);
            st.setString(1, meeting_ID);
            st.setString(2, section_ID);
            st.setString(3, required);
            st.setString(4, type);
            st.setString(5, time);
            st.setString(6, date);
            st.setString(7, room);
            st.executeUpdate();
            st.close();
        }
//        ck_course.close();
        ck_section.close();
        conn.commit();
        conn.setAutoCommit(true);
//        rs_course.close();
        rs_section.close();
        conn.close();

    } catch (Exception e) {
        System.out.println(e);
    }
%>
<%
    if (!is_correct) {
        if (no_section_existed) {
            out.println("<H3><u>The section ID shown below does not exists, Please, try again</u></b>");
        }
//        else if (no_course_existed) {
//            out.println("<H3><u>The course ID shown below does not exists, Please, try again</u></b>");
//        }
    }
    else {
        out.println("<H3><u>Successful Insert new Review Session into the dataBase</u></b>");
    }
%>

<br/><br/>
Meeting ID: <%=meeting_ID%>
<br/><br/>
Section ID: <%=section_ID%>
<br/><br/>
Required: <%=required%>
<br/><br/>
Type: <%=type%>
<br/><br/>
Time: <%=time%>
<br/><br/>
Date: <%=date%>
<br/><br/>
Room: <%=room%>
<br/><br/>
<a href="Review_Session_Submission.jsp"><button> Submit again </button></a>
<a href="../Review_Session_Database.jsp"><button> Check Database </button></a>
<a href="../../index.jsp"><button> Homepage </button></a>
<jsp:include page="../../footer.jsp"/>
</body>
</html>
