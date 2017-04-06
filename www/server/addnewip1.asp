<%
	accessLevel = 10
%>
<!-- #INCLUDE FILE = "../inc/security.asp" -->
<!-- #INCLUDE FILE="../inc/db.asp" -->
<%
	ipaddress=request("ipaddress")
	iptype=request("iptype")

	query="select count(*) as ipcount from tblserverip where ipaddress='" & ipaddress & "'"
	dim rsiptype
	set rsiptype=server.createobject("ADODB.Recordset")
	rsiptype.open query,con
	count=rsiptype("ipcount")

	if(cint(count)>0) then
	set rsiptype=Nothing
%>
	<SCRIPT>
		alert("<%=msgchooseip%>");
		history.go(-1);
	</SCRIPT>
<%
	else
	query="insert into tblserverip (ipaddress,iptype) values('" & ipaddress & "','" & iptype & "')"
	'response.write query
	con.execute (query)
	end if
%>
	<SCRIPT>
		alert("<%=msgipadd%>");
		window.location="addnewip.asp";
	</SCRIPT>