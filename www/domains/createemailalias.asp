<%
	accessLevel = 1
%>
<!-- #INCLUDE FILE = "../inc/security.asp" -->
<!-- #INCLUDE FILE = "../inc/db.asp" -->
<!-- #INCLUDE FILE = "../inc/params.asp" -->
<!-- #INCLUDE FILE = "../inc/functions.asp" -->

<%
	aliasname=request("aliasname")
	redirectadd=request("redirectadd")
	id=session("id")
	domainname=session("domain")
	'-----------------------------------------------------------------------------------
	'Here we are checking the numbere of emailalias allowed to this domain
	'If the domain exceeds its limit then deny him of making the emailalias
	query="select count(mailname) as aliascount from tblmailaddress where domainid='" & id & "'and isalias='1' and actiontype!='0'"
	dim rs
	set rs=server.createobject("ADODB.Recordset")
	rs.open query,con
	aliascount=rs("aliascount")
	set rs=nothing
	
	query="select emailalias from tblrights where id='" & id & "'"
	
	set rs=server.createobject("ADODB.Recordset")
	rs.open query,con
	count=rs("emailalias")
	rs.close

	'Comparing the two counts if they are equal the deny him of making the account
	if(cint(aliascount)>=(count)) then
%>
	<script>
		alert("<%=msg34%>");
		history.go(-1);
	</script>
<%
	elseif(cint(aliascount)<cint(count)) then

	query="select count(mailname) as flag from tblmailaddress where mailname='" & aliasname & "' and domainid=" & id
	rs.open query,con
	if(cint(rs("flag"))>0) then
		rs.close
%>
	<script>
		alert("<%=msg35%>");
		history.go(-1);
	</script>
<%
    else
		query="insert into tblmailaddress set isalias='1' ,actiontype='1',processed='0',domainid='" & id & "',mailname='" & aliasname & "',redirectadd='" & redirectadd & "',domainname='" & domainname & "'"
		con.execute(query)
		if(ucase(sMailServer)="IMAIL") then
			call AddImailAlias(domainname, aliasname, redirectadd) 
		end if

		if(ucase(sMailServer)="ME") then
			call CreateAlias(domainname, aliasname, redirectadd)
		end if
		
%>
	<script>
		alert("<%=lbl720 & " " & saliasname & " " & lbl721%>");
		window.location='/domains/emailalias.asp';
	</script>
<%
	end if
	end if
%>