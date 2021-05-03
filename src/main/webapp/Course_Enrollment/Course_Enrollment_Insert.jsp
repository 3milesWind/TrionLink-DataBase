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
    boolean is_correct = false;
    boolean already_existed = false;
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
            System.out.println("Course enrollment insert -- no data");
        }
        // course id does not exist
        else if (!rs_2.next()) {
            System.out.println("no such a course");
            conn.setAutoCommit(true);
            ck_1.close();
            ck_2.close();
            ck_3.close();
            System.out.println("Course enrollment insert -- no data");
        }
        // class id does not exist
        else if (!rs_3.next()) {
            System.out.println("no such a class");
            conn.setAutoCommit(true);
            ck_1.close();
            ck_2.close();
            ck_3.close();
            System.out.println("Course enrollment insert -- no data");
        }
        else {
            is_correct = true;

            // if info is correct, then consider next
            String find_num_sec = "SELECT ClassId, numbersec From Class WHERE CourseId = ? AND Quarter = ? AND Year = ?";
            String find_min_max = "SELECT minunits, maxunits From Course WHERE CourseId = ?";
            conn.setAutoCommit(false);

            PreparedStatement st_1 = conn.prepareStatement(find_num_sec);
            st_1.setString(1, Course_ID);
            st_1.setString(2, Quarter);
            st_1.setString(3, Year);
            ResultSet rs_a = st_1.executeQuery();
            // use courseid, quarter, year to find numbersec in Class
            rs_a.next();
            String Class_Id = rs_a.getString("ClassId");
            Integer num_sec = Integer.parseInt( rs_a.getString("numbersec") );
            st_1.close();
            rs_a.close();

            PreparedStatement st_2 = conn.prepareStatement(find_min_max);
            st_2.setString(1, Course_ID);
            ResultSet rs_b = st_2.executeQuery();
            rs_b.next();
            Float min_units = Float.parseFloat( rs_b.getString("minunits") );
            Float max_units = Float.parseFloat( rs_b.getString("maxunits") );
            st_2.close();
            rs_b.close();

            System.out.println(num_sec);
            System.out.println(min_units);
            System.out.println(max_units);

            // if multiple sections & flexible on units
            if (num_sec > 1 && min_units < max_units) {
                // direct to another page to prompt for section id and choose of units
                session.setAttribute("student_id", Student_ID);
                session.setAttribute("course_id", Course_ID);
                response.sendRedirect("./Course_Enrollment_Sec_Unit_Page.jsp");
            }
            // if only multiple sections (numbersec from table class)
            else if (num_sec > 1) {
                // direct to another page to prompt for section id only
                session.setAttribute("student_id", Student_ID);
                session.setAttribute("course_id", Course_ID);
                response.sendRedirect("./Course_Enrollment_Section_Page.jsp");
//                System.out.println("should direct to another page");
            }
            // if only flexible on units
            else if (min_units < max_units) {
                // direct to another page to prompt for choose of units only
                session.setAttribute("student_id", Student_ID);
                session.setAttribute("course_id", Course_ID);
                response.sendRedirect("./Course_Enrollment_Unit_Page.jsp");
            }
            // insert into the database without directing to another page
            else {
                // first check if (student id, course id) already exists
                PreparedStatement st_3 = conn.prepareStatement("SELECT * FROM Enrollment WHERE StudentId = ? AND CourseId = ?");
                st_3.setString(1, Student_ID);
                st_3.setString(2, Course_ID);
                ResultSet rs_c = st_3.executeQuery();
                // if found, then should not insert
                if (rs_c.next()) {
                    already_existed = true;
                    System.out.println("Such an enrollment already exists");
                    conn.setAutoCommit(true);
                    st_3.close();
                    System.out.println("Course enrollment insert -- no data");
                } else {
                    already_existed = false;
                    // otherwise, find the section id and insert
                    PreparedStatement st_4 = conn.prepareStatement("SELECT SectionId FROM Section WHERE ClassId = ?");
                    st_4.setString(1, Class_Id);
                    ResultSet rs_d = st_4.executeQuery();
                    rs_d.next();
                    String section_id = rs_d.getString("SectionId");
                    st_4.close();
                    rs_d.close();

                    // insert the enrollment
                    PreparedStatement st = conn.prepareStatement(sql);
                    st.setString(3, section_id);
                    st.setString(1, Student_ID);
                    st.setString(2, Course_ID);
                    st.executeUpdate();
                }
                rs_c.close();
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
        if (already_existed) {
            out.println("<H3><u>The enrollment shown below already exists in the database, Please, try again</u></b>");
        } else {
            out.println("<H3><u>Successful Insert new Enrollment into the dataBase</u></b>");
        }
    } else {
        out.println("<H3><u>Either Student ID, Course ID, or corresponding section shown below does not exist in the database, Please, try again</u></b>");
    }
%>

<br/><br/>
Student ID: <%=Student_ID%>
<br/><br/>
Course ID: <%=Course_ID%>
<br/><br/>
<a href="Course_Enrollment_Submission.jsp"><button> Submit again </button></a>
<a href="./Course_Enrollment_Database.jsp"><button> Check Database </button></a>
<a href="./../index.jsp"><button> Homepage </button></a>
<jsp:include page="../footer.jsp"/>
</body>
</html>
