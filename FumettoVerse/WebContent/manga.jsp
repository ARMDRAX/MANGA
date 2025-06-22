<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="java.util.List" %>
<%@ page session="true" %>
<%@ include file="header.jsp" %>

<html>
<head>
    <title>Manga</title>
    <link rel="stylesheet" href="styles/allComics.css">
</head>
<body>

<div id="cart-message"></div>

<div class="container">
    <h2>Manga</h2>
    <div class="comics">

    <%
        try {
            Connection conn = model.DatabaseConnection.getConnection();
            String sql = "SELECT * FROM comics WHERE tipo = 'MANGA'";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                int id = rs.getInt("id");
                String title = rs.getString("title");
                double price = rs.getDouble("price");
                String image = rs.getString("image");
    %>

    <div class="comic">
        <img src="images/<%= image %>" alt="<%= title %>">
        <h3><%= title %></h3>
        <p class="price">€ <%= rs.getBigDecimal("price") %></p>
        <form class="add-to-cart-form" data-comic-id="<%= id %>">
            <button type="submit" class="add-to-cart">Aggiungi al carrello</button>
        </form>
    </div>

    <%
            }
            rs.close();
            stmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<p>Errore nel caricamento dei manga.</p>");
        }
    %>

    </div>
</div>

<!-- jQuery + script -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="scripts/manga.js"></script>

<%@ include file="footer.jsp" %>
</body>
</html>

