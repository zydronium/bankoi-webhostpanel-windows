<%
accessLevel = 10
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
	
	if(len(session("resellername"))=0) then
		clientname=request("resellername")
	else
		clientname=session("resellername")
	end if
	
	'response.write "The domain name is " & Ucase(lbl521)

	if(ucase(status)=Ucase(lbl521)) then
		query="update tblloginmaster set status='1' where id='" & id & "'"
		'response.write query
		con.execute(query)
	else
		query="update tblloginmaster set status='0' where id='" & id & "'"
		'response.write query
		con.execute(query)
	end if

	query="select * from tbldomain where resellerid='" & id & "'"
	set rsdomainid = Server.CreateObject("ADODB.Recordset")
	rsdomainid.open query,con

	if(rsdomainid.eof) then
		set rsdomainid=nothing
%>
<script>
	alert("<%=msg93%>");
	window.location="../clients/clients.asp";
</script>
<%
	else
	if(ucase(status)=Ucase(lbl521)) then
		statuslbl = Ucase(lbl521)
	else
		statuslbl = Ucase(lbl522)
	end if
	while(not rsdomainid.eof)
			'-----------------------------------------------------------------------------
			response.write "<center><font color=""Blue"" size=""6"">" & ucase(rsdomainid("domainname"))  & " " & lbl710 & " </font><font color=""red""  size=""6"">" & statuslbl & "</font></center>"
			
			'-----------------------------------------------------------------------------
			'Here we are changing the status for the selected domain
			if(Ucase(status)=Ucase(lbl521)) then
				call StartIISWebSite (rsdomainid("domainname"))
				query="update tblloginmaster set status='1' where id='" & rsdomainid("domainid") & "'"
				'response.write query
				flag="1"
				con.execute(query)	
			else
				'Here we are stopping the selected domain so that the site is no longer accessible to users
				call StopIISWebSite (rsdomainid("domainname"))
				query="update tblloginmaster set status='0' where id='" & rsdomainid("domainid") & "'"
				'response.write query
				flag="0"
				con.execute(query)
			end if
			rsdomainid.movenext		
	wend
	'---------------------------------------------------------------------------------------------
	'Checking the type and then deciding the navigation of the control
    usertype=session("type")
	'response.write "The type is " & usertype
	if(usertype="a") then
		path="../clients/clients.asp"
	else
		path="../domains/clientdomains.asp"
	end if

	if(flag="1") then

%>	   
	<script language="javascript">
		alert("<%=msg91%>");
		window.location='<%=path%>';
	</script>
<%
	else
%>
	<script language="javascript">
		alert("<%=msg92%>");
		window.location='<%=path%>';
	</script>
<%
	end if
	end if
%>