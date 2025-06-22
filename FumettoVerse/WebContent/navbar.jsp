<%@ page import="java.util.List" %>
<%
    String user = (String) session.getAttribute("user");
    List<Integer> cart = (List<Integer>) session.getAttribute("cart");
    int cartSize = (cart != null) ? cart.size() : 0;
%>
<link rel="stylesheet" href="style/navbar.css">
<header>
    <div class="logo">FumettoVerse</div>
    <div class="user-links">
        <% if (user == null) { %>
            <a href="login.jsp" class="header-link">Login</a>
            <a href="register.jsp" class="header-link">Registrati</a>
        <% } else { %>
            <span class="welcome-text">Ciao, <%= user %>!</span>
            <a href="logout" class="header-link">Logout</a>
        <% } %>
        <a href="cart.jsp" class="header-link cart-container">
           <img src="images/carrello.jpg" alt="Carrello" class="cart-icon" style="width: 60px; height: auto;" />

            <span class="cart-count"><%= cartSize %></span>
        </a>
    </div>
</header>

<nav class="nav-bar">
    <a href="index.jsp">Home</a>
    <a href="allComics.jsp">Tutti i fumetti</a>
    <a href="manga.jsp">Manga</a>
    <a href="comics.jsp">Comics</a>
    <a href="myorders.jsp">I miei ordini</a>
   
</nav>