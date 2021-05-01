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
    String SSN = "";
    String FirstName = "";
    String MiddleName ="";
    String LastName = "";
    String Residency ="";
    String Enrollment ="";
    String StudentType = "";
    Boolean is_correct = false;
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
         StudentType = request.getParameter("StudentType");
         String stu_data = "INSERT into student Values(?,?,?,?,?,?,?,?)";
         conn.setAutoCommit(false);
         String bc = "Select * from student where student_id = ?";
         PreparedStatement st1 = conn.prepareStatement(bc);
         st1.setString(1,Student_ID);
         ResultSet rs = st1.executeQuery();
        if (rs.next() ) {
            conn.setAutoCommit(true);
            st1.close();
            System.out.println("Student insert -- no data");
        }else {
            is_correct = true;
            PreparedStatement st = conn.prepareStatement(stu_data);
            st.setString(1,Student_ID);
            st.setInt(2, Integer.parseInt(SSN));
            st.setString(3, FirstName);
            st.setString(4, MiddleName);
            st.setString(5, LastName);
            st.setString(6, Residency);
            st.setString(7,Enrollment);
            st.setString(8,StudentType);
            int row = st.executeUpdate();
            conn.commit();
            conn.setAutoCommit(true);
            st.close();

            session.setAttribute("student_id",Student_ID);
            if(StudentType.equals("Undergraduate")) {
                response.sendRedirect("./Undergraduate.jsp");
            } else if (StudentType.equals("Master")) {
                response.sendRedirect("./Master.jsp");
            } else {
                response.sendRedirect("./PHD.jsp");
            }
        }
        } catch (Exception e) {
            System.out.println(e);
        }
%>

<%
   if(is_correct) {
       out.println("<H3><u>The PID/SSN shown below have existed , Please, try again</u></b>");
   }else {
       out.println("<H3><u>Successful Insert new Student into the dataBase</u></b>");
   }
%>
<br/><br>
Student Name: <%=FirstName + " " + LastName%>
<br/><br>
Student ID: <%= Student_ID%>
<br/><br>
<a href="../Student_DataBase_Info.jsp"><button> Check Database </button></a>
<a href="./../../index.jsp"><button> homepage </button></a>
<jsp:include page="../../footer.jsp"/>
</body>
</html>
