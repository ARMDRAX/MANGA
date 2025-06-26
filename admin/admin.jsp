<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
    if (isAdmin == null || !isAdmin) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>
<html>
<head>
    <title>Admin Panel</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/styles/adminstyle.css">
    
</head>
<body>

<header>
    <div class="logo">FumettoVerse Admin</div>
</header>

<h2>Benvenuto Admin</h2>


<div class="admin-image-container">
    <img src="<%= request.getContextPath() %>/images/admin.jpg" alt="Benvenuto Admin">
</div>

<nav>
    <ul>
        <li><a href="<%= request.getContextPath() %>/admin/catalog">Gestione Catalogo</a></li>
<li><a href="<%= request.getContextPath() %>/admin/orders">Visualizza Ordini</a></li>
<li><a href="<%= request.getContextPath() %>/logout">Logout Admin</a></li>

    </ul>
</nav>

</body>
</html>
