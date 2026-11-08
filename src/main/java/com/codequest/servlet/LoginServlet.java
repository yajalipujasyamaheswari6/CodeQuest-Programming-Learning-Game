
package com.codequest.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.annotation.WebInitParam;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.codequest.util.DBConnection;

@WebServlet(
	    urlPatterns = "/LoginServlet",
	    initParams = {
	        @WebInitParam(name = "appName", value = "CodeQuest")
	    }
	)
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException 
    {
    	String appName = getServletConfig().getInitParameter("appName");
    	System.out.println("Application Name: " + appName);
    	
    	String contextAppName =
    	        getServletContext().getInitParameter("appName");

    	System.out.println("ServletContext Name: " + contextAppName);
    	
    	
        String usernameOrEmail = request.getParameter("usernameOrEmail");
        String password = request.getParameter("password");

        try {
            Connection con = DBConnection.getConnection();

            String sql = "SELECT id, username, password FROM users WHERE username=? OR email=?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, usernameOrEmail);
            ps.setString(2, usernameOrEmail);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                String dbPassword = rs.getString("password");

                if (password.equals(dbPassword)) {

                    HttpSession session = request.getSession();

                    session.setAttribute("userId", rs.getInt("id"));
                    session.setAttribute("username", rs.getString("username"));

                    // Create login timestamp cookie
                    Cookie loginCookie = new Cookie(
                            "cqLastLogin",
                            String.valueOf(System.currentTimeMillis()));

                    loginCookie.setMaxAge(7 * 24 * 60 * 60);
                    loginCookie.setHttpOnly(true);
                    loginCookie.setPath(request.getContextPath());

                    response.addCookie(loginCookie);

                    response.sendRedirect("index.jsp");

                } else {
                    request.setAttribute("errorMessage", "Incorrect password!");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                }

            } else {
                request.setAttribute("errorMessage", "Account not found!");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();

            request.setAttribute("errorMessage", "Login failed. Please try again.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
