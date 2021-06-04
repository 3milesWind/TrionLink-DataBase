<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.zip.DeflaterInputStream" %>
<%@ page import="java.util.Dictionary" %>
<%@ page import="java.util.Hashtable" %><%--
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
        String course_ID = "";
        String section_ID = "";
        String review_ID = "";
        String date = "";
        String start_time = "";
        String end_time = "";
        String room = "";
        boolean no_course_existed = false;
        boolean no_section_existed = false;
        boolean time_format_not_match = false;
        boolean date_format_not_match = false;
        boolean invalid_mon_date = false;
        boolean start_gt_end = false; // check start < end
        boolean is_correct = true;
        String wrong = "";
    %>
    <%
        is_correct = true;
        String url = "jdbc:postgresql://localhost:5432/postgres?user=postgres&password=4645";
        try {
            Class.forName("org.postgresql.Driver");
            Connection conn = DriverManager.getConnection(url);
            conn.setAutoCommit(false);
            course_ID = request.getParameter("CourseID");
            section_ID = request.getParameter("SectionID");
            review_ID = request.getParameter("ReviewID");
            date = request.getParameter("Date");
            start_time = request.getParameter("StartTime");
            end_time = request.getParameter("EndTime");
            room = request.getParameter("Room");
            String sql_insert = "INSERT INTO ReviewSession VALUES (?,?,?,?,?,?,?)";
            String sql_ck_1 = "SELECT * FROM Course WHERE CourseId = ?";
            String sql_ck_2 = "SELECT * FROM Section WHERE CourseId = ? AND SectionId = ?";

            // check if course exists
            PreparedStatement ck_1 = conn.prepareStatement(sql_ck_1);
            ck_1.setString(1, course_ID);
            ResultSet rs_1 = ck_1.executeQuery();
            // check if section exists
            PreparedStatement ck_2 = conn.prepareStatement(sql_ck_2);
            ck_2.setString(1, course_ID);
            ck_2.setString(2, section_ID);
            ResultSet rs_2 = ck_2.executeQuery();

            no_course_existed = false;
            no_section_existed = false;
            time_format_not_match = false;
            date_format_not_match = false;
            invalid_mon_date = false;
            start_gt_end = false;
            if (! rs_1.next()) {
                no_course_existed = true;
                System.out.println("Review session insert -- no such a course");
            } else if (! rs_2.next()) {
                no_section_existed = true;
                System.out.println("Review session insert -- no such a section");
            } else if (!start_time.matches("\\d{2}:\\d{2}") || ! end_time.matches("\\d{2}:\\d{2}")) {
                time_format_not_match = true;
                System.out.println("Review session insert -- time format not match 'nn:nn'");
            } else if (!date.matches("\\d{2}/\\d{2}")) {
                date_format_not_match = true;
                System.out.println("Review session insert -- date format not match 'mm/dd'");
            } else {
                // if so, then check if start time <= end time
                // and check if month and date are correct
                String startt = String.join("", start_time.split(":"));
                String endt = String.join("", end_time.split(":"));

                Dictionary<Integer, Integer> dic_md = new Hashtable<Integer, Integer>();
                dic_md.put(1, 31);
                dic_md.put(2, 29);
                dic_md.put(3, 31);
                dic_md.put(4, 30);
                dic_md.put(5, 31);
                dic_md.put(6, 30);
                dic_md.put(7, 31);
                dic_md.put(8, 31);
                dic_md.put(9, 30);
                dic_md.put(10, 31);
                dic_md.put(11, 30);
                dic_md.put(12, 31);

                Integer mon = Integer.parseInt( date.split("/")[0] );
                Integer da = Integer.parseInt( date.split("/")[1] );

                System.out.println(mon);
                System.out.println(da);
                System.out.println(dic_md.get(1));

                if (Integer.parseInt(startt) > Integer.parseInt(endt)) {
                    start_gt_end = true;
                    System.out.println("Review session insert -- start time later than end time");
                } else if (mon <= 0 || mon > 12) {
                    invalid_mon_date = true;
                    System.out.println("Review session insert -- invalid month or date");
                } else {
                    if (da > dic_md.get(mon) || da <= 0) {
                        invalid_mon_date = true;
                        System.out.println("Review session insert -- invalid month or date");
                    } else {
                        // if all correct, then insert
                        PreparedStatement st = conn.prepareStatement(sql_insert);
                        st.setString(1, course_ID);
                        st.setString(2, section_ID);
                        st.setString(3, review_ID);
                        st.setString(4, date);
                        st.setString(5, start_time);
                        st.setString(6, end_time);
                        st.setString(7, room);
                        st.executeUpdate();
                        st.close();
                    }
                }
            }
            ck_1.close();
            ck_2.close();
            conn.commit();
            conn.setAutoCommit(true);
            rs_1.close();
            rs_2.close();
            conn.close();

        } catch (Exception e) {
            is_correct = false;
            wrong = e.toString();
            System.out.println(e);
        }
    %>
    <%
        if (is_correct == false) {
            out.println("<H3><u>" + wrong + "</u></b>");
            out.println("<H3><u> Please, try again</u></b>");
        } else if (no_course_existed) {
            out.println("<H3><u>The course ID shown below does not exists, Please, try again</u></b>");
        } else if (no_section_existed) {
            out.println("<H3><u>The (course ID, section ID) shown below does not exists, Please, try again</u></b>");
        } else if (start_gt_end) {
            out.println("<H3><u>The start time is later than end time, Please, try again</u></b>");
        } else if (time_format_not_match) {
            out.println("<H3><u>The time format shown below does not match 'nn:nn', Please, try again</u></b>");
        } else if (invalid_mon_date) {
            out.println("<H3><u>The month or date is invalid, Please, try again</u></b>");
        } else if (date_format_not_match) {
            out.println("<H3><u>The date format shown below does not match 'mm/dd', Please, try again</u></b>");
        } else {
            out.println("<H3><u>Successfully insert new review session into the database</u></b>");
        }
    %>
    <br/><br/>
    Course ID: <%=course_ID%>
    <br/><br/>
    Review ID: <%=review_ID%>
    <br/><br/>
    Date: <%=date%>
    <br/><br/>
    <a href="Review_Session_Submission.jsp"><button> Submit again </button></a>
    <a href="../Review_Session_Database.jsp"><button> Check Database </button></a>
    <a href="../../insertPage.jsp"><button> Homepage </button></a>
    <jsp:include page="../../footer.jsp"/>
</body>
</html>
