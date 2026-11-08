<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
if (session.getAttribute("adminId") == null) {
    response.sendRedirect("admin-login.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard | CodeQuest</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<jsp:include page="includes/header.jsp" />

<div class="admin-container">

    <h2>Welcome, Admin!</h2>
    <p class="admin-description">
        Manage your CodeQuest programming learning game.
    </p>

    <div class="admin-actions">
        <a href="add-mission.jsp" class="admin-btn">
            Add Mission
        </a>

        <a href="ManageMissionsServlet" class="admin-btn">
            Manage Missions
        </a>

        <a href="AdminLogoutServlet" class="admin-btn logout-btn">
            Logout
        </a>
    </div>

</div>

<jsp:include page="includes/footer.jsp" />

</body>
</html>