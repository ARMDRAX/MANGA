<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Verifica se l'utente è un admin
    Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
    if (isAdmin == null || !isAdmin) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    int id = Integer.parseInt(request.getParameter("id"));
    String title = "";

    try {
        Connection conn = model.DatabaseConnection.getConnection();
        PreparedStatement stmt = conn.prepareStatement("SELECT title FROM comics WHERE id = ?");
        stmt.setInt(1, id);
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            title = rs.getString("title");
        } else {
            response.sendRedirect("catalog.jsp");
            return;
        }

        rs.close();
        stmt.close();
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Elimina Fumetto</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/styles/adminstyle.css">
</head>
<body>

<h2>Conferma Eliminazione</h2>

<div class="form-container">
    <p>Sei sicuro di voler eliminare il fumetto: <strong><%= title %></strong>?</p>

    <form action="deleteComic" method="post">
        <input type="hidden" name="id" value="<%= id %>">

        <button type="submit">Elimina</button>
        <a href="<%= request.getContextPath() %>/admin/catalog.jsp" class="cancel-link">Annulla</a>

    </form>
</div>

</body>
</html>
