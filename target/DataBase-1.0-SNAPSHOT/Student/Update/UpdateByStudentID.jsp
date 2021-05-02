<%--
  Created by IntelliJ IDEA.
  User: guoyili
  Date: 4/27/21
  Time: 8:17 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.sql.*" contentType="text/html;charset=UTF-8" language="java" %>
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
        border: 1px solid #dddddd;
        text-align: left;
        padding: 5px;
    }
    tr:nth-child(even) {
        background-color: #dddddd;
    }
</style>
<body>
<%!
    String ID = "";
    String SSN = "";
    String FirstName = "";
    String MiddleName ="";
    String LastName = "";
    String Residency ="";
    String Enrollment ="";
    Boolean is_correct = false;
%>
<%
    try{
        String url = "jdbc:postgresql://localhost:5432/postgres?user=postgres&password=4645";
        Class.forName("org.postgresql.Driver");
        Connection conn = DriverManager.getConnection(url);
        ID = request.getParameter("student_id");
        System.out.println("update "+ID);
        String sql = "SELECT * from student where student_id = ?";

        conn.setAutoCommit(false);
        PreparedStatement st = conn.prepareStatement(sql);
        st.setString(1,ID);

        // 1)
        ResultSet rs = st.executeQuery();
        System.out.println(rs);
//        is_correct = true;
        while (rs.next()) {
            SSN = rs.getString("ssn");
            FirstName = rs.getString("firstname");
            MiddleName = rs.getString("middlename");
            LastName = rs.getString("lastname");
            Residency = rs.getString("residency");
            Enrollment = rs.getString("enrollment");
        }
        conn.commit();
        conn.setAutoCommit(true);
        st.close();
        conn.close();
    } catch (Exception e) {
        System.out.println(e);
    }
%>
<% if(SSN.equals("")) { %>
<H3><u>The PID does not exist, Please, try again</u></h3>
<br/> <br/>
<a href="./../../index.jsp"><button> homepage </button></a>
<%} else {%>
<form action="Update_Student_Entry.jsp" method="post">
    Student ID: <input type="text" name="Student_Id" value="<%=ID%>" readonly />
    <br/> <br/>
    SSN: <input type="text" name="SSN" value="<%=SSN%>"  size="8"/>
    <br/> <br/>
    First Name: <input type="text"  value="<%=FirstName%>" name="First_Name" required/>
    <br/> <br/>
    Middle Name: <input type="text" value="<%=MiddleName%>" name="Middle_Name" />
    <br/> <br/>
    Last Name: <input type="text"  value="<%=LastName%>" name="Last_Name" required/>
    <br/> <br/>

    Residency: <select value="<%=Residency%>" name="Residency" >
    <option>California resident</option>
    <option>Foreign</option>
    <option>Non-CA US</option>
</select>
    <br/> <br/>
    Enrollment:  <select value="<%=Enrollment%>"  name="Enrollment">
    <option>Current enrolled</option>
    <option>non enrolled</option>
</select>
    <br/> <br/>
    <input type="submit" value="Submit"/>
</form>
<% } %>
</body>
</html>
