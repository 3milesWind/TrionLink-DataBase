<%@ page import="java.sql.*" %>
<%@ page import="java.util.Dictionary" %>
<%@ page import="java.util.Hashtable" %>
<%@ page import="java.util.*" %><%--
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
        double gpa_pts_per_quarter = 0.0;
        double num_of_units_per = 0.0;
        double total_gpa_pts = 0.0;
        double total_num_of_units = 0.0;

        List<String> arr_taken_year_quarter = new ArrayList<>();

        List<String> arr_class_attri = new ArrayList<>();
        List<String> arr_units = new ArrayList<>();
        List<String> arr_grade = new ArrayList<>();

        Object[] obj_class_attri;
        Object[] obj_units;
        Object[] obj_grade;

//        List<String> arr_grade = new ArrayList<>();
        boolean is_correct = true;
        String wrong = "";
        String taken_quarter = "";
        String taken_year = "";
        Dictionary<String, String> dic_quarter_order = new Hashtable<String, String>();
    %>
    <%
        if (arr_taken_year_quarter.size() != 0) {arr_taken_year_quarter.clear();}
//        if (arr_takenYear.size() != 0) {arr_takenYear.clear();}
        if (dic_quarter_order.isEmpty()) {
            dic_quarter_order.put("Winter", "1_Winter");
            dic_quarter_order.put("Spring", "2_Spring");
            dic_quarter_order.put("Summer", "3_Summer");
            dic_quarter_order.put("Fall", "4_Fall");
        }



        String url = "jdbc:postgresql://localhost:5432/postgres?user=postgres&password=4645";
        try {
            is_correct = true;
            Class.forName("org.postgresql.Driver");
            Connection conn = DriverManager.getConnection(url);
            Statement sm1 = conn.createStatement();
            conn.setAutoCommit(false);
            String sql_find_stu = "SELECT Section.classid, Past_course.sectionid, Past_course.student_id, Past_course.units, Past_course.grade, Past_course.quarter, Past_course.year FROM Past_course INNER JOIN Section ON Section.SectionId = Past_course.SectionId";
            String sql_merge_stu = "SELECT Student.ssn, a.* FROM (" + sql_find_stu + ") AS a INNER JOIN Student ON Student.Student_id = a.student_id";
            String sql_taken_quarter = "SELECT b.quarter, b.year from (" + sql_merge_stu + ") AS b WHERE b.ssn = ? GROUP BY b.quarter, b.year";

            String sql_sear_ssn1 = "SELECT b.classid, b.units, b.grade, b.quarter, b.year FROM (" + sql_merge_stu + ") AS b WHERE b.ssn = ?";
            String sql_per_quar = "SELECT c.classid, c.units, c.grade from (" + sql_sear_ssn1 + ") as c where c.quarter = ? AND c.year = ?";

            String sql_grade_convert = "SELECT number_grade FROM Grade_Conversion WHERE Letter_Grade = ?";
            ssn = request.getParameter("ssn");

            PreparedStatement ps = conn.prepareStatement(sql_taken_quarter);
            ps.setString(1, ssn);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                // quarter with number (ex. '3_Summer')
                taken_quarter = dic_quarter_order.get(rs.getString(1));
                taken_year = rs.getString(2);
                arr_taken_year_quarter.add( taken_year + "," + taken_quarter );
            }
            ps.close();
            rs.close();
