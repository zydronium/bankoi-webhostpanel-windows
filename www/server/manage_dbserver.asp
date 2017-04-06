<%
	accessLevel = 10
%>
<!-- #INCLUDE FILE = "../inc/security.asp" -->
<!-- #INCLUDE FILE="../inc/db.asp" -->
<html>
<head>
<title><%=lbl683%></title>
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/general.css">
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/custom.css">
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/layout.css">
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=ISO-8859-1">
<META HTTP-EQUIV="EXPIRES" CONTENT="0">
<script language="javascript">
<!--
function chkAddServer()
{
  if(serverForm.hostserver.value=="")
  {
	alert("<%=msg78%>")
	serverForm.hostserver.focus()
	return false
  }
  if(serverForm.rootusername.value=="")
  {
	alert("<%=msg9%>")
	serverForm.rootusername.focus()
	return false
  } 
  return true
}
function getDetail(){
	document.serverForm.action="manage_dbserver.asp"
	document.serverForm.submit();
}
//-->
</script>
</head>
<body leftmargin=0 topmargin=0 >
<!-- #include file="../inc/header.asp" -->
<br>
<table width="564" border="0" cellspacing="0" cellpadding="5" align="center" class="bodynormal">
  <tr>
	<td class="head" align="center"><b><%=lbl683%></b></td>
  </tr>
</table>

<p>&nbsp;</p>
<%
serverIp = ""
serverUser=""
serverPassword=""
serverType="mssql"
serverStatus="1"
dim rsDetail
set rsDetail = server.CreateObject("ADODB.RecordSet")
IF( (len(request("servers"))>0) or (request("servers")<>0)) then
	serverId = request("servers")
	rsDetail.open "select * from cp_db_servers where id = "& serverId, con
	if(not rsDetail.eof) then
		serverIp = rsDetail("serverip")
		serverUser=rsDetail("serveruser")
		serverPassword=rsDetail("serverpassword")
		serverType=rsDetail("servertype")
		serverStatus=rsDetail("status")
	end if
else
	serverId=0
end if
set rsDetail =nothing
dim rsServers
set rsServers = server.CreateObject("ADODB.RecordSet")

%>
<form name="serverForm" method="post" action="manage_dbserversubmit.asp" onSubmit="return chkAddServer();">

  <table width="564" border="0" cellspacing="0" cellpadding="5" align="center" class="border">
    <tr align="center" bgcolor="#CCCCCC">
      <td colspan="2" class="body"><b><%=lbl684%></b></td>
	</tr>
    <tr>
	  <td width="46%"><%=lbl685%></td>
	  <td width="54%">
		<select name="servers" id="servers" onchange="getDetail()">
		  <option value="0"><%=lbl686%></option>
		  <%
		  rsServers.open "select * from cp_db_servers order by serverip", con
		  while (not rsServers.eof)
		  %>
		  <option value="<%=rsServers("id")%>"><%=rsServers("serverip")%> - [<%=rsServers("servertype")%>]</option>
		  <%
		  rsServers.movenext
		  wend
		  %>
		</select></td>
	</tr>
	<tr>
      <td><%=lbl687%></td>
	  <td><select name="databasetype" id="databasetype">
          <option value="mssql"><%=lbl688%></option>
          <option value="mysql"><%=lbl689%></option>
        </select></td>
	</tr>
    <tr>
      <td>Database Server</td>
	  <td><input name="hostserver" type="text" id="hostserver" value="<%=serverIp%>"></td>
	</tr>
    <tr>
      <td>Root Username</td>
	  <td><input name="rootusername" type="text" id="rootusername" value="<%=serverUser%>"></td>
	</tr>
    <tr>
      <td>Root Password</td>
	  <td><input name="rootpassword" type="text" id="rootpassword" value="<%=serverPassword%>"></td>
	</tr>
    <tr>
      <td>Status</td>
	  <td><select name="status" id="status">
          <option value="1" ><%=lbl690%></option>
          <option value="0"><%=lbl691%></option>
        </select></td>
	</tr>
	<%
	if(serverId =0) then
	%>
    <tr>
      <td colspan="2" align="center" class="body"><input name="mode" type="hidden" id="mode" value="add">
<input type="submit" name="Submit" value="<%=lbl692%>" class="button">
        <br> </td>
	</tr>
	<%
	else
	%>
	<tr>
	  <td colspan="2" align="center" class="body"><input name="mode" type="hidden" id="mode" value="modify">
<input name="Submit2" type="submit" class="button" value="<%=lbl693%>"></td>
	</tr>
	<%
	end if
	%>
  </table>
</form>
<script language="javascript">
for (var i = 0; i < document.serverForm.databasetype.options.length; i++)
{
	if (document.serverForm.databasetype.options[i].value == "<%=serverType%>")
	{
		document.serverForm.databasetype.options[i].selected = true;
		break;
	}
}
for (var i = 0; i < document.serverForm.servers.options.length; i++)
{
	if (document.serverForm.servers.options[i].value == "<%=serverId%>")
	{
		document.serverForm.servers.options[i].selected = true;
		break;
	}
}
for (var i = 0; i < document.serverForm.status.options.length; i++)
{
	if (document.serverForm.status.options[i].value == "<%=serverStatus%>")
	{
		document.serverForm.status.options[i].selected = true;
		break;
	}
}
</script>
<br>
<!-- #include file="../inc/footer.asp" -->
</body>
</html>