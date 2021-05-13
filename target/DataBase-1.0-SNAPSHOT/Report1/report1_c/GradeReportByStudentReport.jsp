<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Arrays" %><%--
  Created by IntelliJ IDEA.
  User: AmberWang
  Date: 2021/5/13
  Time: 上午 09:24
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
        String ssn = "";
        String student_id = "";
        List<String> arr_taken_quarter = new ArrayList<>();

        List<String> arr_class_attri = new ArrayList<>();
        List<String> arr_units = new ArrayList<>();
        List<String> arr_grade = new ArrayList<>();

        Object[] obj_class_attri;
        Object[] obj_units;
        Object[] obj_grade;

//        Object[] arr_class_attri = new Object[]{};
//        Object[] arr_units = new Object[]{};
//        Object[] arr_grade = new Object[]{};

//        ArrayList<Object> obj_class = new ArrayList<Object>(Arrays.asList(arr_class_attri));
//        ArrayList<Object> obj_units = new ArrayList<Object>(Arrays.asList(arr_units));
//        ArrayList<Object> obj_grade = new ArrayList<Object>(Arrays.asList(arr_grade));

//        List<String> arr_grade = new ArrayList<>();
        boolean is_correct = true;
        String wrong = "";
    %>
    <%
        if (arr_taken_quarter.size() != 0) {arr_taken_quarter.clear();}

        String url = "jdbc:postgresql://localhost:5432/postgres?user=postgres&password=4645";
        try {
            is_correct = true;
            Class.forName("org.postgresql.Driver");
            Connection conn = DriverManager.getConnection(url);
            Statement sm1 = conn.createStatement();
            conn.setAutoCommit(false);
            String sql_find_stu = "SELECT Section.classid, Past_course.sectionid, Past_course.student_id, Past_course.units, Past_course.grade, Past_course.taken_quarter FROM Past_course INNER JOIN Section ON Section.SectionId = Past_course.SectionId";
            String sql_merge_stu = "SELECT Student.ssn, a.* FROM (" + sql_find_stu + ") AS a INNER JOIN Student ON Student.Student_id = a.student_id";
            String sql_taken_quarter = "SELECT b.taken_quarter from (" + sql_merge_stu + ") AS b WHERE b.ssn = ?";

            String sql_sear_ssn1 = "SELECT b.classid, b.units, b.grade, b.taken_quarter FROM (" + sql_merge_stu + ") AS b WHERE b.ssn = ?";
            String sql_per_quar = "SELECT c.classid, c.units, c.grade from (" + sql_sear_ssn1 + ") as c where c.taken_quarter = ?";

            ssn = request.getParameter("ssn");

            PreparedStatement ps = conn.prepareStatement(sql_taken_quarter);
            ps.setString(1, ssn);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                arr_taken_quarter.add(rs.getString(1));
            }
            ps.close();
            rs.close();
