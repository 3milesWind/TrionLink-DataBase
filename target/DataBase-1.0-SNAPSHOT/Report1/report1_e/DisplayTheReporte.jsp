<%@ page import="com.sun.net.httpserver.Authenticator" %><%--
  Created by IntelliJ IDEA.
  User: guoyili
  Date: 5/12/21
  Time: 2:43 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page  import="java.sql.*" contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
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
    String SSN = "";
    String Degree = "";
    String DegreeName = "";
    String DegreeType = "";
    String Exception = "";
    boolean is_Error = true;
    boolean BUG = true;
    String url = "jdbc:postgresql://localhost:5432/postgres?user=postgres&password=4645";
//    HashMap<String,List<String>> require_courses = new HashMap<>();
    HashMap<String,String> require_courses = new HashMap<>();
    HashMap<String,double []> require_num = new HashMap<>();
    HashMap<String,List<Double>> require_record = new HashMap<>();
    HashMap<String,List<String>> leftover_course = new HashMap<>();
%>
<%
    /**
     1) Display the NAME of all the concentrations in Y that a student X has completed.
     2) Remember that a student has completed a concentration if first,
     he/she has taken some minimum number of units of courses in that concentration and second,
     the GPA of courses he has taken in that concentration is above some minimum number.
     */
    // --# DataSet up
    // get the list of concentration
    SSN = request.getParameter("student");
    Degree = request.getParameter("degree");
    for (int i = 0; i < Degree.length(); i++) {
       if (Degree.charAt(i) == ' ') {
           DegreeType = Degree.substring(0,i);
           System.out.println("degree type " +DegreeType);
           DegreeName = Degree.substring(i+1);
           System.out.println("degree name " +DegreeName);
           break;
       }
    }
    //System.out.println("Success: + " + DegreeName + "+" + DegreeType);
    try {
        Class.forName("org.postgresql.Driver");
        Connection conn = DriverManager.getConnection(url);
        conn.setAutoCommit(false);

        //clear process
        require_courses.clear();
        require_num.clear();
        require_record.clear();
        leftover_course.clear();
        // Return concentrate name
        String sql_task1 = "select c.concen_name,c.courses, c.mingpa,c.minunit from degree d left outer join concentration c\n" +
                "on d.Degree_Name = c.Degree_Name and d.Degree_Type = c.Degree_Type\n" +
                "where d.Degree_Name = ? and d.Degree_Type = ?";
        PreparedStatement ps_task1 = conn.prepareStatement(sql_task1);
        ps_task1.setString(1,DegreeName);
        ps_task1.setString(2,DegreeType);
        ResultSet rs = ps_task1.executeQuery();
        // ----> return: concentrations name, courses, minGAp, units
        while(rs.next()) {
            System.out.println(rs.getString(1));
            if(!require_courses.containsKey(rs.getString(1))) {
                // get the information of courses
                leftover_course.put(rs.getString(1),new ArrayList<>());
                String [] course = rs.getString(2).split(",");
                for ( int i = 0; i < course.length; i++) {
                    require_courses.put(course[i],rs.getString(1));
                    // get all the course for specific concentrations
                    leftover_course.get(rs.getString(1)).add(course[i]);
                }
                // get the require gpa and units
                double minGPA = Double.parseDouble(rs.getString(3));
                double minUnit = Double.parseDouble(rs.getString(4));
                require_num.put(rs.getString(1), new double[]{minGPA,minUnit});

                // create a array for tracking the numbers
                require_record.put(rs.getString(1), new ArrayList<>());
                require_record.get(rs.getString(1)).add(0.0);
                require_record.get(rs.getString(1)).add(0.0);
                require_record.get(rs.getString(1)).add(0.0);

            } else {
                is_Error = false;
                System.out.println("Some thing wrong for getting the degree information");
            }
        }



        // get the past_Course of current student
        String sql_task2 = "select k.course_id, k.number_grade, k.units from \n" +
                "(select * from past_course p left outer join GRADE_CONVERSION g on p.grade = g.LETTER_GRADE ) \n" +
                "as k left outer join student s on k.student_id = s.student_id\n" +
                "where s.ssn = ?";
        PreparedStatement ps_task2 = conn.prepareStatement(sql_task2);
        ps_task2.setString(1,SSN);
        ResultSet rs2 = ps_task2.executeQuery();

        // ----> return: cousename,number_grade , units
        while(rs2.next()) {
            // get the concentrations name
            String key = require_courses.get(rs2.getString(1));

            // delete completed course from leftover
            if(leftover_course.containsKey(key)) leftover_course.get(key).remove(rs2.getString(1));
            if (require_num.containsKey(key)) {
                List<Double> tem = require_record.get(key);
                // gpa
                double tem_gpa = 0;
                tem_gpa = rs2.getString(2) == null? 0 : Double.parseDouble(rs2.getString(2));
                tem.set(0, tem_gpa + tem.get(0));
                // units
                tem.set(1, Double.parseDouble(rs2.getString(3)) + tem.get(1));
                double count = rs2.getString(2) == null? 0 : 1;

                tem.set(2, tem.get(2) + count);
            } else {
                System.out.println(rs2.getString(1) + " is not at the concentration");
            }
        }

        /*
        * BUG area
        *   testing get the all information
        * */
        if (BUG) {
            // get the all the course for each concentration
            for(String key: require_courses.keySet()) {
                System.out.println("concentration: " + key + " " + require_courses.get(key) );
            }

            for(String key: require_num.keySet()) {
                System.out.println("units: "  + key);
                double [] val = require_num.get(key);
                System.out.println("GPA: "  + val[0] + "----" + "Units: " + val[1]);
            }

            for(String key: require_record.keySet()) {
                System.out.println("Name: "  + key);
               List<Double> res = require_record.get(key);
               for (int i = 0 ; i  < res.size(); i++) {
                   System.out.print(res.get(i) + " ");
               }
                System.out.println();
            }
        }
        conn.commit();
        conn.setAutoCommit(true);
        ps_task1.close();
        ps_task2.close();
        rs.close();
        rs2.close();
        conn.close();
    } catch (Exception e) {
        is_Error = false;
        Exception = e.toString();
        System.out.println(e);
    }

