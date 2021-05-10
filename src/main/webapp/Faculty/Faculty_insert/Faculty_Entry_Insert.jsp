<%--
  Created by IntelliJ IDEA.
  User: guoyili
  Date: 4/30/21
  Time: 1:58 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.sql.*" contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%!
    String url = "jdbc:postgresql://localhost:5432/postgres?user=postgres&password=4645";
    String FirstName = "";
    String LastName ="";
    String middleName = "";
    String title = "";
    String Department = "";
    String name ="";
    boolean is_correct = false;
%>
<%
    try {
        Class.forName("org.postgresql.Driver");
        Connection conn = DriverManager.getConnection(url);
        // get the request name
        FirstName = request.getParameter("First_Name");
        middleName = request.getParameter("Middle_Name");
        LastName = request.getParameter("Last_Name");
        title = request.getParameter("title");
        Department = request.getParameter("Department");

        String sql = "INSERT INTO Faculty VALUES (?,?,?)";
        String sql_ck = "Select * from faculty where faculty_name = ?";
        conn.setAutoCommit(false);
        PreparedStatement ck = conn.prepareStatement(sql_ck);
        if (middleName == "") {
            name = FirstName + " " + LastName;
        } else {
            name = FirstName + " " + middleName + " " + LastName;
        }
        name = name.toLowerCase();
        ck.setString(1, name);
        ResultSet st = ck.executeQuery();
        if (st.next()) {
            ck.close();
            System.out.println("no");
            System.out.println("Faculty is existed");
        } else {
            System.out.println("yes");
            is_correct = true;
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1,name);
            ps.setString(2,title);
            ps.setString(3,Department);
            ps.executeUpdate();
            ck.close();
        }
        conn.commit();
        conn.setAutoCommit(true);
        st.close();
    } catch (Exception e) {
        System.out.println(e);
    }
%>
<% if(is_correct) {%>
<h3>Successfully inserted the information of faculty </h3>
<a href="./Faculty_Insert_Page.jsp"><button> Enter More </button></a>
<a href="../Faculty_DataBase.jsp"><button> Check Database </button></a>
<a href="../../insertPage.jsp"><button> Homepage</button></a>
<jsp:include page="../../footer.jsp"/>
<% } else {%>
<h3>Please,check the faculty's name. And try again </h3>
<a href="Faculty_Insert_Page.jsp"><button> Re-Enter </button></a>
<a href="../../insertPage.jsp"><button> Homepage</button></a>
<jsp:include page="../../footer.jsp"/>
<% } %>
</body>
</html>
