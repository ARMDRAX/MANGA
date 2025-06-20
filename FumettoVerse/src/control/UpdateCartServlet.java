package control;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;
import java.util.Iterator;

@WebServlet("/updateCart")
public class UpdateCartServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ✅ Consente l’uso anche a utenti anonimi
        HttpSession session = request.getSession(true);
        List<Integer> cart = (List<Integer>) session.getAttribute("cart");

        if (cart != null) {
            try {
                int comicId = Integer.parseInt(request.getParameter("comicId"));
                int quantity = Integer.parseInt(request.getParameter("quantity"));

                if (quantity < 0) quantity = 0;

                // Rimuove tutte le istanze del fumetto
                Iterator<Integer> it = cart.iterator();
                while (it.hasNext()) {
                    if (it.next() == comicId) {
                        it.remove();
                    }
                }

                // Aggiunge comicId tante volte quante la quantità
                for (int i = 0; i < quantity; i++) {
                    cart.add(comicId);
                }

                session.setAttribute("cart", cart);

            } catch (NumberFormatException e) {
                // Ignora o logga se vuoi
            }
        }

        response.sendRedirect("cart.jsp");
    }
}

