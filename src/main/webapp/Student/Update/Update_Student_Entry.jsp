<%--
  Created by IntelliJ IDEA.
  User: guoyili
  Date: 4/27/21
  Time: 8:23 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.sql.*" contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    String FirstName = "";
    String MiddleName = "";
    String LastName = "";
    String Student_ID = "";
    String SSN = "";
    String Residency = "";
    String Enrollment = "";
%>
<%
    String url = "jdbc:postgresql://localhost:5432/postgres?user=postgres&password=4645";
    try {
        Class.forName("org.postgresql.Driver");
        Connection conn = DriverManager.getConnection(url);
        FirstName = request.getParameter("First_Name");
        MiddleName = request.getParameter("Middle_Name");
        LastName = request.getParameter("Last_Name");
        Student_ID = request.getParameter("Student_Id");
        SSN = request.getParameter("SSN");
        Residency = request.getParameter("Residency");
        Enrollment = request.getParameter("Enrollment");
        conn.setAutoCommit(false);
        PreparedStatement st = conn.prepareStatement(
                "UPDATE student SET  ssn = ?, firstname = ?," +
                        " middlename = ?, lastname = ?,residency = ?,enrollment = ? where student_id = ?");
        st.setInt(1, Integer.parseInt(SSN));
        st.setString(2, FirstName);
        st.setString(3, MiddleName);
        st.setString(4, LastName);
        st.setString(5, Residency);
        st.setString(6,Enrollment);
        st.setString(7, Student_ID);
        int row = st.executeUpdate();
        conn.commit();
        conn.setAutoCommit(true);
        st.close();
    } catch (Exception e) {
        System.out.println(e);
    }
%>
<p>Successful Update Student Information</p>
<br/><br>
Student Name: <%=FirstName + LastName%>
<br/><br>
Student ID: <%=Student_ID%>
<br/><br>
<a href="../Student_DataBase_Info.jsp"><button> Check Database </button></a>
<jsp:include page="../../footer.jsp"/>
</body>
</html>
