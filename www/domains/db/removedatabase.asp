<%
	accessLevel = 1
%>
<!-- #INCLUDE FILE = "../../inc/security.asp" -->
<!-- #INCLUDE FILE = "../../inc/db.asp" -->
<!-- #INCLUDE FILE = "../../inc/params.asp" -->
<!-- #INCLUDE FILE = "../../inc/functions.asp" -->
<!-- #INCLUDE FILE = "../../inc/dbfunctions.asp" -->
<html>
<head>
<title><%=lbl508%></title>
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/general.css">
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/custom.css">
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/layout.css">
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=ISO-8859-1">
<META HTTP-EQUIV="EXPIRES" CONTENT="0">
<body>
<!-- #INCLUDE FILE = "../../inc/header.asp" -->
<!-- #INCLUDE FILE = "../domainheader.asp" -->
<%
	if(len(request("dbid"))=0) then
%>
	<script>
		alert("<%=msg17%>");
		window.location='/domains/sqldatabase.asp';
	</script>
<%
else
%>
<form  action ="removedb1.asp" method="post" name="mainform" >
  <table width=564 border=0 cellpadding=0 cellspacing=0 align="center">
    <tr> 
      <td width="153"><%=lbl509%> <font name="verdana" color="red"><strong><%=" "&ucase(session("resellername"))%></strong></font><img src="/skins/<%=session("skin")%>/elements/white.gif" width="100%" height=1 alt="" border=0></td>
      <td width="363"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="8" height="8" border="0"></td>
    </tr>
    <tr> 
      <th colspan="2"><font color="#003366"><strong><%=msg18%></strong></font></tr>
    
<%
dim db
db=split(request("dbid"),",")
set rsDbList = server.createobject("adodb.recordset")
rsDbList.open "select * from cp_db_all where id in ("& request("dbid") &")", con
if(not rsDbList.eof) then 
%>
<tr>
		<td height="21" align="center" bgcolor="#EEEEEE">
        <font color="#003366"><%=lbl501%></font></td>
		<td height="21" align="center" bgcolor="#EEEEEE">
        <font color="#003366"><%=lbl510%></font></td>
    </tr>
<%
while (not rsDbList.eof )
%>
		<input type="hidden" name="db" value="<%=rsDbList("id")%>">
	<tr>
		<td height="21" align="center">
        <font color="#003366"><%=rsDbList("dbname")%></font></td>
		<td height="21" align="center">
        <font color="#003366"><%=rsDbList("type")%></font></td>
    </tr>
<%
	rsDbList.movenext
  wend
  end if
%>      
    <tr> 
      <th colspan="2">&nbsp;</tr>
    <tr> 	
      <td colspan="2"><div align="center"> 
          <input type="submit" name="Button35" value="<%=lbl511%>" class="commonButton" >
          <input type="button" name="Button352" value="<%=lbl512%>" class="commonButton" onClick="window.location='/domains/sqldatabase.asp'">
        </div></td>
    </tr>
  </table>
</form>
<!-- #INCLUDE FILE = "../../inc/footer.asp" -->
<%
	end if
%>
</body>
</html>
