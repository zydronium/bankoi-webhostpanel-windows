<%
lang = session("lang")
session.abandon
response.redirect("/setlang.asp?lang="& lang)
%>