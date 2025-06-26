<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> a365fcfeb0018ec9b95aa9c4e6a8aa230cf35c24
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page session="true" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="header.jsp" %>

<html>
<head>
    <title>Il mio carrello</title>
<<<<<<< HEAD
    <link rel="stylesheet" href="styles/common.css">
    <link rel="stylesheet" href="styles/carrellostyle.css">
=======
    <link rel="stylesheet" href="style/common.css">
    <link rel="stylesheet" href="style/carrellostyle.css">
>>>>>>> a365fcfeb0018ec9b95aa9c4e6a8aa230cf35c24
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
<<<<<<< HEAD
        <div class="empty-cart-message">
    <img src="images/goku-dragon-ball-guru.jpg" alt="Carrello vuoto" />
    <h3>Il tuo carrello è vuoto</h3>
    <p>Scopri i nostri fumetti e riempi il tuo carrello!</p>
    <a href="index.jsp" class="shop-now-btn">Vai allo Shop</a>
</div>

=======
        <p>Il carrello è vuoto.</p>
>>>>>>> a365fcfeb0018ec9b95aa9c4e6a8aa230cf35c24
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

<<<<<<< HEAD
            
=======
            <form action="clearCart" method="post">
                <button type="submit" class="clear-cart-btn">Svuota Carrello</button>
            </form>
>>>>>>> a365fcfeb0018ec9b95aa9c4e6a8aa230cf35c24
        </div>
    <% } else { %>
        <p style="text-align: right; color: gray; font-style: italic; margin-top: 20px;">
            Effettua il login per procedere al checkout.
        </p>
    <% } %>
<<<<<<< HEAD
<form action="clearCart" method="post">
                <button type="submit" class="clear-cart-btn">Svuota Carrello</button>
            </form>
=======

>>>>>>> a365fcfeb0018ec9b95aa9c4e6a8aa230cf35c24
    <%
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<p>Errore durante il caricamento del carrello.</p>");
            }
        }
    %>
</div>


<<<<<<< HEAD


<script src="scripts/cart.js"></script>
=======
<script>
document.addEventListener("DOMContentLoaded", function () {
    const form = document.querySelector("form");
    const errorBox = document.createElement("div");
    errorBox.id = "cartErrors";
    errorBox.style.color = "red";
    errorBox.style.textAlign = "center";
    errorBox.style.fontWeight = "bold";
    form?.prepend(errorBox);

    function showError(msg) {
        errorBox.innerHTML = "";
        const p = document.createElement("p");
        p.textContent = msg;
        errorBox.appendChild(p);
    }

    form?.addEventListener("submit", function (e) {
        const quantityInputs = form.querySelectorAll("input[type='number']");
        for (let input of quantityInputs) {
            const val = parseInt(input.value);
            if (isNaN(val) || val <= 0) {
                e.preventDefault();
                showError("Inserisci una quantità valida (numero maggiore di 0).");
                return;
            }
        }
        errorBox.innerHTML = "";
    });

    form?.querySelectorAll("input[type='number']").forEach(input => {
        input.addEventListener("change", () => {
            const val = parseInt(input.value);
            if (isNaN(val) || val <= 0) {
                showError("Inserisci una quantità valida (numero maggiore di 0).");
            } else {
                errorBox.innerHTML = "";
            }
        });
    });
});
</script>

>>>>>>> a365fcfeb0018ec9b95aa9c4e6a8aa230cf35c24
</body>
</html>

<%@ include file="footer.jsp" %>
<<<<<<< HEAD
=======
=======
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

>>>>>>> 6c23e22ce354c2340ecf7d1bf4dcb52de023e73a
>>>>>>> a365fcfeb0018ec9b95aa9c4e6a8aa230cf35c24
