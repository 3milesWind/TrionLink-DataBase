<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.*" %><%--
  Created by IntelliJ IDEA.
  User: AmberWang
  Date: 2021/5/15
  Time: 上午 06:58
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
        String section_id = "";
        String from_month = "";
        String from_date = "";
        String to_month = "";
        String to_date = "";
        String current_year = "2021";
        Dictionary<Integer, String> dic_num_day = new Hashtable<Integer, String>();
        boolean is_correct = true;
        String wrong = "";
        List<String> arr_mon = new ArrayList<>();
        List<String> arr_tues = new ArrayList<>();
        List<String> arr_wed = new ArrayList<>();
        List<String> arr_thurs = new ArrayList<>();
        List<String> arr_fri = new ArrayList<>();
        Dictionary<Integer, Integer> dic_md = new Hashtable<Integer, Integer>();
        Dictionary<Integer, String> dic_num_month = new Hashtable<Integer, String>();
        Dictionary<String, Integer> dic_month_num = new Hashtable<String, Integer>();
        List<String> arr_time_interval = new ArrayList<>();
    %>
    <%
        String url = "jdbc:postgresql://localhost:5432/postgres?user=postgres&password=4645";
        try {
            Class.forName("org.postgresql.Driver");
            Connection conn = DriverManager.getConnection(url);
            conn.setAutoCommit(false);

            if (dic_num_day.isEmpty()) {
                dic_num_day.put(1, "Sunday");
                dic_num_day.put(2, "Monday");
                dic_num_day.put(3, "Tuesday");
                dic_num_day.put(4, "Wednesday");
                dic_num_day.put(5, "Thursday");
                dic_num_day.put(6, "Friday");
                dic_num_day.put(7, "Saturday");
                dic_num_day.put(0, "Saturday");
            }
            if (dic_md.isEmpty()) {
                dic_md.put(1, 31);
                dic_md.put(2, 29);
                dic_md.put(3, 31);
                dic_md.put(4, 30);
                dic_md.put(5, 31);
                dic_md.put(6, 30);
                dic_md.put(7, 31);
                dic_md.put(8, 31);
                dic_md.put(9, 30);
                dic_md.put(10, 31);
                dic_md.put(11, 30);
                dic_md.put(12, 31);
            }
            if (dic_num_month.isEmpty()) {
                dic_num_month.put(1, "January");
                dic_num_month.put(2, "February");
                dic_num_month.put(3, "March");
                dic_num_month.put(4, "April");
                dic_num_month.put(5, "May");
                dic_num_month.put(6, "June");
                dic_num_month.put(7, "July");
                dic_num_month.put(8, "August");
                dic_num_month.put(9, "September");
                dic_num_month.put(10, "October");
                dic_num_month.put(11, "November");
                dic_num_month.put(12, "December");
            }
            if (dic_month_num.isEmpty()) {
                dic_month_num.put("January", 1);
                dic_month_num.put("February", 2);
                dic_month_num.put("March", 3);
                dic_month_num.put("April", 4);
                dic_month_num.put("May", 5);
                dic_month_num.put("June", 6);
                dic_month_num.put("July", 7);
                dic_month_num.put("August", 8);
                dic_month_num.put("September", 9);
                dic_month_num.put("October", 10);
                dic_month_num.put("November", 11);
                dic_month_num.put("December", 12);
            }
            if (arr_mon.size() != 0) {arr_mon.clear();}
            if (arr_tues.size() != 0) {arr_tues.clear();}
            if (arr_wed.size() != 0) {arr_wed.clear();}
            if (arr_thurs.size() != 0) {arr_thurs.clear();}
            if (arr_fri.size() != 0) {arr_fri.clear();}

            if (arr_time_interval.size() == 0) {
                Integer temp_hr = 8;
                String temp_hr_format = "";
                for (int i = 0; i < 12; i++) {
                    if (temp_hr + i < 10) {
                        temp_hr_format = "0" + String.valueOf(temp_hr + i) + ":00";
                    } else {
                        temp_hr_format = String.valueOf(temp_hr + i) + ":00";
                    }
                    System.out.println(temp_hr_format);
                    arr_time_interval.add(temp_hr_format);
                }
            }

            section_id = request.getParameter("sectionid");
            from_month = request.getParameter("fromMonth");
            from_date = request.getParameter("fromDate");
            to_month = request.getParameter("toMonth");
            to_date = request.getParameter("toDate");

            String sql_get_time = "SELECT meet_day, start_time, end_time FROM Meeting WHERE SectionId = ?";

            PreparedStatement st = conn.prepareStatement(sql_get_time);
            st.setString(1, section_id);
            ResultSet rs = st.executeQuery();
            while(rs.next()) {
                String[] temp_list = rs.getString(1).split(",");
                for (int i = 0; i < temp_list.length; i++) {
                    if (temp_list[i].equals("Monday")) {
                        arr_mon.add(rs.getString(2));
                    } else if (temp_list[i].equals("Tuesday")) {
                        arr_tues.add(rs.getString(2));
                    } else if (temp_list[i].equals("Wednesday")) {
                        arr_wed.add(rs.getString(2));
                    } else if (temp_list[i].equals("Thursday")) {
                        arr_thurs.add(rs.getString(2));
                    } else if (temp_list[i].equals("Friday")) {
                        arr_fri.add(rs.getString(2));
                    }
                }
            }
            rs.close();
            st.close();
            conn.close();

            Calendar c = Calendar.getInstance();
            c.set(Integer.parseInt(current_year), Integer.parseInt(from_month)-1, Integer.parseInt(from_date));
            Integer from_num_dayOfWeek = c.get(Calendar.DAY_OF_WEEK);
            String from_dayOfWeek = dic_num_day.get(from_num_dayOfWeek);

            c.set(Integer.parseInt(current_year), Integer.parseInt(to_month)-1, Integer.parseInt(to_date));
            Integer to_num_dayOfWeek = c.get(Calendar.DAY_OF_WEEK);
            String to_dayOfWeek = dic_num_day.get(to_num_dayOfWeek);
            System.out.println(current_year + " " + from_month + " " + from_date + " --> " + from_dayOfWeek);
            System.out.println(current_year + " " + to_month + " " + to_date + " --> " + to_dayOfWeek);

            Integer num_between;
            if (from_month.equals(to_month)) {  // if same month
                num_between = Integer.parseInt(to_date) - Integer.parseInt(from_date) + 1;
            } else {
                Integer end_date = dic_md.get(Integer.parseInt(from_month));
                num_between = ( end_date - Integer.parseInt(from_date)) + Integer.parseInt(to_date) + 1;
            }

            Integer num_day = from_num_dayOfWeek;
            String current_day = "";
            Integer current_end_day = dic_md.get( Integer.parseInt(from_month) );
            Integer current_date = Integer.parseInt(from_date);
            String current_mon = dic_num_month.get( Integer.parseInt(from_month) );


            String cur_time;
            Integer cur_hr;
            String next_hr;
            for (int j = 0; j < num_between; j++) {
                current_day = dic_num_day.get(num_day);
                System.out.println(current_mon + " " + current_date + " " + current_day);

                for (int i = 0; i < arr_time_interval.size(); i++) {
                    cur_time = arr_time_interval.get(i);
                    if (current_day.equals("Monday")) {
                        if ( !arr_mon.contains(cur_time)) {
                            cur_hr = Integer.parseInt((cur_time.split(":"))[0]);
                            if (cur_hr+1 < 10) { next_hr = "0" + String.valueOf(cur_hr+1) + ":00"; }
                            else { next_hr = String.valueOf(cur_hr+1) + ":00"; }
                            out.println("<h3>" + current_mon + " " + current_date + " " + current_day + " " + cur_time + " - " + next_hr + "</h3>");
                        }
                    } else if (current_day.equals("Tuesday")) {
                        if ( !arr_tues.contains(cur_time)) {
                            cur_hr = Integer.parseInt((cur_time.split(":"))[0]);
                            if (cur_hr+1 < 10) { next_hr = "0" + String.valueOf(cur_hr+1) + ":00"; }
                            else { next_hr = String.valueOf(cur_hr+1) + ":00"; }
                            out.println("<h3>" + current_mon + " " + current_date + " " + current_day + " " + cur_time + " - " + next_hr + "</h3>");
                        }
                    } else if (current_day.equals("Wednesday")) {
                        if ( !arr_wed.contains(cur_time)) {
                            cur_hr = Integer.parseInt((cur_time.split(":"))[0]);
                            if (cur_hr+1 < 10) { next_hr = "0" + String.valueOf(cur_hr+1) + ":00"; }
                            else { next_hr = String.valueOf(cur_hr+1) + ":00"; }
                            out.println("<h3>" + current_mon + " " + current_date + " " + current_day + " " + cur_time + " - " + next_hr + "</h3>");
                        }
                    } else if (current_day.equals("Thursday")) {
                        if ( !arr_thurs.contains(cur_time)) {
                            cur_hr = Integer.parseInt((cur_time.split(":"))[0]);
                            if (cur_hr+1 < 10) { next_hr = "0" + String.valueOf(cur_hr+1) + ":00"; }
                            else { next_hr = String.valueOf(cur_hr+1) + ":00"; }
                            out.println("<h3>" + current_mon + " " + current_date + " " + current_day + " " + cur_time + " - " + next_hr + "</h3>");
                        }
                    } else if (current_day.equals("Friday")) {
                        if ( !arr_fri.contains(cur_time)) {
                            cur_hr = Integer.parseInt((cur_time.split(":"))[0]);
                            if (cur_hr+1 < 10) { next_hr = "0" + String.valueOf(cur_hr+1) + ":00"; }
                            else { next_hr = String.valueOf(cur_hr+1) + ":00"; }
                            out.println("<h3>" + current_mon + " " + current_date + " " + current_day + " " + cur_time + " - " + next_hr + "</h3>");
                        }
                    }
                }

                if (current_date.equals(current_end_day)) {
                    current_date = 1; // start date of next month
                    current_mon = dic_num_month.get(((dic_month_num.get(current_mon)) + 1) % 12 + 1);
                    current_end_day = dic_md.get( dic_month_num.get(current_mon) );
                } else {
                    current_date += 1;
                }

                num_day = ((num_day + 1) % 7);
            }

        } catch (Exception e) {
            is_correct = false;
            wrong = e.toString();
            System.out.println(e);
        }
    %>
    <a href="../../report.jsp"><button> Homepage </button></a>
    <jsp:include page="../../footer.jsp"/>
</body>
</html>
