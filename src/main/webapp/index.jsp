
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CodeQuest – Programming Learning Game</title>
    <link rel="stylesheet" href="css/style.css">
</head>

<body>

    <%@ include file="includes/header.jsp" %>

    <main class="main-content-container">

        <!-- Hero Section -->
        <section class="hero">

            <div class="hero-content">

                <h1 class="hero-title">
                    Level Up Your Coding Skills with CodeQuest
                </h1>

                <p class="hero-description">
                    Learn programming through exciting challenges,
                    complete missions, earn XP and become a coding champion!
                </p>

                <% if (session.getAttribute("userId") != null) { %>
    <a href="MissionsServlet" class="primary-btn">Start Learning</a>
<% } else { %>
    <a href="login.jsp" class="primary-btn">Start Learning</a>
<% } %>

                <a href="#features" class="secondary-btn">
                    Explore Features
                </a>

            </div>

        </section>


        <!-- About Section -->
        <section class="about" id="about">

            <h2>About CodeQuest</h2>

            <p>
                CodeQuest is a programming learning platform that makes
                learning fun through game-based challenges and interactive
                coding missions.
            </p>

        </section>


        <!-- How It Works Section -->
        <section class="how-it-works" id="how-it-works">

            <h2>How It Works</h2>

            <div class="steps-container">

                <div class="step-card">
                    <h3>1. Register</h3>
                    <p>Create your account and start your coding journey.</p>
                </div>

                <div class="step-card">
                    <h3>2. Solve Missions</h3>
                    <p>Complete programming questions and challenges.</p>
                </div>

                <div class="step-card">
                    <h3>3. Earn XP</h3>
                    <p>Earn experience points and unlock new levels.</p>
                </div>

            </div>

        </section>


        <!-- Features Section -->
        <section class="features" id="features">

            <h2>Explore Our Features</h2>

            <div class="features-container">

                <div class="feature-card">
                    <h3>XP System</h3>
                    <p>Earn XP for every successful challenge.</p>
                </div>

                <div class="feature-card">
                    <h3>Levels</h3>
                    <p>Progress through different coding levels.</p>
                </div>

                <div class="feature-card">
                    <h3>Coding Challenges</h3>
                    <p>Improve your programming skills through missions.</p>
                </div>

                <div class="feature-card">
                    <h3>Leaderboard</h3>
                    <p>Compare your XP and rankings with other students.</p>
                </div>

            </div>

        </section>

    </main>

    <%@ include file="includes/footer.jsp" %>

</body>
</html>
