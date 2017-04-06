<%
	accessLevel = 1
%>
<!-- #INCLUDE FILE = "../inc/security.asp" -->
<!-- #INCLUDE FILE = "../inc/db.asp" -->
<!-- #INCLUDE FILE = "../inc/params.asp" -->
<!-- #INCLUDE FILE = "../inc/functions.asp" -->
<%
    email=request("email")
    password=request("password")
	id=session("id")
	domain=session("domain")

	'-----------------------------------------------------------------------------------
	'Here we are checking the numbere of mail accounts allowed to this domain
	'If the domain exceeds its limit then deny him of making the mail account
	query="select count(mailname) as popcount from tblmailaddress where domainid='" & id & "' and isalias='0'"
	dim rs
	set rs=server.createobject("ADODB.Recordset")
	rs.open query,con
	popcount=rs("popcount")
	set rs=nothing
	
	query="select popmailaccount from tblrights where id='" & id & "'"
	
	set rs=server.createobject("ADODB.Recordset")
	rs.open query,con
	count=rs("popmailaccount")
	rs.close

	'Comparing the two counts if they are equal the deny him of making the account
	if(cint(popcount) >=count) then
%>
	<script>
		alert("<%=msg38%>");
		history.go(-1);
	</script>
<%
	elseif(cint(popcount)<cint(count)) then

    query="select count(mailname) as name from tblmailaddress where mailname='" & email & "' and domainid=" & id
    
	set rs=server.createobject("ADODB.Recordset")
	rs.open query,con
	if(cint(rs("name"))>0) then
		rs.close
%>
	<script>
	alert("<%=msg39%>");
	history.go(-1);
	</script>
<%
	else
		set rsDomain = server.createobject("ADODB.recordset")
		rsDomain.open "select domainname from tbldomain where domainid="& id, con
		if(not rsDomain.eof ) then
			if(ucase(sMailServer)<>"QMAIL") then
				proc = 1
			else
				proc = 0
			end if
			query="insert into tblmailaddress (domainname,  domainid, mailname, mailpass, isalias, actiontype, processed) values ('" & rsDomain("domainname") & "', " & id & ", '" & email & "', '" & password & "', 0, 1, "& proc &")"
			'response.write query
			con.execute(query)
			
			'------------------------------------------------------
			if(ucase(sMailServer)="IMAIL") then
				Call AddImailUser(domain,email,email,password) 
			end if
			'------------------------------------------------------
			If(ucase(sMailServer) = "ME") then
				'Response.write "Creating Mailenable Account"
				call AddMElUser(sMailServerPath,domain, email, password)
			end if
			'------------------------------------------------------
		end if
	end if
%>
<script>
		alert("<%=msg40 & " " & email%>");
		window.location='/domains/mailaccount.asp';
</script>
<%
  end if
%>