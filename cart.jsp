<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.OrderItem" %>
<%@ page import="java.util.*" %>
<%@ include file="header.jsp" %>

<title>Il mio carrello</title>
<link rel="stylesheet" href="styles/common.css">
<link rel="stylesheet" href="styles/carrellostyle.css">

<div class="cart-container">
    <h2>Il mio carrello</h2>

    <%
        Boolean empty = (Boolean) request.getAttribute("emptyCart");
        if (empty != null && empty) {
    %>
        <div class="empty-cart-message">
            <img src="images/goku-dragon-ball-guru.jpg" alt="Carrello vuoto" />
            <h3>Il tuo carrello è vuoto</h3>
            <p>Scopri i nostri fumetti e riempi il tuo carrello!</p>
            <a href="index" class="shop-now-btn">Vai allo Shop</a>
        </div>
    <%
        } else {
            List<OrderItem> items = (List<OrderItem>) request.getAttribute("items");
            double total = (double) request.getAttribute("total");
            String user = (String) request.getAttribute("user");

            for (OrderItem item : items) {
                double subtotal = item.getPrice() * item.getQuantity();
    %>
        <div class="cart-item">
            <img src="images/<%= item.getImage() %>" alt="<%= item.getTitle() %>">
            <div class="cart-info">
                <h3><%= item.getTitle() %></h3>
                <div class="price">€ <%= String.format("%.2f", item.getPrice()) %> x <%= item.getQuantity() %></div>
                <div class="price">Subtotale: € <%= String.format("%.2f", subtotal) %></div>

                <div class="cart-actions">
                    <form action="updateCart" method="post">
                        <input type="hidden" name="comicId" value="<%= item.getId() %>">
                        <input type="number" name="quantity" value="<%= item.getQuantity() %>" min="1" class="quantity-input">
                        <button type="submit" class="update-btn">Aggiorna</button>
                    </form>
                                      
                    <form action="removeFromCart" method="post">
                        <input type="hidden" name="comicId" value="<%= item.getId() %>">
                        <button type="submit" class="remove-btn">Rimuovi</button>
                    </form>
                </div>
            </div>
        </div>
    <%
            }
    %>

    <div class="cart-total">Totale: € <%= String.format("%.2f", total) %></div>

   <div class="buttons-container">
    <form action="checkout" method="get">
    <button type="submit" class="checkout-btn">Procedi al Checkout</button>
</form>

</div>



    
    <form action="clearCart" method="post">
        <button type="submit" class="clear-cart-btn">Svuota Carrello</button>
    </form>
    <%
        }
    %>
</div>

<%@ include file="footer.jsp" %>
