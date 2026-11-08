<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>

<%
    if (session.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Map<String, Object>> leaderboard =
        (List<Map<String, Object>>) request.getAttribute("leaderboard");

    String errorMessage =
        (String) request.getAttribute("errorMessage");
%>

<!DOCTYPE html>
<html>

<head>
    <title>CodeQuest - Leaderboard</title>
    <link rel="stylesheet" href="css/style.css">
</head>

<body>

<%@ include file="includes/header.jsp" %>

<div class="leaderboard-container">

    <h1>CodeQuest Leaderboard</h1>

    <p>See how you rank against other students!</p>

    <% if (errorMessage != null) { %>

        <p><%= errorMessage %></p>

    <% } else if (leaderboard != null && !leaderboard.isEmpty()) { %>

        <div class="table-wrapper">

            <table class="mission-table">

                <tr>
                    <th>Rank</th>
                    <th>Student</th>
                    <th>Total XP</th>
                    <th>Level</th>
                    <th>Completed Missions</th>
                </tr>

                <% for (Map<String, Object> student : leaderboard) { %>

                <tr>

                   <td>
    <%
        int rank = (Integer) student.get("rank");

        if (rank == 1) {
    %>
        1st 
    <% } else if (rank == 2) { %>
        2nd
    <% } else if (rank == 3) { %>
        3rd
    <% } else { %>
        #<%= rank %>
    <% } %>
</td>

                    <td><%= student.get("username") %></td>

                    <td><%= student.get("totalXp") %> XP</td>

                    <td><%= student.get("playerLevel") %></td>

                    <td><%= student.get("completedMissions") %></td>

                </tr>

                <% } %>

            </table>

        </div>

    <% } else { %>

        <p>No players available yet. Be the first to join CodeQuest!</p>

    <% } %>

    <a href="index.jsp" class="admin-btn">Back to Home</a>

</div>

<%@ include file="includes/footer.jsp" %>

</body>
</html>
