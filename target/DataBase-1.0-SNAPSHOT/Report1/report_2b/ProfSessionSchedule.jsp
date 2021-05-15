<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.*" %><%--
  Created by IntelliJ IDEA.
  User: AmberWang
  Date: 2021/5/15
  Time: 上午 06:57
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
        List<String> arr_section_id = new ArrayList<>();
        List<String> arr_course_id = new ArrayList<>();
        List<String> arr_course_name = new ArrayList<>();
        List<String> arr_month = new ArrayList<String>(){
            {
                add("January");
                add("February");
                add("March");
                add("April");
                add("May");
                add("June");
                add("July");
                add("August");
                add("September");
                add("October");
                add("November");
                add("December");
            }
        };
    %>
    <%
        // clean the data
        if (arr_section_id.size() != 0) {arr_section_id.clear();}
        if (arr_course_id.size() != 0) {arr_course_id.clear();}
        if (arr_course_name.size() != 0) {arr_course_name.clear();}

        String url = "jdbc:postgresql://localhost:5432/postgres?user=postgres&password=4645";
        try {
            Class.forName("org.postgresql.Driver");
            Connection conn = DriverManager.getConnection(url);
            Statement sm = conn.createStatement();

            String sql_get_current_info = "SELECT a.CourseId, a.Title, Section.SectionId FROM (SELECT * FROM Class WHERE Quarter = 'Spring' AND Year = '2021') AS a INNER JOIN Section ON a.ClassId = Section.ClassId";
            ResultSet rs = sm.executeQuery(sql_get_current_info);
            while (rs.next()) {
                arr_course_id.add(rs.getString(1));
                arr_course_name.add(rs.getString(2));
                arr_section_id.add(rs.getString(3));
            }
            rs.close();
            sm.close();
            conn.close();
        } catch (Exception e) {
            System.out.println(e);
        }
    %>
    <form action="ProfSessionScheduleReport.jsp" method="post">
        <h3>Select a current section for report</h3>
        Select Section: <select name="sectionid">
        <% for (int i = 0; i < arr_course_id.size(); i++) { %>
            <option value="<%=arr_section_id.get(i)%>">
                <%=arr_course_id.get(i)%>, <%=arr_course_name.get(i)%>, <%=arr_section_id.get(i)%>
            </option>
        <% } %>
        </select>
        <br/><br/>
        From: Month: <select name="fromMonth">
        <% for (int i = 0; i < arr_month.size(); i++) { %>
            <option><%=arr_month.get(i)%></option>
        <% } %>
        </select>
        Date: <input type="number" name="fromDate" min="1" max="31"/>
        <br/><br/>
        To: Month: <select name="toMonth">
        <% for (int i = 0; i < arr_month.size(); i++) { %>
            <option><%=arr_month.get(i)%></option>
        <% } %>
        </select>
        Date: <input type="number" name="toDate" min="1" max="31"/>
        <br/><br/>
        <input type="submit" value="Submit" />
    </form>
    <a href="../../report.jsp"><button> Homepage </button></a>
    <jsp:include page="../../footer.jsp"/>
</body>
</html>
