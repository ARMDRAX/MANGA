package com.example.fumettoverse;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/removeFromCart")
public class RemoveFromCartServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        List<Integer> cart = (List<Integer>) session.getAttribute("cart");
        String comicIdParam = request.getParameter("comicId");

        if (cart != null && comicIdParam != null) {
            try {
                int comicId = Integer.parseInt(comicIdParam);
                cart.removeIf(id -> id == comicId);
                session.setAttribute("cart", cart);
            } catch (NumberFormatException e) {
                // Ignora valore non valido
            }
        }

        // Torna alla pagina carrello
        response.sendRedirect("cart.jsp");
    }
}
