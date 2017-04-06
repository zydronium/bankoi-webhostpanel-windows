<%
	accessLevel = 1
%>
<!-- #INCLUDE FILE = "../inc/security.asp" -->
<!-- #INCLUDE FILE = "../inc/db.asp" -->
<!-- #INCLUDE FILE = "../inc/params.asp" -->
<!-- #INCLUDE FILE = "../inc/functions.asp" -->
<%
	hostid=request("hostid")
	id=session("id")
	
	query="delete from tblhostheader where hostheaderid='"& hostid &"' and domainid='" & id & "' and isdefault=0"
	'response.write query
	con.execute query


	query="select hostheader from tblhostheader where domainid='" & id & "'"
	set rs=Server.createObject("ADODB.Recordset")
	rs.open query,con
	i=0
	redim arrNewServerBinding(20)
	while(not rs.eof)
		arrNewServerBinding(i)=rs("hostheader")
		i=i+1
		rs.movenext
	wend
	redim PRESERVE arrNewServerBinding(i-1)

	UpdateHostHeaders arrNewServerBinding, session("domain")
%>
<script>
	alert("<%=msg43%>");
	window.location='hostentries.asp';
</script>