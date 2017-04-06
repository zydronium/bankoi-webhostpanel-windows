<%
accessLevel = 10
%>

<!-- #INCLUDE FILE = "../inc/security.asp" -->
<!-- #INCLUDE FILE="../inc/db.asp" -->
<!-- #INCLUDE FILE="../inc/functions.asp" -->

<%
	if(len(request("chkEntries"))=0) then
%>
		<script>
			alert("<%=msg113%>");
			window.location='/server/dnstemplate.asp';
		</script>
<%
	end if

	arr = split(request("chkEntries"),",")
	For i=0 to ubound(arr)
			query = "delete from tbldnstemplate where resellerid = '0' and id='" & Trim(arr(i)) & "'"
			'Response.write "<tr><td align='center' bgcolor='#666666'><font face='verdana' color='white' size='2'>The id to delete is "  & Trim(arr(i)) & "</font></td></tr><BR>"
			con.Execute (query)
			counter = counter+1
	Next
	Response.Write "</table>"
%>

<script>
	alert("<%=counter & " " & lbl731 & " " & lbl746%>");
	window.location = "/server/dnstemplate.asp";
</script>


