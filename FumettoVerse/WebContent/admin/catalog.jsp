<<<<<<< HEAD
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
    <link rel="stylesheet" href="<%= request.getContextPath() %>/style/adminstyle.css">
</head>
<body>

<h2>Catalogo Fumetti</h2>

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
                            <a href="deleteComic.jsp?id=<%= rs.getInt("id") %>" class="action-button" onclick="return confirm('Sei sicuro di cancellare?')">Cancella</a>
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

</body>
</html>
=======
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
<head><title>Gestione Catalogo</title>
<link rel="stylesheet" href="<%= request.getContextPath() %>/style/adminstyle.css">

</head>
<body>
<h2>Catalogo Fumetti</h2>

<a href="addComic.jsp">Aggiungi Nuovo Fumetto</a>

<table border="1" cellpadding="5" cellspacing="0">
    <tr>
        <th>ID</th><th>Titolo</th><th>Prezzo</th><th>Azioni</th>
    </tr>

<%
    try {
        Connection conn = com.example.fumettoverse.DatabaseConnection.getConnection();
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT * FROM comics");

        while (rs.next()) {
%>
            <tr>
                <td><%= rs.getInt("id") %></td>
                <td><%= rs.getString("title") %></td>
                <td>€ <%= String.format("%.2f", rs.getDouble("price")) %></td>
                <td>
                    <a href="editComic.jsp?id=<%= rs.getInt("id") %>">Modifica</a> |
                    <a href="deleteComic?id=<%= rs.getInt("id") %>" onclick="return confirm('Sei sicuro di cancellare?')">Cancella</a>
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

<a href="admin.jsp">Torna a pannello admin</a>

</body>
</html>
>>>>>>> 6c23e22ce354c2340ecf7d1bf4dcb52de023e73a
