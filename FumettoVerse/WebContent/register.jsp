<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Registrazione - FumettoVerse</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/loginelogoutstyle.css">
</head>
<body>

<%@ include file="header.jsp" %>

<h2 style="text-align:center; color: #e60000; margin-top: 30px;">Registrazione</h2>

<div id="errorMessages" style="max-width: 400px; margin: 10px auto;"></div>

<form id="registerForm" class="login-form" action="register" method="post" novalidate>
    <label for="name">Nome</label>
    <input type="text" id="name" name="name" required placeholder="Inserisci il tuo nome">

    <label for="email">Email</label>
    <input type="email" id="email" name="email" required placeholder="Inserisci la tua email">

    <label for="password">Password</label>
    <input type="password" id="password" name="password" required placeholder="Crea una password">

    <button type="submit">Registrati</button>

    <p style="text-align:center; margin-top: 15px;">Hai già un account? 
        <a href="${pageContext.request.contextPath}/login.jsp" style="color: #e60000; font-weight: bold;">Accedi</a>
    </p>
</form>

<%
    String error = request.getParameter("error");
    if ("1".equals(error)) {
%>
    <p style="color:red; text-align:center; font-weight:bold;">Errore durante la registrazione, riprova.</p>
<%
    }
%>



<%@ include file="footer.jsp" %>
<script src="scripts/register.js"></script>
</body>
</html>
