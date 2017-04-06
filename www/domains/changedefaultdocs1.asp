<%
	accessLevel = 1
%>
<!-- #INCLUDE FILE = "../inc/security.asp" -->
<!-- #INCLUDE FILE = "../inc/db.asp" -->
<!-- #INCLUDE FILE = "../inc/params.asp" -->
<!-- #INCLUDE FILE = "../inc/functions.asp" -->

<%
	Docs= replace(request("docs"),vbCRLF,",")	
	AddDefaultDocs session("domain"),Docs
%>
<SCRIPT>
	alert("<%= msg23 & " " & session("domain")%>");
	window.location="/server/domaininfo.asp";
</SCRIPT>