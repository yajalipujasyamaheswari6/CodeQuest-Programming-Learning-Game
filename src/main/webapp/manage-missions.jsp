<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page import="java.util.List, java.util.Map" %>

<%
if (session.getAttribute("adminId") == null) {
    response.sendRedirect("admin-login.jsp");
    return;
}

List<Map<String, Object>> missions =
    (List<Map<String, Object>>) request.getAttribute("missions");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Missions | CodeQuest</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<jsp:include page="includes/header.jsp" />

<div class="admin-container manage-container">

    <div class="admin-navigation">
        <a href="admin-dashboard.jsp" class="admin-btn">
            Dashboard
        </a>

        <a href="add-mission.jsp" class="admin-btn">
            Add Mission
        </a>
    </div>

    <h2>Manage Programming Missions</h2>

    <% if ("delete".equals(request.getParameter("error"))) { %>
        <div class="alert-box alert-error">
            Unable to delete this mission. It may already have submissions.
        </div>
    <% } %>

    <% if (missions == null || missions.isEmpty()) { %>

        <div class="empty-message">
            <p>No missions available.</p>
            <a href="add-mission.jsp" class="admin-btn">
                Add Your First Mission
            </a>
        </div>

    <% } else { %>

        <div class="table-wrapper">
            <table class="mission-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Title</th>
                        <th>Category</th>
                        <th>Difficulty</th>
                        <th>Correct Answer</th>
                        <th>XP</th>
                        <th>Action</th>
                    </tr>
                </thead>

                <tbody>
                    <% for (Map<String, Object> m : missions) { %>
                    <tr>
                        <td><%= m.get("id") %></td>
                        <td><%= m.get("title") %></td>
                        <td><%= m.get("category") %></td>
                        <td><%= m.get("difficulty") %></td>
                        <td><%= m.get("correctAnswer") %></td>
                        <td><%= m.get("xpReward") %></td>

                        <td>
                            <form action="DeleteMissionServlet" method="post"
                                onsubmit="return confirm('Are you sure you want to delete this mission?');">

                                <input type="hidden" name="id"
                                    value="<%= m.get("id") %>">

                                <button type="submit" class="delete-btn">
                                    Delete
                                </button>
                            </form>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>

    <% } %>

</div>

<jsp:include page="includes/footer.jsp" />

</body>
</html>