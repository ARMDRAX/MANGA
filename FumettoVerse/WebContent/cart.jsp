<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page session="true" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="navbar.jsp" %>

<html>
<head>
    <title>Il mio carrello</title>
    <link rel="stylesheet" href="style/carrellostyle.css">
    <link rel="stylesheet" href="style/navbar.css">
</head>
<body>

<%
     user = (String) session.getAttribute("user");
     cart = (List<Integer>) session.getAttribute("cart");
%>

<div class="container">
    <h2>Il mio carrello</h2>

    <%
        if (cart == null || cart.isEmpty()) {
    %>
        <p>Il carrello è vuoto.</p>
    <%
        } else {
            try {
                Connection conn = com.example.fumettoverse.DatabaseConnection.getConnection();
                double total = 0;

                // Conta le quantità di ogni prodotto
                Map<Integer, Integer> quantityMap = new HashMap<>();
                for (int comicId : cart) {
                    quantityMap.put(comicId, quantityMap.getOrDefault(comicId, 0) + 1);
                }

                for (Map.Entry<Integer, Integer> entry : quantityMap.entrySet()) {
                    int comicId = entry.getKey();
                    int quantity = entry.getValue();

                    String sql = "SELECT * FROM comics WHERE id = ?";
                    PreparedStatement stmt = conn.prepareStatement(sql);
                    stmt.setInt(1, comicId);
                    ResultSet rs = stmt.executeQuery();

                    if (rs.next()) {
                        String title = rs.getString("title");
                        double price = rs.getDouble("price");
                        String image = rs.getString("image");
                        total += price * quantity;
    %>

    <div class="comic">
        <img src="images/<%= image %>" alt="<%= title %>">

        <div class="comic-info">
            <h3><%= title %></h3>

            <div class="price-quantity">
                <p class="price">€ <%= String.format("%.2f", price) %> x </p>
                <form action="updateCart" method="post" class="update-cart-form">
                    <input type="hidden" name="comicId" value="<%= comicId %>">
                    <input type="number" name="quantity" value="<%= quantity %>" min="1" class="quantity-input">
                </form>
            </div>
        </div>

        <div class="buttons-inline">
            <form action="updateCart" method="post" class="update-form">
                <input type="hidden" name="comicId" value="<%= comicId %>">
                <input type="number" name="quantity" value="<%= quantity %>" min="1" style="display:none;">
                <button type="submit" class="update-btn">Aggiorna</button>
            </form>

            <form action="removeFromCart" method="post" class="remove-form">
                <input type="hidden" name="comicId" value="<%= comicId %>">
                <button type="submit" class="remove-btn">Rimuovi</button>
            </form>
        </div>
    </div>

    <%
                    }
                    rs.close();
                    stmt.close();
                }
                conn.close();
    %>

    <h3>Totale: € <%= String.format("%.2f", total) %></h3>

    <% if (user != null) { %>
        <div class="buttons-container">
            <form action="checkout.jsp" method="get" class="checkout-form">
                <button type="submit" class="checkout-btn">Procedi al Checkout</button>
            </form>

            <form action="clearCart" method="post" class="clear-cart-form">
                <button type="submit" class="clear-cart-btn">Svuota Carrello</button>
            </form>
        </div>
    <% } else { %>
        <p style="text-align: right; color: gray; font-style: italic; margin-top: 20px;">
            Effettua il login per procedere al checkout.
        </p>
    <% } %>

    <%
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<p>Errore durante il caricamento del carrello.</p>");
            }
        }
    %>
</div>

</body>
</html>

