<%--
  Created by IntelliJ IDEA.
  User: guoyili
  Date: 5/13/21
  Time: 5:01 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.sql.*" contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
        <html>
<head>
    <title>Title</title>
</head>
<style>
    table {
        font-family: sans-serif;
        border-collapse: collapse;
        width: 50%;
    }
    td, th {
        border: 1px solid black;
        text-align: left;
    }
</style>
<body>
<%!
    String Course = "";
    String Profs  = "";
    String Quarter = "";
    String url = "jdbc:postgresql://localhost:5432/postgres?user=postgres&password=4645";
    boolean is_correct = true;
    String Exception = "";
    HashMap<String,Integer> res = new HashMap<>();
    HashMap<String,Integer> res2 = new HashMap<>();
%>
<%
    try {
        res.put("A",0);
        res.put("B",0);
        res.put("C",0);
        res.put("D",0);
        res.put("other",0);
        Class.forName("org.postgresql.Driver");
        Connection conn = DriverManager.getConnection(url);
        Course = request.getParameter("Course");
        Profs = request.getParameter("Profs");
        Quarter = request.getParameter("Quarter");
        System.out.println(Course +  " " + Profs + " " + Quarter + " ");
        conn.setAutoCommit(false);
        String sql = "select p.grade, count(grade) from past_course p left outer join section s\n" +
                "on p.course_id = s.courseid and p.sectionid = s.sectionid\n" +
                "where course_id = ? and quarter = ? and faculty_name = ?\n" +
                "group by grade";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1,Course);
        ps.setString(3,Profs);
        ps.setString(2,Quarter);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            String ch = rs.getString(1);
            if(!res.containsKey(ch)) {
                res.put("other",res.get("other") + Integer.parseInt(rs.getString(2)));
            } else {
                res.put(ch,res.get(ch) + Integer.parseInt(rs.getString(2)));
            }
        }
        conn.commit();
        conn.setAutoCommit(true);
        conn.close();
    } catch (Exception e) {
        is_correct = false;
        Exception = e.toString();
        System.out.println(e.toString());
    }
%>
<h3 >Course grade counts for profs over quarter</h3>
<%
    if (is_correct == false) {
        out.print("<h3>" + Exception + "</h3>");
    } else {

        if (res.isEmpty()) {
            out.print("no find useful information");
        } else {
            out.print("<table>");
            out.println("<tr><th>Grade</th><th>count</th></tr>");
            for (String key : res.keySet()) {
                out.println("<tr><th>" + key + "</th>" +
                        "<th>" +res.get(key) + "</th></tr>");
            }

            out.print("</table>");
        }
    }

%>
<%
    try {

        Class.forName("org.postgresql.Driver");
        Connection conn = DriverManager.getConnection(url);
        Course = request.getParameter("Course");
//        Profs = request.getParameter("Profs");
//    Quarter = request.getParameter("Quarter");
//    System.out.println(Course +  " " + Profs + " " + Quarter + " ");
        conn.setAutoCommit(false);
        String sql = "select p.student_id, p.grade from past_course p left outer join section s\n" +
                "on p.course_id = s.courseid and p.sectionid = s.sectionid\n" +
                "where course_id = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1,Course);
        ResultSet rs = ps.executeQuery();
        out.print("<h3> Given student x grade for " + Course + " over years</h3>" );
        out.print("<table>");
        out.println("<tr><th>StudentID</th><th>Grade</th></tr>");
        while (rs.next()) {
            out.println("<tr><th>" + rs.getString(1) + "</th>" +
                    "<th>" +rs.getString(2) + "</th></tr>");
        }
        out.print("</table>");
        conn.commit();
        conn.setAutoCommit(true);
        conn.close();
    } catch (Exception e) {
        is_correct = false;
        Exception = e.toString();
        System.out.println(e.toString());
    }
%>

<%
    try {
        res2.put("A",0);
        res2.put("B",0);
        res2.put("C",0);
        res2.put("D",0);
        res2.put("other",0);
        Class.forName("org.postgresql.Driver");
        Connection conn = DriverManager.getConnection(url);
        Course = request.getParameter("Course");
        Profs = request.getParameter("Profs");
//    Quarter = request.getParameter("Quarter");
//    System.out.println(Course +  " " + Profs + " " + Quarter + " ");
        conn.setAutoCommit(false);
        String sql = "select p.grade, count(grade) from past_course p left outer join section s\n" +
                "on p.course_id = s.courseid and p.sectionid = s.sectionid\n" +
                "where course_id = ? and faculty_name = ?\n" +
                "group by grade";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1,Course);
        ps.setString(2,Profs);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            String ch = rs.getString(1);
            if(!res2.containsKey(ch)) {
                res2.put("other",res2.get("other") + Integer.parseInt(rs.getString(2)));
            } else {
                res2.put(ch,res2.get(ch) + Integer.parseInt(rs.getString(2)));
            }
        }
        conn.commit();
        conn.setAutoCommit(true);
        conn.close();
    } catch (Exception e) {
        is_correct = false;
        Exception = e.toString();
        System.out.println(e.toString());
    }
%>
<h3 >Course counts for profs. over the years</h3>
<%
    if (is_correct == false) {
        out.print("<h3>" + Exception + "</h3>");
    } else {

        if (res.isEmpty()) {
            out.print("no find useful information");
        } else {
            out.print("<table>");
            out.println("<tr><th>Grade</th><th>count</th></tr>");
            for (String key : res.keySet()) {
                out.println("<tr><th>" + key + "</th>" +
                        "<th>" +res.get(key) + "</th></tr>");
            }

            out.print("</table>");
        }
    }

%>
<%
    try {
        Class.forName("org.postgresql.Driver");
        Connection conn = DriverManager.getConnection(url);
        Course = request.getParameter("Course");
        Profs = request.getParameter("Profs");
//    Quarter = request.getParameter("Quarter");
//    System.out.println(Course +  " " + Profs + " " + Quarter + " ");
        conn.setAutoCommit(false);
        String sql = "select avg(number_grade) from  grade_conversion g left outer join \n" +
                "(select p.student_id, p.grade from past_course p left outer join section s\n" +
                "on p.course_id = s.courseid and p.sectionid = s.sectionid\n" +
                "where course_id = ? and faculty_name = ?) as k on g.LETTER_GRADE = k.grade\n" +
                "where Student_id is not null and grade is not null\n";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1,Course);
        ps.setString(2,Profs);
        ResultSet rs = ps.executeQuery();
        out.print("<h3> Average degree <h3>");
        while (rs.next()) {
            out.print("<h3>" + rs.getString(1) + "</h3>");
        }
        conn.commit();
        conn.setAutoCommit(true);
        conn.close();
    } catch (Exception e) {
        is_correct = false;
        Exception = e.toString();
        System.out.println(e.toString());
    }
%>
<a href="./Report3Index.jsp"><button> other reports </button></a>
<a href="../../report.jsp"><button> Homepage </button></a>
<jsp:include page="../../footer.jsp"/>
</body>
</html>
