
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

@WebServlet("/SubmitMissionServlet")
public class SubmitMissionServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = (Integer) session.getAttribute("userId");
        String answer = request.getParameter("answer");
        String resultMessage;

        try {
            int missionId = Integer.parseInt(
                    request.getParameter("missionId"));

            if (answer == null || answer.trim().isEmpty()) {
                resultMessage = "Please select an answer.";

            } else {
                Connection con = DBConnection.getConnection();
                con.setAutoCommit(false);

                try {
                    // Check previous submission
                    String checkSql = "SELECT id FROM mission_submissions "
                            + "WHERE user_id=? AND mission_id=?";

                    PreparedStatement checkPs = con.prepareStatement(checkSql);
                    checkPs.setInt(1, userId);
                    checkPs.setInt(2, missionId);

                    ResultSet checkRs = checkPs.executeQuery();

                    if (checkRs.next()) {
                        resultMessage =
                                "You have already attempted this mission.";
                        con.rollback();

                    } else {
                        String missionSql =
                                "SELECT correct_answer, xp_reward "
                                + "FROM missions WHERE id=?";

                        PreparedStatement missionPs =
                                con.prepareStatement(missionSql);

                        missionPs.setInt(1, missionId);

                        ResultSet missionRs = missionPs.executeQuery();

                        if (!missionRs.next()) {
                            throw new Exception("Mission not found.");
                        }

                        String correctAnswer =
                                missionRs.getString("correct_answer");

                        int xp = missionRs.getInt("xp_reward");

                        boolean isCorrect =
                                answer.trim().equals(correctAnswer.trim());

                        missionRs.close();
                        missionPs.close();
                        checkRs.close();
                        checkPs.close();

                        // Save submission
                        String insertSql =
                                "INSERT INTO mission_submissions "
                                + "(user_id, mission_id, answer, is_correct) "
                                + "VALUES (?, ?, ?, ?)";

                        PreparedStatement insertPs =
                                con.prepareStatement(insertSql);

                        insertPs.setInt(1, userId);
                        insertPs.setInt(2, missionId);
                        insertPs.setString(3, answer);
                        insertPs.setBoolean(4, isCorrect);

                        insertPs.executeUpdate();
                        insertPs.close();

                        if (isCorrect) {

String updateSql = "UPDATE users SET total_xp = total_xp + ?, "
        + "player_level = FLOOR((total_xp + ?) / 500) + 1 "
        + "WHERE id=?";

PreparedStatement updatePs = con.prepareStatement(updateSql);

updatePs.setInt(1, xp);
updatePs.setInt(2, xp);
updatePs.setInt(3, userId);

updatePs.executeUpdate();
updatePs.close();


                            resultMessage =
                                    "Correct answer! You earned " + xp + " XP.";

                        } else {
                            resultMessage =
                                    "Incorrect answer! Better luck next time.";
                        }

                        con.commit();
                    }

                } catch (Exception e) {
                    con.rollback();
                    throw e;
                } finally {
                    con.setAutoCommit(true);
                    con.close();
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            resultMessage =
                    "Something went wrong while submitting your answer.";
        }

        session.setAttribute("resultMessage", resultMessage);
        response.sendRedirect("MissionsServlet");
    }
}
