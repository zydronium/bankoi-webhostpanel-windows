<%
	accessLevel = 1
%>
<!-- #INCLUDE FILE = "../inc/security.asp" -->
<!-- #INCLUDE FILE = "../inc/db.asp" -->
<!-- #INCLUDE FILE = "../inc/params.asp" -->
<html>
<head>
<title><%=lbl659%></title>

<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/general.css">
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/custom.css">
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/layout.css">
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=ISO-8859-1">
<META HTTP-EQUIV="EXPIRES" CONTENT="0">

<!-- #INCLUDE FILE = "../inc/header.asp" -->
<!-- #INCLUDE FILE = "../domains/domainheader.asp" -->

<%
	if(len(request("dsn"))=0) then
%>
	<script>
		alert("<%=msg62%>");
		window.location='/domains/managedsn.asp';
	</script>
<%
	end if
%>
<body>
<form  action ="/domains/removedsn1.asp" method="post" name="mainform" >
  <table width=564 border=0 cellpadding=0 cellspacing=0 align="center">
    <tr> 
      <td colspan="2"><%=lbl509%> <font name="verdana" color="red"><strong><%=" "&ucase(session("contactname"))%></strong></font><img src="/skins/<%=session("skin")%>/elements/white.gif" width="100%" height=1 alt="" border=0></td>
      <td width="363"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="8" height="8" border="0"></td>
    </tr>
    <tr> 
      <th colspan="5"><font color="#003366"><strong><%=lbl660%></strong></font></tr>
    
<%
  
  dim  dsn

  dsn=split(request("dsn"),",")
  for i=lbound(dsn) to ubound(dsn)
%>
		<input type="hidden" name="dsn" value="<%=dsn(i)%>">
	<tr>
		<td height="21" colspan="4" align="center"><div align="center"></div>
        <font color="#003366"><%=dsn(i)%></font></td>
<%
  next
%>   
    <tr> 
      <th colspan="5">&nbsp;</tr>
    <tr> 
	
      <td colspan="5"><div align="center"> 
          <input type="submit" name="Button35" value="<%=lbl511%>" class="commonButton" >
          <input type="button" name="Button352" value="<%=lbl512%>" class="commonButton" onClick="window.location='/domains/managedsn.asp'">
        </div></td>
    </tr>
  </table>
</form>
</body>
</html><br>
<br>
<!-- #INCLUDE FILE = "../inc/footer.asp" -->