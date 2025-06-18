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
