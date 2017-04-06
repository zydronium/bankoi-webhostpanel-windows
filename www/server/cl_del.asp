<% Response.expires=0 %>
<%
	accessLevel = 10
%>
<!-- #INCLUDE FILE = "../inc/security.asp" -->
<!-- #INCLUDE FILE="../inc/db.asp" -->
<html>
<head>
<title>
Clients
</title>
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
<form action='/server/delclient.asp' method='post' name="mainform">
<!-- #INCLUDE FILE="../inc/header.asp" -->
<%
if(len(request("del"))=0) then
%>
<script>
	alert("<%=msgclientseldel%>");
	window.location='/clients/clients.asp';
</script>
<%
else
'response.write "Amit yadav"
dim delClients
delClients = request("del")
dim arrDel
dim count
dim newList : newList = ""
arrDel = split(delClients,",")
session("arrclientid")=delClients
'response.write "The array is " &request("del")
count=0

dim successStr, failStr, successCount, failCount
failStr = ""
successStr =""
successCount=0
failCount =0
dim rsCheck
set rsCheck = Server.CreateObject("ADODB.RECORDSET")
for i=lbound(arrDel) to ubound(arrDel)	
	strcontact="select * from (tbldomain left join tblcontactinfo on tblcontactinfo.id = tbldomain.resellerid) where tbldomain.resellerid="& trim(arrDel(i))
	rsCheck.open strcontact, con	
	if(not rsCheck.eof) then
		 failStr = failStr & "<tr><td><li>" & rsCheck("contactname") & "</li></td></tr>"
		 failCount = failCount + 1
	else
		rsCheck.close
		rsCheck.open "select * from tblcontactinfo where id ="& trim(arrDel(i)), con	
		if(not rsCheck.eof) then
			successStr = successStr & "<tr><td><li>" & rsCheck("contactname") & "</li></td></tr>"
		else
			successStr = successStr & "<tr><td><li>" & rsCheck("contactname") & "</li></td></tr>"
		end if
		 successCount = successCount + 1
	end if
	rsCheck.close
	count=count+1    
next  
%>
<ul>
<table width="560" border="0" cellspacing="0" cellpadding="0" align="center">
<tr><td height=35>&nbsp;</td></tr>
  <tr><th><%=lbldelclient%> (<%=successCount%>)</td></tr>
	<%=successStr%>
	<%
	if(failCount > 0) then 
	%>
	<tr><td height="35">&nbsp;</td></tr>
  <tr><th>Clients can not be deleted (<%=failCount%>), you need to delete domains of these clients first </td></tr>
  <%=failStr%>
  <%
  end if
  %>
  <tr><td height="35">&nbsp;</td></tr>
  <tr><td align=center><input type="button" class="commonButton" value="<%=lblProceed%>" onClick="chk_form_data(document.mainform);"> &nbsp;&nbsp; <input type="button" class="commonButton" value="<%=lblCancel%>" onclick="location.href='/clients/clients.asp'"></td></tr>
</table>
</ul>
<%end if%>
</body>
</html><br>
<br>
<!-- #INCLUDE FILE = "../inc/footer.asp" -->