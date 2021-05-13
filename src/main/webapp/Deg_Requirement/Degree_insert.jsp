<%--
  Created by IntelliJ IDEA.
  User: guoyili
  Date: 5/2/21
  Time: 3:54 PM
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
    String Type = "";
    String url = "jdbc:postgresql://localhost:5432/postgres?user=postgres&password=4645";
    boolean is_correct = true;
    String error = "";
    int units = 0;
    String department = "";
    int lowerDivisonUnit = 0;
    int UpperDivisionUnit = 0;
    int ElectiveUnit = 0;
%>
<%
    degreeName = request.getParameter("degreeName");
    Type =  request.getParameter("Type");
    department = request.getParameter("department");
//    units = Integer.parseInt(request.getParameter("Units"));
    lowerDivisonUnit = Integer.parseInt(request.getParameter("lowerDivisonUnit"));
    UpperDivisionUnit = Integer.parseInt(request.getParameter("UpperDivisionUnit"));
    ElectiveUnit = Integer.parseInt(request.getParameter("ElectiveUnit"));
    try {
        units = lowerDivisonUnit + UpperDivisionUnit + ElectiveUnit;
        Class.forName("org.postgresql.Driver");
        Connection conn = DriverManager.getConnection(url);
        String sql = "insert into degree values(?,?,?,?,?,?,?)";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1,degreeName);
        ps.setString(2,Type);
        ps.setString(3,department);
        ps.setInt(4,units);
        ps.setInt(5,lowerDivisonUnit);
        ps.setInt(6,UpperDivisionUnit);
        ps.setInt(7,ElectiveUnit);
        ps.executeUpdate();
    } catch (Exception e) {
        is_correct = false;
        System.out.println(e);
    }
%>
<% if (is_correct) {%>
<h3>Successfully Add Degree Info</h3>
<% } else { %>
<h3>Please,check input data.</h3>
<h3>Degree may have been exited.</h3>
<% } %>
<a href="./DegreePage.jsp"><button> Enter More </button></a>
<a href="./DegreeDataBase.jsp"><button> Check Database </button></a>
<a href="../index.jsp"><button> Homepage</button></a>
<jsp:include page="../footer.jsp"/>
</body>
</html>
