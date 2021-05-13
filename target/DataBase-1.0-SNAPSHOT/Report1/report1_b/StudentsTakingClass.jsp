<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: AmberWang
  Date: 2021/5/13
  Time: 上午 01:09
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
        List<String> arr_courseId = new ArrayList<>();
        List<String> arr_quarter = new ArrayList<>();
        List<String> arr_year = new ArrayList<>();
        List<String> arr_classId = new ArrayList<>();
    %>
    <%
        // if uses the back button, arraylist will be added on
        if (arr_courseId.size() != 0) {arr_courseId.clear();}
        if (arr_quarter.size() != 0) {arr_quarter.clear();}
        if (arr_year.size() != 0) {arr_year.clear();}
        if (arr_classId.size() != 0) {arr_classId.clear();}

        String url = "jdbc:postgresql://localhost:5432/postgres?user=postgres&password=4645";
        try {
            Class.forName("org.postgresql.Driver");
            Connection conn = DriverManager.getConnection(url);
            Statement sm = conn.createStatement();
            String sql_st = "SELECT Course.CourseId, Class.Quarter, Class.Year, Class.ClassId FROM Course INNER JOIN Class ON Course.CourseId = Class.CourseId GROUP BY Course.CourseId, Class.Quarter, Class.Year, Class.ClassId";
            ResultSet st = sm.executeQuery(sql_st);
            while(st.next()) {
                arr_courseId.add(st.getString(1));
                arr_quarter.add(st.getString(2));
                arr_year.add(st.getString(3));
                arr_classId.add(st.getString(4));
            }

            sm.close();
            st.close();
            conn.close();
        } catch (Exception e) {
            System.out.println(e);
        }
    %>
    <form action="StudentsTakingClassReport.jsp" method="post">
        <h3>Pick a class for report</h3>
        Select Class: <select name="classId">
        <% for (int i = 0; i < arr_courseId.size(); i++) { %>
        <option value="<%=arr_classId.get(i)%>">
            <%=arr_courseId.get(i)%>, <%=arr_quarter.get(i)%>, <%=arr_year.get(i)%>
        </option>
        <% } %>
        </select>
        <br/><br/>
        <input type="submit" value="Submit" />
    </form>
    <a href="../../report.jsp"><button> Homepage </button></a>
    <jsp:include page="../../footer.jsp"/>
</body>
</html>
