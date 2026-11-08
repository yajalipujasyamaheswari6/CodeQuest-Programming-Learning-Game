
package com.codequest.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.codequest.util.DBConnection;

@WebServlet("/AddMissionServlet")
public class AddMissionServlet extends HttpServlet {

	
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException
{

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("adminId") == null) {
            response.sendRedirect("admin-login.jsp");
            return;
        }

        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String category = request.getParameter("category");
        String difficulty = request.getParameter("difficulty");

        String optionA = request.getParameter("optionA");
        String optionB = request.getParameter("optionB");
        String optionC = request.getParameter("optionC");
        String optionD = request.getParameter("optionD");

        String correctAnswer = request.getParameter("correctAnswer");

        try {
            int xpReward = Integer.parseInt(request.getParameter("xpReward"));
            int adminId = (Integer) session.getAttribute("adminId");

            String sql = "INSERT INTO missions "
                    + "(title, description, category, difficulty, "
                    + "option_a, option_b, option_c, option_d, "
                    + "correct_answer, xp_reward, created_by) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

            try (Connection con = DBConnection.getConnection();
                 PreparedStatement ps = con.prepareStatement(sql)) {

                ps.setString(1, title);
                ps.setString(2, description);
                ps.setString(3, category);
                ps.setString(4, difficulty);
                ps.setString(5, optionA);
                ps.setString(6, optionB);
                ps.setString(7, optionC);
                ps.setString(8, optionD);
                ps.setString(9, correctAnswer);
                ps.setInt(10, xpReward);
                ps.setInt(11, adminId);

                ps.executeUpdate();
            }

            request.setAttribute("successMessage",
                    "Mission added successfully!");

        } catch (Exception e) {
            e.printStackTrace();

            request.setAttribute("errorMessage",
                    "Unable to add mission. Please check your details.");
        }

        request.getRequestDispatcher("add-mission.jsp")
               .forward(request, response);
    }
}
