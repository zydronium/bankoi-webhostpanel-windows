<%
	accessLevel = 10
%>
<!-- #INCLUDE FILE = "../inc/security.asp" -->
<!-- #INCLUDE FILE="../inc/db.asp" -->
<html>
<head>
<title><%=lbl681%></title>
<script>
function chk_form_data(f)
{
	f.submit();
	return true;
}
</script>
</head>

<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/general.css">
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/custom.css">
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/layout.css">
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=ISO-8859-1">
<META HTTP-EQUIV="EXPIRES" CONTENT="0">
</head>
<body>
<form action="removeipadd1.asp" method="post" name="mainform">
<!-- #INCLUDE FILE="../inc/header.asp" -->
<%
	
	if(len(Request("ipaddresses"))=0) then
%>
	<script>
		alert("<%=msg77%>");
		window.location='addnewip.asp';
	</script>
<%
	else
	ipaddresses=Split(Request("ipaddresses"),",")
	set rsiptype=server.createobject("ADODB.Recordset")
	failCount=0
	successCount=0
	IpToDelete=""
	For i=Lbound(ipaddresses) to Ubound(ipaddresses)
		query="select count(*) as ipcount from (tblresellerip inner join tblserverip on tblserverip.id=tblresellerip.ipaddress)where tblserverip.ipaddress='" & Trim(ipaddresses(i)) & "'"
		'Response.Write query
		rsiptype.open query,con
		If(rsiptype("ipcount")>0) then
			failStr = failStr & "<tr><td><li>" & Trim(ipaddresses(i)) & "</li></td></tr>"
			failCount = failCount + 1
		Else
			successStr = successStr & "<tr><td><li>" & Trim(ipaddresses(i)) & "</li></td></tr>"
			if(IpToDelete="") then
				IpToDelete=Trim(ipaddresses(i))
			else
				IpToDelete=IpToDelete & "," & Trim(ipaddresses(i))
			end if
			successCount = successCount + 1
		End If
		rsiptype.close
	Next
	session("Ipdelete")=IpTodelete
%>
<input type="hidden" name="IpTodelete" value="<%=IpToDelete%>">
<ul>
<table width="580" border="0" cellspacing="0" cellpadding="0" align="center">
<tr><td height=35></td></tr>
<%
	if(successCount>0) then
%>
  <tr><th colspan="3"><%=lbl682%> (<%=successCount%>)</td></tr>
	<%=successStr%>
	<%
	End if	
	if(failCount > 0) then 
	%>
	<tr><td height="35">&nbsp;</td></tr>
  <tr><th>Ip addresses can not be deleted (<%=failCount%>), they are assigned to some clients </td></tr>
  <%=failStr%>
  <%
  end if
  %>
  <tr><td height="35">&nbsp;</td></tr>
  <tr><td align=center>
  <input type="submit" class="commonButton" value="<%=lbl511%>" Onclick="chk_form_data(document.mainform);"> &nbsp;&nbsp; <input type="button" class="commonButton" value="<%=lbl512%>" onclick="location.href='/server/addnewip.asp'"></td></tr>
</table>
</ul>
<%	
End if
%>
</form>
</body>
</html>
<br>
<br>
<!-- #INCLUDE FILE = "../inc/footer.asp" -->