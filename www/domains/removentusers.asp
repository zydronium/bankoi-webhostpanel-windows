<%
	accessLevel = 1
%>
<!-- #INCLUDE FILE = "../inc/security.asp" -->
<!-- #INCLUDE FILE = "../inc/db.asp" -->
<!-- #INCLUDE FILE = "../inc/params.asp" -->
<html>
<head>
<title><%=lbl665%></title>

<link rel="stylesheet" type="text/css" href="/skins/default/css/general.css">
<link rel="stylesheet" type="text/css" href="/skins/default/css/custom.css">
<link rel="stylesheet" type="text/css" href="/skins/default/css/layout.css">
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=ISO-8859-1">
<META HTTP-EQUIV="EXPIRES" CONTENT="0">

<!-- #INCLUDE FILE = "../inc/header.asp" -->
<!-- #INCLUDE FILE = "../domains/domainheader.asp" -->
<%
	if(len(request("ntuser"))=0) then
%>
	<script>
		alert("<%=msg68%>");
		window.location='/domains/manageusers.asp';
	</script>
<%
	else
%>
<body>
<form  action ="/domains/removentusers1.asp" method="post" name="mainform" >
  <table width=564 border=0 cellpadding=0 cellspacing=0 align="center">
    <tr> 
      <td width="253"><%=lbl509%> <font name="verdana" color="red"><strong><%=" "&ucase(session("contactname"))%></strong></font><img src="/skins/Standard_7/elements/white.gif" width="100%" height=1 alt="" border=0></td>
      <td width="363"><img src="/skins/Standard_7/elements/white.gif" alt="" width="8" height="8" border="0"></td>
    </tr>
    <tr> 
      <th colspan="2"><font color="#003366"><strong><%=lbl666%></strong></font></tr>
    
<%
  'response.write request("email")
  dim  alias
 ntuser=split(request("ntuser"),",")
  for i=lbound(ntuser) to ubound(ntuser)	
%>
		
	<tr>
		<td height="21" colspan="2" align="center"><div align="center"></div>
        <font color="#003366"><%=ntuser(i)%></font></td>
    </tr>
<%
  next
%>      
    <tr> 
      <th colspan="2">&nbsp;</tr>
    <tr> 
	
      <td colspan="2"><div align="center"> 
          <input type="submit" name="Button35" value="<%=lbl511%>" class="commonButton" >
          <input type="button" name="Button352" value="<%=lbl512%>" class="commonButton" onClick="window.location='/domains/manageusers.asp'">
        </div></td>
    </tr>
	 <tr> 
	
      <td colspan="2"><div align="center"> 
          &nbsp;
        </div></td>
    </tr> <tr> 
	
      <td colspan="2"><div align="center"> 
          &nbsp;
        </div></td>
    </tr>
  </table>
<input type="hidden" name="ntuser" value="<%=request("ntuser")%>">
</form>
</body>
</html>
<%
end if
%>
</form>
<!-- #INCLUDE FILE = "../inc/footer.asp" -->
</body>
</html>
