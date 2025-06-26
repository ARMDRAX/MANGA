<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, model.Comic" %>
<%
   
    Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");
    if (isAdmin == null || !isAdmin) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    List<Comic> comics = (List<Comic>) request.getAttribute("comics");
%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Gestione Catalogo</title>
    <link rel="stylesheet"
          href="<%= request.getContextPath() %>/styles/adminstyle.css">
</head>
<body>

<h2>Catalogo Fumetti</h2>

<% if ("1".equals(request.getAttribute("deleted"))) { %>
<div class="success-message" id="delete-msg">
    ✅ Fumetto eliminato con successo.
</div>
<% } %>

<% if ("1".equals(request.getParameter("added"))) { %>
    <div class="success-message">✅ Fumetto aggiunto con successo.</div>
<% } %>

<div class="button-container">
    <a href="<%= request.getContextPath() %>/admin/addComic.jsp"
       class="action-button">Aggiungi Nuovo Fumetto</a>
</div>

<div class="catalog-table-container">
    <table class="catalog-table">
        <tr>
            <th>ID</th><th>Titolo</th><th>Prezzo</th><th>Azioni</th>
        </tr>

        <%  if (comics == null || comics.isEmpty()) { %>
        <tr><td colspan="4">Nessun fumetto presente.</td></tr>
        <%  } else {
                for (Comic c : comics) { %>
        <tr>
            <td><%= c.getId() %></td>
            <td><%= c.getTitle() %></td>
            <td>€ <%= String.format("%.2f", c.getPrice()) %></td>
            <td>
                <a href="<%= request.getContextPath()
                          %>/admin/editComic?id=<%= c.getId() %>"
                   class="action-button">Modifica</a>

                <a href="<%= request.getContextPath()
                          %>/admin/deleteComic?id=<%= c.getId() %>"
                   class="action-button">Cancella</a>
            </td>
        </tr>
        <%      }
            } %>
    </table>
</div>

<div class="button-container" style="margin-top:20px;">
   <a href="<%= request.getContextPath() %>/admin/admin.jsp" class="action-button">
    Torna a pannello admin
</a>

</div>

<script>
window.addEventListener("DOMContentLoaded", () => {
    const msgs = [document.getElementById("delete-msg"), document.getElementById("add-msg")];

    msgs.forEach(msg => {
        if (msg) {
            setTimeout(() => {
                msg.style.opacity = '0';
                setTimeout(() => msg.remove(), 500);
            }, 3000);
        }
    });
});
</script>
</body>
</html>
