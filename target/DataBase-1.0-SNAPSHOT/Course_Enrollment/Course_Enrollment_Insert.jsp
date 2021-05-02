<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: AmberWang
  Date: 2021/5/2
  Time: 下午 12:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%!
    String Student_ID = "";
    String Course_ID = "";
    String Quarter = "";
    String Year = "";
    Boolean is_correct = false;
%>
<%
    String url = "jdbc:postgresql://localhost:5432/postgres?user=postgres&password=4645";
    try {
        Class.forName("org.postgresql.Driver");
        Connection conn = DriverManager.getConnection(url);
        Student_ID = request.getParameter("StudentID");
        Course_ID = request.getParameter("CourseID");
        Quarter = request.getParameter("Quarter");
        Year = request.getParameter("Year");
        String sql = "INSERT INTO Enrollment VALUES (?,?,?)";
        String sql_ck_1 = "SELECT * FROM Student WHERE Student_Id = ?";
        String sql_ck_2 = "SELECT * FROM Course WHERE CourseId = ?";
        String sql_ck_3 = "SELECT * FROM Class WHERE CourseId = ? AND Quarter = ? AND Year = ?";

        conn.setAutoCommit(false);
        // check if student id exists
        PreparedStatement ck_1 = conn.prepareStatement(sql_ck_1);
        ck_1.setString(1, Student_ID);
        ResultSet rs_1 = ck_1.executeQuery();
        // check if course id exists
        PreparedStatement ck_2 = conn.prepareStatement(sql_ck_2);
        ck_2.setString(1, Course_ID);
        ResultSet rs_2 = ck_2.executeQuery();
        // check if (courseid, quarter, year) is in the database
        PreparedStatement ck_3 = conn.prepareStatement(sql_ck_3);
        ck_3.setString(1, Course_ID);
        ck_3.setString(2, Quarter);
        ck_3.setString(3, Year);
        ResultSet rs_3 = ck_3.executeQuery();

        // student id does not exist
        if (!rs_1.next()) {
            System.out.println("no such a student");
            conn.setAutoCommit(true);
            ck_1.close();
            ck_2.close();
            ck_3.close();
//            System.out.println("Course enrollment insert -- no data");
        }
        // course id does not exist
        else if (!rs_2.next()) {
            System.out.println("no such a course");
            conn.setAutoCommit(true);
            ck_1.close();
            ck_2.close();
            ck_3.close();
//            System.out.println("Course enrollment insert -- no data");
        }
        // class id does not exist
        else if (!rs_3.next()) {
            System.out.println("no such a class");
            conn.setAutoCommit(true);
            ck_1.close();
            ck_2.close();
            ck_3.close();
//            System.out.println("Course enrollment insert -- no data");
        }


//        if (!rs_1.next() || !rs_2.next() || !rs_3.next()) {
//            conn.setAutoCommit(true);
//            ck_1.close();
//            ck_2.close();
//            ck_3.close();
//            System.out.println("Course enrollment insert -- no data");
//        }
        else {
            is_correct = true;
//            PreparedStatement st = conn.prepareStatement(sql);
//            st.setString(1, Student_ID);
//            st.setString(2, Course_ID);
//            st.executeUpdate();
//            ck_1.close();
//            ck_2.close();
//            ck_3.close();

            // if info is correct, then consider next
            String find_num_sec = "SELECT ClassId, numbersec From Class WHERE CourseId = ? AND Quarter = ? AND Year = ?";
            conn.setAutoCommit(false);
            PreparedStatement st_1 = conn.prepareStatement(find_num_sec);
            st_1.setString(1, Course_ID);
            st_1.setString(2, Quarter);
            st_1.setString(3, Year);
            ResultSet rs = st_1.executeQuery();
            // use courseid, quarter, year to find numbersec in Class
            rs.next();
            String Class_Id = rs.getString("ClassId");
            Integer num_sec = Integer.parseInt( rs.getString("numbersec") );

            System.out.println(num_sec);


            st_1.close();
            rs.close();
            // if multiple sections (numbersec from table class)
            if (num_sec > 1) {

                // direct to another page to prompt for section id
                session.setAttribute("student_id", Student_ID);
                session.setAttribute("course_id", Course_ID);
                response.sendRedirect("./Course_Enrollment_Section_Page.jsp");
                System.out.println("should direct to another page");
            } else {
                // find the section id
                PreparedStatement st_2 = conn.prepareStatement("SELECT SectionId From Section WHERE ClassId = ?");
                st_2.setString(1, Class_Id);
                ResultSet rs_a = st_2.executeQuery();
                rs_a.next();
                String section_id = rs.getString("SectionId");
                st_2.close();
                rs_a.close();

                // insert the enrollment
                PreparedStatement st = conn.prepareStatement(sql);
                st.setString(3, section_id);
                st.setString(1, Student_ID);
                st.setString(2, Course_ID);
                st.executeUpdate();

            }
            ck_1.close();
            ck_2.close();
            ck_3.close();
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

<%
    if (is_correct) {
        out.println("<H3><u>Successful Insert new Enrollment into the dataBase</u></b>");
    } else {
        out.println("<H3><u>Either Student ID, Course ID, or corresponding section shown below does not exist in the database, Please, try again</u></b>");
    }
%>
</body>
</html>
