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
        width: 50%;
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
    List<String []> res = new ArrayList<>();
    HashSet<String> hashset = new HashSet<>();
    List<List<String>> full_schedule = new ArrayList<>();
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
        System.out.println("Input: " + student_id);

        // collect the
        String sql_task1 = "select m.courseid, m.start_time, m.end_time, m.meet_day from meeting m left outer join enrollment e\n" +
                "on m.courseid = e.courseid and m.sectionid = e.sectionid\n" +
                "where studentid = ?";
        PreparedStatement ps_task1 = conn.prepareStatement(sql_task1);
        ps_task1.setString(1,student_id);
        ResultSet rs = ps_task1.executeQuery();

        // return --> course id, start time, end time, day of week
        while(rs.next()) {
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


        // collect the current available time

        String sql_task2 = "select m.courseid, c.classid, m.start_time, m.end_time, m.meet_day from meeting m left outer join Class c\n" +
                "on m.CourseId = c.CourseId \n" +
                "where c.quarter = 'Spring' and c.year = '2018'";
        Statement ps_task2 = conn.createStatement();
        ResultSet rs2 = ps_task2.executeQuery(sql_task2);
        while (rs2.next()) {
            String [] days = rs2.getString(5).split(",");
            // if the student have taken this course, just skip
            if(hashset.contains(rs2.getString(1))) continue;

            // check day, if overlap either one of them
            // add it into res
            for (String day: days) {
                // converting the time to int
                String start = rs2.getString(3);
                start = start.substring(0,2) + start.substring(3);
                String end = rs2.getString(4);
                end = end.substring(0,2) + end.substring(3);
                int startTime = Integer.parseInt(start);
                int endTime = Integer.parseInt(end);
                System.out.println(startTime + " " + endTime);

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
                for (int i = 0; i < link.size(); i++) {
                     int [] cmp = link.get(i);
                     if (startTime < cmp[1] && startTime > cmp[0]) {
                         return1 = true;
                         break;
                     } else if (endTime > cmp[0] && endTime < cmp[1]) {
                         return1 = true;
                         break;
                     } else if (startTime < cmp[0] && endTime > cmp[1]) {
                         return1 = true;
                         break;
                     } else if (startTime > cmp[0] && endTime < cmp[1]) {
                         return1 = true;
                         break;
                     }
                }
                if (return1 == true) {
                    res.add(new String[]{rs2.getString(1), rs2.getString(2)});
                    break;
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
                for (String[] key : res) {
                    System.out.println("course: " + key[0] + "---" + "class: " + key[1]);
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
        out.println("<tr><th>Conflict Courses</th><th>Class Title</th></tr>");
        if (res.isEmpty()) {
           out.println("none avaliable course");
        } else {
            for (String[] key : res) {

                out.println("<tr><th>" + key[0] + "</th>" +
                             "<th>" + key[1] + "</th></tr>");
            }
        }
    %>
</table>
<a href="../../report.jsp"><button> Homepage </button></a>
<jsp:include page="../../footer.jsp"/>
</body>
</html>
