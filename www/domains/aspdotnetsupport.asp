<%
	accessLevel = 1
%>
<!-- #INCLUDE FILE = "../inc/security.asp" -->
<!-- #INCLUDE FILE = "../inc/db.asp" -->
<!-- #INCLUDE FILE = "../inc/params.asp" -->
<html>
<head>
<title><%=lbl519%></title>

<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/general.css">
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/custom.css">
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/layout.css">
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=ISO-8859-1">
<META HTTP-EQUIV="EXPIRES" CONTENT="0">

<script>
function chk_frm(f){
f.action="/domains/setaspdotnet.asp"
f.submit
}
</script>

</head>
<%
    id=session("id")
	username=session("domain")
	
	usertype=session("type")
	if(usertype="d") then
	query = "select aspdotnetsupport from tblrights where id='" & id & "'"
	'response.write query
	set Chk = Server.CreateObject("ADODb.Recordset")
	Chk.open query,con
	if(ucase(chk("aspdotnetsupport")) = Ucase("n")) then
%>
		<script>
			alert("<%=msg112%>");
			window.location = "/domains/edit_domain.asp";
		</script>
<%
		response.end
	end if
	end if

	'---------------------------------------------------------------------------------------------
	query="select aspdotnetsupport from tbldomainpref where domainid='" & id & "'"
	'response.write query
	set rs=server.createobject("ADODB.Recordset")
	rs.open query,con
	if(rs("aspdotnetsupport")="N") then
	    aspdot=lbl521
	else
	    aspdot=lbl522
	end if
%>

<!-- #INCLUDE FILE = "../inc/header.asp" -->

<!------------------------------------------------------------------------------------------------>
<!--Here the menu for Client is created-->
<!-- #INCLUDE FILE = "../server/subheader.asp" -->

<!------------------------------------------------------------------------------
The header of reseller prepared here
-->
<!-- #INCLUDE FILE = "../domains/domainheader.asp" -->
<!--
----------------------------------------------------------------------------
The header ends here
-->
<body>
<form  method="post" name="mainform">
<table width=370 border=0 cellpadding=0 cellspacing=0 align="center">
  <tr> 
    <td width=436><%=lbl509%> <font name="verdana" color="red"><strong><%=" "&ucase(session("contactname"))%></strong></font><img src="/skins/Standard_7/elements/white.gif" width="100%" height=1 alt="" border=0></td>
    <td width=7><img src="/skins/Standard_7/elements/white.gif" alt="" width="8" height="8" border="0"></td>
  </tr>
  <tr> 
    <td colspan="2"><img src="/skins/<%=session("skin")%>/elements/line.gif" width=560 height=1 border=0></td>
  </tr>
  <tr> 
    <td colspan="2">&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="2"><div align="center"><%=aspdot & " " %> <%=lbl520%><font name="verdana" color="red"><strong> 
        <%=" "&username%></strong></font></div></td>
  </tr>
  <tr> 
    <td colspan="2">&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="2"><img src="/skins/<%=session("skin")%>/elements/line.gif" width=560 height=1 border=0></td>
  </tr>
  <tr> 
    <td height="29" colspan="2"><div align="center"> </div></td>
  </tr>
  <tr>
    <td colspan="2"><div align="center">
        <input type="submit" name="Button35" value="<%=aspdot%>" class="commonButton" onClick="return chk_frm(document.mainform)">
      </div></td>
  </tr> <tr> 
	
      <td colspan="2"><div align="center"> 
          &nbsp;
        </div></td>
    </tr>
</table>
<input type="hidden" name="aspdot" value="<%=aspdot%>">
</form>
</body>
</html><!-- #INCLUDE FILE = "../inc/footer.asp" -->