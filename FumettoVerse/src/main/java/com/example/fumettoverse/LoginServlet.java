package com.example.fumettoverse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try (Connection conn = DatabaseConnection.getConnection()) {
            String sql = "SELECT * FROM users WHERE email = ? AND password = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            stmt.setString(2, password);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                // Prendo il nome e il ruolo admin
                String name = rs.getString("name");
                boolean isAdmin = rs.getBoolean("is_admin");

                request.getSession().setAttribute("user", name);
                request.getSession().setAttribute("isAdmin", isAdmin);

                if (isAdmin) {
                    // Redirect pagina admin
                    response.sendRedirect(request.getContextPath() + "/admin/admin.jsp");
                } else {
                    // Redirect pagina utente normale
                    response.sendRedirect(request.getContextPath() + "/index.jsp");
                }
            } else {
                response.sendRedirect(request.getContextPath() + "/login.jsp?error=1");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=1");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
    }
}
