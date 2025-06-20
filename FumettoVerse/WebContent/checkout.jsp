<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.*" %>
<%@ include file="header.jsp" %>
<%@ include file="footer.jsp" %>

<%
    String user = (String) session.getAttribute("user");
     cart = (List<Integer>) session.getAttribute("cart");

    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    double total = 0;

    try {
        Connection conn = model.DatabaseConnection.getConnection();
        for (int comicId : cart) {
            String sql = "SELECT price FROM comics WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, comicId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                total += rs.getDouble("price");
            }

            rs.close();
            stmt.close();
        }
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<p>Errore durante il calcolo del totale.</p>");
    }
%>

<html>
<head>
    <title>Checkout</title>
    <link rel="stylesheet" href="style/checkoutstyle.css">
    <link rel="stylesheet" href="style/navbar.css">

    <script>
        function toggleCardDetails() {
            const paymentMethod = document.querySelector('input[name="paymentMethod"]:checked').value;
            const cardDetails = document.getElementById('card-details');
            cardDetails.style.display = (paymentMethod === 'Carta di Credito') ? 'block' : 'none';
        }

        document.addEventListener("DOMContentLoaded", function() {
            const form = document.querySelector("form");
            const errorDiv = document.getElementById('error-message');

            form.addEventListener("submit", function(event) {
                errorDiv.innerText = "";

                const paymentMethodElem = document.querySelector('input[name="paymentMethod"]:checked');
                if (!paymentMethodElem) {
                    errorDiv.innerText = "Seleziona un metodo di pagamento.";
                    event.preventDefault();
                    return;
                }
                const paymentMethod = paymentMethodElem.value;

                const address = document.getElementById('address').value.trim();
                const zip = document.getElementById('zip').value.trim();
                const city = document.getElementById('city').value.trim();

                const errors = [];

                // Controlli base indirizzo
                if (!address) errors.push("Inserisci l'indirizzo.");
                if (!zip.match(/^\d{5}$/)) errors.push("Inserisci un CAP valido (5 cifre).");
                if (!city) errors.push("Inserisci la città.");

                if (paymentMethod === "Carta di Credito") {
                    const cardNumber = document.querySelector('input[name="cardNumber"]').value.trim();
                    const expiry = document.querySelector('input[name="expiry"]').value.trim();
                    const cvv = document.querySelector('input[name="cvv"]').value.trim();

                    if (!cardNumber || !expiry || !cvv) {
                        errors.push("Completa tutti i campi della carta di credito.");
                    } else {
                        if (!/^[0-9]{13,19}$/.test(cardNumber)) errors.push("Numero carta non valido.");
                        if (!/^(0[1-9]|1[0-2])\/\d{2}$/.test(expiry)) errors.push("Scadenza carta non valida (MM/AA).");
                        if (!/^\d{3,4}$/.test(cvv)) errors.push("CVV non valido.");
                    }
                }

                if (errors.length > 0) {
                    errorDiv.innerHTML = errors.map(e => `<p>${e}</p>`).join('');
                    event.preventDefault();
                }
            });
        });
    </script>
</head>
<body>
<%
    String errorMessage = (String) request.getAttribute("errorMessage");
    if (errorMessage != null) {
%>
    <p style="color:red;"><strong>Errore:</strong> <%= errorMessage %></p>
<%
    }
%>

<div class="container">
    <h2>Checkout</h2>
    <h3>Riepilogo ordine:</h3>
    <ul>
        <%
            try {
                Connection conn = model.DatabaseConnection.getConnection();
                for (int comicId : cart) {
                    String sql = "SELECT * FROM comics WHERE id = ?";
                    PreparedStatement stmt = conn.prepareStatement(sql);
                    stmt.setInt(1, comicId);
                    ResultSet rs = stmt.executeQuery();

                    if (rs.next()) {
                        String title = rs.getString("title");
                        double price = rs.getDouble("price");
        %>
                        <li><strong><%= title %></strong> - € <%= String.format("%.2f", price) %></li>
        <%
                    }
                    rs.close();
                    stmt.close();
                }
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<p>Errore durante il caricamento del carrello.</p>");
            }
        %>
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

        <button type="submit" class="checkout-btn">Conferma ordine</button>
        <div id="error-message" style="color: red; margin-top: 10px;"></div>
    </form>
</div>
</body>
</html>
