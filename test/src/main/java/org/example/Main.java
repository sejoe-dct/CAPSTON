package org.example;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import java.sql.*;

public class Main {
        public static void main(String[] args) {
            Connection con = null;

            String server = " root@localhost ";
            String database = " cap ";
            String user_name = " root ";
            String password = " tkddms1101 ";

            try {
                Class.forName("org.mariadb.jdbc.Driver");
            } catch (ClassNotFoundException e) {
                System.err.println(" Driver Loading Error : " + e.getMessage());
                e.printStackTrace();
            }

            try {
                con = DriverManager.getConnection("jdbc:mysql://" +
                        server + "/" +
                        database +
                        "?useSSL=false", user_name, password);
                System.out.println("Connect Success");
            } catch (SQLException e) {
                System.err.println("Error Message :" + e.getMessage());
                e.printStackTrace();
            }

            try {
                if (con != null)
                    con.close();
            } catch (SQLException e) {
            }
        }

}

