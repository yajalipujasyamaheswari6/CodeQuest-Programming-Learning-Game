
package com.codequest.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.codequest.util.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/StudentDashboardServlet")
public class StudentDashboardServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = (Integer) session.getAttribute("userId");

        try {
            Connection con = DBConnection.getConnection();

            String sql = "SELECT u.username, u.total_xp, u.player_level, "
                       + "(SELECT COUNT(*) FROM mission_submissions ms "
                       + "WHERE ms.user_id = u.id AND ms.is_correct = TRUE) "
                       + "AS completed_missions "
                       + "FROM users u WHERE u.id=?";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                int totalXp = rs.getInt("total_xp");
                int level = rs.getInt("player_level");
                int completedMissions = rs.getInt("completed_missions");

                request.setAttribute("username",
                        rs.getString("username"));

                request.setAttribute("totalXp", totalXp);
                request.setAttribute("level", level);
                request.setAttribute("progress", totalXp % 500);
                request.setAttribute("completedMissions",
                        completedMissions);
            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage",
                    "Unable to load your dashboard.");
        }

        request.getRequestDispatcher("student-dashboard.jsp")
               .forward(request, response);
    }
}
