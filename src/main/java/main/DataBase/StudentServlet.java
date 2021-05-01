package main.DataBase;
import  java.sql.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(urlPatterns = {"/Student_Entry_Response"})
public class StudentServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        DataBase db = new DataBase();
        db.connect();
        String FirstName = request.getParameter("First_Name");
        String MiddleName = request.getParameter("Middle_Name");
        String LastName = request.getParameter("Last_Name");
        String Student_ID = request.getParameter("Student_Id");
        String SSN = request.getParameter("SSN");
        String Residency = request.getParameter("Residency");
       String Enrollment = request.getParameter("Enrollment");
        String stu_data = "Insert INSERT into Student Values(?,?,?,?,?,?,?)";
        try {
            db.conn.setAutoCommit(false);
            PreparedStatement st = db.conn.prepareStatement(stu_data);
            st.setString(1, Student_ID);
            st.setString(2, SSN);
            st.setString(3,FirstName);
            st.setString(4,MiddleName);
            st.setString(5,LastName);
            st.setString(6,Residency);
            st.setString(7,Enrollment);
            int row = st.executeUpdate();
            System.out.println(row);
            db.conn.commit();
            db.conn.setAutoCommit(true);
            st.close();
        } catch (Exception e) {
            System.out.println(e);
        }

    }
}
