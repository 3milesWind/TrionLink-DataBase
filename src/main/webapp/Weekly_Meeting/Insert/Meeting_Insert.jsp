<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page isErrorPage="true" %>
<%--
  Created by IntelliJ IDEA.
  User: AmberWang
  Date: 2021/5/10
  Time: 下午 11:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <%!
        String course_ID = "";
        String section_ID = "";
        String meeting_ID = "";
        String required = "";
        String type = "";
        String start_time = "";
        String end_time = "";
        String room = "";
        boolean no_course_existed = false;
        boolean no_section_existed = false;
        boolean no_day_selected = false;
        boolean dup_course_meeting = false;
        boolean time_format_not_match = false;
        boolean start_gt_end = false; // check start < end
        boolean error_flag = false;
        String wrong = "";
    %>
    <%
        String url = "jdbc:postgresql://localhost:5432/postgres?user=postgres&password=4645";
        try {
            Class.forName("org.postgresql.Driver");
            Connection conn = DriverManager.getConnection(url);
            conn.setAutoCommit(false);

            course_ID = request.getParameter("CourseID");
            section_ID = request.getParameter("SectionID");
            meeting_ID = request.getParameter("MeetingID");
            required = request.getParameter("Required");
            type = request.getParameter("Type");
            String day[] = request.getParameterValues("day");
            start_time = request.getParameter("StartTime");
            end_time = request.getParameter("EndTime");
            room = request.getParameter("Room");
            String sql_ck_1 = "SELECT * FROM Course WHERE CourseId = ?";
            String sql_ck_2 = "SELECT * FROM Section WHERE CourseId = ? AND SectionId = ?";
            String sql_ck_3 = "SELECT * FROM Meeting WHERE MeetingId = ?";


            PreparedStatement ck_1 = conn.prepareStatement(sql_ck_1);
            ck_1.setString(1, course_ID);
            ResultSet rs_1 = ck_1.executeQuery();

            PreparedStatement ck_2 = conn.prepareStatement(sql_ck_2);
            ck_2.setString(1, course_ID);
            ck_2.setString(2, section_ID);
            ResultSet rs_2 = ck_2.executeQuery();

            PreparedStatement ck_3 = conn.prepareStatement(sql_ck_3);
            ck_3.setString(1, meeting_ID);
            ResultSet rs_3 = ck_3.executeQuery();

            no_course_existed = false;
            no_section_existed = false;
            no_day_selected = false;
            start_gt_end = false;
            time_format_not_match = false;
            dup_course_meeting = false;

            if (day == null || day.length == 0) { // check if days are selected
                no_day_selected = true;
                System.out.println("Meeting insert -- no day is selected");
            } else if (!rs_1.next()) {
                no_course_existed = true;
                System.out.println("Meeting insert -- no such a course");
            } else if (!rs_2.next()) {
                no_section_existed = true;
                System.out.println("Meeting insert -- no such a (courseID, sectionID)");
            } else if (!start_time.matches("\\d{2}:\\d{2}") || ! end_time.matches("\\d{2}:\\d{2}")) { // check if start time and end time matches the format dd:dd
                time_format_not_match = true;
                System.out.println("Meeting insert -- time format not match 'dd:dd'");
            } else if (rs_3.next()) {
                dup_course_meeting = true;
                System.out.println("Meeting insert -- duplicate meeting id");
            }
            else {
                // if so, then check if start time <= end time
                String startt = String.join("", start_time.split(":"));
                String endt = String.join("", end_time.split(":"));
                if (Integer.parseInt(startt) > Integer.parseInt(endt)) {
                    start_gt_end = true;
                    System.out.println("Meeting insert -- start time later than end time");
                } else {
                    // if all correct, then insert
                    String days = String.join(",", day);
                    String sql_insert = "INSERT INTO Meeting VALUES (?,?,?,?,?,?,?,?,?)";
                    PreparedStatement st = conn.prepareStatement(sql_insert);
                    st.setString(1, course_ID);
                    st.setString(2, section_ID);
                    st.setString(3, meeting_ID);
                    st.setString(4, required);
                    st.setString(5, type);
                    st.setString(6, days);
                    st.setString(7, start_time);
                    st.setString(8, end_time);
                    st.setString(9, room);
                    st.executeUpdate();
                    st.close();
                }
            }

            conn.commit();
            conn.setAutoCommit(true);
            rs_1.close();
            rs_2.close();
            ck_1.close();
            ck_2.close();
            conn.close();
        } catch (Exception e) {
            error_flag = true;
            wrong = e.toString();
            System.out.println(e);
        }
    %>
    <%
        if (error_flag) {
            out.println("<H3><u>" + wrong + "</u></b>");
            out.println("<H3><u>Please, try again</u></b>");
        } else if (no_course_existed) {
            out.println("<H3><u>The course ID shown below does not exists, Please, try again</u></b>");
        } else if (no_section_existed) {
            out.println("<H3><u>The (course ID, section ID) shown below does not exists, Please, try again</u></b>");
        } else if (no_day_selected) {
            out.println("<H3><u>The day should be selected, Please, try again</u></b>");
        } else if (start_gt_end) {
            out.println("<H3><u>The start time is later than end time, Please, try again</u></b>");
        } else if (time_format_not_match) {
            out.println("<H3><u>The time format shown below does not match 'dd:dd', Please, try again</u></b>");
        } else if (dup_course_meeting) {
            out.println("<H3><u>The meetingId already exists, Please, try again</u></b>");
        } else {
            out.println("<H3><u>Successfully insert new weekly meeting into the database</u></b>");
        }
    %>
    <br/><br/>
    Course ID: <%=course_ID%>
    <br/><br/>
    Meeting ID: <%=meeting_ID%>
    <br/><br/>
    Required: <%=required%>
    <br/><br/>
    Type: <%=type%>
    <br/><br/>
    <a href="Meeting_Insert_Page.jsp"><button> Submit again </button></a>
    <a href="../Weekly_Meeting_Database.jsp"><button> Check Database </button></a>
    <a href="../../index.jsp"><button> Homepage </button></a>
    <jsp:include page="../../footer.jsp"/>
</body>
</html>
