<<<<<<< HEAD
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Registrazione - FumettoVerse</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style/loginelogoutstyle.css">
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

<script>
document.addEventListener("DOMContentLoaded", function() {
    const form = document.getElementById("registerForm");
    const nameInput = document.getElementById("name");
    const emailInput = document.getElementById("email");
    const passwordInput = document.getElementById("password");
    const errorContainer = document.getElementById("errorMessages");

    function isValidEmail(email) {
        const regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        return regex.test(email);
    }

    function isValidPassword(password) {
        const regex = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$/;
        return regex.test(password);
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

        if (nameInput.value.trim() === "") {
            errors.push("Il nome è obbligatorio.");
        }
        if (!isValidEmail(emailInput.value)) {
            errors.push("Inserisci un indirizzo email valido.");
        }
        if (!isValidPassword(passwordInput.value)) {
            errors.push("La password deve essere lunga almeno 8 caratteri e contenere almeno una lettera e un numero.");
        }

        if (errors.length > 0) {
            event.preventDefault();
            showErrors(errors);
        }
    });

    [nameInput, emailInput, passwordInput].forEach(input => {
        input.addEventListener("change", function() {
            const errors = [];

            if (input === nameInput && nameInput.value.trim() === "") {
                errors.push("Il nome è obbligatorio.");
            }
            if (input === emailInput && !isValidEmail(emailInput.value)) {
                errors.push("Inserisci un indirizzo email valido.");
            }
            if (input === passwordInput && !isValidPassword(passwordInput.value)) {
                errors.push("La password deve essere lunga almeno 8 caratteri e contenere almeno una lettera e un numero.");
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
>>>>>>> 6c23e22ce354c2340ecf7d1bf4dcb52de023e73a
