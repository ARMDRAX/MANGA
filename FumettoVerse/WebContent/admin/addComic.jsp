<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> a365fcfeb0018ec9b95aa9c4e6a8aa230cf35c24
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
    if (isAdmin == null || !isAdmin) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Aggiungi Fumetto</title>
<<<<<<< HEAD
    <link rel="stylesheet" href="<%= request.getContextPath() %>/styles/adminstyle.css">
=======
    <link rel="stylesheet" href="<%= request.getContextPath() %>/style/adminstyle.css">
>>>>>>> a365fcfeb0018ec9b95aa9c4e6a8aa230cf35c24
</head>
<body>

<h2>Aggiungi Nuovo Fumetto</h2>

<div class="form-container">
    <!-- enctype aggiunto per il file upload -->
    <form action="<%= request.getContextPath() %>/admin/addComic" method="post" enctype="multipart/form-data">

        <label for="title">Titolo:</label>
        <input type="text" id="title" name="title" required>

        <label for="price">Prezzo (€):</label>
        <input type="number" id="price" name="price" step="0.01" min="0" required>

        <label for="tipo">Tipo:</label>
        <select id="tipo" name="tipo" required>
            <option value="MANGA">MANGA</option>
            <option value="FUMETTO">FUMETTO</option>
        </select>

        <label for="image">Immagine:</label>
        <input type="file" id="image" name="image" accept="image/*" required>

        <button type="submit">Salva</button>
    </form>

    <a href="catalog.jsp" class="cancel-link">Annulla</a>
</div>

</body>
</html>
<<<<<<< HEAD
=======
=======
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
>>>>>>> 6c23e22ce354c2340ecf7d1bf4dcb52de023e73a
>>>>>>> a365fcfeb0018ec9b95aa9c4e6a8aa230cf35c24
