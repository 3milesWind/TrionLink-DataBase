<%--
  Created by IntelliJ IDEA.
  User: guoyili
  Date: 5/13/21
  Time: 12:43 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.sql.*" contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*"%>
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
<%!
    String ssn = "";
    String student_id = "";
    boolean is_correct = true;
    String Exception = "";
    List<int []> cur_schedule = new ArrayList<>();
    List<String []> res = new ArrayList<>();
    HashSet<String> hashset = new HashSet<>();
    List<List<String>> full_schedule = new ArrayList<>();
    String url = "jdbc:postgresql://localhost:5432/postgres?user=postgres&password=4645";
%>
<%
    try {
        Class.forName("org.postgresql.Driver");
        Connection conn = DriverManager.getConnection(url);

        // find the student id by ssn
        ssn = request.getParameter("ssn");
        conn.setAutoCommit(false);
        PreparedStatement find_id = conn.prepareStatement("select * from student where ssn = ?");
        find_id.setString(1, ssn);
        ResultSet rs_id = find_id.executeQuery();
        if (!rs_id.next()) {
            System.out.println("Am i here");
            is_correct = false;
            System.out.println("Can not find the student Id");
        }
        // Get the student ID
        student_id = rs_id.getString(1);
        System.out.println("Input: " + student_id);

        // collect the
        String sql_task1 = "select m.courseid, m.start_time, m.end_time from meeting m left outer join enrollment e\n" +
                "on m.courseid = e.courseid and m.sectionid = e.sectionid\n" +
                "where studentid = ?";
        PreparedStatement ps_task1 = conn.prepareStatement(sql_task1);
        ps_task1.setString(1,student_id);
        ResultSet rs = ps_task1.executeQuery();
        while(rs.next()) {
            hashset.add(rs.getString(0));
            String start = rs.getString(1);
            start = start.substring(0,2) + start.substring(3);
            String end = rs.getString(2);
            end = end.substring(0,2) + end.substring(3);
            cur_schedule.add(new int[] {Integer.parseInt(start),Integer.parseInt(end)});
        }

        // collect the current available time
        String sql_task2 = "select m.courseid, c.classid, m.start_time, m.end_time from meeting m left outer join Class c\n" +
                "on m.CourseId = c.CourseId \n" +
                "where c.quarter = 'Spring' and c.year = '2018'";
        PreparedStatement ps_task2 = conn.prepareStatement(sql_task2);
        ResultSet rs2 = ps_task2.executeQuery();
        while (rs2.next()) {
            // converting the time to int
            String start = rs.getString(2);
            start = start.substring(0,2) + start.substring(3);
            String end = rs.getString(3);
            end = end.substring(0,2) + end.substring(3);
            int startTime = Integer.parseInt(start);
            int endTime = Integer.parseInt(end);
            System.out.println(startTime + " " + endTime);

            for(int i = 0; i < cur_schedule.size(); i++){
                int [] cmp = cur_schedule.get(1);

            }

        }



        conn.commit();
        conn.setAutoCommit(true);
    } catch (Exception e){
        is_correct = false;
        Exception = e.toString();
        System.out.println(e);
    }
%>
<body>

</body>
</html>
