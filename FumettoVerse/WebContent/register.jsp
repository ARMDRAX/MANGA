<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Registrazione - FumettoVerse</title>
    <link rel="stylesheet" href="style/loginelogoutstyle.css">
</head>
<body>
<h2>Registrazione</h2>

<form action="register" method="post">
    <label>Nome:</label><br>
    <input type="text" name="name" required><br>

    <label>Email:</label><br>
    <input type="email" name="email" required><br>

    <label>Password:</label><br>
    <input type="password" name="password" required><br><br>

    <button type="submit">Registrati</button>
</form>

<%
    String error = request.getParameter("error");
    if ("1".equals(error)) {
%>
    <p style="color:red;">Errore durante la registrazione, riprova.</p>
<%
    }
%>

<p>Hai già un account? <a href="login.jsp">Accedi</a></p>
</body>
</html>
