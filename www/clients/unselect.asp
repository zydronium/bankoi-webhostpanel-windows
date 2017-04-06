<%
if(ucase(session("type")) = "A") then session.Contents.Remove("reselid")
  response.redirect("/server/domains.asp")
%>