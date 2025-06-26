<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> a365fcfeb0018ec9b95aa9c4e6a8aa230cf35c24
<%@ page import="java.sql.*, java.text.SimpleDateFormat" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
    if (isAdmin == null || !isAdmin) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    String fromDate = request.getParameter("fromDate");
    String toDate = request.getParameter("toDate");
    String customer = request.getParameter("customer");

    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

    String query = "SELECT o.order_number, o.user, o.comic_id, o.quantity, o.payment_method, o.total_price, o.order_date, c.title " +
                   "FROM orders o JOIN comics c ON o.comic_id = c.id WHERE 1=1 ";

    if (fromDate != null && !fromDate.isEmpty()) query += " AND o.order_date >= '" + fromDate + "'";
    if (toDate != null && !toDate.isEmpty()) query += " AND o.order_date <= '" + toDate + "'";
    if (customer != null && !customer.isEmpty()) query += " AND o.user = '" + customer + "'";

    query += " ORDER BY o.order_date DESC";
%>
<html>
<head>
    <title>Visualizza Ordini</title>
<<<<<<< HEAD
    <link rel="stylesheet" href="<%= request.getContextPath() %>/styles/adminstyle.css">
=======
    <link rel="stylesheet" href="<%= request.getContextPath() %>/style/adminstyle.css">
>>>>>>> a365fcfeb0018ec9b95aa9c4e6a8aa230cf35c24
</head>
<body>

<header>
    <div class="logo">FumettoVerse - Admin</div>
</header>

<div class="container">

    <h2>Storico Ordini</h2>

    <div class="form-container">
        <form method="get" action="orders.jsp">
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
                <th>Metodo Pagamento</th>
                <th>Totale (€)</th>
                <th>Data Ordine</th>
            </tr>

            <%
                try {
                    Connection conn = model.DatabaseConnection.getConnection();
                    Statement stmt = conn.createStatement();
                    ResultSet rs = stmt.executeQuery(query);

                    boolean found = false;

                    while (rs.next()) {
                        found = true;
            %>
            <tr>
                <td><%= rs.getInt("order_number") %></td>
                <td><%= rs.getString("user") %></td>
                <td><%= rs.getString("title") %></td>
                <td><%= rs.getInt("quantity") %></td>
                <td><%= rs.getString("payment_method") %></td>
                <td>€ <%= String.format("%.2f", rs.getDouble("total_price")) %></td>
                <td><%= rs.getDate("order_date") %></td>
            </tr>
            <%
                    }

                    if (!found) {
            %>
            <tr>
                <td colspan="7">Nessun ordine trovato per i criteri selezionati.</td>
            </tr>
            <%
                    }

                    rs.close();
                    stmt.close();
                    conn.close();
                } catch (Exception e) {
            %>
            <tr>
                <td colspan="7">Errore durante il caricamento degli ordini.</td>
            </tr>
            <%
                    e.printStackTrace();
                }
            %>
        </table>
    </div>

    <div class="button-container">
        <a href="admin.jsp" class="add-button">Torna al Pannello Admin</a>
    </div>

</div>

</body>
</html>
<<<<<<< HEAD
=======
=======
<%@ page import="java.sql.*, java.text.SimpleDateFormat" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
    if (isAdmin == null || !isAdmin) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    String fromDate = request.getParameter("fromDate");
    String toDate = request.getParameter("toDate");
    String customer = request.getParameter("customer");

    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

    String query = "SELECT o.order_number, o.user, o.comic_id, o.quantity, o.payment_method, o.total_price, o.order_date, c.title " +
                   "FROM orders o JOIN comics c ON o.comic_id = c.id WHERE 1=1 ";

    if (fromDate != null && !fromDate.isEmpty()) query += " AND o.order_date >= '" + fromDate + "'";
    if (toDate != null && !toDate.isEmpty()) query += " AND o.order_date <= '" + toDate + "'";
    if (customer != null && !customer.isEmpty()) query += " AND o.user = '" + customer + "'";

    query += " ORDER BY o.order_date DESC";

%>
<html>
<head><title>Visualizza Ordini</title></head>
<body>
<h2>Visualizza Ordini</h2>

<form method="get" action="orders.jsp">
    <label>Da data (YYYY-MM-DD):</label>
    <input type="date" name="fromDate" value="<%= fromDate != null ? fromDate : "" %>">

    <label>A data (YYYY-MM-DD):</label>
    <input type="date" name="toDate" value="<%= toDate != null ? toDate : "" %>">

    <label>Cliente:</label>
    <input type="text" name="customer" value="<%= customer != null ? customer : "" %>">

    <button type="submit">Filtra</button>
</form>

<table border="1" cellpadding="5" cellspacing="0">
    <tr>
        <th>Numero Ordine</th><th>Cliente</th><th>Fumetto</th><th>Quantità</th><th>Metodo Pagamento</th><th>Totale (€)</th><th>Data Ordine</th>
    </tr>

<%
    try {
        Connection conn = com.example.fumettoverse.DatabaseConnection.getConnection();
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery(query);

        while (rs.next()) {
%>
            <tr>
                <td><%= rs.getInt("order_number") %></td>
                <td><%= rs.getString("user") %></td>
                <td><%= rs.getString("title") %></td>
                <td><%= rs.getInt("quantity") %></td>
                <td><%= rs.getString("payment_method") %></td>
                <td>€ <%= String.format("%.2f", rs.getDouble("total_price")) %></td>
                <td><%= rs.getDate("order_date") %></td>
            </tr>
<%
        }

        rs.close();
        stmt.close();
        conn.close();
    } catch (Exception e) {
        out.println("<tr><td colspan='7'>Errore caricamento ordini</td></tr>");
        e.printStackTrace();
    }
%>
</table>

<a href="index.jsp">Torna a pannello admin</a>

</body>
</html>
>>>>>>> 6c23e22ce354c2340ecf7d1bf4dcb52de023e73a
>>>>>>> a365fcfeb0018ec9b95aa9c4e6a8aa230cf35c24
