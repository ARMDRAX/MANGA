<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> a365fcfeb0018ec9b95aa9c4e6a8aa230cf35c24
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.List" %>
<%@ page import="model.DatabaseConnection" %>
<%@ include file="header.jsp" %>

<div id="cart-message"></div>

<!-- AGGIUNTA CLASSE index-page -->
<div class="container index-page">
   <div class="hero-section">
      <img src="images/home.jpg" alt="Benvenuto su FumettoVerse" />
      <div class="welcome-overlay">Benvenuto!</div>
   </div>

   <h2 class="consigliati-title">I migliori</h2>

   <div class="comics">
       <%
           Connection conn = null;
           PreparedStatement stmt = null;
           ResultSet rs = null;

           try {
               conn = DatabaseConnection.getConnection();
               String sql = "SELECT * FROM comics LIMIT 4";
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
</div>

<<<<<<< HEAD
<!-- Inclusione jQuery e script personalizzato -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="scripts/index.js"></script>

<%@ include file="footer.jsp" %>
=======
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function(){
    $('.add-to-cart-form').submit(function(e){
        e.preventDefault();
        const form = $(this);
        const comicId = form.data('comic-id');

        $.ajax({
            url: 'cart',
            type: 'POST',
            data: { comicId: comicId },
            success: function(response) {
                if(response.success) {
                    $('.cart-count').text(response.cartCount).show();
                    $('#cart-message').text('Fumetto aggiunto al carrello!').fadeIn();
                    setTimeout(function(){ $('#cart-message').fadeOut(); }, 3000);
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

<%@ include file="footer.jsp" %>
=======
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.fumettoverse.DatabaseConnection" %>
<%@ include file="navbar.jsp" %>

<html>
<head>
    <title>FumettoVerse - Home</title>
    <link rel="stylesheet" href="style/homepage.css">
    <link rel="stylesheet" href="style/navbar.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>

<div id="cart-message"></div>

<div class="container">

   <div class="hero-section">
    <img src="images/home.jpg" alt="Benvenuto su FumettoVerse" />
    <div class="welcome-overlay">Benvenuto!</div>
</div>
    <h2 class="consigliati-title">Consigliati per te</h2>


    <div class="comics">
        <%
            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;

            try {
                conn = DatabaseConnection.getConnection();
                String sql = "SELECT * FROM comics LIMIT 4";
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
</div>

<script>
$(document).ready(function(){
    $('.add-to-cart-form').submit(function(e){
        e.preventDefault();
        const form = $(this);
        const comicId = form.data('comic-id');

        $.ajax({
            url: 'cart',
            type: 'POST',
            data: { comicId: comicId },
            success: function(response) {
                if(response.success) {
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
