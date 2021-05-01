<%--
  Created by IntelliJ IDEA.
  User: guoyili
  Date: 4/30/21
  Time: 12:40 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.sql.*" contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.HashMap" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%!
    String Student_id = "";
    String Start_Quarter = "";
    String Start_year = "";
    String End_Quarter = "";
    String End_year = "";
    String Reason = "";
    Boolean is_correct = false;
%>
<%
    HashMap<String,Integer> hs = new HashMap<>();
    hs.put("Winter",1);
    hs.put("Spring",2);
    hs.put("Summer",3);
    hs.put("Fall",4);
    String url = "jdbc:postgresql://localhost:5432/postgres?user=postgres&password=4645";
    try {
        Class.forName("org.postgresql.Driver");
        Connection conn = DriverManager.getConnection(url);
        Student_id = request.getParameter("Student_Id");
        Start_Quarter = request.getParameter("start_quarter");
        Start_year = request.getParameter("start_year");
        End_Quarter = request.getParameter("end_quarter");
        End_year = request.getParameter("end_year");
        Reason = request.getParameter("reason");
        String stu_data = "INSERT into probation Values(?,?,?,?)";
        conn.setAutoCommit(false);
        String bc = "Select * from student where student_id = ?";
        PreparedStatement st1 = conn.prepareStatement(bc);
        st1.setString(1,Student_id);
        ResultSet rs = st1.executeQuery();
        int start_year = Integer.parseInt(Start_year);
        int end_year = Integer.parseInt(End_year);
        int start_quarter = hs.get(Start_Quarter);
        int end_quarter = hs.get(End_Quarter);
        if (!rs.next() || end_year < start_year || start_quarter >  end_quarter) {
            conn.setAutoCommit(true);
            st1.close();
            System.out.println("Student insert -- no data");
        }else {
            is_correct = true;
            PreparedStatement st = conn.prepareStatement(stu_data);
            st.setString(1,Student_id);
            st.setString(2, Start_Quarter + " " + Start_year);
            st.setString(3, End_Quarter + " " + End_year);
            st.setString(4, Reason);
            int row = st.executeUpdate();
            conn.commit();
            conn.setAutoCommit(true);
            st.close();
        }
    } catch (Exception e) {
        System.out.println(e);
    }
%>
<% if(is_correct) {%>
<h3> Successfully, add information into probation database </h3>>
<a href="./Probation_find_ID.jsp"><button> Check Probation  </button></a>
<a href="../../index.jsp"><button> homepage </button></a>
<jsp:include page="../footer.jsp"/>
<% } else { %>
<h3> The id/time you enter may not correct, Please Try again </h3>>
<a href="./Probation_Entry_Submission.jsp"><button> Probation Page </button></a>
<% } %>
</body>
</html>
