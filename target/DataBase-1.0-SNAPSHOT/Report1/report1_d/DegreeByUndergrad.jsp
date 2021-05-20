<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: AmberWang
  Date: 2021/5/14
  Time: 下午 01:27
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

        List<String> arr_degree_type = new ArrayList<>();
        List<String> arr_degree_name = new ArrayList<>();
    %>
    <%
        // if uses the back button, arrayList will be added on
        if (arr_ssn.size() != 0) {arr_ssn.clear();}
        if (arr_first.size() != 0) {arr_first.clear();}
        if (arr_middle.size() != 0) {arr_middle.clear();}
        if (arr_last.size() != 0) {arr_last.clear();}
        if (arr_degree_type.size() != 0) {arr_degree_type.clear();}
        if (arr_degree_name.size() != 0) {arr_degree_name.clear();}

        String url = "jdbc:postgresql://localhost:5432/postgres?user=postgres&password=4645";
        try {
            Class.forName("org.postgresql.Driver");
            Connection conn = DriverManager.getConnection(url);
            Statement sm = conn.createStatement();

            // get ssn without duplicates
            String sql_get_ssn = "SELECT Student.ssn FROM Student INNER JOIN Enrollment ON Enrollment.StudentId = Student.Student_Id GROUP BY Student.ssn";
//            String sql_get_ssn = "SELECT ssn FROM Student GROUP BY Student.ssn";

            String sql_get_name = "SELECT a.ssn, firstname, middlename, lastname FROM (" + sql_get_ssn + ") AS a INNER JOIN Student ON a.ssn = Student.ssn";

            ResultSet st = sm.executeQuery(sql_get_name);
            while(st.next()) {
                arr_ssn.add(st.getString(1));
                arr_first.add(st.getString(2));
                arr_middle.add(st.getString(3));
                arr_last.add(st.getString(4));
            }

            String sql_get_degree = "SELECT Degree_Type, Degree_Name FROM Degree WHERE Degree_Type = 'B.S.' OR Degree_Type = 'B.A.'";
            st = sm.executeQuery(sql_get_degree);
            while(st.next()) {
                arr_degree_type.add(st.getString(1));
                arr_degree_name.add(st.getString(2));
            }
            sm.close();
            st.close();
            conn.close();
        } catch (Exception e) {
            System.out.println(e);
        }
    %>
    <form action="DegreeCheck.jsp" method="post">
        <h3>Pick a student for report</h3>
        Select Student: <select name="ssn">
            <%  for (int i = 0; i < arr_ssn.size(); i++) {
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
        <br/>
        <h3>Pick a degree for report</h3>
        Select Degree: <select name="degree">
        <% for (int i = 0; i < arr_degree_type.size(); i++) { %>
            <option><%=arr_degree_type.get(i)%> <%=arr_degree_name.get(i)%></option>
        <% } %>
        </select>
        <br/><br/>
        <input type="submit" value="Submit"/>
    </form>
    <a href="../../report.jsp"><button> Homepage </button></a>
    <jsp:include page="../../footer.jsp"/>
</body>
</html>
