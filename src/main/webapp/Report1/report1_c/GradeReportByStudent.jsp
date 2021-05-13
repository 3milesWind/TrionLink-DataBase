<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: AmberWang
  Date: 2021/5/13
  Time: 上午 09:23
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
        List<String> arr_ssn = new ArrayList<>();
        List<String> arr_first = new ArrayList<>();
        List<String> arr_middle = new ArrayList<>();
        List<String> arr_last = new ArrayList<>();
    %>
    <%
        // if uses the back button, arrayList will be added on
        if (arr_ssn.size() != 0) {arr_ssn.clear();}
        if (arr_first.size() != 0) {arr_first.clear();}
        if (arr_middle.size() != 0) {arr_middle.clear();}
        if (arr_last.size() != 0) {arr_last.clear();}

        String url = "jdbc:postgresql://localhost:5432/postgres?user=postgres&password=4645";
        try {
            Class.forName("org.postgresql.Driver");
            Connection conn = DriverManager.getConnection(url);
            Statement sm = conn.createStatement();
            String sql_st = "SELECT Student.ssn, Student.firstname, Student.middlename, Student.lastname FROM Student INNER JOIN Past_Course ON Past_Course.Student_Id = Student.Student_Id";
            ResultSet st = sm.executeQuery(sql_st);
            while(st.next()) {
                arr_ssn.add(st.getString(1));
                arr_first.add(st.getString(2));
                arr_middle.add(st.getString(3));
                arr_last.add(st.getString(4));
            }
            sm.close();
            st.close();
            conn.close();
        } catch (Exception e) {
            System.out.println(e);
        }
    %>
    <form action="GradeReportByStudentReport.jsp" method="post">
        <h3>Pick a student for grade report</h3>
        Select Student: <select name="ssn">
            <% for (int i = 0; i < arr_ssn.size(); i++) {
                    if (arr_middle.get(i).equals("")) {   %>
                        <option value="<%=arr_ssn.get(i)%>">
                            <%=arr_ssn.get(i)%>, <%=arr_first.get(i)%>, <%=arr_last.get(i)%>
                        </option>
                    <% } else { %>
                        <option value="<%=arr_ssn.get(i)%>">
                        <%=arr_ssn.get(i)%>, <%=arr_first.get(i)%>, <%=arr_middle.get(i)%>, <%=arr_last.get(i)%>
                        </option>
                    <% } %>
                <% } %>
        </select>
        <br/> <br/>
        <input type="submit" value="Submit" />
    </form>
    <a href="../../report.jsp"><button> Homepage </button></a>
    <jsp:include page="../../footer.jsp"/>
</body>
</html>
