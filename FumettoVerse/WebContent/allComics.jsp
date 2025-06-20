<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, java.util.List" %>
<%@ page import="model.DatabaseConnection" %>
<%@ include file="header.jsp" %>
<%@ include file="footer.jsp" %>

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
</html>