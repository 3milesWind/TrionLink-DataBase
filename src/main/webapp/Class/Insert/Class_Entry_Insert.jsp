<%@ page import="java.sql.*" %><%--
  Created by IntelliJ IDEA.
  User: AmberWang
  Date: 2021/5/2
  Time: 上午 10:39
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
    String class_ID = "";
    String course_ID = "";
    String title = "";
    String quarter = "";
    String year = "";
    String numbersec = "";
    String nextoffer_quarter = "";
    String nextoffer_year = "";
    boolean class_not_exist = false;
    boolean course_not_exist = false;
    boolean dup_year_quarter = false;
    boolean correct_num_sec = false;
    boolean current_year_not_correct = false;
    boolean offer_year_not_correct = false;
    boolean is_correct = false;
%>
<%
    try {
        Class.forName("org.postgresql.Driver");
        Connection conn = DriverManager.getConnection(url);
        class_ID = request.getParameter("ClassID");
        course_ID = request.getParameter("CourseID");
        title = request.getParameter("Title");
        quarter = request.getParameter("Quarter");
        year = request.getParameter("Year");
        numbersec = request.getParameter("NumberSec");
        nextoffer_quarter = request.getParameter("NextOfferQuarter");
        nextoffer_year = request.getParameter("NextOfferYear");

        String sql = "INSERT INTO Class VALUES (?,?,?,?,?,?,?)";
        String sql_ck = "SELECT * FROM Class WHERE ClassID = ?";
        String sql_ck_1 = "SELECT * FROM Course WHERE CourseID = ?";
        String sql_ck_2 = "SELECT * FROM Class WHERE Quarter = ? AND Year = ? AND CourseID = ?";

        conn.setAutoCommit(false);

        // check if course exists
        PreparedStatement ck_1 = conn.prepareStatement(sql_ck_1);
        ck_1.setString(1, course_ID);
        ResultSet rs_1 = ck_1.executeQuery();

        // check if class is duplicate (same class id)
        PreparedStatement ck = conn.prepareStatement(sql_ck);
        ck.setString(1, class_ID);
        ResultSet rs = ck.executeQuery();

        // check if course ID & quarter & year are duplicate
        PreparedStatement ck_2 = conn.prepareStatement(sql_ck_2);
        ck_2.setString(1, quarter);
        ck_2.setString(2, year);
        ck_2.setString(3, course_ID);
        ResultSet rs_2 = ck_2.executeQuery();

        course_not_exist = false;
        class_not_exist = false;
        dup_year_quarter = false;
        correct_num_sec = true;
        current_year_not_correct = false;
        offer_year_not_correct = false;
        is_correct = false;
        // insert class when course is already existed
        if (!rs_1.next()) {
            course_not_exist = true;
            System.out.println("Class insert -- no such a course");
        } else if (rs.next()) {
            System.out.println("Class insert -- duplicate class");
        } else {
            class_not_exist = true;
            if (rs_2.next()) {
                dup_year_quarter = true;
                System.out.println("Class insert -- duplicate quarter and year of same course");
            } else {
                // if numbersec is not numeric
                if ( (! numbersec.chars().allMatch(Character::isDigit)) || (Integer.parseInt(numbersec) <= 0) ) {
                    correct_num_sec = false;
                    System.out.println("Class insert -- Number of sections is not numeric or not larger than 0");
                } else if ( ! nextoffer_year.chars().allMatch(Character::isDigit) ) {
                    offer_year_not_correct = true;
                    System.out.println("Class insert -- Offer year is not numeric");
                } else if ( ! year.chars().allMatch(Character::isDigit) ) {
                    current_year_not_correct = true;
                    System.out.println("Class insert -- Current year is not numeric");
                }
                else {
                    if (Integer.parseInt(nextoffer_year) < 2020) {
                        offer_year_not_correct = true;
                        System.out.println("Class insert -- Offer year should be larger or equal to 2020");
                    } else if (Integer.parseInt(year) > 2018) {
                        current_year_not_correct = true;
                        System.out.println("Class insert -- Current year should be less or equal to 2018");
                    }
                    else {
                        // otherwise, just insert
                        PreparedStatement st = conn.prepareStatement(sql);
                        st.setString(1, class_ID);
                        st.setString(2, course_ID);
                        st.setString(3, title);
                        st.setString(4, quarter);
                        st.setString(5, year);
                        st.setString(6, numbersec);
                        String nextoffer = nextoffer_quarter + "," + nextoffer_year;
                        st.setString(7, nextoffer);
                        st.executeUpdate();
                        ck.close();
                    }
                }
            }
        }
        rs_1.close();
        rs.close();
        rs_2.close();
        conn.commit();
        conn.setAutoCommit(true);
        conn.close();
    } catch (Exception e) {
        System.out.println(e);
    }
%>

<%
    if (course_not_exist) {
        out.println("<H3><u>The Course ID shown below does not existed , Please, try again</u></b>");
    } else {
        if (class_not_exist) {
            if (dup_year_quarter) {
                out.println("<H3><u>The Quarter and Year of the same Course is already existed. Please, try again</u></b>");
            } else if (! correct_num_sec) {
                out.println("<H3><u>The number of sections is invalid (Either not numeric or not larger than 0). Please, try again</u></b>");
            } else if (offer_year_not_correct) {
                out.println("<H3><u>The offer year is invalid (Either not numeric or not larger or equal to 2020). Please, try again</u></b>");
            } else if (current_year_not_correct) {
                out.println("<H3><u>The current year is invalid (Either not numeric or not less or equal to 2018). Please, try again</u></b>");
            } else {
                out.println("<H3><u>Successful Insert new Class into the dataBase</u></b>");
            }
        } else {
            out.println("<H3><u>The Class ID shown below have existed , Please, try again</u></b>");
        }
    }
%>

<br/><br/>
Class ID: <%=class_ID%>
<br/><br/>
Course ID: <%=course_ID%>
<br/><br/>
Title: <%=title%>
<br/><br/>
<a href="Class_Insert_Page.jsp"><button> Resubmit Again </button></a>
<a href="../Class_Database_Info.jsp"><button> Check Database </button></a>
<a href="./../../index.jsp"><button> Homepage </button></a>
<jsp:include page="../../footer.jsp"/>

</body>
</html>
