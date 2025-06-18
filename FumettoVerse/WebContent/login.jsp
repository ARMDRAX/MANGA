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
