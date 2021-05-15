<%@ page import="java.sql.*" %>
<%@ page import="java.nio.DoubleBuffer" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %><%--
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
        Double lower_units = 0.0;
        Double upper_units = 0.0;
        Double elective_units = 0.0;
        Double student_units = 0.0;
        List<String> arr_course_id = new ArrayList<>();
        List<Double> arr_course_units = new ArrayList<>();
        List<Double> arr_lower_id = new ArrayList<>();
        List<Double> arr_upper_id = new ArrayList<>();
        List<Double> arr_elective_id = new ArrayList<>();
    %>
    <%
        if (arr_course_id.size() != 0) {arr_course_id.clear();}
        if (arr_course_units.size() != 0) {arr_course_units.clear();}
        if (arr_lower_id.size() != 0) {arr_lower_id.clear();}
        if (arr_upper_id.size() != 0) {arr_upper_id.clear();}
        if (arr_elective_id.size() != 0) {arr_elective_id.clear();}

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

            String sql_get_total_units = "SELECT total_unit, lowerdivisionunit, upperdivisionunit, electiveunit FROM Degree WHERE Degree_type = ? AND Degree_name = ?";
            PreparedStatement st1 = conn.prepareStatement(sql_get_total_units);
            st1.setString(1, degree_type);
            st1.setString(2, degree_name);
            ResultSet rs1 = st1.executeQuery();
            while (rs1.next()) {
                total_units = Double.parseDouble(rs1.getString(1));
                lower_units = Double.parseDouble(rs1.getString(2));
                upper_units = Double.parseDouble(rs1.getString(3));
                elective_units = Double.parseDouble(rs1.getString(4));
            }
//            System.out.println("total units: " + total_units);
            rs1.close();
            st1.close();

            String sql_get_student_units = "SELECT course_id, units FROM Past_course WHERE Student_id = ?";
            PreparedStatement st2 = conn.prepareStatement(sql_get_student_units);
            st2.setString(1, student_id);
            ResultSet rs2 = st2.executeQuery();
            while (rs2.next()) {
                arr_course_id.add(rs2.getString(1));
                arr_course_units.add(Double.parseDouble(rs2.getString(2)));
                student_units += Double.parseDouble(rs2.getString(2));

                // determine whether the current course id is lower, upper, or elective (can be two of them)
                String[] course_number = rs2.getString(1).split("[a-zA-Z]");
                for (int i = 0;i < course_number.length; i++) {
                    System.out.println(i + "---" + course_number[i]);
                }
            }
//            System.out.println("student units: " + student_units);
            rs2.close();
            st2.close();

        } catch (Exception e) {
            System.out.print(e);
        }
    %>
    <h2>Still need <%=total_units - student_units%> units to graduate with <%=degree_type%> <%=degree_name%></h2>
    <h3>Minimum Units for each categories:</h3>
    <h4>Lower Division: <%=lower_units%> units</h4>
    <h4>Upper Division: <%=upper_units%> units</h4>
    <h4>Electives: <%=elective_units%> units</h4>

</body>
</html>
