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
            if (arr_mon.size() != 0) {arr_mon.clear();}
            if (arr_tues.size() != 0) {arr_tues.clear();}
            if (arr_wed.size() != 0) {arr_wed.clear();}
            if (arr_thurs.size() != 0) {arr_thurs.clear();}
            if (arr_fri.size() != 0) {arr_fri.clear();}

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
            Integer num_dayOfWeek = c.get(Calendar.DAY_OF_WEEK);
            String from_dayOfWeek = dic_num_day.get(num_dayOfWeek);

            c.set(Integer.parseInt(current_year), Integer.parseInt(to_month)-1, Integer.parseInt(to_date));
            num_dayOfWeek = c.get(Calendar.DAY_OF_WEEK);
            String to_dayOfWeek = dic_num_day.get(num_dayOfWeek);
            System.out.println(current_year + " " + from_month + " " + from_date + " --> " + from_dayOfWeek);
            System.out.println(current_year + " " + to_month + " " + to_date + " --> " + to_dayOfWeek);

            Integer num_between;
            if (from_month.equals(to_month)) {  // if same month
                num_between = Integer.parseInt(to_date) - Integer.parseInt(from_date);
                System.out.print(num_between);
            }


        } catch (Exception e) {
            is_correct = false;
            wrong = e.toString();
            System.out.println(e);
        }
    %>
</body>
</html>
