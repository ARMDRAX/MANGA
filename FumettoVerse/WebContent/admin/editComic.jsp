<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
    if (isAdmin == null || !isAdmin) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    int id = 0;
    String title = "";
    double price = 0;
    String tipo = "";
    String image = "";

    try {
        id = Integer.parseInt(request.getParameter("id"));

        Connection conn = model.DatabaseConnection.getConnection();
        PreparedStatement stmt = conn.prepareStatement("SELECT * FROM comics WHERE id = ?");
        stmt.setInt(1, id);
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            title = rs.getString("title");
            price = rs.getDouble("price");
            tipo = rs.getString("tipo");
            image = rs.getString("image"); // 👉 recupero immagine
        } else {
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
    <link rel="stylesheet" href="<%= request.getContextPath() %>/styles/adminstyle.css">
</head>
<body>

<h2>Modifica Fumetto</h2>

<div class="form-container">
    <form action="editComic" method="post" enctype="multipart/form-data">
        <input type="hidden" name="id" value="<%= id %>">
        <input type="hidden" name="currentImage" value="<%= image %>">

        <label for="title">Titolo:</label>
        <input type="text" id="title" name="title" value="<%= title %>" required>

        <label for="price">Prezzo (€):</label>
        <input type="number" id="price" name="price" value="<%= price %>" step="0.01" min="0" required>

        <label for="tipo">Tipo:</label>
        <select id="tipo" name="tipo" required>
            <option value="MANGA" <%= "MANGA".equalsIgnoreCase(tipo) ? "selected" : "" %>>Manga</option>
            <option value="FUMETTO" <%= "FUMETTO".equalsIgnoreCase(tipo) ? "selected" : "" %>>Fumetto</option>
        </select>

        <p>Immagine attuale:</p>
        <img src="images/<%= image %>" alt="<%= title %>" width="150" style="margin-bottom: 10px;" />

        <label for="image">Sostituisci immagine:</label>
        <input type="file" id="image" name="image" accept="image/*">

        <button type="submit">Aggiorna</button>
    </form>

    <a href="catalog.jsp" class="cancel-link">Annulla</a>
</div>

</body>
</html>

