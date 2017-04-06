<%
	session("NTuser")=request("name")
	response.redirect("../domains/editntuser.asp")
%>