package control;

import model.ComicDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/editComic")
public class EditComic extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Recupera sessione esistente, senza crearne una nuova
        HttpSession session = request.getSession(false);
        
        // Controllo autenticazione
        if (session == null || session.getAttribute("authToken") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // Controllo ruolo admin
        Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
        if (isAdmin == null || !isAdmin) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Accesso non autorizzato");
            return;
        }

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String title = request.getParameter("title");
            double price = Double.parseDouble(request.getParameter("price"));
            String tipo = request.getParameter("tipo");

            ComicDAO dao = new ComicDAO();
            dao.updateComic(id, title, price, tipo);

            // Redirect al catalogo fumetti admin
            response.sendRedirect(request.getContextPath() + "/admin/catalog.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            // In caso di errore torna alla pagina di modifica con errore
            response.sendRedirect(request.getContextPath() + "/admin/editComic.jsp?error=1&id=" + request.getParameter("id"));
        }
    }
}
