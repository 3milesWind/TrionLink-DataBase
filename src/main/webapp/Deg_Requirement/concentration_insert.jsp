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
    String name = "";
    String courses = "";
    String elective = "";
    int minUnit = 0;
    double minGPA = 0;
    boolean is_correct = true;
    String exception = "";
    String url = "jdbc:postgresql://localhost:5432/postgres?user=postgres&password=4645";
%>
<%
    name =  request.getParameter("concentration_name");
    degreeName = request.getParameter("degreeName");
    degreeType =  request.getParameter("Type");
    courses =  request.getParameter("courses");
    elective =  request.getParameter("elective");
    minGPA = Double.parseDouble(request.getParameter("minGPA"));
    minUnit = Integer.parseInt(request.getParameter("minUnit"));

    try {
        Class.forName("org.postgresql.Driver");
        Connection conn = DriverManager.getConnection(url);
        String sql = "Insert  into concentration values(?,?,?,?,?,?,?)";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1,name);
        ps.setString(2,degreeName);
        ps.setString(3,degreeType);
        ps.setString(4,courses);
        ps.setString(5,elective);
        ps.setDouble(6,minGPA);
        ps.setInt(7,minUnit);
        ps.executeUpdate();
    }catch (Exception e){
        is_correct = false;
        exception = e.toString();
        System.out.println(e);
    }

%>

<% if (is_correct) {%>
<h3>Successfully Add Degree Info</h3>
<% } else { %>
<h3>Please,check input data.</h3>
<h3>Degree may have/haven't been exited.</h3>
<h3><%=exception%></h3>>
<% } %>
<a href="concentration.jsp"><button> Enter More </button></a>
<a href="./DegreeDataBase.jsp"><button> Check Database </button></a>
<a href="../index.jsp"><button> Homepage</button></a>
<jsp:include page="../footer.jsp"/>
</body>
</html>
