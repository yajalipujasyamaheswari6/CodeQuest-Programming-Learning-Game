
package com.codequest.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.codequest.util.DBConnection;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        if (username == null || email == null ||
                password == null || confirmPassword == null ||
                username.trim().isEmpty() || email.trim().isEmpty() ||
                password.isEmpty() || confirmPassword.isEmpty()) {

            request.setAttribute("errorMessage", "All fields are required.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        if (!password.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "Passwords do not match.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        if (password.length() < 8) {
            request.setAttribute("errorMessage", "Password must be at least 8 characters.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        try (Connection con = DBConnection.getConnection()) {

            if (con == null) {
                throw new SQLException("Database connection failed.");
            }

            String checkSql =
                    "SELECT id FROM users WHERE username = ? OR email = ?";

            try (PreparedStatement check = con.prepareStatement(checkSql)) {

                check.setString(1, username.trim());
                check.setString(2, email.trim());

                try (ResultSet rs = check.executeQuery()) {

                    if (rs.next()) {
                        request.setAttribute("errorMessage",
                                "Username or email already exists.");
                        request.getRequestDispatcher("register.jsp")
                                .forward(request, response);
                        return;
                    }
                }
            }

            String sql = "INSERT INTO users "
                    + "(username, email, password, total_xp, player_level) "
                    + "VALUES (?, ?, ?, 0, 1)";

            try (PreparedStatement ps = con.prepareStatement(sql)) {

                ps.setString(1, username.trim());
                ps.setString(2, email.trim());
                ps.setString(3, password);

                ps.executeUpdate();
            }

            request.setAttribute("successMessage",
                    "Registration successful! You can now login.");

        } catch (SQLException e) {

            e.printStackTrace();

            request.setAttribute("errorMessage",
                    "Registration failed: " + e.getMessage());
        }

        request.getRequestDispatcher("register.jsp").forward(request, response);
    }
}
