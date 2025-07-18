<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> a365fcfeb0018ec9b95aa9c4e6a8aa230cf35c24
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, java.util.List" %>
<%@ page import="model.DatabaseConnection" %>
<%@ include file="header.jsp" %>
<<<<<<< HEAD
<%@ page import="jakarta.servlet.http.HttpServletRequest" %>
<html>
<head>
    <title>FumettoVerse - Tutti i fumetti</title>
    <link rel="stylesheet" href="styles/allComics.css">
=======
<%@ include file="footer.jsp" %>

<html>
<head>
    <title>FumettoVerse - Tutti i fumetti</title>
   
    <link rel="stylesheet" href="style/allComics.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
>>>>>>> a365fcfeb0018ec9b95aa9c4e6a8aa230cf35c24
</head>
<body>

<div id="cart-message"></div>

<main>
<<<<<<< HEAD
    <h2 class="container">Tutti i fumetti</h2>
=======
    <h2 class="container" >Tutti i fumetti</h2>
>>>>>>> a365fcfeb0018ec9b95aa9c4e6a8aa230cf35c24
    <div class="comics">
        <%
            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;
            try {
                conn = DatabaseConnection.getConnection();
                String sql = "SELECT * FROM comics";
                stmt = conn.prepareStatement(sql);
                rs = stmt.executeQuery();

                while (rs.next()) {
        %>
<<<<<<< HEAD
            <div class="comic">
                <img src="images/<%= rs.getString("image") %>" alt="<%= rs.getString("title") %>" />
                <h3><%= rs.getString("title") %></h3>
                <p class="price">€ <%= rs.getBigDecimal("price") %></p>
                <form class="add-to-cart-form" data-comic-id="<%= rs.getInt("id") %>">
                    <button type="submit" class="add-to-cart">Aggiungi al carrello</button>
                </form>
            </div>
=======
                    <div class="comic">
                        <img src="images/<%= rs.getString("image") %>" alt="<%= rs.getString("title") %>" />
                        <h3><%= rs.getString("title") %></h3>
                        <p class="price">€ <%= rs.getBigDecimal("price") %></p>
                        <form class="add-to-cart-form" data-comic-id="<%= rs.getInt("id") %>">
                            <button type="submit" class="add-to-cart">Aggiungi al carrello</button>
                        </form>
                    </div>
>>>>>>> a365fcfeb0018ec9b95aa9c4e6a8aa230cf35c24
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            }
        %>
    </div>
</main>

<<<<<<< HEAD
<!-- jQuery e script -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="scripts/allComics.js"></script>

<%@ include file="footer.jsp" %>
</body>
</html>
=======
<script>
$(document).ready(function(){
    $('.add-to-cart-form').submit(function(e){
        e.preventDefault();
        const form = $(this);
        const comicId = form.data('comic-id');

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
=======
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, java.util.List" %>
<%@ page import="com.example.fumettoverse.DatabaseConnection" %>
<%@ include file="navbar.jsp" %>

<html>
<head>
    <title>FumettoVerse - Tutti i fumetti</title>
   
    <link rel="stylesheet" href="style/allComics.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>

<div id="cart-message"></div>

<main>
    <h2 class="container" >Tutti i fumetti</h2>
    <div class="comics">
        <%
            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;
            try {
                conn = DatabaseConnection.getConnection();
                String sql = "SELECT * FROM comics";
                stmt = conn.prepareStatement(sql);
                rs = stmt.executeQuery();

                while (rs.next()) {
        %>
                    <div class="comic">
                        <img src="images/<%= rs.getString("image") %>" alt="<%= rs.getString("title") %>" />
                        <h3><%= rs.getString("title") %></h3>
                        <p class="price">€ <%= rs.getBigDecimal("price") %></p>
                        <form class="add-to-cart-form" data-comic-id="<%= rs.getInt("id") %>">
                            <button type="submit" class="add-to-cart">Aggiungi al carrello</button>
                        </form>
                    </div>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            }
        %>
    </div>
</main>

<script>
$(document).ready(function(){
    $('.add-to-cart-form').submit(function(e){
        e.preventDefault();
        const form = $(this);
        const comicId = form.data('comic-id');

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
>>>>>>> 6c23e22ce354c2340ecf7d1bf4dcb52de023e73a
</html>
>>>>>>> a365fcfeb0018ec9b95aa9c4e6a8aa230cf35c24