%>
<%if(is_Error == false) {
    out.print("<h3>" + Exception +  "<h3/>");
} else {%>
<h3>Student who completed Concentration below</h3>
<table>
    <%
        out.println("<tr><th>Concentration</th>" +
                "<th>Average Grade</th>" +
                "<th>Taken units</th>" +
                " </tr>");
        for (String key : require_record.keySet()) {
            double [] req = require_num.get(key);
            List<Double> res = require_record.get(key);
            double GPA = res.get(0) / res.get(2);
            GPA = GPA > 4 ? 4 : GPA;
            double unit = res.get(1);
            out.print("<tr>");
            if (GPA >= req[0] && unit >= req[1]) {
                out.print("<th>" + key + "</th>" + "<th>" + GPA  + "</th>"
                        + "<th>" + unit + "</th>");
            }
            out.print("</tr>");
        }

    %>
</table>

<h3>The course Student have been taken</h3>
<table>
    <%

        try{
            Class.forName("org.postgresql.Driver");
            Connection conn = DriverManager.getConnection(url);
            String sql = "select p.course_id, p.units, p.grade from past_course p left join student s on p.student_id = s.student_id\n" +
                    "where ssn = ?";
            PreparedStatement ps_task5 = conn.prepareStatement(sql);
            ps_task5.setString(1,SSN);
            ResultSet rs5 = ps_task5.executeQuery();
            out.println("<th>Course</th>" +
                    "<th>Units</th>" +
                    "<th>Grade</th>" +
                    " </tr>");
            while (rs5.next()){
                out.print("<tr><th>" + rs5.getString(1) + "</th>" + "<th>" + rs5.getString(2) + "</th>" +
                        "<th>" + rs5.getString(3)  +"</th></tr>");
            }
            ps_task5.close();
            rs5.close();
            conn.close();
        } catch (Exception e) {
            is_Error = false;
            Exception = "The course Student have been taken " + e.toString();
            System.out.println(e);
        }

    %>
</table>
<h3>Student who have not completed Concentration courses below</h3>
<%
    for (String key : leftover_course.keySet()) {
        List<String> li = leftover_course.get(key);
        if (!li.isEmpty()) {
            out.print("<h4>" + key + " Concentration shown below"  + "</h4>");
            for ( String course: li) {
                try {
                    Class.forName("org.postgresql.Driver");
                    Connection conn = DriverManager.getConnection(url);
                    String sql = "select * from class c\n" +
                            "where c.courseid = ? limit 1";
                    PreparedStatement ps_task4 = conn.prepareStatement(sql);
                    ps_task4.setString(1,course);
                    ResultSet rs4 = ps_task4.executeQuery();
                    if (rs4.next()) {
                        out.print("<h5>" + course + "------------" + "Next Offer: "+ rs4.getString(7) +"</h5>");
                    } else {
                        out.print("<h5>" + course + " ------------" + "Next Offer: Do not have schedule"  + "</h5>");
                    }
                    ps_task4.close();
                    rs4.close();
                    conn.close();
                } catch (Exception e) {
                    is_Error = false;
                    Exception = "Student who have not completed Concentration courses below " + e.toString();
                    System.out.println(e);
                }
            }
        }
    }
%>
<%}%>
<br/><br/>
<a href="../../report.jsp"><button> Homepage </button></a>
<jsp:include page="../../footer.jsp"/>
</body>
</html>
