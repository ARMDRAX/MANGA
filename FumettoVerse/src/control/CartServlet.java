package control;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.json.JSONObject;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @SuppressWarnings("unchecked")
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        JSONObject json = new JSONObject();

        // ✅ Crea la sessione se non esiste (utente anonimo supportato)
        HttpSession session = request.getSession(true);

        try {
            int comicId = Integer.parseInt(request.getParameter("comicId"));

            List<Integer> cart = (List<Integer>) session.getAttribute("cart");
            if (cart == null) {
                cart = new ArrayList<>();
            }

            cart.add(comicId);
            session.setAttribute("cart", cart);

            json.put("success", true);
            json.put("cartCount", cart.size());

        } catch (Exception e) {
            json.put("success", false);
            json.put("message", "Errore durante l'aggiunta al carrello: " + e.getMessage());
        }

        out.print(json.toString());
        out.flush();
    }
}

