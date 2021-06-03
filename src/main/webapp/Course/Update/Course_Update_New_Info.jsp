<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: AmberWang
  Date: 2021/6/3
  Time: 上午 09:06
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
        String CourseId = "";
        String CourseName = "";
        String Department = "";
        String Prerequisites = "";
        String Gradeoption = "";
        String Lab = "";
        Integer Minunits = 0;
        Integer Maxunits = 0;
    %>
    <%
        try{
            String url = "jdbc:postgresql://localhost:5432/postgres?user=postgres&password=4645";
            Class.forName("org.postgresql.Driver");
            Connection conn = DriverManager.getConnection(url);
            CourseId = request.getParameter("course_id");
            String sql = "select * from course where courseid = ?";

            conn.setAutoCommit(false);
            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, CourseId);

            ResultSet rs = st.executeQuery();
            while(rs.next()) {
                CourseName = rs.getString("course_name");
                Department = rs.getString("department");
                Prerequisites = rs.getString("prerequisites");
                Gradeoption = rs.getString("gradeoption");
                Lab = rs.getString("lab");
                Minunits = rs.getInt("minunits");
                Maxunits = rs.getInt("maxunits");
            }
            System.out.println(Gradeoption);
            System.out.println(Lab);
            conn.commit();
            conn.setAutoCommit(true);
            st.close();
            conn.close();
        } catch (Exception e) {
            System.out.println(e);
        }
    %>
    <%  if (CourseName.equals("")) { %>
        <H3><u>The Course ID does not exist. Please, try again</u></h3>
        <br/> <br/>
        <a href="./../../index.jsp"><button> Homepage </button></a>
    <%  } else { %>
        <form action="Course_Update.jsp" method="post">
            Course ID: <input type="text" name="courseid" value="<%=CourseId%>" readonly />
            <br/> <br/>
            CourseName: <input type="text" name="coursename" value="<%=CourseName%>" required/>
            <br/> <br/>
            Department: <input type="text" name="department" value="<%=Department%>" required/>
            <br/> <br/>
            Prerequisites: <input type="text" name="prerequisites" value="<%=Prerequisites%>" />
            <br/> <br/>
            Grade Option: <select name="gradeoption" value="<%=Gradeoption%>" required>
                <% if (Gradeoption.equals("Letter")) { %>
                    <option selected>Letter</option>
                    <option>S/U</option>
                    <option>Letter or S/U</option>
                <% } else if (Gradeoption.equals("S/U")) { %>
                    <option>Letter</option>
                    <option selected>S/U</option>
                    <option>Letter or S/U</option>
                <% } else { %>
                    <option>Letter</option>
                    <option>S/U</option>
                    <option selected>Letter or S/U</option>
                <% } %>
            </select>
            <br/> <br/>
            Lab: <select name="lab" value="<%=Lab%>" required>
                <% if (Lab.equals("Yes")) { %>
                    <option selected>Yes</option>
                    <option>No</option>
                <% } else { %>
                    <option>Yes</option>
                    <option selected>No</option>
                <% } %>
            </select>
            <br/> <br/>
            Min Units: <input type="number" name="minunits" value="<%=Minunits%>" min="0" required/>
            <br/> <br/>
            Max Units: <input type="number" name="maxunits" value="<%=Maxunits%>" min="0" required/>
            <br/> <br/>
            <input type="submit" value="Submit"/>
        </form>
    <%  } %>
</body>
</html>
