<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> a365fcfeb0018ec9b95aa9c4e6a8aa230cf35c24
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="java.util.List" %>
<%@ page session="true" %>
<%@ include file="header.jsp" %>
<<<<<<< HEAD
=======
<%@ include file="footer.jsp" %>
>>>>>>> a365fcfeb0018ec9b95aa9c4e6a8aa230cf35c24

<html>
<head>
    <title>Comics</title>
<<<<<<< HEAD
    <link rel="stylesheet" href="styles/allComics.css">
=======
    <link rel="stylesheet" href="style/allComics.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
>>>>>>> a365fcfeb0018ec9b95aa9c4e6a8aa230cf35c24
</head>
<body>

<div id="cart-message"></div>

<div class="container">
    <h2>Comics</h2>
    <div class="comics">

    <%
        try {
            Connection conn = model.DatabaseConnection.getConnection();
            String sql = "SELECT * FROM comics WHERE tipo = 'FUMETTO'";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                int id = rs.getInt("id");
                String title = rs.getString("title");
                double price = rs.getDouble("price");
                String image = rs.getString("image");
    %>

    <div class="comic">
        <img src="images/<%= image %>" alt="<%= title %>">
        <h3><%= title %></h3>
        <p class="price">€ <%= rs.getBigDecimal("price") %></p>
        <form class="add-to-cart-form" data-comic-id="<%= id %>">
            <button type="submit" class="add-to-cart">Aggiungi al carrello</button>
        </form>
    </div>

    <%
            }
            rs.close();
            stmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
<<<<<<< HEAD
            out.println("<p>Errore nel caricamento dei comics.</p>");
=======
            out.println("<p>Errore nel caricamento dei manga.</p>");
>>>>>>> a365fcfeb0018ec9b95aa9c4e6a8aa230cf35c24
        }
    %>

    </div>
</div>

<<<<<<< HEAD
<!-- jQuery e script -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="scripts/comics.js"></script>

<%@ include file="footer.jsp" %>
</body>
</html>
=======
<script>
$(document).ready(function(){
    $('.add-to-cart-form').submit(function(e){
        e.preventDefault();
        const comicId = $(this).data('comic-id');

        $.ajax({
            url: 'cart', // Assicurati che questa sia la URL corretta del tuo servlet o endpoint
            type: 'POST',
            data: { comicId: comicId },
            dataType: 'json',
            success: function(response) {
                if(response.success) {
                    // Aggiorna il numero nel carrello nella navbar
                    $('.cart-count').text(response.cartCount).show();

                    $('#cart-message').text('Fumetto aggiunto al carrello!').fadeIn();

                    setTimeout(function(){
                        $('#cart-message').fadeOut();
                    }, 3000);
                } else {
                    alert('Errore: ' + response.message);
                }
            },
            error: function() {
                alert('Errore di comunicazione con il server.');
            }
        });
    });
});
</script>

</body>
</html>
=======
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="java.util.List" %>
<%@ page session="true" %>
<%@ include file="navbar.jsp" %>

<html>
<head>
    <title>Comics</title>
    <link rel="stylesheet" href="style/allComics.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>

<div id="cart-message"></div>

<div class="container">
    <h2>Comics</h2>
    <div class="comics">

    <%
        try {
            Connection conn = com.example.fumettoverse.DatabaseConnection.getConnection();
            String sql = "SELECT * FROM comics WHERE tipo = 'FUMETTO'";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                int id = rs.getInt("id");
                String title = rs.getString("title");
                double price = rs.getDouble("price");
                String image = rs.getString("image");
    %>

    <div class="comic">
        <img src="images/<%= image %>" alt="<%= title %>">
        <h3><%= title %></h3>
        <p class="price">€ <%= rs.getBigDecimal("price") %></p>
        <form class="add-to-cart-form" data-comic-id="<%= id %>">
            <button type="submit" class="add-to-cart">Aggiungi al carrello</button>
        </form>
    </div>

    <%
            }
            rs.close();
            stmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<p>Errore nel caricamento dei manga.</p>");
        }
    %>

    </div>
</div>

<script>
$(document).ready(function(){
    $('.add-to-cart-form').submit(function(e){
        e.preventDefault();
        const comicId = $(this).data('comic-id');

        $.ajax({
            url: 'cart', // Assicurati che questa sia la URL corretta del tuo servlet o endpoint
            type: 'POST',
            data: { comicId: comicId },
            dataType: 'json',
            success: function(response) {
                if(response.success) {
                    // Aggiorna il numero nel carrello nella navbar
                    $('.cart-count').text(response.cartCount).show();

                    $('#cart-message').text('Fumetto aggiunto al carrello!').fadeIn();

                    setTimeout(function(){
                        $('#cart-message').fadeOut();
                    }, 3000);
                } else {
                    alert('Errore: ' + response.message);
                }
            },
            error: function() {
                alert('Errore di comunicazione con il server.');
            }
        });
    });
});
</script>

</body>
</html>
>>>>>>> 6c23e22ce354c2340ecf7d1bf4dcb52de023e73a
>>>>>>> a365fcfeb0018ec9b95aa9c4e6a8aa230cf35c24
