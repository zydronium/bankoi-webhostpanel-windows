<%
	accessLevel = 1
%>
<!-- #INCLUDE FILE = "../inc/security.asp" -->
<!-- #INCLUDE FILE = "../inc/db.asp" -->
<!-- #INCLUDE FILE = "../inc/params.asp" -->
<!-- #INCLUDE FILE = "../inc/functions.asp" -->
<%
	dirname=request("path")
	writePerm=request("write")
	domainname=session("domain")
	id=session("id")
	
	dim userHostDir : userHostDir = sHostingDir & "\" & session("resellername") & "\" & session("ftpuser")
	
	path=userHostDir & "\" & dirname
	'response.write writePerm


	SetWritePermission path, writePerm

%>
	<script>
		alert("<%=msg90 & " " & dirname%> ");
		window.location='/domains/permexplorer.asp';
	</script>
