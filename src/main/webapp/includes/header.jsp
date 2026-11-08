<%
    Integer userId = (Integer) session.getAttribute("userId");
    Integer adminId = (Integer) session.getAttribute("adminId");
%>

<header>
    <nav class="container">

        <div class="logo">
            <h1>CodeQuest</h1>
        </div>

        <div class="nav-links">
            <a href="index.jsp">Home</a>
            <a href="index.jsp#about">About</a>
            <a href="index.jsp#how-it-works">How it Works</a>

           <% if (userId != null) { %>
    <a href="StudentDashboardServlet">Dashboard</a>
    <a href="MissionsServlet">Programming Missions</a>
    <a href="LeaderboardServlet">Leaderboard</a>
<% } %>

            <% if (adminId != null) { %>
                <a href="admin-dashboard.jsp">Admin Dashboard</a>
                <a href="ManageMissionsServlet">Manage Missions</a>
            <% } %>
        </div>

        <div class="auth-buttons">

            <% if (userId != null || adminId != null) { %>

                <a href="LogoutServlet" class="logout-btn">
                    Logout
                </a>

            <% } else { %>

                <a href="login.jsp" class="login-btn">
                    Login
                </a>

                <a href="register.jsp" class="register-btn">
                    Register
                </a>

                <a href="admin-login.jsp" class="admin-login-btn">
                    Admin Login
                </a>

            <% } %>

        </div>

    </nav>
</header>