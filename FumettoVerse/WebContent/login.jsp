<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> a365fcfeb0018ec9b95aa9c4e6a8aa230cf35c24
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login - FumettoVerse</title>
<<<<<<< HEAD
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/loginelogoutstyle.css">
=======
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style/loginelogoutstyle.css">
>>>>>>> a365fcfeb0018ec9b95aa9c4e6a8aa230cf35c24
</head>
<body>

<%@ include file="header.jsp" %>

<h2 style="text-align:center; color: #e60000; margin-top: 30px;">Login</h2>

<div id="errorMessages" style="max-width: 400px; margin: 10px auto;"></div>

<form id="loginForm" class="login-form" action="${pageContext.request.contextPath}/login" method="post" novalidate>
    <label for="email">Email</label>
    <input type="email" id="email" name="email" required placeholder="Inserisci la tua email">

    <label for="password">Password</label>
    <input type="password" id="password" name="password" required placeholder="Inserisci la tua password">

    <button type="submit">Accedi</button>

    <p style="text-align:center; margin-top: 15px;">Non hai un account? 
        <a href="${pageContext.request.contextPath}/register.jsp" style="color: #e60000; font-weight: bold;">Registrati</a>
    </p>
</form>

<%
    String error = request.getParameter("error");
    if ("1".equals(error)) {
%>
    <p style="color:red; text-align:center; font-weight:bold;">Email o password errati</p>
<%
    }
%>

<<<<<<< HEAD


<%@ include file="footer.jsp" %>
<script src="scripts/login.js"></script>
</body>
</html>
=======
<script>
document.addEventListener("DOMContentLoaded", function() {
    const form = document.getElementById("loginForm");
    const emailInput = document.getElementById("email");
    const passwordInput = document.getElementById("password");
    const errorContainer = document.getElementById("errorMessages");

    function isValidEmail(email) {
        const regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        return regex.test(email);
    }

    function showErrors(errors) {
        errorContainer.innerHTML = "";
        errors.forEach(err => {
            const p = document.createElement("p");
            p.textContent = err;
            p.style.color = "red";
            p.style.textAlign = "center";
            p.style.fontWeight = "bold";
            errorContainer.appendChild(p);
        });
    }

    form.addEventListener("submit", function(event) {
        const errors = [];

        if (!isValidEmail(emailInput.value)) {
            errors.push("Inserisci un indirizzo email valido.");
        }
        if (passwordInput.value.trim() === "") {
            errors.push("Inserisci la password.");
        }

        if (errors.length > 0) {
            event.preventDefault();
            showErrors(errors);
        }
    });

    [emailInput, passwordInput].forEach(input => {
        input.addEventListener("change", function() {
            const errors = [];

            if (input === emailInput && !isValidEmail(emailInput.value)) {
                errors.push("Inserisci un indirizzo email valido.");
            }
            if (input === passwordInput && passwordInput.value.trim() === "") {
                errors.push("Inserisci la password.");
            }

            if (errors.length > 0) {
                showErrors(errors);
            } else {
                errorContainer.innerHTML = "";
            }
        });
    });
});
</script>

<%@ include file="footer.jsp" %>
</body>
</html>
=======
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login - FumettoVerse</title>
    <link rel="stylesheet" href="style/loginelogoutstyle.css">
</head>
<body>
<h2>Login</h2>

<form action="${pageContext.request.contextPath}/login" method="post">
    <label>Email:</label><br>
    <input type="email" name="email" required><br>

    <label>Password:</label><br>
    <input type="password" name="password" required><br><br>

    <button type="submit">Login</button>
</form>

<%
    String error = request.getParameter("error");
    if ("1".equals(error)) {
%>
    <p style="color:red;">Email o password errati</p>
<%
    }
%>

<p>Non hai un account? <a href="${pageContext.request.contextPath}/register.jsp">Registrati</a></p>
</body>
</html>
>>>>>>> 6c23e22ce354c2340ecf7d1bf4dcb52de023e73a
>>>>>>> a365fcfeb0018ec9b95aa9c4e6a8aa230cf35c24
