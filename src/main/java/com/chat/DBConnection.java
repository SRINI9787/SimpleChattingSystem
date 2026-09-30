package com.chat;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static final String URL =
            "jdbc:mysql://db01.dbhost.dev:5051/db_454qbpdfp"
            + "?useSSL=false"
            + "&serverTimezone=Asia/Kolkata"
            + "&allowPublicKeyRetrieval=true";

    private static final String USER =
            "user_454qbpdfp";

    private static final String PASSWORD =
            "YOUR_BYTEXL_PASSWORD";

    public static Connection getConnection() {

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");

            return DriverManager.getConnection(
                    URL,
                    USER,
                    PASSWORD
            );

        } catch (ClassNotFoundException e) {

            System.out.println(
                    "MySQL JDBC Driver not found."
            );

            e.printStackTrace();

        } catch (SQLException e) {

            System.out.println(
                    "Database connection failed."
            );

            e.printStackTrace();
        }

        return null;
    }
}