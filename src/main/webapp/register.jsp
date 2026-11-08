
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="includes/header.jsp" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CodeQuest - Student Registration</title>
    <link rel="stylesheet" href="css/style.css">
</head>

<body>

    <div class="registration-container">

        <h1>Create Your CodeQuest Account</h1>

        <form action="RegisterServlet" method="POST">

            <div class="form-group">
                <label for="username">Username</label>
                <input type="text" id="username"
                    name="username" required>
            </div>

            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email"
                    name="email" required>
            </div>

            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password"
                    name="password" required>
            </div>

            <div class="form-group">
                <label for="confirmPassword">Confirm Password</label>
                <input type="password" id="confirmPassword"
                    name="confirmPassword" required>
            </div>

            <button type="submit" class="register-btn">
                Register
            </button>

        </form>

        <%
            String errorMsg = (String) request.getAttribute("errorMessage");
            String successMsg = (String) request.getAttribute("successMessage");
        %>

        <% if (errorMsg != null) { %>
            <div class="alert-box alert-error">
                <%= errorMsg %>
            </div>
        <% } %>

        <% if (successMsg != null) { %>
            <div class="alert-box alert-success">
                <%= successMsg %>
            </div>
        <% } %>

        <p class="login-link">
            Already have an account?
            <a href="login.jsp">Login</a>
        </p>

    </div>
  <%@ include file="includes/footer.jsp" %>
</body>
</html>
