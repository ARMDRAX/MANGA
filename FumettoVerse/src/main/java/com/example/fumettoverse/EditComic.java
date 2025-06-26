package com.example.fumettoverse;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/editComic")
public class EditComic extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Boolean isAdmin = (Boolean) request.getSession().getAttribute("admin");
        if (isAdmin == null || !isAdmin) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        int id = Integer.parseInt(request.getParameter("id"));
        String title = request.getParameter("title");
        double price = Double.parseDouble(request.getParameter("price"));

        try (Connection conn = DatabaseConnection.getConnection()) {
            String sql = "UPDATE comics SET title = ?, price = ? WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, title);
            stmt.setDouble(2, price);
            stmt.setInt(3, id);
            stmt.executeUpdate();
            stmt.close();
            response.sendRedirect("catalog.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Errore durante aggiornamento fumetto.");
        }
    }
}
