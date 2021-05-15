<%@ page import="java.sql.*" %>
<%@ page import="java.nio.DoubleBuffer" %><%--
  Created by IntelliJ IDEA.
  User: AmberWang
  Date: 2021/5/14
  Time: 下午 01:27
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
        String student_id = "";
        String degree_type = "";
        String degree_name = "";
        Double total_units = 0.0;
        Double student_units = 0.0;

    %>
    <%
        student_id = (String)session.getAttribute("student_id");
        degree_type = (String)session.getAttribute("degree_type");
        degree_name = (String)session.getAttribute("degree_name");
        String url = "jdbc:postgresql://localhost:5432/postgres?user=postgres&password=4645";
        try {
            Class.forName("org.postgresql.Driver");
            Connection conn = DriverManager.getConnection(url);
//            Statement sm1 = conn.createStatement();
            conn.setAutoCommit(false);

            total_units = 0.0;
            student_units = 0.0;

            String sql_get_total_units = "SELECT total_unit FROM Degree WHERE Degree_type = ? AND Degree_name = ?";
            PreparedStatement st1 = conn.prepareStatement(sql_get_total_units);
            st1.setString(1, degree_type);
            st1.setString(2, degree_name);
            ResultSet rs1 = st1.executeQuery();
            while (rs1.next()) {
                total_units = Double.parseDouble(rs1.getString(1));
            }
            System.out.println("total units: " + total_units);
            rs1.close();
            st1.close();

            String sql_get_student_units = "SELECT units FROM Past_course WHERE Student_id = ?";
            PreparedStatement st2 = conn.prepareStatement(sql_get_student_units);
            st2.setString(1, student_id);
            ResultSet rs2 = st2.executeQuery();
            while (rs2.next()) {
                student_units += Double.parseDouble(rs2.getString(1));
            }
            System.out.println("student units: " + student_units);
            rs2.close();
            st2.close();

        } catch (Exception e) {
            System.out.print(e);
        }
    %>
    <h2>Still need <%=total_units - student_units%> units to graduate with <%=degree_type%> <%=degree_name%></h2>
</body>
</html>