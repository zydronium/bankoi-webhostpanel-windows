<%
	accessLevel = 1
%>
<!-- #INCLUDE FILE="../inc/db.asp" -->
<!-- #INCLUDE FILE = "../inc/params.asp" -->
<!-- #INCLUDE FILE = "../inc/functions.asp" -->
<!-- #INCLUDE FILE = "../inc/security.asp" -->

<%
	mailacc=request("mail")
	pass=request("password")
	old_pass=request("old_passwd")
	domain=session("domain")
	
	if(ucase(session("type"))="M") then
			query="select mailpass,domainid from tblmailaddress where mailname='" & mailacc & "'"
			dim rspass
			set rspass=server.createobject("ADODB.Recordset")
			rspass.open query,con
			if(not old_pass=rspass("mailpass")) then
%>
					<script>
						alert("<%=msg26%>");
						history.go(-1);
					</script>

<%
					response.end
			end if
	end if
	'domId = 
	'query="update tblmailaddress set mailpass='" & pass & "' ,actiontype='2',processed='0' where mailname='" & mailacc & "'"
	
if(ucase(sMailServer) = "IMAIL") then
		call ModifyImailUser(domain,mailacc,mailacc,pass) 
		query="update tblmailaddress set mailpass='" & pass & "' ,actiontype='2' where mailname='" & mailacc & "' and domainname='"& domain & "'"
	elseif(ucase(sMailServer) = "ME") then
		call ChangeMElPassword(domain, mailacc, pass)
		query="update tblmailaddress set mailpass='" & pass & "' ,actiontype='2' where mailname='" & mailacc & "' and domainname='"& domain & "'"
	else
		query="update tblmailaddress set mailpass='" & pass & "' ,actiontype='2',processed='0' where mailname='" & mailacc & "' and domainname='"& domain & "'"
	end if
	'response.write query
	con.execute(query)
%>

<script>
	alert("<%=msg27%>");
	window.location="/domains/mailaccount.asp"
</script>