//            conn.close();
            %>
            <%!
            Object[][][] arrayQuarterYear = new Object[arr_taken_quarter.size()][3][];
            List<Integer> arr_num_class_per_quar = new ArrayList<>();
            int prev_size = 0;
            %>
            <%
                System.out.println("taken quarter: " + arr_taken_quarter.size());
            for (int i = 0; i < arr_taken_quarter.size(); i++) {
                System.out.println(i);
                out.println("<h3>" + arr_taken_quarter.get(i) + "</h3>");
                PreparedStatement st1 = conn.prepareStatement(sql_per_quar);
                st1.setString(1, ssn);
                st1.setString(2, arr_taken_quarter.get(i));
                ResultSet rs1 = st1.executeQuery();
                int temp = 0;
//                out.println("asdasdas");
                while(rs1.next()) {
//                    System.out.println("76869686966");
                    String curr_class_id = rs1.getString(1);
                    PreparedStatement st2 = conn.prepareStatement("Select * From Class Where ClassId = ?");
                    st2.setString(1, curr_class_id);
                    ResultSet rs2 = st2.executeQuery();
//                    out.println(temp + " --- kkkkkk");
                    String tempstr = "";
                    while (rs2.next()) {
                        tempstr = rs2.getString(1) + ":" + rs2.getString(2)+ ":" + rs2.getString(3)+ ":" + rs2.getString(4)+ ":" + rs2.getString(5)+ ":" + rs2.getString(6)+ ":" + rs2.getString(7);
                        arr_class_attri.add(rs2.getString(1) + ":" + rs2.getString(2)+ ":" + rs2.getString(3)+ ":" + rs2.getString(4)+ ":" + rs2.getString(5)+ ":" + rs2.getString(6)+ ":" + rs2.getString(7));

                    }
                    arr_units.add(rs1.getString("units"));
                    arr_grade.add(rs1.getString("grade"));
//                    arr_units[temp] = rs1.getString("units");
//                    arr_grade[temp] = rs1.getString("grade");
                    System.out.println(tempstr + "---" + rs1.getString("units") + "---" + rs1.getString("grade"));
                    rs2.close();
                    st2.close();
                    temp += 1;
                }
//                Object[] arrayPerQuar = new Object[3];
//                arrayPerQuar[0] = arr_class_attri;
//                arrayPerQuar[1] = arr_units;
//                arrayPerQuar[2] = arr_grade;

//                Object[] obj1 = arrayQuarterYear[i][0];
//                arrayQuarterYear[i][0] = obj_class;
//                arrayQuarterYear[i][1] = arr_units;
//                arrayQuarterYear[i][2] = arr_grade;

//                out.println("dssdsfsdfsd" + arr_class_attri.size());
//                obj_class_attri = new Object[arr_class_attri.size()];
//                obj_units = new Object[arr_class_attri.size()];
//                obj_grade = new Object[arr_class_attri.size()];
//                for (int z = 0; z < arr_class_attri.size(); z++)
//                {
//                    System.out.println("I think its below");
//                    obj_class_attri[z] = arr_class_attri.get(z);
//
//                    obj_units[z] = arr_units.get(z);
//                    obj_grade[z] = arr_grade.get(z);
//                    System.out.println("I think its above");
//                }
//                arrayQuarterYear[i][0] = obj_class_attri;
//                System.out.println("I think its above");
//                arrayQuarterYear[i][1] = obj_units;
//                arrayQuarterYear[i][2] = obj_grade;

//                arrayQuarterYear[i][0] = arr_class_attri;
//                arrayQuarterYear[i][1] = arr_units;
//                arrayQuarterYear[i][2] = arr_grade;
                if (prev_size == 0) {
                    arr_num_class_per_quar.add( arr_class_attri.size() );
                    prev_size = arr_class_attri.size();
                } else {
                    arr_num_class_per_quar.add( arr_class_attri.size() - prev_size);
                    prev_size = arr_class_attri.size() - prev_size;
                }
                arr_num_class_per_quar.add( arr_class_attri.size() );
                rs1.close();
                st1.close();
            }
        } catch (Exception e) {
            is_correct = false;
            wrong = e.toString();
            System.out.println(e);
        }
    %>
    <%
        int num = 0;
        for (int i = 0; i < (arr_taken_quarter).size(); i++) { %>
        <h3><% out.println(arr_taken_quarter.get(i) + "yayaya"); %></h3>
        <table>
            <%
                out.println("<tr><th>Class ID</th>" +
                            "<th>Course ID</th>" +
                            "<th>Title</th>" +
                            "<th>Quarter</th>" +
                            "<th>Year</th>" +
                            "<th>NumbSec</th>" +
                            "<th>Next Offer</th>" +
                            "<th>units</th>" +
                            "<th>grade</th>" +
                            "</tr>");
                for (int j = 0; j < arr_num_class_per_quar.get(i); j++) {
//                    temp_p = i * 3 + j;


                    String class_attr_per_class = arr_class_attri.get(num);
                    String[] class_attri_list = class_attr_per_class.split(":");
//                    String[] class_attri = String.valueOf((arrayQuarterYear[i][0])[j]).split(":");
                    out.println("<tr><th>" + class_attri_list[0] + "</th>" +
                            "<th>" + class_attri_list[0] + "</th>" +
                            "<th>" + class_attri_list[1] + "</th>" +
                            "<th>" + class_attri_list[2] + "</th>" +
                            "<th>" + class_attri_list[3] + "</th>" +
                            "<th>" + class_attri_list[4] + "</th>" +
                            "<th>" + class_attri_list[5] + "</th>" +
                            "<th>" + arr_units.get(num) + "</th>" +
                            "<th>" + arr_grade.get(num) + "</th>" +
                            "</tr>");

                    num += 1;
                }

            %>
        </table>
    <% } %>
</body>
</html>
