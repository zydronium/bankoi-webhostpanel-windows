<%
	accessLevel = 10
%>
<!-- #INCLUDE FILE = "../inc/security.asp" -->
<!-- #INCLUDE FILE="../inc/db.asp" -->
<!-- #INCLUDE FILE="../inc/params.asp" -->
<!-- #INCLUDE FILE="../inc/functions.asp" -->
<html>
<%
'On Error Resume Next
 Call RestartIIS()
 response.redirect("/server/server.asp")
%>
