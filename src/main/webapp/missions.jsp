<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<%@ page import="java.util.List, java.util.Map" %>

<%
    if (session.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Map<String, Object>> missions =
        (List<Map<String, Object>>) request.getAttribute("missions");

    String error = (String) request.getAttribute("errorMessage");
    String resultMessage =
        (String) request.getAttribute("resultMessage");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Programming Missions | CodeQuest</title>
    <link rel="stylesheet" href="css/style.css">
</head>

<body>

    <jsp:include page="includes/header.jsp" />

    <div class="student-missions-container">

        <h2>Programming Missions</h2>

        <p class="missions-description">
            Complete programming challenges and earn XP!
        </p>

        <% if (resultMessage != null) { %>
    <div class="mission-result
        <%= resultMessage.toLowerCase().contains("correct") 
            && !resultMessage.toLowerCase().contains("incorrect")
            ? "correct-message" : "wrong-message" %>">
        <%= resultMessage %>
    </div>
<% } %>

        <% if (error != null) { %>
            <div class="alert-box alert-error">
                <%= error %>
            </div>
        <% } %>

        <% if (missions == null || missions.isEmpty()) { %>

            <div class="empty-message">
                No missions are available right now.
                Please check again later.
            </div>

        <% } else { %>

            <div class="student-missions-grid">

                <% for (Map<String, Object> m : missions) { %>

                    <div class="student-mission-card">

                        <div class="mission-card-top">
                            <span><%= m.get("category") %></span>
                            <span><%= m.get("difficulty") %></span>
                            <span><%= m.get("xpReward") %> XP</span>
                        </div>

                        <h3><%= m.get("title") %></h3>

                        <p class="mission-question">
                            <%= m.get("description") %>
                        </p>

                        <form action="SubmitMissionServlet" method="post">

                            <input type="hidden" name="missionId"
                                value="<%= m.get("id") %>">

                            <div class="mission-options">

                                <label>
                                    <input type="radio" name="answer"
                                        value="<%= m.get("optionA") %>" required>
                                    <span>A. <%= m.get("optionA") %></span>
                                </label>

                                <label>
                                    <input type="radio" name="answer"
                                        value="<%= m.get("optionB") %>">
                                    <span>B. <%= m.get("optionB") %></span>
                                </label>

                                <label>
                                    <input type="radio" name="answer"
                                        value="<%= m.get("optionC") %>">
                                    <span>C. <%= m.get("optionC") %></span>
                                </label>

                                <label>
                                    <input type="radio" name="answer"
                                        value="<%= m.get("optionD") %>">
                                    <span>D. <%= m.get("optionD") %></span>
                                </label>

                            </div>

                            <button type="submit" class="submit-mission-btn">
                                Submit Answer
                            </button>

                        </form>

                    </div>

                <% } %>

            </div>

        <% } %>

    </div>

    <jsp:include page="includes/footer.jsp" />

</body>
</html>