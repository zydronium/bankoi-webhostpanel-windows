<%
	accessLevel = 0
%>

<!-- #INCLUDE FILE="../inc/db.asp" -->
<!-- #INCLUDE FILE = "../inc/params.asp" -->
<!-- #INCLUDE FILE = "../inc/functions.asp" -->
<!-- #INCLUDE FILE = "../inc/security.asp" -->

<%
		domain = session("maildomain")
		mailacc = session("userid")
		old_Pass = Request("old_passwd")
		new_Pass = Request("password")

		if(ucase(session("type")) = "M") then
			query="select mailpass,domainid from tblmailaddress where mailname='" & mailacc & "'"
			dim rspass
			set rspass=server.createobject("ADODB.Recordset")
			rspass.open query,con
			if(not old_Pass = rspass("mailpass")) then
%>
					<script>
						alert("<%=msg26%>");
						location.replace("mailaccount.asp");
					</script>

<%
					response.end
			else		


					if(ucase(sMailServer) = "IMAIL") then
						call ModifyImailUser(domain,mailacc,mailacc,pass) 
						query="UPDATE tblmailaddress SET mailpass='" & new_Pass & "' ,actiontype='2' where mailname='" & mailacc & "' and domainname='"& domain & "'"
					elseif(ucase(sMailServer) = "ME") then
						call ChangeMElPassword(domain, mailacc, pass)
						query="UPDATE tblmailaddress SET mailpass='" & new_Pass & "' ,actiontype='2' where mailname='" & mailacc & "' and domainname='"& domain & "'"
					else
						query="UPDATE tblmailaddress SET mailpass='" & new_Pass & "' ,actiontype='2',processed='0' where mailname='" & mailacc & "' and domainname='"& domain & "'"
					end if
					con.execute(query)
%>

<script>
	alert("<%=msg27%>");
	window.location="/mailuser/mailaccount.asp"
</script>

<%
			end if
		end if
%>