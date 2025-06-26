<<<<<<< HEAD
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
=======
<<<<<<< HEAD
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Verifica se l'utente è un admin
>>>>>>> a365fcfeb0018ec9b95aa9c4e6a8aa230cf35c24
    Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
    if (isAdmin == null || !isAdmin) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    int id = 0;
    String title = "";
    double price = 0;
<<<<<<< HEAD
    String tipo = "";
    String image = "";

    try {
        id = Integer.parseInt(request.getParameter("id"));

=======

    try {
        // Recupera l'ID dalla richiesta
        id = Integer.parseInt(request.getParameter("id"));

        // Connessione al database
>>>>>>> a365fcfeb0018ec9b95aa9c4e6a8aa230cf35c24
        Connection conn = model.DatabaseConnection.getConnection();
        PreparedStatement stmt = conn.prepareStatement("SELECT * FROM comics WHERE id = ?");
        stmt.setInt(1, id);
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            title = rs.getString("title");
            price = rs.getDouble("price");
<<<<<<< HEAD
            tipo = rs.getString("tipo");
            image = rs.getString("image"); // 👉 recupero immagine
        } else {
=======
        } else {
            // Se non trovato, torna al catalogo
>>>>>>> a365fcfeb0018ec9b95aa9c4e6a8aa230cf35c24
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
<<<<<<< HEAD
    <link rel="stylesheet" href="<%= request.getContextPath() %>/styles/adminstyle.css">
=======
    <link rel="stylesheet" href="<%= request.getContextPath() %>/style/adminstyle.css">
>>>>>>> a365fcfeb0018ec9b95aa9c4e6a8aa230cf35c24
</head>
<body>

<h2>Modifica Fumetto</h2>

<div class="form-container">
<<<<<<< HEAD
    <form action="editComic" method="post" enctype="multipart/form-data">
        <input type="hidden" name="id" value="<%= id %>">
        <input type="hidden" name="currentImage" value="<%= image %>">
=======
    <form action="editComic" method="post">
        <input type="hidden" name="id" value="<%= id %>">
>>>>>>> a365fcfeb0018ec9b95aa9c4e6a8aa230cf35c24

        <label for="title">Titolo:</label>
        <input type="text" id="title" name="title" value="<%= title %>" required>

        <label for="price">Prezzo (€):</label>
        <input type="number" id="price" name="price" value="<%= price %>" step="0.01" min="0" required>

<<<<<<< HEAD
        <label for="tipo">Tipo:</label>
        <select id="tipo" name="tipo" required>
            <option value="MANGA" <%= "MANGA".equalsIgnoreCase(tipo) ? "selected" : "" %>>Manga</option>
            <option value="FUMETTO" <%= "FUMETTO".equalsIgnoreCase(tipo) ? "selected" : "" %>>Fumetto</option>
        </select>

        <p>Immagine attuale:</p>
        <img src="images/<%= image %>" alt="<%= title %>" width="150" style="margin-bottom: 10px;" />

        <label for="image">Sostituisci immagine:</label>
        <input type="file" id="image" name="image" accept="image/*">

=======
>>>>>>> a365fcfeb0018ec9b95aa9c4e6a8aa230cf35c24
        <button type="submit">Aggiorna</button>
    </form>

    <a href="catalog.jsp" class="cancel-link">Annulla</a>
</div>

</body>
</html>
<<<<<<< HEAD

=======
=======
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
    if (isAdmin == null || !isAdmin) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    int id = Integer.parseInt(request.getParameter("id"));
    String title = "";
    double price = 0;

    try {
        Connection conn = com.example.fumettoverse.DatabaseConnection.getConnection();
        PreparedStatement stmt = conn.prepareStatement("SELECT * FROM comics WHERE id = ?");
        stmt.setInt(1, id);
        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            title = rs.getString("title");
            price = rs.getDouble("price");
        } else {
            response.sendRedirect("catalog.jsp");
        }
        rs.close();
        stmt.close();
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<html>
<head><title>Modifica Fumetto</title></head>
<body>
<h2>Modifica Fumetto</h2>

<form action="editComic" method="post">
    <input type="hidden" name="id" value="<%= id %>">

    <label>Titolo:</label><br>
    <input type="text" name="title" value="<%= title %>" required><br><br>

    <label>Prezzo (€):</label><br>
    <input type="number" name="price" value="<%= price %>" step="0.01" min="0" required><br><br>

    <button type="submit">Aggiorna</button>
</form>

<a href="catalog.jsp">Annulla</a>

</body>
</html>
>>>>>>> 6c23e22ce354c2340ecf7d1bf4dcb52de023e73a
>>>>>>> a365fcfeb0018ec9b95aa9c4e6a8aa230cf35c24
