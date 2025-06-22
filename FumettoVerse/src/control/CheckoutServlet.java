package control;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.OrderDAO;

import java.io.IOException;
import java.util.*;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    @SuppressWarnings("unchecked")
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String email = (String) session.getAttribute("user");
        List<Integer> cart = (List<Integer>) session.getAttribute("cart");
        Map<Integer, Integer> quantities = (Map<Integer, Integer>) session.getAttribute("quantities");

        if (cart == null || cart.isEmpty()) {
            response.sendRedirect("cart.jsp?error=Carrello vuoto");
            return;
        }

        String paymentMethod = request.getParameter("paymentMethod");
        String totalPriceStr = request.getParameter("totalPrice");

        if (paymentMethod == null || totalPriceStr == null) {
            response.sendRedirect("checkout.jsp?error=Dati mancanti");
            return;
        }

        try {
            double totalPrice = Double.parseDouble(totalPriceStr);
            int orderNumber = new Random().nextInt(900000) + 100000;

            // fallback se quantities è null
            if (quantities == null) {
                quantities = new HashMap<>();
                for (Integer comicId : cart) {
                    quantities.put(comicId, 1); // default
                }
            }

            OrderDAO dao = new OrderDAO();
            dao.saveOrder(email, cart, quantities, paymentMethod, totalPrice, orderNumber);

            session.removeAttribute("cart");
            session.removeAttribute("quantities");

            response.sendRedirect("thankyou.jsp");
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("checkout.jsp?error=Prezzo non valido");
        } catch (Exception e) {
            e.printStackTrace(); // stampa anche in console
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("checkout.jsp").forward(request, response);
        }
    }
}
