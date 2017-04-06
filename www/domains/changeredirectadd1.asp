<%
	accessLevel = 1
%>
<!-- #INCLUDE FILE = "../inc/security.asp" -->
<!-- #INCLUDE FILE = "../inc/db.asp" -->
<!-- #INCLUDE FILE = "../inc/params.asp" -->
<!-- #INCLUDE FILE = "../inc/functions.asp" -->
<%
	redirectadd=request("redirectadd")
	alias=request("alias")
	domainname=session("domain")
	query="select * from tblmailaddress where mailname='" & alias & "'"
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.open query,con

	if(rs.eof) then
%>
<Script>
	alert("<%=msg28%>");
	window.location="/domains/emailalias.asp";
</script>
<%
	else
		query="update tblmailaddress set redirectadd='" & redirectadd & "',actiontype=2,processed='0' where mailname='" & alias & "'"
		con.execute query
		if(ucase(sMailServer)="IMAIL") then
			call ModifyImailAlias(domainname, alias, redirectadd) 
		end if

		if(ucase(sMailServer)="ME") then
			call ChangeRedirectAdd(domainname, alias, redirectadd) 
		end if
%>
<Script>
	alert("<%=msg29%>");
	window.location="/domains/emailalias.asp";
</script>
<%
	end if
%>