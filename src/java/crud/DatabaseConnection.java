/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
/**
 *
 * @author Andika
 */
package crud;

import java.sql.*;

public class DatabaseConnection {
    private static final String DBDRIVER = "com.mysql.cj.jdbc.Driver";
    private static final String DBCONNECTION = "jdbc:mysql://localhost:3306/test";
    private static final String DBUSER = "root";
    private static final String DBPASS = "";
    
    public static Connection getConnection() throws ClassNotFoundException, SQLException {
        Class.forName(DBDRIVER);
        return DriverManager.getConnection(DBCONNECTION, DBUSER, DBPASS);
    }
    
    public static void closeConnection(Connection conn) {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    
    public static void closeStatement(Statement st) {
        if (st != null) {
            try {
                st.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    
    public static void closeResultSet(ResultSet rs) {
        if (rs != null) {
            try {
                rs.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
