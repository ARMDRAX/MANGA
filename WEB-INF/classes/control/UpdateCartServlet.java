package control;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import model.ComicDAO;

import java.io.IOException;
import java.util.*;

@WebServlet("/updateCart")
public class UpdateCartServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(true);
        List<Integer> cart = (List<Integer>) session.getAttribute("cart");

        if (cart != null) {
            try {
                int comicId = Integer.parseInt(request.getParameter("comicId"));
                int quantity = Integer.parseInt(request.getParameter("quantity"));
                if (quantity < 0) quantity = 0;

                cart.removeIf(id -> id == comicId);

                for (int i = 0; i < quantity; i++) {
                    cart.add(comicId);
                }

                session.setAttribute("cart", cart);
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }

        response.sendRedirect("cart");
    }
}
