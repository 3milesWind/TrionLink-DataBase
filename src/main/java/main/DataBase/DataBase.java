package main.DataBase;
import  java.sql.*;
class DataBase{
    final static String url = "jdbc:postgresql://localhost:5432/postgres?user=postgres&password=4645";
    public Connection conn;
    public void connect(){
        try {
            Class.forName("org.postgresql.Driver");
            this.conn = DriverManager.getConnection(url);
        } catch (Exception e) {
            System.out.println(e);
        }
    }
    public void disconnect() {
        try{
            if(this.conn != null) this.conn.close();
        }catch (Exception e) {
            System.out.println(e);
        }
    }
    public static void main (String args[]) throws SQLException {

        DataBase DB = new DataBase();
        DB.connect();
        Statement st = DB.conn.createStatement();
        ResultSet result = null;
        result = st.executeQuery("select * from Student");
        if ( result.next() ) {
            System.out.println(result.getString("SSN"));
        }
        DB.disconnect();
    }
}
