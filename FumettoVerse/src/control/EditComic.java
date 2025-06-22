package control;

import model.ComicDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

@WebServlet("/admin/editComic")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, // 1MB
                 maxFileSize = 5 * 1024 * 1024,    // 5MB
                 maxRequestSize = 10 * 1024 * 1024) // 10MB
public class EditComic extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

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
            String title = request.getParameter("title");
            double price = Double.parseDouble(request.getParameter("price"));
            String tipo = request.getParameter("tipo");

            // Recupera l'immagine attuale (nel caso non venga sostituita)
            String currentImage = request.getParameter("currentImage");
            String newImageName = currentImage;

            // Gestione nuova immagine
            Part filePart = request.getPart("image");
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                newImageName = System.currentTimeMillis() + "_" + fileName; // evitiamo conflitti di nome

                String uploadPath = getServletContext().getRealPath("/images");
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }

                filePart.write(uploadPath + File.separator + newImageName);
            }

            // Aggiorna nel DB
            ComicDAO dao = new ComicDAO();
            dao.updateComic(id, title, price, tipo, newImageName);

            response.sendRedirect(request.getContextPath() + "/admin/catalog.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/editComic.jsp?error=1&id=" + request.getParameter("id"));
        }
    }
}
