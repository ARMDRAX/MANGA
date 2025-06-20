<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Verifica se l'utente è un admin
    Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
    if (isAdmin == null || !isAdmin) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    int id = 0;
    String title = "";
    double price = 0;

    try {
        // Recupera l'ID dalla richiesta
        id = Integer.parseInt(request.getParameter("id"));

        // Connessione al database
        Connection conn = model.DatabaseConnection.getConnection();
        PreparedStatement stmt = conn.prepareStatement("SELECT * FROM comics WHERE id = ?");
        stmt.setInt(1, id);
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            title = rs.getString("title");
            price = rs.getDouble("price");
        } else {
            // Se non trovato, torna al catalogo
            response.sendRedirect("catalog.jsp");
            return;
        }

        rs.close();
        stmt.close();
        conn.close();

    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("catalog.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Modifica Fumetto</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/style/adminstyle.css">
</head>
<body>

<h2>Modifica Fumetto</h2>

<div class="form-container">
    <form action="editComic" method="post">
        <input type="hidden" name="id" value="<%= id %>">

        <label for="title">Titolo:</label>
        <input type="text" id="title" name="title" value="<%= title %>" required>

        <label for="price">Prezzo (€):</label>
        <input type="number" id="price" name="price" value="<%= price %>" step="0.01" min="0" required>

        <button type="submit">Aggiorna</button>
    </form>

    <a href="catalog.jsp" class="cancel-link">Annulla</a>
</div>

</body>
</html>
