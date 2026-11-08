<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
if (session.getAttribute("adminId") == null) {
    response.sendRedirect("admin-login.jsp");
    return;
}

String error = (String) request.getAttribute("errorMessage");
String success = (String) request.getAttribute("successMessage");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Mission | CodeQuest</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<jsp:include page="includes/header.jsp" />

<div class="admin-container form-container">

    <div class="admin-navigation">
        <a href="admin-dashboard.jsp" class="admin-btn">
            Dashboard
        </a>

        <a href="ManageMissionsServlet" class="admin-btn">
            Manage Missions
        </a>
    </div>

    <h2>Add Programming Mission</h2>

    <% if (error != null) { %>
        <div class="alert-box alert-error"><%= error %></div>
    <% } %>

    <% if (success != null) { %>
        <div class="alert-box alert-success"><%= success %></div>
    <% } %>

    <form action="AddMissionServlet" method="post">

        <div class="form-group">
            <label>Mission Title</label>
            <input type="text" name="title" required>
        </div>

        <div class="form-group">
            <label>Description / Question</label>
            <textarea name="description" rows="4" required></textarea>
        </div>

        <div class="form-group">
            <label>Category</label>
            <select name="category" required>
                <option value="">Select Category</option>
                <option value="Java">Java</option>
                <option value="SQL">SQL</option>
                <option value="DSA">DSA</option>
            </select>
        </div>

        <div class="form-group">
            <label>Difficulty</label>
            <select name="difficulty" required>
                <option value="">Select Difficulty</option>
                <option value="Easy">Easy</option>
                <option value="Medium">Medium</option>
                <option value="Hard">Hard</option>
            </select>
        </div>

        <div class="form-group">
            <label>Option A</label>
            <input type="text" name="optionA" required>
        </div>

        <div class="form-group">
            <label>Option B</label>
            <input type="text" name="optionB" required>
        </div>

        <div class="form-group">
            <label>Option C</label>
            <input type="text" name="optionC" required>
        </div>

        <div class="form-group">
            <label>Option D</label>
            <input type="text" name="optionD" required>
        </div>

        <div class="form-group">
            <label>Correct Answer</label>
            <input type="text" name="correctAnswer"
                placeholder="Enter the exact correct option text" required>
        </div>

        <div class="form-group">
            <label>XP Reward</label>
            <input type="number" name="xpReward"
                value="50" min="1" required>
        </div>

        <button type="submit" class="register-btn">
            Add Mission
        </button>

    </form>

</div>

<jsp:include page="includes/footer.jsp" />

</body>
</html>