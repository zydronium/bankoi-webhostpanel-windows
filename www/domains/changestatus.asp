<%
accessLevel = 5
%>

<!-- #INCLUDE FILE = "../inc/security.asp" -->
<!-- #INCLUDE FILE = "../inc/db.asp" -->
<!-- #INCLUDE FILE = "../inc/params.asp" -->
<!-- #INCLUDE FILE = "../inc/functions.asp" -->
<%
	
	status=request("status")
	
	if(len(session("id"))=0) then
		id=request("id")
	else
		id=session("id")
	end if
	
	if(len(session("domain"))=0) then
		domainname=request("domain")
	else
		domainname=session("domain")
	end if
	
	'-----------------------------------------------------------------------------
	response.write "<center><font color=""Blue"" size=""6"">" & ucase(domainname) & " is </font><font color=""red""  size=""6"">" & status & "</font></center>"
	
	'-----------------------------------------------------------------------------
	'Here we are changing the status for the selected domain
	if(Ucase(status)=Ucase(lbl521)) then
		call StartIISWebSite (domainname)
		query="update tblloginmaster set status='1' where id='" & id & "'"
		flag="1"
		con.execute(query)	
	else
		'Here we are stopping the selected domain so that the site is no longer accessible to users
		call StopIISWebSite (domainname)
	    query="update tblloginmaster set status='0' where id='" & id & "'"
		'response.write query
		flag="0"
		con.execute(query)
	end if
	
	'---------------------------------------------------------------------------------------------
	'Checking the type and then deciding the navigation of the control
    usertype=session("type")
	'response.write "The type is " & usertype
	if(usertype="a") then
		path="/server/domains.asp"
	else
		path="/domains/clientdomains.asp"
	end if

	if(flag="1") then

%>	   
	<script language="javascript">
		alert("<%=ucase(domainname) & " " & msg30%>");
		window.location='<%=path%>';
	</script>
<%
	else
%>
	<script language="javascript">
		alert("<%=ucase(domainname) & " " & msg31%>");
		window.location='<%=path%>';
	</script>
<%
	end if
%>