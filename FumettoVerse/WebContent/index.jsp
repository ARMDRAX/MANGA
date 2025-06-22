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

<!-- Inclusione jQuery e script personalizzato -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="scripts/index.js"></script>

<%@ include file="footer.jsp" %>
