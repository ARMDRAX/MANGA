package control;

import model.User;
import model.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.UUID;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            UserDAO userDAO = new UserDAO();
            userDAO.registerUser(name, email, password);

            // Recupera l'utente appena registrato
            User newUser = userDAO.doLogin(email, password); // stesso metodo usato nel login

            if (newUser != null) {
                // Crea la sessione e salva il token + ruolo
                HttpSession session = request.getSession(true);
                session.setAttribute("authToken", UUID.randomUUID().toString());
                session.setAttribute("user", newUser.getName());  // <-- Salva solo il nome come String
                session.setAttribute("userId", newUser.getId());
                session.setAttribute("role", newUser.isAdmin() ? "admin" : "user");

                // Reindirizza in base al ruolo
                if (newUser.isAdmin()) {
                    response.sendRedirect("admin/admin.jsp");
                } else {
                    response.sendRedirect("index.jsp");
                }
            } else {
                response.sendRedirect("login.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("register.jsp?error=1");
        }
    }
}
