<%
	accessLevel = 10
%>
<!-- #INCLUDE FILE = "../inc/security.asp" -->
<!-- #INCLUDE FILE = "../inc/db.asp" -->
<%
	status=request("statusname")
	id=session("reselid")
	'-----------------------------------------------------------------------------
	'Here we are changing the status for the client,the domains under this client
	'must also be dissabled.
	'response.write ucase(status) & "==>" & ucase(lbl521)
	if(ucase(status) = ucase(lbl521)) then

		query="update tblloginmaster set status='1' where id='" & id & "'"
		flag="1"
		con.execute(query)	
		query="select domainid from tbldomain where resellerid='" & id & "'"
		set rs=server.CreateObject("ADODB.Recordset")
		rs.open query,con
		while(not rs.EOF)	
			query="update tblloginmaster set status='1' where id='" & rs("domainid") & "'"
			'response.write query
			con.execute(query)
			rs.movenext
		wend
		rs.close
	else
	    query="update tblloginmaster set status='0' where id='" & id & "'"
		flag="0"
		con.execute(query)
		query="select domainid from tbldomain where resellerid='" & id & "'"
		set rs=server.CreateObject("ADODB.Recordset")
		rs.open query,con
		while(not rs.EOF)	
			query="update tblloginmaster set status='0' where id='" & rs("domainid") & "'"
			'response.write query
			con.execute(query)
			rs.movenext
		wend
		rs.close
	end if
	
	if(flag="1") then
%>	   
	<script language="javascript">
		alert("<%=msgclientsen%>");
		window.location='/clients/clients.asp';
	</script>
<%
	else
%>
	<script language="javascript">
		alert("<%=msgclientdis%>");
		window.location='/clients/clients.asp';
	</script>
<%
	end if
%>