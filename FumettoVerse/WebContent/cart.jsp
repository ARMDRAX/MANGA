<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page session="true" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.jsp" %>

<html>
<head>
    <title>Il mio carrello</title>
    <link rel="stylesheet" href="styles/common.css">
    <link rel="stylesheet" href="styles/carrellostyle.css">
</head>
<body>

<%
    String user = (String) session.getAttribute("user");
    cart = (List<Integer>) session.getAttribute("cart");
%>

<div class="cart-container">
    <h2>Il mio carrello</h2>

    <%
        if (cart == null || cart.isEmpty()) {
    %>
        <div class="empty-cart-message">
    <img src="images/goku-dragon-ball-guru.jpg" alt="Carrello vuoto" />
    <h3>Il tuo carrello è vuoto</h3>
    <p>Scopri i nostri fumetti e riempi il tuo carrello!</p>
    <a href="index.jsp" class="shop-now-btn">Vai allo Shop</a>
</div>

    <%
        } else {
            try {
                Connection conn = model.DatabaseConnection.getConnection();
                double total = 0;

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

    <div class="cart-item">
        <img src="images/<%= image %>" alt="<%= title %>">

        <div class="cart-info">
            <h3><%= title %></h3>
            <div class="price">€ <%= String.format("%.2f", price) %> x <%= quantity %></div>

            <div class="cart-actions">
                <form action="updateCart" method="post" class="update-form">
                    <input type="hidden" name="comicId" value="<%= comicId %>">
                    <input type="number" name="quantity" value="<%= quantity %>" min="1" class="quantity-input">
                    <button type="submit" class="update-btn">Aggiorna</button>
                </form>

                <form action="removeFromCart" method="post" class="remove-form">
                    <input type="hidden" name="comicId" value="<%= comicId %>">
                    <button type="submit" class="remove-btn">Rimuovi</button>
                </form>
            </div>
        </div>
    </div>

    <%
                    }
                    rs.close();
                    stmt.close();
                }
                conn.close();
    %>

    <div class="cart-total">Totale: € <%= String.format("%.2f", total) %></div>

    <% if (user != null) { %>
        <div class="buttons-container">
            <form action="checkout.jsp" method="get">
                <button type="submit" class="checkout-btn">Procedi al Checkout</button>
            </form>

            
        </div>
    <% } else { %>
        <p style="text-align: right; color: gray; font-style: italic; margin-top: 20px;">
            Effettua il login per procedere al checkout.
        </p>
    <% } %>
<form action="clearCart" method="post">
                <button type="submit" class="clear-cart-btn">Svuota Carrello</button>
            </form>
    <%
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<p>Errore durante il caricamento del carrello.</p>");
            }
        }
    %>
</div>




<script src="scripts/cart.js"></script>
</body>
</html>

<%@ include file="footer.jsp" %>
