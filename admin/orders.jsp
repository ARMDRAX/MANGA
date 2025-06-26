<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Order" %>
<%@ page import="model.OrderItem" %>
<%
    
    Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
    if (isAdmin == null || !isAdmin) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    String fromDate = (String) request.getAttribute("fromDate");
    String toDate = (String) request.getAttribute("toDate");
    String customer = (String) request.getAttribute("customer");
    List<Order> orders = (List<Order>) request.getAttribute("orders");
    Boolean error = (Boolean) request.getAttribute("error");
%>

<html>
<head>
    <title>Visualizza Ordini</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/styles/adminstyle.css">
</head>
<body>

<header>
    <div class="logo">FumettoVerse - Admin</div>
</header>

<div class="container">

    <h2>Storico Ordini</h2>

    <div class="form-container">
        <form method="get" action="<%= request.getContextPath() %>/admin/orders">
            <label>Da data:</label>
            <input type="date" name="fromDate" value="<%= fromDate != null ? fromDate : "" %>">

            <label>A data:</label>
            <input type="date" name="toDate" value="<%= toDate != null ? toDate : "" %>">

            <label>Cliente:</label>
            <input type="text" name="customer" placeholder="Inserisci username" value="<%= customer != null ? customer : "" %>">

            <button type="submit">Filtra</button>
        </form>
    </div>

    <div class="catalog-table-container">
        <table class="catalog-table">
            <tr>
                <th>Numero Ordine</th>
                <th>Cliente</th>
                <th>Fumetto</th>
                <th>Quantità</th>
                <th>Prezzo (€)</th>
                <th>Subtotale (€)</th>
                <th>Metodo Pagamento</th>
                <th>Totale Ordine (€)</th>
                <th>Data Ordine</th>
            </tr>

            <%
                if (error != null && error) {
            %>
            <tr><td colspan="9">Errore durante il caricamento degli ordini.</td></tr>
            <%
                } else if (orders == null || orders.isEmpty()) {
            %>
            <tr><td colspan="9">Nessun ordine trovato per i criteri selezionati.</td></tr>
            <%
                } else {
                    for (Order order : orders) {
                        for (OrderItem item : order.getItems()) {
                            double subtotal = item.getQuantity() * item.getPrice();
            %>
            <tr>
                <td><%= order.getOrderNumber() %></td>
                <td><%= order.getUser() %></td>
                <td><%= item.getTitle() %></td>
                <td><%= item.getQuantity() %></td>
                <td>€ <%= String.format("%.2f", item.getPrice()) %></td>
                <td>€ <%= String.format("%.2f", subtotal) %></td>
                <td><%= order.getPaymentMethod() %></td>
                <td>€ <%= String.format("%.2f", order.getTotalPrice()) %></td>
                <td><%= order.getOrderDate() %></td>
            </tr>
            <%
                        }
                    }
                }
            %>
        </table>
    </div>

    <div class="button-container">
       <a href="<%= request.getContextPath() %>/admin/admin.jsp" class="action-button">
           Torna al pannello admin
       </a>
    </div> 

</div>

</body>
</html>
