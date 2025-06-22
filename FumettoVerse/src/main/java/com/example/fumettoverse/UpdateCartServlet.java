package com.example.fumettoverse;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;
import java.util.ArrayList;
import java.util.Iterator;

@WebServlet("/updateCart")
public class UpdateCartServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        List<Integer> cart = (List<Integer>) session.getAttribute("cart");

        if (cart != null) {
            try {
                int comicId = Integer.parseInt(request.getParameter("comicId"));
                int quantity = Integer.parseInt(request.getParameter("quantity"));

                if (quantity < 0) {
                    quantity = 0; // quantità negativa non valida, la normalizzo a 0
                }

                // Rimuovi tutte le occorrenze di comicId
                Iterator<Integer> it = cart.iterator();
                while (it.hasNext()) {
                    if (it.next() == comicId) {
                        it.remove();
                    }
                }

                // Se la quantità è > 0, aggiungi comicId tante volte
                for (int i = 0; i < quantity; i++) {
                    cart.add(comicId);
                }

                session.setAttribute("cart", cart);

            } catch (NumberFormatException e) {
                // Potresti loggare l'errore o gestirlo in altro modo
            }
        }

        response.sendRedirect("cart.jsp");
    }
}
