
package com.codequest.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.codequest.util.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/LeaderboardServlet")
public class LeaderboardServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        List<Map<String, Object>> leaderboard = new ArrayList<>();

        try {
            Connection con = DBConnection.getConnection();

            String sql = "SELECT u.username, u.total_xp, u.player_level, "
                       + "COUNT(CASE WHEN ms.is_correct = TRUE "
                       + "THEN ms.id END) AS completed_missions "
                       + "FROM users u "
                       + "LEFT JOIN mission_submissions ms "
                       + "ON u.id = ms.user_id "
                       + "GROUP BY u.id, u.username, u.total_xp, u.player_level "
                       + "ORDER BY u.total_xp DESC";

            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            int rank = 1;

            while (rs.next()) {
                Map<String, Object> student = new HashMap<>();

                student.put("rank", rank++);
                student.put("username", rs.getString("username"));
                student.put("totalXp", rs.getInt("total_xp"));
                student.put("playerLevel", rs.getInt("player_level"));
                student.put("completedMissions",
                        rs.getInt("completed_missions"));

                leaderboard.add(student);
            }

            rs.close();
            ps.close();
            con.close();

            request.setAttribute("leaderboard", leaderboard);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage",
                    "Unable to load leaderboard.");
        }

        request.getRequestDispatcher("leaderboard.jsp")
               .forward(request, response);
    }
}
