<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: AmberWang
  Date: 2021/5/15
  Time: 上午 02:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <%!
        String ssn = "";
        String student_id = "";
        String degree_name = "";
        String major = "";
        boolean degree_major_not_match = false;
    %>
    <%
        String url = "jdbc:postgresql://localhost:5432/postgres?user=postgres&password=4645";
        try {
            Class.forName("org.postgresql.Driver");
            Connection conn = DriverManager.getConnection(url);
            ssn = request.getParameter("ssn");
            // get rid of degree type
            degree_name = (request.getParameter("degree")).substring(5);

            // find student id using ssn
            String sql_get_student_id = "SELECT Undergraduate.student_id FROM Undergraduate INNER JOIN Student ON Student.student_id = Undergraduate.student_id AND Student.ssn = ?";
            PreparedStatement st_1 = conn.prepareStatement(sql_get_student_id);
            st_1.setString(1, ssn);
            ResultSet rs1 = st_1.executeQuery();
            while (rs1.next()) {
                student_id = rs1.getString(1);
            }
            rs1.close();
            st_1.close();
            // find major using student id
            String sql_get_major = "SELECT major FROM Undergraduate WHERE Student_id = ?";
            PreparedStatement st_2 = conn.prepareStatement(sql_get_major);
            st_2.setString(1, student_id);
            ResultSet rs2 = st_2.executeQuery();
            while (rs2.next()) {
                major = rs2.getString(1);
            }
            rs2.close();
            st_2.close();
            conn.close();
            // check if major of the selected student matches with the selected degree name
            if (major.equals(degree_name)) {
                // if matches, then redirect to another page for report
                session.setAttribute("student_id", student_id);
                session.setAttribute("degree_name", degree_name);
                response.sendRedirect("./DegreeByUndergradReport.jsp");
            } else {
                // otherwise, display error message and then ask for next step
                // either reselect or go back to homepage
                degree_major_not_match = true;
                System.out.println("Report Degree -- major does not match with degree name");
            }
        } catch (Exception e) {
            System.out.println(e);
        }

    %>
    <%
        if (degree_major_not_match) {
          out.println("<H3><u>The student's major does not match with degree name. Please, try again</u></b>");
        }
    %>
    <br/><br/>
    Student's SSN: <%=ssn%>
    <br/><br/>
    Student's major: <%=major%>
    <br/><br/>
    Selected degree name: <%=degree_name%>
    <br/><br/>
    <a href="./DegreeByUndergrad.jsp"><button> Resubmit Again </button></a>
    <a href="./../../index.jsp"><button> Homepage </button></a>
    <jsp:include page="../../footer.jsp"/>
</body>
</html>
