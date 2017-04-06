<%
accessLevel = 10
%>

<!-- #INCLUDE FILE = "../inc/security.asp" -->
<!-- #INCLUDE FILE="../inc/db.asp" -->
<!-- #INCLUDE FILE="../inc/functions.asp" -->

<%
	resellerid = session("reselid")

	if(Len(resellerid) = 0) then
%>
<script>
				alert("<%=msg120%>");
				window.location = "/clients/clients.asp";
</script>
<%	
				Response.End
		End if


	if(len(request("chkEntries"))=0) then
%>
		<script>
			alert("<%=msg113%>");
			window.location = "/clients/ClientDnsTemplate.asp";
		</script>
<%
		Response.End
	end if

	arr = split(request("chkEntries"),",")
	For i=0 to ubound(arr)
			query = "delete from tbldnstemplate where resellerid = '" & resellerid & "' and id='" & Trim(arr(i)) & "'"
			con.Execute (query)
			counter = counter+1
	Next
	Response.Write "</table>"
%>

<script>
	alert("<%=counter & " " & lbl731 & " " & lbl746%>");
	window.location = "/clients/ClientDnsTemplate.asp";
</script>


