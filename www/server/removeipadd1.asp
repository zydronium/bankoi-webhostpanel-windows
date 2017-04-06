<%
	accessLevel = 10
%>
<!-- #INCLUDE FILE = "../inc/security.asp" -->
<!-- #INCLUDE FILE="../inc/db.asp" -->
<%	
	'Response.write session("Ipdelete")
	If(len(session("Ipdelete"))=0) then
%>
	<script>
		alert("<%=msg87%>");
		window.location='addnewip.asp';
	</script>
<%
	Else
	IpToDelete=Split(session("Ipdelete"),",")
	Count=0
	For i=Lbound(IpToDelete) to Ubound(IpToDelete)
		query="delete from tblserverip where ipaddress='" & Trim(IpToDelete(i)) & "'"
		con.execute (query)
		Count=Count+1
	Next
	End IF
%>
<Script>
	alert(<%=count%> + " <%=" " & msg88%>");
	window.location='addnewip.asp';
</Script>
