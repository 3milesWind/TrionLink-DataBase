<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="javax.xml.transform.Result" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: AmberWang
  Date: 2021/5/13
  Time: 上午 01:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<style>
    table {
        font-family: sans-serif;
        border-collapse: collapse;
        width: 100%;
    }
    td, th {
        border: 1px solid black;
        text-align: left;
    }
</style>
<body>
    <%!
        String class_id = "";

        boolean is_correct = true;
        String wrong = "";
    %>
    <H3>Students Currently Taking This Class</H3>
    <table>
        <%
            String url = "jdbc:postgresql://localhost:5432/postgres?user=postgres&password=4645";
            try {
                Class.forName("org.postgresql.Driver");
                Connection conn = DriverManager.getConnection(url);
                conn.setAutoCommit(false);

                class_id = request.getParameter("classId");

                // find stud_id, units, gradeoption of classid
                String sql_find_stu = "SELECT Enrollment.studentId, Section.ClassId, Enrollment.Units, Enrollment.gradeOption FROM Enrollment INNER JOIN Section ON Enrollment.SectionId = Section.SectionId";
                // join with Student to get all the attributes of Student
                String sql_stud_attri = "SELECT a.ClassId, Student.*, a.Units, a.gradeOption FROM (" + sql_find_stu + ") AS a INNER JOIN Student ON a.StudentId = Student.Student_Id";
                // search for a specific class id
                String sql_sear_class = "SELECT * FROM (" + sql_stud_attri + ") AS b WHERE b.ClassId = ?";

                PreparedStatement ps = conn.prepareStatement(sql_sear_class);
                ps.setString(1, class_id);
                ResultSet rs = ps.executeQuery();
                out.println("<tr><th>Student ID</th>" +
                                "<th>SSN</th>" +
                                "<th>First Name</th>" +
                                "<th>Middle Name</th>" +
                                "<th>Last Name</th>" +
                                "<th>Residency</th>" +
                                "<th>Enrollment</th>" +
                                "<th>Student Type</th>" +
                                "<th>Units</th>" +
                                "<th>Grade Option</th>" +
                                "</tr>");
                while(rs.next()) {
                    out.println("<tr><th>" + rs.getString(2) + "</th>"
                                + "<th>" + rs.getString(3) + "</th>"
                                + "<th>" + rs.getString(4) + "</th>"
                                + "<th>" + rs.getString(5) + "</th>"
                                + "<th>" + rs.getString(6) + "</th>"
                                + "<th>" + rs.getString(7) + "</th>"
                                + "<th>" + rs.getString(8) + "</th>"
                                + "<th>" + rs.getString(9) + "</th>"
                                + "<th>" + rs.getString(10) + "</th>"
                                + "<th>" + rs.getString(11) + "</th>"
                                + "</tr>");
                }
                rs.close();
                conn.commit();
                conn.setAutoCommit(true);
                ps.close();
                conn.close();
            } catch (Exception e) {
                is_correct = false;
                wrong = e.toString();
                System.out.println(e);
            }
        %>
    </table>
    <%
        if (is_correct == false) {
            out.print("<h3>" + wrong + "</h3>");
        }
        is_correct = true;
        wrong = "";
    %>
    <br/> <br/>
    <H3>Students Have Taken This Class Before</H3>

    <table>
        <%
            try {
                Class.forName("org.postgresql.Driver");
                Connection conn = DriverManager.getConnection(url);
                conn.setAutoCommit(false);

                class_id = request.getParameter("classId");

            } catch (Exception e) {
                is_correct = false;
                wrong = e.toString();
                System.out.println(e);
            }
        %>
    </table>

    <br/><br/>
    <a href="../../report.jsp"><button> Homepage </button></a>
    <a href="StudentsTakingClass.jsp"><button> Check Others </button></a>
    <jsp:include page="../../footer.jsp"/>
</body>
</html>
