<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
    if (isAdmin == null || !isAdmin) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>
<html>
<head>
    <title>Gestione Catalogo</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/styles/adminstyle.css">
</head>
<body>

<h2>Catalogo Fumetti</h2>
<% if ("1".equals(request.getParameter("deleted"))) { %>
    <div class="success-message" id="delete-msg">
        ✅ Fumetto eliminato con successo.
    </div>
<% } %>

<!-- Pulsante Aggiungi dentro container per allineamento a destra -->
<div class="button-container">
    <a href="addComic.jsp" class="action-button">Aggiungi Nuovo Fumetto</a>
</div>

<!-- Contenitore tabella per spostarla a destra -->
<div class="catalog-table-container">
    <table class="catalog-table">
        <tr>
            <th>ID</th><th>Titolo</th><th>Prezzo</th><th>Azioni</th>
        </tr>

        <%
            try {
                Connection conn = model.DatabaseConnection.getConnection();
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT * FROM comics");

                while (rs.next()) {
        %>
                    <tr>
                        <td><%= rs.getInt("id") %></td>
                        <td><%= rs.getString("title") %></td>
                        <td>€ <%= String.format("%.2f", rs.getDouble("price")) %></td>
                        <td>
                            <a href="editComic.jsp?id=<%= rs.getInt("id") %>" class="action-button">Modifica</a>
                            <a href="deleteComic.jsp?id=<%= rs.getInt("id") %>" class="action-button">Cancella</a>

                        </td>
                    </tr>
        <%
                }

                rs.close();
                stmt.close();
                conn.close();
            } catch (Exception e) {
                out.println("<tr><td colspan='4'>Errore caricamento catalogo</td></tr>");
                e.printStackTrace();
            }
        %>
    </table>
</div>

<!-- Pulsante Torna a pannello admin dentro container per allineamento a destra -->
<div class="button-container" style="margin-top: 20px;">
    <a href="admin.jsp" class="action-button">Torna a pannello admin</a>
</div>
<script>
    window.addEventListener("DOMContentLoaded", () => {
        const msg = document.getElementById("delete-msg");
        if (msg) {
            setTimeout(() => {
                msg.style.opacity = '0';
                setTimeout(() => msg.remove(), 500);
            }, 3000);
        }
    });
</script>

</body>
</html>
