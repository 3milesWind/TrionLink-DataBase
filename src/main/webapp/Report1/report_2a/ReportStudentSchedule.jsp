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
        width: 80%;
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
    HashMap<String,List<int []>>cur_schedule = new HashMap<>();
    HashMap<String,List<String>> res = new HashMap<>();
    HashSet<String> hashset = new HashSet<>();
    List<String> AvaliableCousrs = new ArrayList<>();
    boolean BUG = false;
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
//        System.out.println("Input: " + student_id);

        // collect the
        String sql_task1 = "select m.courseid, m.start_time, m.end_time, m.meet_day, m.meet_type from meeting m left outer join enrollment e\n" +
                "on m.courseid = e.courseid and m.sectionid = e.sectionid\n" +
                "where studentid = ?";
        PreparedStatement ps_task1 = conn.prepareStatement(sql_task1);
        ps_task1.setString(1,student_id);
        ResultSet rs = ps_task1.executeQuery();
        cur_schedule.clear();
        hashset.clear();
        res.clear();
        AvaliableCousrs.clear();
        // return --> course id, start time, end time, day of week
        out.print("<table>");
        out.println("<tr><th>Courses</th><th>meet_days</th><th>Start</th><th>End</th><th>Meeting Type</th></tr>");
        while(rs.next()) {
            out.println("<tr><th>" + rs.getString(1)+ "</th>" +
                    "<th>" + rs.getString(4) + "</th>" +
                    "<th>" + rs.getString(2) + "</th>" +
                    "<th>" + rs.getString(3)+ "</th>" +
                    "<th>" + rs.getString(5) + "</th>" +
                    "</tr>");

            String [] days = rs.getString(4).split(",");
            hashset.add(rs.getString(1));

            for (String day : days) {
                // create a hash table
                if(!cur_schedule.containsKey(day)) cur_schedule.put(day,new ArrayList<>());
                String start = rs.getString(2);
                start = start.substring(0,2) + start.substring(3);
                String end = rs.getString(3);
                end = end.substring(0,2) + end.substring(3);
                cur_schedule.get(day).add(new int[] {Integer.parseInt(start),Integer.parseInt(end)});
            }
        }
        out.println("</table>");

        // collect the current available time

        String sql_task2 = "select m.courseid, c.classid, m.start_time, m.end_time, m.meet_day, m.meet_type, m.sectionid from meeting m left outer join Class c\n" +
                "on m.CourseId = c.CourseId \n" +
                "where c.quarter = 'Spring' and c.year = '2021'";
        Statement ps_task2 = conn.createStatement();
        ResultSet rs2 = ps_task2.executeQuery(sql_task2);
        while (rs2.next()) {
            String [] days = rs2.getString(5).split(",");
            // if the student have taken this course, just skip
            if(hashset.contains(rs2.getString(1))) continue;

            // check day, if overlap either one of them
            // add it into res
            boolean available_course = true;
            for (String day: days) {
                // converting the time to int
                String start = rs2.getString(3);
                start = start.substring(0,2) + start.substring(3);
                String end = rs2.getString(4);
                end = end.substring(0,2) + end.substring(3);
                int startTime = Integer.parseInt(start);
                int endTime = Integer.parseInt(end);
//                System.out.println(startTime + " " + endTime);

                // if the cure schedule did not have, skip
                if(!cur_schedule.containsKey(day)) {
                    break;
                }

                // start check duplicate course
                List<int []> link = cur_schedule.get(day);
                Collections.sort(link, new Comparator<int[]>() {
                    @Override
                    public int compare(int[] o1, int[] o2) {
                        if (o1[0] == o2[0]) return 0;
                        if (o1[0] < o2[0] ) return -1;
                        return 1;
                    }
                });
                boolean return1 = false;
                // check whether the time conflict the schedule
                //System.out.print("Starting check time: " + startTime + "--" + endTime + "\n");
                for (int i = 0; i < link.size(); i++) {
                     int [] cmp = link.get(i);
                     if (startTime < cmp[1] && startTime > cmp[0]) {
                         return1 = true;
                         //System.out.print("====work1======: " + startTime + "--" + endTime+ "\n");
                         break;
                     } else if (endTime > cmp[0] && endTime < cmp[1]) {
                         //System.out.print("====work2======: " + startTime + "--" + endTime+ "\n");
                         return1 = true;
                         break;
                     } else if (startTime < cmp[0] && endTime > cmp[1]) {
                         //System.out.print("====work3======: " + startTime + "--" + endTime+ "\n");
                         return1 = true;
                         break;
                     } else if (startTime > cmp[0] && endTime < cmp[1]) {
                         //System.out.print("====work4======: " + startTime + "--" + endTime+ "\n");
                         return1 = true;
                         break;
                     } else if (startTime == cmp[0] && endTime == cmp[1]) {
                         //System.out.print("====work5======: " + startTime + "--" + endTime+ "\n");
                         return1 = true;
                         break;
                     }
                }
                if (return1 == true) {
                    available_course = false;
                    String data = rs2.getString(1) + "," + rs2.getString(2) +  "," + rs2.getString(7);
                    //String data = rs2.getString(1) + "," + rs2.getString(2) + "," + rs2.getString(5) + "," + rs2.getString(7);
                    if (AvaliableCousrs.contains(data)) AvaliableCousrs.remove(data);
                    if (!res.containsKey(data)) {
                        res.put(data,new ArrayList<>());
                    }
                    res.get(data).add(rs2.getString(6));
                    res.get(data).add(rs2.getString(3));
                    res.get(data).add(rs2.getString(4));
                    res.get(data).add(rs2.getString(5));
                    break;
                }
            }
            String data = rs2.getString(1) + "," + rs2.getString(2) + "," + rs2.getString(7);
            if (available_course == true  && !res.containsKey(data) && !AvaliableCousrs.contains(data)){
                AvaliableCousrs.add(data);
            }
        }



        System.out.println(AvaliableCousrs.size());
        // Check the avaliable course
        for (int i = 0; i < AvaliableCousrs.size(); i++) {
//            System.out.println(AvaliableCousrs.get(i));
           for (String key : res.keySet()) {
               String [] avali = AvaliableCousrs.get(i).split(",");
               String [] unavali = key.split(",");
//               System.out.println("Key: " + key);
               if (avali[0].equals(unavali[0])) {
                   res.remove(key);
               }
           }
        }
        // debug model
        if (BUG) {
            // check current schedule
            for (String key: cur_schedule.keySet()) {
                List<int []> times = cur_schedule.get(key);
                System.out.println("day of week: " + key);
                for (int i = 0; i < times.size(); i++) {
                    System.out.print(times.get(i)[0]  + "  " + times.get(i)[1]);
                }
                System.out.println("");
            }

            // check the res
            if (res.isEmpty()) {
                System.out.println("none avaliable course");
            } else {
                for (String key : res.keySet()) {
                    String [] cc = key.split(",");
                    System.out.println("course: " + cc[0] + "---" + "class: " + cc[1] + "comflict with: " + res.get(key));
                }
            }
        }
        conn.commit();
        conn.setAutoCommit(true);
        conn.close();
    } catch (Exception e){
        is_correct = false;
        Exception = e.toString();
        System.out.println(e);
    }
%>
<body>
<h3>Conflict schedule</h3>
<table>
    <%
        out.println("<tr><th>Conflict Courses</th><th>Class Title</th><th>Meeting Type</th><th>Days</th><th>Start</th><th>End</th></tr>");
        if (res.isEmpty()) {
           out.println("none avaliable course");
        } else {
            for (String key : res.keySet()) {
                String [] cc = key.split(",");
                out.println("<tr><th>" + cc[0] + "</th>" +
                             "<th>" + cc[1]  + "</th>" +
                             "<th>" + res.get(key).get(0) + "</th>" +
                        "<th>" + res.get(key).get(3) + "</th>" +
                        "<th>" + res.get(key).get(1) + "</th>" +
                        "<th>" + res.get(key).get(2) + "</th>" +
                        "</tr>");
            }
        }
       // res.clear();
    %>
</table>
<a href="../../report.jsp"><button> Homepage </button></a>
<jsp:include page="../../footer.jsp"/>
</body>
</html>
