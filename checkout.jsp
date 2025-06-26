<%@ page contentType="text/html;charset=UTF-8" language="java" session="true" %>
<%@ page import="model.OrderItem" %>
<%@ page import="java.util.*" %>
<%@ include file="header.jsp" %>

<title>Checkout</title>
<link rel="stylesheet" href="styles/checkoutstyle.css">

<%
   
    List<OrderItem> items = (List<OrderItem>) request.getAttribute("items");
    double total = (request.getAttribute("total") != null) ? (double) request.getAttribute("total") : 0.0;
    String errorMessage = (String) request.getAttribute("errorMessage");
%>

<% if (errorMessage != null) { %>
    <p style="color:red;"><strong>Errore:</strong> <%= errorMessage %></p>
<% } %>

<div class="container">
    <h2>Checkout</h2>

<% if (items == null || items.isEmpty()) { %>
    <p>Il tuo carrello è vuoto. <a href="cart">Torna al carrello</a></p>
<% } else { %>
    <h3>Riepilogo ordine:</h3>
    <ul>
        <% for (OrderItem item : items) {
               double subtotal = item.getPrice() * item.getQuantity();
        %>
            <li>
                <strong><%= item.getTitle() %></strong> – € <%= String.format("%.2f", item.getPrice()) %> x <%= item.getQuantity() %>
                = <%= String.format("%.2f", subtotal) %> €
            </li>
        <% } %>
    </ul>

    <h3>Totale: € <%= String.format("%.2f", total) %></h3>

    <form action="checkout" method="post" novalidate>
        <input type="hidden" name="totalPrice" value="<%= total %>">

        <fieldset>
            <legend>Dati di spedizione</legend>
            <label for="address">Via:</label><br>
            <input type="text" id="address" name="address" required><br><br>

            <label for="zip">CAP:</label><br>
            <input type="text" id="zip" name="zip" pattern="[0-9]{5}" required><br><br>

            <label for="city">Città:</label><br>
            <input type="text" id="city" name="city" required><br><br>
        </fieldset>

        <fieldset>
            <legend>Metodo di pagamento</legend>
            <label><input type="radio" name="paymentMethod" value="Carta di Credito" required onclick="toggleCardDetails()"> Carta di Credito</label><br>
            <label><input type="radio" name="paymentMethod" value="PayPal" required onclick="toggleCardDetails()"> PayPal</label><br>
            <label><input type="radio" name="paymentMethod" value="Contrassegno" required onclick="toggleCardDetails()"> Contrassegno</label><br>
        </fieldset>

        <fieldset id="card-details" style="display:none;">
            <legend>Dati Carta di Credito</legend>
            <input type="text" name="cardNumber" placeholder="Numero carta" pattern="[0-9]{13,19}"><br><br>
            <input type="text" name="expiry" placeholder="MM/AA" pattern="(0[1-9]|1[0-2])/\\d{2}"><br><br>
            <input type="text" name="cvv" placeholder="CVV" pattern="\\d{3,4}"><br><br>
        </fieldset>

        <div class="buttons-container">
            <button type="submit" class="checkout-btn">Conferma ordine</button>
        </div>
        <div id="error-message" style="color: red; margin-top: 10px;"></div>
    </form>
<% } %>
</div>

<script src="scripts/checkout.js"></script>

<%@ include file="footer.jsp" %>
