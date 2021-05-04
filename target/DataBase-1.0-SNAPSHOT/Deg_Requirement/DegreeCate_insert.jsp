<%--
  Created by IntelliJ IDEA.
  User: guoyili
  Date: 5/2/21
  Time: 4:10 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.sql.*" contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>

<body>
<%!
    String degreeName = "";
    String degreeType = "";
    String department = "";
    int minimum_units = 0;
    double Minimum_Average_Grade = 0;
    String concentration = "";
    boolean is_correct = true;
    String url = "jdbc:postgresql://localhost:5432/postgres?user=postgres&password=4645";
%>
<%
    degreeName = request.getParameter("degreeName");
    degreeType =  request.getParameter("Type");
    department =  request.getParameter("Department");
    minimum_units = Integer.parseInt(request.getParameter("units"));
    Minimum_Average_Grade = Double.parseDouble(request.getParameter("grade"));
    concentration = request.getParameter("concentration");
    try {
        Class.forName("org.postgresql.Driver");
        Connection conn = DriverManager.getConnection(url);
        String sql = "Insert  into degreeCate values(?,?,?,?,?,?)";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1,degreeName);
        ps.setString(2,degreeType);
        ps.setString(3,department);
        ps.setInt(4,minimum_units);
        ps.setDouble(5,Minimum_Average_Grade);
        ps.setString(6,concentration);
        ps.executeUpdate();
    }catch (Exception e){
        is_correct = false;
        System.out.println(e);
    }

%>

<% if (is_correct) {%>
<h3>Successfully Add Degree Info</h3>
<% } else { %>
<h3>Please,check input data.</h3>
<h3>Degree may have/haven't been exited.</h3>
<% } %>
<a href="./DegreeCate.jsp"><button> Enter More </button></a>
<a href="./DegreeDataBase.jsp"><button> Check Database </button></a>
<a href="../index.jsp"><button> Homepage</button></a>
<jsp:include page="../footer.jsp"/>
</body>
</html>
