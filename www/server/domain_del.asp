<%
	accessLevel = 5
%>
<!-- #INCLUDE FILE = "../inc/security.asp" -->
<!-- #INCLUDE FILE="../inc/db.asp" -->

<html>
<head>
<title>Delete Client</title>
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/general.css">
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/custom.css">
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/layout.css">
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=ISO-8859-1">
<META HTTP-EQUIV="EXPIRES" CONTENT="0">

<script>
function chk_form_data(f)
{
	f.submit();
	return true;
}
</script>
</head>
<!-- #include file="../inc/header.asp" -->
<%
	if(len(request("del"))=0) then
%>
	<script>
		alert("<%=msgnodomsel%>");
		window.location='/server/domains.asp';
	</script>
<%
else
%>
<body>
<form action='../server/domain_del1.asp' method='post' name="mainform">
<center>
<img src="/skins/<%=session("skin")%>/elements/line.gif" width=564 height=1 border=0>
</center>
<%
dim arr
dim count
count=0
'response.write request("del")
length=len(request("del"))
'response.write "Length is " & length
arr = split(request("del"),",")
%>
 <table width="564" border="0" align="center" cellpadding=0 cellspacing=0>
    
<%
for i=0 to ubound(arr)
    query="select domainname from tbldomain where domainid='" & trim(arr(i)) & "'"
    dim rs
	set rs=Server.createobject("ADODB.RecordSet")
	rs.open query,con
  %>
  <tr>
	  <td height="25" align="center"><%=lblThedomain%> <strong><font color=red face=verdana><%= rs("domainname")%>
  </font></strong> <%=msgwill%></td>
</tr>
  <input type="hidden" name="domainname" value="<%=rs("domainname")%>"><%
next

%>
</table>
<%
for i=0 to ubound(arr)
%>
   <input type="hidden" name="chk" value="<%=arr(i)%>">
<%
next
%>
<center>
<img src="/skins/<%=session("skin")%>/elements/line.gif" width=564 height=1 border=0>
<br>
</center>
<center>
<input type="button" name="confirm" value="<%=lbldel%>" class="navigationButton" onClick="chk_form_data(document.mainform);">
<input type="button" name="cancel" value="<%=lblCancel%>" class="navigationButton" onClick="window.location='../server/domains.asp'">
</center>
</form>
</body>
</html>
<%
  end if
%>
<br>

<br>
<!-- #INCLUDE FILE = "../inc/footer.asp" -->