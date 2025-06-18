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
