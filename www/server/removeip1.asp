<%
	accessLevel = 10
%>
<!-- #INCLUDE FILE = "../inc/security.asp" -->
<!-- #INCLUDE FILE="../inc/db.asp" -->
<%	
	resellerid=session("reselid")
	'response.write request("ipchk")
	If(len(request("ipchk"))=0) then
%>
	<script>
		alert("<%=msg87%>");
		window.location='assignip.asp';
	</script>
<%
	Else
	ipchk=Split(request("ipchk"),", ")
	Count=0
	For i=Lbound(ipchk) to Ubound(ipchk)
		query="select id from tblserverip where ipaddress='" & Trim(ipchk(i)) & "'"
		'response.write query
		Dim rs1
		set rs1=server.createobject("ADODB.Recordset")
		rs1.open query,con
		ipid=rs1("id")
		rs1.Close

			query="delete from tblresellerip where ipaddress='" & ipid & "' and resellerid='" & session("reselid") & "'"
			'response.write query
			con.execute (query)

			query="update tblserverip set isavailable='Y' where iptype='Exclusive' and id='" & ipid & "'"
	        'response.write query
	        con.execute(query)

			Count=Count+1
	Next
	End IF
%>
<Script>
	if(<%=count%>!=0)
		alert(<%=count%> + " <%=" " & msg88%>");
	else
		alert("<%=msg89%>");
		window.location='assignip.asp';
</Script>
