<%@ page import="java.util.List" %>
<%
    String token = (String) session.getAttribute("authToken");
    String role = (String) session.getAttribute("role");
    String userName = (String) session.getAttribute("user");
    List<Integer> cart = (List<Integer>) session.getAttribute("cart");
    int cartSize = (cart != null) ? cart.size() : 0;
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>FumettoVerse</title>
<<<<<<< HEAD
    <link rel="stylesheet" href="styles/common.css">
    <link rel="stylesheet" href="styles/homepage.css">
=======
    <link rel="stylesheet" href="style/common.css">
    <link rel="stylesheet" href="style/homepage.css">
>>>>>>> a365fcfeb0018ec9b95aa9c4e6a8aa230cf35c24
</head>
<body>
<header>
    <div class="logo">FumettoVerse</div>
    <div class="user-links">
        <% if (token == null) { %>
            <a href="login.jsp" class="header-link">Login</a>
            <a href="register.jsp" class="header-link">Registrati</a>
        <% } else { %>
            <span class="welcome-text">Ciao, <%= userName %>!</span>
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
    <% if ("admin".equals(role)) { %>
        <a href="admin/admin.jsp">Gestione catalogo</a>
    <% } %>
</nav>
