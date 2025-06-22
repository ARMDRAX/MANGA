<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> a365fcfeb0018ec9b95aa9c4e6a8aa230cf35c24
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.*" %>
<%@ include file="header.jsp" %>
<<<<<<< HEAD
=======
<%@ include file="footer.jsp" %>
>>>>>>> a365fcfeb0018ec9b95aa9c4e6a8aa230cf35c24

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
<<<<<<< HEAD
    <link rel="stylesheet" href="styles/checkoutstyle.css">
=======
    <link rel="stylesheet" href="style/checkoutstyle.css">
    
>>>>>>> a365fcfeb0018ec9b95aa9c4e6a8aa230cf35c24
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
<<<<<<< HEAD
            String comicsSql = "SELECT comic_title, quantity, price_at_purchase " +
                               "FROM orders WHERE user = ? AND order_number = ?";
=======
            String comicsSql = "SELECT comics.title, comics.price, orders.quantity " +
                               "FROM orders JOIN comics ON orders.comic_id = comics.id " +
                               "WHERE orders.user = ? AND orders.order_number = ?";
>>>>>>> a365fcfeb0018ec9b95aa9c4e6a8aa230cf35c24
            PreparedStatement comicsStmt = conn.prepareStatement(comicsSql);
            comicsStmt.setString(1, user);
            comicsStmt.setInt(2, orderNumber);
            ResultSet comicsRs = comicsStmt.executeQuery();

            while (comicsRs.next()) {
<<<<<<< HEAD
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
=======
                String title = comicsRs.getString("title");
                double price = comicsRs.getDouble("price");
                int quantity = comicsRs.getInt("quantity");
        %>
                <li><strong><%= title %></strong> - Quantità: <%= quantity %> - Prezzo unitario: € <%= String.format("%.2f", price) %></li>
>>>>>>> a365fcfeb0018ec9b95aa9c4e6a8aa230cf35c24
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
<<<<<<< HEAD
    <div class="no-orders-message">
        <img src="images/ordini.jpg" alt="Nessun ordine" />
        <h3>Non hai ancora effettuato ordini</h3>
        <p>Esplora il nostro catalogo e trova il tuo prossimo fumetto!</p>
        <a href="index.jsp" class="shop-now-btn">Vai allo Shop</a>
    </div>
=======
    <p>Nessun ordine</p>
>>>>>>> a365fcfeb0018ec9b95aa9c4e6a8aa230cf35c24
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
<<<<<<< HEAD

<%@ include file="footer.jsp" %>
=======
=======
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.*" %>
<%@ include file="navbar.jsp" %>

<html>
<head>
    <title>I tuoi ordini</title>
    <link rel="stylesheet" href="style/checkoutstyle.css">
    <link rel="stylesheet" href="style/navbar.css">
</head>
<body>

<%
     user = (String) session.getAttribute("user");

    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    try {
        Connection conn = com.example.fumettoverse.DatabaseConnection.getConnection();

        // Recupera gli ordini con la data (supponendo che nella tabella ci sia la colonna order_date)
        String sql = "SELECT order_number, payment_method, MAX(total_price) as total_price, MAX(order_date) as order_date " +
                     "FROM orders WHERE user = ? GROUP BY order_number, payment_method ORDER BY order_number DESC";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, user);
        ResultSet rs = stmt.executeQuery();

        while (rs.next()) {
            int orderNumber = rs.getInt("order_number");
            String paymentMethod = rs.getString("payment_method");
            double totalPrice = rs.getDouble("total_price");
            Timestamp orderDate = rs.getTimestamp("order_date"); // Assumiamo che la colonna sia di tipo TIMESTAMP
%>

<div class="container">
    <h2>Ordine #<%= orderNumber %></h2>
    <p>Data: <%= orderDate != null ? orderDate.toString() : "Data non disponibile" %></p>
    <p>Metodo di pagamento: <%= paymentMethod %></p>
    <p><strong>Totale ordine: € <%= String.format("%.2f", totalPrice) %></strong></p>
    <h3>Fumetti ordinati:</h3>
    <ul>
        <%
            // Recupera i fumetti e le quantità di questo ordine
            String comicsSql = "SELECT comics.title, comics.price, orders.quantity " +
                               "FROM orders JOIN comics ON orders.comic_id = comics.id " +
                               "WHERE orders.user = ? AND orders.order_number = ?";
            PreparedStatement comicsStmt = conn.prepareStatement(comicsSql);
            comicsStmt.setString(1, user);
            comicsStmt.setInt(2, orderNumber);
            ResultSet comicsRs = comicsStmt.executeQuery();

            while (comicsRs.next()) {
                String title = comicsRs.getString("title");
                double price = comicsRs.getDouble("price");
                int quantity = comicsRs.getInt("quantity");
        %>
                <li><strong><%= title %></strong> - Quantità: <%= quantity %> - Prezzo unitario: € <%= String.format("%.2f", price) %></li>
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
>>>>>>> 6c23e22ce354c2340ecf7d1bf4dcb52de023e73a
>>>>>>> a365fcfeb0018ec9b95aa9c4e6a8aa230cf35c24
