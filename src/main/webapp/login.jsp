
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Student Login | CodeQuest</title>
<link rel="stylesheet" href="css/style.css">
</head>

<body>

<jsp:include page="includes/header.jsp" />

<div class="registration-container">

    <h2>Welcome Back to CodeQuest</h2>

    <% 
    String error = (String) request.getAttribute("errorMessage");
    String success = (String) request.getAttribute("successMessage");

    if (error != null) {
    %>
        <div class="alert-box error"><%= error %></div>
    <% } %>

    <% if (success != null) { %>
        <div class="alert-box success"><%= success %></div>
    <% } %>

    <form action="LoginServlet" method="post">

        <div class="form-group">
            <label>Username or Email</label>
            <input type="text" name="usernameOrEmail"
                   placeholder="Enter username or email" required>
        </div>

        <div class="form-group">
            <label>Password</label>
            <input type="password" name="password"
                   placeholder="Enter password" required>
        </div>

        <button type="submit" class="register-btn">Login</button>

    </form>

    <p>Don't have an account?
        <a href="register.jsp">Register</a>
    </p>

</div>

<jsp:include page="includes/footer.jsp" />

</body>
</html>
