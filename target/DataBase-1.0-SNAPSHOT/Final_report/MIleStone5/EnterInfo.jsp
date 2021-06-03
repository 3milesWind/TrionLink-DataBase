<%--
  Created by IntelliJ IDEA.
  User: guoyili
  Date: 5/13/21
  Time: 4:58 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.sql.*" contentType="text/html;charset=UTF-8" language="java" %>
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
        border: 1px solid black;
        text-align: left;
    }
</style>
<body>
<%!
    String url = "jdbc:postgresql://localhost:5432/postgres?user=postgres&password=4645";
%>
<%
    try {
        Class.forName("org.postgresql.Driver");
        Connection conn = DriverManager.getConnection(url);
        String sql = "DROP TABLE IF EXISTS CPQG;\n" +
                "Create table CPQG as \n" +
                "select p.course_id,p.quarter, p.year, p.sectionid, s.faculty_name,\n" +
                "count (case when grade in ('A+','A','A-') then 1 ELSE Null end) as \"A\",\n" +
                "Count (case when grade in ('B+','B','B-') then 1 ELSE NUll end) as \"B\",\n" +
                "Count (Case when grade in ('C+', 'C', 'C-') then 1 ELSE NUll  end ) as \"C\",\n" +
                "Count (Case when grade in ('D+','D', 'D-') then 1 ELSE NUll end) as \"D\",\n" +
                "Count (Case When grade in ('F') Then 1 ELSE NUll end) as \"other\"\n" +
                "from past_course p left outer join section s\n" +
                "on p.course_id = s.courseid and p.sectionid = s.sectionid\n" +
                "group by p.course_id,p.quarter, p.year, p.sectionid, s.faculty_name";
        Statement st = conn.createStatement();
        st.execute(sql);
        sql =   "DROP Function IF EXISTS cpqg() CASCADE;" +
                "CREATE FUNCTION cpqg() RETURNS trigger AS $cpqg_func$\n" +
                "BEGIN\n" +
                "IF (TG_OP = 'INSERT') THEN\n" +
                "\tIF new.grade in ('A-','A','A+') THEN\n" +
                "    \tUPDATE CPQG SET \"A\" = \"A\" + 1 WHERE course_id = new.course_id AND sectionid = new.sectionid;\n" +
                "\tELSIF new.grade in ('B-','B','B+') THEN\n" +
                "\t\tUPDATE CPQG SET \"B\" = \"B\" + 1 WHERE course_id = new.course_id AND sectionid = new.sectionid;\n" +
                "\tELSIF new.grade in ('C-','C','C+') THEN\n" +
                "\t\tUPDATE CPQG SET \"C\" = \"C\" + 1 WHERE course_id = new.course_id AND sectionid = new.sectionid;\n" +
                "\tELSIF new.grade in ('D-','D','D+') THEN\n" +
                "\t\tUPDATE CPQG SET \"D\" = \"D\" + 1 WHERE course_id = new.course_id AND sectionid = new.sectionid;\n" +
                "\tELSE \n" +
                "\t\tUPDATE CPQG SET \"other\" = \"other\" + 1 WHERE course_id = new.course_id AND sectionid = new.sectionid;\n" +
                "\tEND if;\n" +
                "END IF;\n" +
                "IF (TG_OP = 'UPDATE') THEN\n" +
                "\tIF new.grade in ('A-','A','A+') THEN\n" +
                "    \tUPDATE CPQG SET \"A\" = \"A\" + 1 WHERE course_id = new.course_id AND sectionid = new.sectionid;\n" +
                "\t\t\n" +
                "\t\tIF old.grade in ('B-','B','B+') THEN\n" +
                "\t\t\tUPDATE CPQG SET \"B\" = \"B\" - 1 WHERE course_id = new.course_id AND sectionid = new.sectionid;\n" +
                "\t\tELSIF old.grade in ('C-','C','C+') THEN\n" +
                "\t\t\tUPDATE CPQG SET \"C\" = \"C\" - 1 WHERE course_id = new.course_id AND sectionid = new.sectionid;\n" +
                "\t\tELSIF old.grade in ('D-','D','D+') THEN\n" +
                "\t\t\tUPDATE CPQG SET \"D\" = \"D\" - 1 WHERE course_id = new.course_id AND sectionid = new.sectionid;\n" +
                "\t\tELSE \n" +
                "\t\t\tUPDATE CPQG SET \"other\" = \"other\" - 1 WHERE course_id = new.course_id AND sectionid = new.sectionid;\n" +
                "\t\tEND if;\n" +
                "\tELSIF new.grade in ('B-','B','B+') THEN\n" +
                "\t\tUPDATE CPQG SET \"B\" = \"B\" + 1 WHERE course_id = new.course_id AND sectionid = new.sectionid;\n" +
                "\t\t\n" +
                "\t\tIF old.grade in ('A-','A','A+') THEN\n" +
                "\t\t\tUPDATE CPQG SET \"A\" = \"A\" - 1 WHERE course_id = new.course_id AND sectionid = new.sectionid;\n" +
                "\t\tELSIF old.grade in ('C-','C','C+') THEN\n" +
                "\t\t\tUPDATE CPQG SET \"C\" = \"C\" - 1 WHERE course_id = new.course_id AND sectionid = new.sectionid;\n" +
                "\t\tELSIF old.grade in ('D-','D','D+') THEN\n" +
                "\t\t\tUPDATE CPQG SET \"D\" = \"D\" - 1 WHERE course_id = new.course_id AND sectionid = new.sectionid;\n" +
                "\t\tELSE \n" +
                "\t\t\tUPDATE CPQG SET \"other\" = \"other\" - 1 WHERE course_id = new.course_id AND sectionid = new.sectionid;\n" +
                "\t\tEND if;\n" +
                "\tELSIF new.grade in ('C-','C','C+') THEN\n" +
                "\t\tUPDATE CPQG SET \"C\" = \"C\" + 1 WHERE course_id = new.course_id AND sectionid = new.sectionid;\n" +
                "\t\t\n" +
                "\t\tIF old.grade in ('A-','A','A+') THEN\n" +
                "\t\t\tUPDATE CPQG SET \"A\" = \"A\" - 1 WHERE course_id = new.course_id AND sectionid = new.sectionid;\n" +
                "\t\tELSIF old.grade in ('B-','B','B+') THEN\n" +
                "\t\t\tUPDATE CPQG SET \"B\" = \"B\" - 1 WHERE course_id = new.course_id AND sectionid = new.sectionid;\n" +
                "\t\tELSIF old.grade in ('D-','D','D+') THEN\n" +
                "\t\t\tUPDATE CPQG SET \"D\" = \"D\" - 1 WHERE course_id = new.course_id AND sectionid = new.sectionid;\n" +
                "\t\tELSE \n" +
                "\t\t\tUPDATE CPQG SET \"other\" = \"other\" - 1 WHERE course_id = new.course_id AND sectionid = new.sectionid;\n" +
                "\t\tEND if;\n" +
                "\tELSIF new.grade in ('D-','D','D+') THEN\n" +
                "\t\tUPDATE CPQG SET \"D\" = \"D\" + 1 WHERE course_id = new.course_id AND sectionid = new.sectionid;\n" +
                "\t\t\n" +
                "\t\tIF old.grade in ('A-','A','A+') THEN\n" +
                "\t\t\tUPDATE CPQG SET \"A\" = \"A\" - 1 WHERE course_id = new.course_id AND sectionid = new.sectionid;\n" +
                "\t\tELSIF old.grade in ('B-','B','B+') THEN\n" +
                "\t\t\tUPDATE CPQG SET \"B\" = \"B\" - 1 WHERE course_id = new.course_id AND sectionid = new.sectionid;\n" +
                "\t\tELSIF old.grade in ('C-','C','C+') THEN\n" +
                "\t\t\tUPDATE CPQG SET \"C\" = \"C\" - 1 WHERE course_id = new.course_id AND sectionid = new.sectionid;\n" +
                "\t\tELSE \n" +
                "\t\t\tUPDATE CPQG SET \"other\" = \"other\" - 1 WHERE course_id = new.course_id AND sectionid = new.sectionid;\n" +
                "\t\tEND if;\n" +
                "\tELSE \n" +
                "\t\tUPDATE CPQG SET \"other\" = \"other\" + 1 WHERE course_id = new.course_id AND sectionid = new.sectionid;\n" +
                "\t\tIF old.grade in ('A-','A','A+') THEN\n" +
                "\t\t\tUPDATE CPQG SET \"A\" = \"A\" - 1 WHERE course_id = new.course_id AND sectionid = new.sectionid;\n" +
                "\t\tELSIF old.grade in ('B-','B','B+') THEN\n" +
                "\t\t\tUPDATE CPQG SET \"B\" = \"B\" - 1 WHERE course_id = new.course_id AND sectionid = new.sectionid;\n" +
                "\t\tELSIF old.grade in ('C-','C','C+') THEN\n" +
                "\t\t\tUPDATE CPQG SET \"C\" = \"C\" - 1 WHERE course_id = new.course_id AND sectionid = new.sectionid;\n" +
                "\t\tELSE \n" +
                "\t\t\tUPDATE CPQG SET \"D\" = \"D\" - 1 WHERE course_id = new.course_id AND sectionid = new.sectionid;\n" +
                "\t\tEND if;\n" +
                "\tEND if;\n" +
                "\t\n" +
                "END IF;\n" +
                "RETURN NEW;\n" +
                "END;\n" +
                "$cpqg_func$ LANGUAGE plpgsql;";
        st.execute(sql);
        sql = "CREATE TRIGGER cpqg_func AFTER INSERT OR UPDATE of grade ON past_course\n" +
                "FOR EACH ROW EXECUTE PROCEDURE cpqg();";
        st.execute(sql);
        sql = "select * from CPQG";
        ResultSet rs = st.executeQuery(sql);
        out.print("<h3> Generate table and triggers <h3>");
        out.print("<table>");
        out.println("<tr><th>Course ID</th><th>SectionId</th><th>Faculty_name</th>" +
                "<th>A</th>" +
                "<th>B</th>" +
                "<th>C</th>" +
                "<th>D</th>" +
                "<th>Other</th>" +
                "</tr>");
        while (rs.next()) {
            out.println("<tr>" +
                    "<th>" + rs.getString(1) + "</th>" +
                    "<th>" +rs.getString(4) + "</th>" +
                    "<th>" +rs.getString(5) + "</th>" +
                    "<th>" +rs.getString(6) + "</th>" +
                    "<th>" +rs.getString(7) + "</th>" +
                    "<th>" +rs.getString(8) + "</th>" +
                    "<th>" +rs.getString(9) + "</th>" +
                    "<th>" +rs.getString(10) + "</th>" +
                    "</tr>");
        }
        out.print("</table>");

        // CPG
        sql = "DROP TABLE IF EXISTS CPG;\n" +
                "Create table CPG as\n" +
                "select p.course_id,  s.faculty_name,\n" +
                "count (case when grade in ('A+','A','A-') then 1 ELSE Null end) as \"A\",\n" +
                "Count (case when grade in ('B+','B','B-') then 1 ELSE NUll end) as \"B\",\n" +
                "Count (Case when grade in ('C+', 'C', 'C-') then 1 ELSE NUll  end ) as \"C\",\n" +
                "Count (Case when grade in ('D+','D', 'D-') then 1 ELSE NUll end) as \"D\",\n" +
                "Count (Case When grade in ('F') Then 1 ELSE NUll end) as \"other\"\n" +
                "from past_course p left outer join section s\n" +
                "on p.course_id = s.courseid and p.sectionid = s.sectionid\n" +
                "group by p.course_id, s.faculty_name";
        st.execute(sql);

        sql = "DROP Function IF EXISTS CPG() CASCADE;" +
                "CREATE FUNCTION CPG() RETURNS trigger AS $CPG_func$\n" +
                "Declare\n" +
                "\tfaculty varchar = (select distinct faculty_name\n" +
                "\t\tfrom past_course p left outer join section s\n" +
                "\t\ton p.course_id = s.courseid and p.sectionid = s.sectionid\n" +
                "\t\twhere p.course_id = new.course_id and p.sectionid = new.sectionid);\n" +
                "BEGIN\n" +
                "IF (TG_OP = 'INSERT') THEN\n" +
                "\tIF new.grade in ('A-','A','A+') THEN\n" +
                "    \tUPDATE CPG SET \"A\" = \"A\" + 1 WHERE course_id = new.course_id AND faculty_name = faculty;\n" +
                "\tELSIF new.grade in ('B-','B','B+') THEN\n" +
                "\t\tUPDATE CPG SET \"B\" = \"B\" + 1 WHERE course_id = new.course_id AND faculty_name = faculty;\n" +
                "\tELSIF new.grade in ('C-','C','C+') THEN\n" +
                "\t\tUPDATE CPG SET \"C\" = \"C\" + 1 WHERE course_id = new.course_id AND faculty_name = faculty;\n" +
                "\tELSIF new.grade in ('D-','D','D+') THEN\n" +
                "\t\tUPDATE CPG SET \"D\" = \"D\" + 1 WHERE course_id = new.course_id AND faculty_name = faculty;\n" +
                "\tELSE \n" +
                "\t\tUPDATE CPG SET \"other\" = \"other\" + 1 WHERE course_id = new.course_id AND faculty_name =faculty;\n" +
                "\tEND if;\n" +
                "END IF;\n" +
                "IF (TG_OP = 'UPDATE') THEN\n" +
                "\tIF new.grade in ('A-','A','A+') THEN\n" +
                "    \tUPDATE CPG SET \"A\" = \"A\" + 1 WHERE course_id = new.course_id AND faculty_name = faculty;\n" +
                "\t\tIF old.grade in ('B-','B','B+') THEN\n" +
                "\t\t\tUPDATE CPG SET \"B\" = \"B\" - 1 WHERE course_id = new.course_id AND faculty_name =faculty;\n" +
                "\t\tELSIF old.grade in ('C-','C','C+') THEN\n" +
                "\t\t\tUPDATE CPG SET \"C\" = \"C\" - 1 WHERE course_id = new.course_id AND faculty_name = faculty;\n" +
                "\t\tELSIF old.grade in ('D-','D','D+') THEN\n" +
                "\t\t\tUPDATE CPG SET \"D\" = \"D\" - 1 WHERE course_id = new.course_id AND faculty_name = faculty;\n" +
                "\t\tELSE \n" +
                "\t\t\tUPDATE CPG SET \"other\" = \"other\" - 1 WHERE course_id = new.course_id AND faculty_name =faculty;\n" +
                "\t\tEnd if;\n" +
                "\tELSIF new.grade in ('B-','B','B+') THEN\n" +
                "\t\tUPDATE CPG SET \"B\" = \"B\" + 1 WHERE course_id = new.course_id AND faculty_name = faculty;\n" +
                "\t\tIF old.grade in ('A-','A','A+') THEN\n" +
                "\t\t\tUPDATE CPG SET \"A\" = \"A\" - 1 WHERE course_id = new.course_id AND faculty_name = faculty;\n" +
                "\t\tELSIF old.grade in ('C-','C','C+') THEN\n" +
                "\t\t\tUPDATE CPG SET \"C\" = \"C\" - 1 WHERE course_id = new.course_id AND faculty_name = faculty;\n" +
                "\t\tELSIF old.grade in ('D-','D','D+') THEN\n" +
                "\t\t\tUPDATE CPG SET \"D\" = \"D\" - 1 WHERE course_id = new.course_id AND faculty_name = faculty;\n" +
                "\t\tELSE \n" +
                "\t\t\tUPDATE CPG SET \"other\" = \"other\" - 1 WHERE course_id = new.course_id AND faculty_name = faculty;\n" +
                "\t\tEnd if;\n" +
                "\tELSIF new.grade in ('C-','C','C+') THEN\n" +
                "\t\tUPDATE CPG SET \"C\" = \"C\" + 1 WHERE course_id = new.course_id AND faculty_name = faculty;\n" +
                "\t\tIF old.grade in ('A-','A','A+') THEN\n" +
                "\t\t\tUPDATE CPG SET \"A\" = \"A\" - 1 WHERE course_id = new.course_id AND faculty_name = faculty;\n" +
                "\t\tELSIF old.grade in ('B-','B','B+') THEN\n" +
                "\t\t\tUPDATE CPG SET \"B\" = \"B\" - 1 WHERE course_id = new.course_id AND faculty_name = faculty;\n" +
                "\t\tELSIF old.grade in ('D-','D','D+') THEN\n" +
                "\t\t\tUPDATE CPG SET \"D\" = \"D\" - 1 WHERE course_id = new.course_id AND faculty_name = faculty;\n" +
                "\t\tELSE \n" +
                "\t\t\tUPDATE CPG SET \"other\" = \"other\" - 1 WHERE course_id = new.course_id AND faculty_name = faculty;\n" +
                "\t\tEnd if;\n" +
                "\t\t\n" +
                "\tELSIF new.grade in ('D-','D','D+') THEN\n" +
                "\t\tUPDATE CPG SET \"D\" = \"D\" + 1 WHERE course_id = new.course_id AND faculty_name = faculty;\n" +
                "\t\tIF old.grade in ('A-','A','A+') THEN\n" +
                "\t\t\tUPDATE CPG SET \"A\" = \"A\" - 1 WHERE course_id = new.course_id AND faculty_name = new.faculty;\n" +
                "\t\tELSIF old.grade in ('B-','B','B+') THEN\n" +
                "\t\t\tUPDATE CPG SET \"B\" = \"B\" - 1 WHERE course_id = new.course_id AND faculty_name = new.faculty;\n" +
                "\t\tELSIF old.grade in ('C-','C','C+') THEN\n" +
                "\t\t\tUPDATE CPG SET \"C\" = \"C\" - 1 WHERE course_id = new.course_id AND faculty_name = new.faculty;\n" +
                "\t\tELSE \n" +
                "\t\t\tUPDATE CPG SET \"other\" = \"other\" - 1 WHERE course_id = new.course_id AND faculty_name = new.faculty;\n" +
                "\t\tEnd if;\n" +
                "\tELSE \n" +
                "\t\tUPDATE CPG SET \"other\" = \"other\" + 1 WHERE course_id = new.course_id AND faculty_name =faculty;\n" +
                "\t\tIF old.grade in ('A-','A','A+') THEN\n" +
                "\t\t\tUPDATE CPG SET \"A\" = \"A\" - 1 WHERE course_id = new.course_id AND faculty_name = faculty;\n" +
                "\t\tELSIF old.grade in ('B-','B','B+') THEN\n" +
                "\t\t\tUPDATE CPG SET \"B\" = \"B\" - 1 WHERE course_id = new.course_id AND faculty_name = faculty;\n" +
                "\t\tELSIF old.grade in ('C-','C','C+') THEN\n" +
                "\t\t\tUPDATE CPG SET \"C\" = \"C\" - 1 WHERE course_id = new.course_id AND faculty_name = faculty;\n" +
                "\t\tELSE \n" +
                "\t\t\tUPDATE CPG SET \"D\" = \"D\" - 1 WHERE course_id = new.course_id AND faculty_name = faculty;\n" +
                "\t\tEnd if;\n" +
                "\tEND if;\n" +
                "END IF;\n" +
                "RETURN NEW;\n" +
                "END;\n" +
                "$CPG_func$ LANGUAGE plpgsql;";
        st.execute(sql);
        sql = "CREATE TRIGGER CPG_func AFTER INSERT OR UPDATE of grade ON past_course\n" +
                "FOR EACH ROW EXECUTE PROCEDURE CPG();";
        st.execute(sql);
        sql = "select * from CPG";
        rs = st.executeQuery(sql);
        out.print("<h3> Generate table and triggers <h3>");
        out.print("<table>");
        out.println("<tr><th>Course ID</th><th>Faculty_name</th>" +
                "<th>A</th>" +
                "<th>B</th>" +
                "<th>C</th>" +
                "<th>D</th>" +
                "<th>Other</th>" +
                "</tr>");
        while (rs.next()) {
            out.println("<tr>" +
                    "<th>" + rs.getString(1) + "</th>" +
                    "<th>" +rs.getString(2) + "</th>" +
                    "<th>" +rs.getString(3) + "</th>" +
                    "<th>" +rs.getString(4) + "</th>" +
                    "<th>" +rs.getString(5) + "</th>" +
                    "<th>" +rs.getString(6) + "</th>" +
                    "<th>" +rs.getString(7) + "</th>" +
                    "</tr>");
        }
        out.print("</table>");

    } catch (Exception e) {
       out.println("<h3>" + e.toString() + "</h3>");
    }
%>
<h3>Generate necessary sql. Let's starting test</h3>
<form method="post" action="Profs_Grades_Quater.jsp">
    <input type="submit" value="Starting test">
</form>
</body>
</html>
