<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.*" %>
<%@ include file="header.jsp" %>

<%
    String authToken = (String) session.getAttribute("authToken");
    if (authToken == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String user = (String) session.getAttribute("user");
%>

<html>
<head>
    <title>I tuoi ordini</title>
    <link rel="stylesheet" href="styles/checkoutstyle.css">
</head>
<body>

<%
    try {
        Connection conn = model.DatabaseConnection.getConnection();

        String sql = "SELECT order_number, payment_method, MAX(total_price) as total_price, MAX(order_date) as order_date " +
                     "FROM orders WHERE user = ? GROUP BY order_number, payment_method ORDER BY order_number DESC";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, user);
        ResultSet rs = stmt.executeQuery();

        boolean hasOrders = false;

        while (rs.next()) {
            hasOrders = true;

            int orderNumber = rs.getInt("order_number");
            String paymentMethod = rs.getString("payment_method");
            double totalPrice = rs.getDouble("total_price");
            Timestamp orderDate = rs.getTimestamp("order_date");
%>

<div class="container">
    <h2>Ordine #<%= orderNumber %></h2>
    <p>Data: <%= orderDate != null ? orderDate.toString() : "Data non disponibile" %></p>
    <p>Metodo di pagamento: <%= paymentMethod %></p>
    <p><strong>Totale ordine: € <%= String.format("%.2f", totalPrice) %></strong></p>
    <h3>Fumetti ordinati:</h3>
    <ul>
        <%
            String comicsSql = "SELECT comic_title, quantity, price_at_purchase " +
                               "FROM orders WHERE user = ? AND order_number = ?";
            PreparedStatement comicsStmt = conn.prepareStatement(comicsSql);
            comicsStmt.setString(1, user);
            comicsStmt.setInt(2, orderNumber);
            ResultSet comicsRs = comicsStmt.executeQuery();

            while (comicsRs.next()) {
                String title = comicsRs.getString("comic_title");
                double priceAtPurchase = comicsRs.getDouble("price_at_purchase");
                int quantity = comicsRs.getInt("quantity");
                double subtotal = priceAtPurchase * quantity;
        %>
                <li>
                    <strong><%= title %></strong>
                    – Quantità: <%= quantity %>
                    – Prezzo unitario: € <%= String.format("%.2f", priceAtPurchase) %>
                    – Subtotale: € <%= String.format("%.2f", subtotal) %>
                </li>
        <%
            }

            comicsRs.close();
            comicsStmt.close();
        %>
    </ul>
    <hr>
</div>

<%
        }

        if (!hasOrders) {
%>
    <div class="no-orders-message">
        <img src="images/ordini.jpg" alt="Nessun ordine" />
        <h3>Non hai ancora effettuato ordini</h3>
        <p>Esplora il nostro catalogo e trova il tuo prossimo fumetto!</p>
        <a href="index.jsp" class="shop-now-btn">Vai allo Shop</a>
    </div>
<%
        }

        rs.close();
        stmt.close();
        conn.close();

    } catch (Exception e) {
        e.printStackTrace();
        out.println("<p>Errore durante il caricamento degli ordini.</p>");
    }
%>

</body>
</html>

<%@ include file="footer.jsp" %>
