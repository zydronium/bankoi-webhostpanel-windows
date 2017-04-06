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
domain=session("domain")
address=split(request("emails"),",")
for i=lbound(address) to ubound(address)
	'-----------------------------------------------------------------------------------
	query="select * from tblmailaddress where mailname='" & trim(address(i)) & "'"
	dim rs
	set rs=server.createobject("ADODB.Recordset")
	rs.open query,con
	domainid=rs("domainid")
	password=rs("mailpass")
	email=rs("mailname")
	
	set rsDomain = server.createobject("ADODB.recordset")
	rsDomain.open "select domainname from tbldomain where domainid="& id, con
	if(not rsDomain.eof ) then
		query="update tblmailaddress set actiontype='0',processed='0' where mailname='" & trim(address(i)) & "' and domainid=" & id
		'response.write query
		
		if(ucase(sMailServer)="IMAIL") then
			call DeleteImailUser(domain,trim(address(i)))
			query="delete from tblmailaddress where mailname='" & trim(address(i)) & "' and domainid=" & id
		end if

		if(ucase(sMailServer)="ME") then
			call RemoveMElUser(domain, trim(address(i)))
			query="delete from tblmailaddress where mailname='" & trim(address(i)) & "' and domainid=" & id
			'response.write query
		end if

		
		con.execute(query)
	end if
	count=count+1
	set rs=nothing
	set rsDomain=nothing
next 
%>
<script>
	alert("Total <%=count & msg67%>")
	window.location="/domains/mailaccount.asp"
</script>