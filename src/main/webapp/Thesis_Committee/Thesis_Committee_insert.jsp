<%--
  Created by IntelliJ IDEA.
  User: guoyili
  Date: 5/1/21
  Time: 12:21 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.sql.*"   contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%!
    String student_id = "";
    String FirstName = "";
    String LastName = "";
    String MiddleName = "";
    String program = "";
    String Department  = "";
    String name = "";
    boolean is_correct = false;
    String url = "jdbc:postgresql://localhost:5432/postgres?user=postgres&password=4645";
%>
<%
    student_id = request.getParameter("Student_Id");
    FirstName = request.getParameter("First_Name");
    MiddleName = request.getParameter("Middle_Name");
    LastName = request.getParameter("Last_Name");
    program = request.getParameter("Program");
    Department = request.getParameter("Department");
    name = FirstName + " " + MiddleName + " " + LastName;
    name = name.toLowerCase();
    try {
        Class.forName("org.postgresql.Driver");
        Connection conn = DriverManager.getConnection(url);
         /*
         *  Check if the Student id whether if valid or not
         * */
        String sql_id = "select * from student where student_id = ?";
        PreparedStatement ID_Check = conn.prepareStatement(sql_id);
        ID_Check.setString(1,student_id);
        ResultSet ID_St = ID_Check.executeQuery();

        /*
         *  Check if the faculty name whether if valid or not
         * */
        String sql_Name = "select * from faculty where faculty_name = ?";
        PreparedStatement Name_Check = conn.prepareStatement(sql_Name);
        Name_Check.setString(1,name);
        ResultSet Name_St = Name_Check.executeQuery();

        /*
        *  check if the name + faculty existed in database
        * */
        String sql_thesis = "select * from Thesis_committee where Student_id = ? and faculty_name = ?";
        PreparedStatement Thesis_Check = conn.prepareStatement(sql_thesis);
        Thesis_Check.setString(1,student_id);
        Thesis_Check.setString(2,name);
        ResultSet Thesis_St = Thesis_Check.executeQuery();

        if (!ID_St.next() || !Name_St.next() || Thesis_St.next()) {
            System.out.println("ID/Faculty does not exist");
        } else {
            /*
            *  create a new Thesis committee
            * */
            is_correct = true;
            String sql = "Insert into Thesis_committee values (?,?,?,?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1,student_id);
            ps.setString(2,program);
            ps.setString(3,name);
            ps.setString(4,Department);
            ps.executeQuery();
            ps.close();
        }
        ID_Check.close();
        ID_St.close();
        Name_Check.close();
        Name_St.close();
        Thesis_Check.close();
        Thesis_St.close();
    } catch (Exception e) {
        System.out.println(e);
    }
%>
<% if (is_correct) {%>
<h3>Have been updated your committee info</h3>
<% } else { %>
<h3>Please,check the information.</h3>
<br/>
<h3>Student Id/faculty name may not correct</h3>
<br/>
<h3> it exist in our dataBase</h3>
<% } %>
<a href="./Thesis_Committee_Submission.jsp"><button> Enter More </button></a>
<a href="./Thesis_Committee_DataBase.jsp"><button> Check Database </button></a>
<a href="../index.jsp"><button> Homepage</button></a>
<jsp:include page="../footer.jsp"/>
</body>
</html>
