<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Boolean isAdmin = (Boolean) session.getAttribute("admin");
    if (isAdmin == null || !isAdmin) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>

<html>
<head><title>Aggiungi Fumetto</title></head>
<body>
<h2>Aggiungi Nuovo Fumetto</h2>

<form action="addComic" method="post">
    <label>Titolo:</label><br>
    <input type="text" name="title" required><br><br>

    <label>Prezzo (€):</label><br>
    <input type="number" name="price" step="0.01" min="0" required><br><br>

    <button type="submit">Salva</button>
</form>

<a href="catalog.jsp">Annulla</a>
</body>
</html>
