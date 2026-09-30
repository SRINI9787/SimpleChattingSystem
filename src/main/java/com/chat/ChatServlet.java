package com.chat;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/chat")
public class ChatServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType(
                "text/plain;charset=UTF-8"
        );

        HttpSession session =
                request.getSession(false);

        if (session == null ||
                session.getAttribute("username") == null) {

            response.getWriter().print(
                    "Please login first"
            );

            return;
        }

        String sender =
                (String) session.getAttribute("username");

        String receiver =
                request.getParameter("receiver");

        String message =
                request.getParameter("message");

        if (receiver == null ||
                receiver.trim().isEmpty()) {

            response.getWriter().print(
                    "Receiver is required"
            );

            return;
        }

        if (message == null ||
                message.trim().isEmpty()) {

            response.getWriter().print(
                    "Message cannot be empty"
            );

            return;
        }

        String sql =
                "INSERT INTO messages " +
                "(sender, receiver, message) " +
                "VALUES (?, ?, ?)";

        try (Connection con =
                     DBConnection.getConnection()) {

            if (con == null) {

                response.getWriter().print(
                        "Database connection failed"
                );

                return;
            }

            try (PreparedStatement ps =
                         con.prepareStatement(sql)) {

                ps.setString(
                        1,
                        sender
                );

                ps.setString(
                        2,
                        receiver.trim()
                );

                ps.setString(
                        3,
                        message.trim()
                );

                ps.executeUpdate();

                response.getWriter().print("success");
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.getWriter().print(
                    "Database error"
            );
        }
    }


    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType(
                "application/json;charset=UTF-8"
        );

        PrintWriter out =
                response.getWriter();

        HttpSession session =
                request.getSession(false);

        if (session == null ||
                session.getAttribute("username") == null) {

            out.print("[]");

            return;
        }

        String currentUser =
                (String) session.getAttribute(
                        "username"
                );

        String receiver =
                request.getParameter("receiver");

        if (receiver == null ||
                receiver.trim().isEmpty()) {

            out.print("[]");

            return;
        }

        receiver = receiver.trim();

        String sql =
                "SELECT sender, receiver, message, " +
                "DATE_FORMAT(message_time, " +
                "'%h:%i %p') AS time " +
                "FROM messages " +
                "WHERE (sender = ? AND receiver = ?) " +
                "OR (sender = ? AND receiver = ?) " +
                "ORDER BY message_time ASC";

        try (Connection con =
                     DBConnection.getConnection()) {

            if (con == null) {

                out.print("[]");

                return;
            }

            try (PreparedStatement ps =
                         con.prepareStatement(sql)) {

                ps.setString(1, currentUser);
                ps.setString(2, receiver);
                ps.setString(3, receiver);
                ps.setString(4, currentUser);

                try (ResultSet rs =
                             ps.executeQuery()) {

                    StringBuilder json =
                            new StringBuilder();

                    json.append("[");

                    boolean first = true;

                    while (rs.next()) {

                        if (!first) {
                            json.append(",");
                        }

                        first = false;

                        json.append("{");

                        json.append(
                                "\"sender\":\""
                        );

                        json.append(
                                escapeJson(
                                        rs.getString(
                                                "sender"
                                        )
                                )
                        );

                        json.append("\",");

                        json.append(
                                "\"receiver\":\""
                        );

                        json.append(
                                escapeJson(
                                        rs.getString(
                                                "receiver"
                                        )
                                )
                        );

                        json.append("\",");

                        json.append(
                                "\"message\":\""
                        );

                        json.append(
                                escapeJson(
                                        rs.getString(
                                                "message"
                                        )
                                )
                        );

                        json.append("\",");

                        json.append(
                                "\"time\":\""
                        );

                        json.append(
                                escapeJson(
                                        rs.getString(
                                                "time"
                                        )
                                )
                        );

                        json.append("\"");

                        json.append("}");
                    }

                    json.append("]");

                    out.print(
                            json.toString()
                    );
                }
            }

        } catch (Exception e) {

            e.printStackTrace();

            out.print("[]");
        }
    }


    private String escapeJson(String value) {

        if (value == null) {
            return "";
        }

        return value
                .replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\n", "\\n")
                .replace("\r", "\\r")
                .replace("\t", "\\t");
    }
}