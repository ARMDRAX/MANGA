package control;

import model.ComicDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/admin/deleteComic")
public class DeleteComicServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ✅ Controllo autenticazione e ruolo admin tramite boolean isAdmin
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("authToken") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
        if (isAdmin == null || !isAdmin) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Accesso non autorizzato");
            return;
        }

        try {
            int id = Integer.parseInt(request.getParameter("id"));

            ComicDAO dao = new ComicDAO();
            dao.deleteComic(id);

            response.sendRedirect("catalog.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("deleteComic.jsp?error=1");
        }
    }
}
