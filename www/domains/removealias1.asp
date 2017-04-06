<%
	accessLevel = 1
%>
<!-- #INCLUDE FILE = "../inc/security.asp" -->
<!-- #INCLUDE FILE = "../inc/db.asp" -->
<!-- #INCLUDE FILE = "../inc/params.asp" -->
<!-- #INCLUDE FILE = "../inc/functions.asp" -->

<%
dim address,count
count=0
id=session("id")
domainname=session("domain")
alias=split(request("alias"),",")
for i=lbound(alias) to ubound(alias)
	'-----------------------------------------------------------------------------------
	'Deleting the email aliases from the table tblmailaddress
	query="update tblmailaddress set actiontype='0',processed='0'  where mailname='" & trim(alias(i)) & "' and domainid=" & id

	if(ucase(sMailServer)="IMAIL") then
		call DeleteImailAlias(domainname, trim(alias(i))) 
		query="delete from  tblmailaddress  where mailname='" & trim(alias(i)) & "' and domainid=" & id
	end if

	if(ucase(sMailServer)="ME") then
		call RemoveMElUser(domainname, trim(alias(i))) 
		query="delete from  tblmailaddress  where mailname='" & trim(alias(i)) & "' and domainid=" & id
	end if

	con.execute(query)
	count=count+1
	
next 
%>
<script>
	alert("<%=count & " " & msg60%>")
	window.location="/domains/emailalias.asp"
</script>