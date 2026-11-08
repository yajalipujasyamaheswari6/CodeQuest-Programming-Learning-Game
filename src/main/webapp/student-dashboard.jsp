
<%@ page import="java.lang.Integer" %>

<%
    if (session.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String username = (String) request.getAttribute("username");

    Integer totalXp = (Integer) request.getAttribute("totalXp");
    Integer level = (Integer) request.getAttribute("level");
    Integer progress = (Integer) request.getAttribute("progress");
    Integer completedMissions =
        (Integer) request.getAttribute("completedMissions");

    String errorMessage =
        (String) request.getAttribute("errorMessage");

    int progressPercent = progress == null ? 0 : progress * 100 / 500;
%>

<!DOCTYPE html>
<html>

<head>
    <title>Student Dashboard - CodeQuest</title>
    <link rel="stylesheet" href="css/style.css">
</head>

<body>

<%@ include file="includes/header.jsp" %>

<div class="student-dashboard">

    <h1>Welcome, <%= username == null ? "Student" : username %>!</h1>

    <p>Your programming journey starts here.</p>

    <% if (errorMessage != null) { %>

        <p><%= errorMessage %></p>

    <% } else if (totalXp != null && level != null) { %>

        <div class="dashboard-cards">

            <div class="dashboard-card">
                <h3>Total XP</h3>
                <h2><%= totalXp %> XP</h2>
            </div>

            <div class="dashboard-card">
                <h3>Player Level</h3>
                <h2>Level <%= level %></h2>
            </div>

            <div class="dashboard-card">
                <h3>Completed Missions</h3>
                <h2><%= completedMissions == null ? 0 : completedMissions %></h2>
            </div>

        </div>

        <div class="xp-progress">

            <h3>Next Level Progress</h3>

            <p><%= progress %> / 500 XP</p>

            <div class="progress-bar">
                <div class="progress-fill"
                     style="width: <%= progressPercent %>%;">
                </div>
            </div>

        </div>

    <% } %>

    <div class="dashboard-links">

        <a href="MissionsServlet" class="admin-btn">
            Programming Missions
        </a>

        <a href="LeaderboardServlet" class="admin-btn">
            View Leaderboard
        </a>

    </div>

</div>

<%@ include file="includes/footer.jsp" %>

</body>
</html>
