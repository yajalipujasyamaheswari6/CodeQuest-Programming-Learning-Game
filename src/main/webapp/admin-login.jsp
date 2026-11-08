
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Login | CodeQuest</title>
<link rel="stylesheet" href="css/style.css">
</head>
<body>

<jsp:include page="includes/header.jsp" />

<div class="registration-container admin-login-container">

    <h2>Admin Login</h2>

    <%
    String error = (String) request.getAttribute("errorMessage");
    if (error != null) {
    %>
        <div class="alert-box error"><%= error %></div>
    <% } %>

    <form action="AdminLoginServlet" method="post">

        <div class="form-group">
            <label>Admin Username</label>
            <input type="text" name="username"
                   placeholder="Enter admin username" required>
        </div>

        <div class="form-group">
            <label>Password</label>
            <input type="password" name="password"
                   placeholder="Enter password" required>
        </div>

        <button type="submit" class="register-btn">Login</button>

    </form>

</div>

<jsp:include page="includes/footer.jsp" />

</body>
</html>
