package com.example.fumettoverse;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.json.JSONObject;  // Assicurati che questo import funzioni

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/cart")  // Assicurati che l'URL sia /cart per il form/action ajax
public class CartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @SuppressWarnings("unchecked")
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        PrintWriter out = response.getWriter();

        try {
            int comicId = Integer.parseInt(request.getParameter("comicId"));

            HttpSession session = request.getSession();
            List<Integer> cart = (List<Integer>) session.getAttribute("cart");

            if (cart == null) {
                cart = new ArrayList<>();
            }

            cart.add(comicId);
            session.setAttribute("cart", cart);

            JSONObject json = new JSONObject();
            json.put("success", true);
            json.put("cartCount", cart.size());

            out.print(json.toString());
            out.flush();

        } catch (Exception e) {
            JSONObject json = new JSONObject();
            json.put("success", false);
            json.put("message", "Errore durante l'aggiunta al carrello: " + e.getMessage());
            out.print(json.toString());
            out.flush();
        }
    }
}
