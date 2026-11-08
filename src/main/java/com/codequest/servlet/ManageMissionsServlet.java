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

@WebServlet("/ManageMissionsServlet")
public class ManageMissionsServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("adminId") == null) {
            response.sendRedirect("admin-login.jsp");
            return;
        }

        List<Map<String, Object>> missions = new ArrayList<>();

        try {
            Connection con = DBConnection.getConnection();

            String sql = "SELECT * FROM missions ORDER BY id DESC";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Map<String, Object> mission = new HashMap<>();

                mission.put("id", rs.getInt("id"));
                mission.put("title", rs.getString("title"));
                mission.put("category", rs.getString("category"));
                mission.put("difficulty", rs.getString("difficulty"));
                mission.put("correctAnswer", rs.getString("correct_answer"));
                mission.put("xpReward", rs.getInt("xp_reward"));

                missions.add(mission);
            }

            rs.close();
            ps.close();
            con.close();

            request.setAttribute("missions", missions);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Unable to load missions.");
        }

        request.getRequestDispatcher("manage-missions.jsp")
               .forward(request, response);
    }
}