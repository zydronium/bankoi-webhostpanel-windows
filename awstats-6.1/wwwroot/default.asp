<%
serverName = request.Servervariables("SERVER_NAME")
if(left(serverName,4)="www.") then serverName= mid(serverName,5)
response.redirect("/webstat/cgi-bin/awstats.pl?config="& serverName)
%>