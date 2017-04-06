<%
	accessLevel = 1
%>
<!-- #INCLUDE FILE = "../inc/security.asp" -->
<!-- #INCLUDE FILE = "../inc/db.asp" -->
<!-- #INCLUDE FILE = "../inc/params.asp" -->
<html>
<head>
<title><%=lbl656%></title>

<link rel="stylesheet" type="text/css" href="/skins/default/css/general.css">
<link rel="stylesheet" type="text/css" href="/skins/default/css/custom.css">
<link rel="stylesheet" type="text/css" href="/skins/default/css/layout.css">
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=ISO-8859-1">
<META HTTP-EQUIV="EXPIRES" CONTENT="0">

<!-- #INCLUDE FILE = "../inc/header.asp" -->
<!------------------------------------------------------------------------------------------------>
<!--Here the menu for Client is created-->
<!-- #INCLUDE FILE = "../server/subheader.asp" -->
<!-- #INCLUDE FILE = "../domains/domainheader.asp" -->
<%
	if(len(request("emails"))=0) then
%>
	<script>
		alert("<%=lbl657%>");
		window.location='/domains/emailalias.asp';
	</script>
<%
	end if
%>
<body>
<form  action ="/domains/removealias1.asp" method="post" name="mainform" >
  <table width=564 border=0 cellpadding=0 cellspacing=0 align="center">
    <tr> 
      <td width="253"><%=lbl509%> <font name="verdana" color="red"><strong><%=" "&ucase(session("contactname"))%></strong></font><img src="/skins/Standard_7/elements/white.gif" width="100%" height=1 alt="" border=0></td>
      <td width="363"><img src="/skins/Standard_7/elements/white.gif" alt="" width="8" height="8" border="0"></td>
    </tr>
    <tr> 
      <th colspan="2"><font color="#003366"><strong><%=lbl658%></strong></font></tr>
    
<%
  'response.write request("email")
  dim  alias
  alias=split(request("emails"),",")
  for i=lbound(alias) to ubound(alias)
%>
		<input type="hidden" name="alias" value="<%=alias(i)%>">
	<tr>
		<td height="21" colspan="2" align="center"><div align="center"></div>
        <font color="#003366"><%=alias(i)%></font></td>
    </tr>
<%
  next
%>
      
    <tr> 
      <th colspan="2">&nbsp;</tr>
    <tr> 
	
      <td colspan="2"><div align="center"> 
          <input type="submit" name="Button35" value="<%=lbl511%>" class="commonButton" >
          <input type="button" name="Button352" value="<%=lbl512%>" class="commonButton" onClick="window.location='/domains/emailalias.asp'">
        </div></td>
    </tr><tr> 
	
      <td colspan="2"><div align="center"> 
          &nbsp;
        </div></td>
    </tr>
  </table>
</form>
</body>
</html>
<!-- #INCLUDE FILE = "../inc/footer.asp" -->