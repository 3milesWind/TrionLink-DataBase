<%--
  Created by IntelliJ IDEA.
  User: guoyili
  Date: 4/27/21
  Time: 7:18 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.sql.*" contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<style>
    table {
        font-family: arial, sans-serif;
        border-collapse: collapse;
        width: 50%;
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
    boolean is_correct = false;
%>
<%

    String url = "jdbc:postgresql://localhost:5432/postgres?user=postgres&password=4645";
    try {
        Class.forName("org.postgresql.Driver");
        Connection conn = DriverManager.getConnection(url);
        String Student_ID = request.getParameter("student_id");
        System.out.println(Student_ID);
        String sql = "Delete from student where student_id = ?";
        conn.setAutoCommit(false);
        PreparedStatement st1 = conn.prepareStatement("select * from student where student_id = ?");
        st1.setString(1,Student_ID);
        ResultSet ps = st1.executeQuery();
        if (!ps.next() ) {
            conn.setAutoCommit(true);
            st1.close();
            System.out.println("no data");
        }else {
            is_correct = true;
            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1,Student_ID);
            int row = st.executeUpdate();
            conn.commit();
            conn.setAutoCommit(true);
            st.close();
        }
    } catch (Exception e) {
        System.out.println(e);
    }

%>
<% if(is_correct == false) { %>
<H3><u>The PID does not exist, Please, try again</u></h3>
<br/> <br/>
<a href="./../../index.jsp"><button> homepage </button></a>
<%} else {%>
<p>Successful Delete! Here is new Student table</p>
<table>
    <%
        try{
            Class.forName("org.postgresql.Driver");
            Connection conn = DriverManager.getConnection(url);
            Statement sm = conn.createStatement();
            ResultSet st = sm.executeQuery("select * from student");
            out.println("<tr><th>StudentID</th><th>StudentSSn</th><th>StudentName</th></tr>");
            while (st.next()) {

                out.print("<tr><th>" + st.getString(1) + "</th>" + "<th>" + st.getString(2)  + "</th>"
                        + "<th>" + st.getString(3) + " "  + st.getString(5) + "</th></tr>");
            }
        }catch (Exception e){
            System.out.println(e);
        }
    %>
</table>
<%}%>
<a href="../../insertPage.jsp"><button> Homepage</button></a>
<a href="./DeleteByStudentID.jsp"><button> Delete more </button></a>
<a href="../Student_DataBase_Info.jsp"><button> More detail </button></a>
<jsp:include page="../../footer.jsp"/>
</body>
</html>