//            conn.close();
            %>
            <%!
            List<Integer> arr_num_class_per_quar = new ArrayList<>();
            int prev_size = 0;
            List<Double> arr_gpa_per_quarter = new ArrayList<>();
            %>
            <%
            if (arr_num_class_per_quar.size() != 0) {arr_num_class_per_quar.clear();}
            if (arr_gpa_per_quarter.size() != 0) {arr_gpa_per_quarter.clear();}
            if (arr_class_attri.size() != 0) {arr_class_attri.clear();}
            if (arr_units.size() != 0) {arr_units.clear();}
            if (arr_grade.size() != 0) {arr_grade.clear();}
            prev_size = 0;      // clear out the prev size such that recheck for others won't get wrong output
            // before loop through each (quarter, year), need to sort quarter_year arrayList
            Collections.sort(arr_taken_year_quarter);
            String[] year_quarter_list;

            total_gpa_pts = 0.0;
            total_num_of_units = 0.0;
            for (int i = 0; i < arr_taken_year_quarter.size(); i++) {
                PreparedStatement st1 = conn.prepareStatement(sql_per_quar);
                st1.setString(1, ssn);
                year_quarter_list = (arr_taken_year_quarter.get(i)).split(",");
//                System.out.println("taken quarter year: ----- " + (year_quarter_list[1]).substring(2) + " " + year_quarter_list[0]);
                st1.setString(2, (year_quarter_list[1]).substring(2));
                st1.setString(3, year_quarter_list[0]);
                ResultSet rs1 = st1.executeQuery();
                int temp = 0;
                gpa_pts_per_quarter = 0.0;
                num_of_units_per = 0;
                while(rs1.next()) {
                    String curr_class_id = rs1.getString(1);
                    PreparedStatement st2 = conn.prepareStatement("Select * From Class Where ClassId = ?");
                    st2.setString(1, curr_class_id);
                    ResultSet rs2 = st2.executeQuery();
                    String tempstr = "";
                    while (rs2.next()) {
                        tempstr = rs2.getString(1) + "://" + rs2.getString(2)+ "://" + rs2.getString(3)+ "://" + rs2.getString(4)+ "://" + rs2.getString(5)+ "://" + rs2.getString(6)+ "://" + rs2.getString(7);
                        arr_class_attri.add(rs2.getString(1) + "://" + rs2.getString(2)+ "://" + rs2.getString(3)+ "://" + rs2.getString(4)+ "://" + rs2.getString(5)+ "://" + rs2.getString(6)+ "://" + rs2.getString(7));
                    }
                    arr_units.add(rs1.getString("units"));
                    arr_grade.add(rs1.getString("grade"));

                    PreparedStatement st3 = conn.prepareStatement(sql_grade_convert);
                    st3.setString(1, rs1.getString("grade"));
                    ResultSet rs3 = st3.executeQuery();
                    while (rs3.next()) {
                        gpa_pts_per_quarter += Double.parseDouble(rs1.getString("units")) * Double.parseDouble(rs3.getString(1));
                        total_gpa_pts += Double.parseDouble(rs1.getString("units")) * Double.parseDouble(rs3.getString(1));
                    }
                    num_of_units_per += Double.parseDouble(rs1.getString("units"));
                    total_num_of_units += Double.parseDouble(rs1.getString("units"));

                    rs3.close();
                    rs2.close();
                    st2.close();
                    temp += 1;
                }
                arr_gpa_per_quarter.add(gpa_pts_per_quarter / num_of_units_per);

                if (prev_size == 0) {
                    arr_num_class_per_quar.add( arr_class_attri.size() );
                    prev_size = arr_class_attri.size();
                } else {
                    arr_num_class_per_quar.add( arr_class_attri.size() - prev_size);
                    prev_size = arr_class_attri.size() - prev_size;
                }
                rs1.close();
                st1.close();
            }
            conn.close();
        } catch (Exception e) {
            is_correct = false;
            wrong = e.toString();
            System.out.println(e);
        }
    %>
    <%
        String[] str_list;
        int num = 0;

        for (int i = 0; i < (arr_taken_year_quarter).size(); i++) {
            str_list = (arr_taken_year_quarter.get(i)).split(",");
    %>
        <h1><% out.println( (str_list[1]).substring(2) + " " + str_list[0] ); %></h1>
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
                    String class_attr_per_class = arr_class_attri.get(num);
                    String[] class_attri_list = class_attr_per_class.split("://");
                    out.println("<tr><th>" + class_attri_list[0] + "</th>" +
                            "<th>" + class_attri_list[1] + "</th>" +
                            "<th>" + class_attri_list[2] + "</th>" +
                            "<th>" + class_attri_list[3] + "</th>" +
                            "<th>" + class_attri_list[4] + "</th>" +
                            "<th>" + class_attri_list[5] + "</th>" +
                            "<th>" + class_attri_list[6] + "</th>" +
                            "<th>" + arr_units.get(num) + "</th>" +
                            "<th>" + arr_grade.get(num) + "</th>" +
                            "</tr>");

                    num += 1;
                }

            %>
        </table>
        <br/>
        <h3>GPA: <%=arr_gpa_per_quarter.get(i)%> </h3>
    <% } %>
    <br/><br/>
    <h2>Cumulative GPA: <%=total_gpa_pts / total_num_of_units%> </h2>
    <br/><br/>
    <a href="../../report.jsp"><button> Homepage </button></a>
    <a href="./GradeReportByStudent.jsp"><button> Check Others </button></a>
    <jsp:include page="../../footer.jsp"/>
</body>
</html>
