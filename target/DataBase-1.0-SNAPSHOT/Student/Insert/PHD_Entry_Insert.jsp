<%--
  Created by IntelliJ IDEA.
  User: guoyili
  Date: 4/27/21
  Time: 5:11 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.sql.*" contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%!
    String Student_ID = "";
    String Type = "";
    String Department ="";
    String advior = "";
    int thesis = 0;
    int diff_thesis = 0;
%>
<%
    String url = "jdbc:postgresql://localhost:5432/postgres?user=postgres&password=4645";
    try {
        Class.forName("org.postgresql.Driver");
        Connection conn = DriverManager.getConnection(url);
        Student_ID = request.getParameter("student_id");
        Type = request.getParameter("Type");
        Department = request.getParameter("Department");
        String stu_data = "INSERT into phd Values(?,?,?,?,?,?)";
        String random = "SELECT faculty_name FROM Faculty ORDER BY RANDOM() LIMIT 1";
        conn.setAutoCommit(false);
        PreparedStatement rand = conn.prepareStatement(random);
        ResultSet rs = rand.executeQuery();
        /*
        *  Random generate a advior for phd
        * */
        if (rs.next()) {
            advior = rs.getString("faculty_name");
            System.out.println(advior);
        }

        PreparedStatement st = conn.prepareStatement(stu_data);
        st.setString(1,Student_ID);
        st.setString(2, Department);
        st.setString(3, Type);
        st.setString(4, advior);
        st.setInt(5,thesis);
        st.setInt(6,diff_thesis);
        st.executeUpdate();
        conn.commit();
        conn.setAutoCommit(true);
        st.close();
        rand.close();
        rs.close();
        conn.close();
    } catch (Exception e) {
        System.out.println(e);
    }
%>

Student ID: <%= Student_ID%>
<br/><br>
<H3>Successfully inserted</H3>
<a href="../Student_DataBase_Info.jsp"><button> Check Database </button></a>
<a href="../../insertPage.jsp"><button> Homepage</button></a>
<jsp:include page="../../footer.jsp"/>
</body>
</html>
