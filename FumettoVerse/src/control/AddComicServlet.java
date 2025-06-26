package control;

import model.ComicDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;

@WebServlet("/admin/addComic")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,       // 1MB
    maxFileSize = 1024 * 1024 * 5,         // 5MB
    maxRequestSize = 1024 * 1024 * 10      // 10MB
)
public class AddComicServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Controllo autenticazione e ruolo admin
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
            String title = request.getParameter("title");
            double price = Double.parseDouble(request.getParameter("price"));
            String tipo = request.getParameter("tipo");

            Part imagePart = request.getPart("image");
            String fileName = Path.of(imagePart.getSubmittedFileName()).getFileName().toString();

            // Percorso assoluto dinamico nella cartella images del progetto web
            String uploadPath = getServletContext().getRealPath("") + File.separator + "images";
            File uploads = new File(uploadPath);
            if (!uploads.exists()) uploads.mkdirs();

            // Aggiungi timestamp per evitare sovrascrittura
            String newFileName = System.currentTimeMillis() + "_" + fileName;
            File file = new File(uploads, newFileName);
            try (InputStream input = imagePart.getInputStream()) {
                Files.copy(input, file.toPath());
            }

            ComicDAO dao = new ComicDAO();
            dao.addComic(title, price, tipo, newFileName);

            response.sendRedirect("catalog.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("addComic.jsp?error=1");
        }
    }
}

