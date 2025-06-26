package control;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.RequestDispatcher;
import model.Comic;
import model.ComicDAO;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/catalog")
public class AdminCatalogServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response) throws ServletException, IOException {

        /* --- sicurezza --------------------------------------------------- */
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("authToken") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
        if (isAdmin == null || !isAdmin) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN,
                               "Accesso non autorizzato");
            return;
        }
        /* ----------------------------------------------------------------- */

        try {
            ComicDAO dao = new ComicDAO();
            List<Comic> comics = dao.getAllComics();   // già presente nel DAO
            request.setAttribute("comics", comics);

            /* manteniamo eventuale flag “deleted” per messaggio di successo */
            String deleted = request.getParameter("deleted");
            if (deleted != null) request.setAttribute("deleted", deleted);

            RequestDispatcher rd =
                request.getRequestDispatcher("/admin/catalog.jsp");
            rd.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath()
                                   + "/admin.jsp?error=catalog");
        }
    }
}
