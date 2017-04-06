<%
	accessLevel = 1
%>
<!-- #INCLUDE FILE = "../inc/security.asp" -->
<!-- #INCLUDE FILE = "../inc/db.asp" -->
<!-- #INCLUDE FILE = "../inc/params.asp" -->
<!-- #INCLUDE FILE = "../inc/functions.asp" -->
<html>
<head>
<title><%=lbl513%></title>

<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/general.css">
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/custom.css">
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/layout.css">
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=ISO-8859-1">
<META HTTP-EQUIV="EXPIRES" CONTENT="0">
</head>
<script language="javascript">
function chk_dom(dom_name)
{
	nore = /\.$/;
	re = /^[A-Za-z0-9]([A-Za-z0-9-]*[A-Za-z0-9])*(\.[A-Za-z0-9]([A-Za-z0-9-]*[A-Za-z0-9])*)+$/;
	return (dom_name.search(nore) == -1) && (dom_name.search(re) != -1);//Returns true or false
}

//---------------------------------------------------------------------------------------------------------
function chk(f)
{
  if(!chk_dom(f.hostname.value))
	{
		alert("<%=msg19%>");
		f.hostname.value="";
		f.hostname.focus();
		return false;
	}
	return true;
}
</script>

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
<% 
	set rsip = server.createobject("ADODB.recordset")
	rsip.open "select ipaddress from tblresellerip where resellerid = "& session("reselid"),con
	IpAddress = rsip("ipaddress")
	set rsip = nothing
	sIp = GetIpAddress(IpAddress, con)
%>
<form method="POST" action="addhostentries1.asp" name="mainform" onSubmit="return chk(document.mainform)">
  <div align="center">
    <center>
    <table border="0" width="55%" cellspacing="0" cellpadding="0" height="139">
      <tr> 
        <td width="100%" colspan="3" height="9"> <p align="center"><b><font face="Verdana" size="2" color="#800000"><%=lbl514%></font></b></td>
      </tr>
      <tr>
        <td colspan="3" height="9"><img src="/skins/<%=session("skin")%>/elements/line.gif" width=564 height=1 border=0></td>
      </tr>
      <tr> 
        <td width="44%" align="right" height="25"><font face="Verdana" size="2" color="#000080"><%=lbl515%>:</font></td>
        <td width="4%" height="25"></td>
        <td width="52%" height="25"><input value="<%=sIp%>" name="ipaddress" type="text" id="ipaddress" size="20" readonly></td>
      </tr>
      <tr> 
        <td width="44%" align="right" height="25"><font face="Verdana" size="2" color="#000080"><%=lbl516%>:</font></td>
        <td width="4%" height="25"></td>
        <td width="52%" height="25"><input name="port" value="80" type="text" id="port" size="20" readonly></td>
      </tr>
      <tr> 
        <td width="44%" align="right" height="24"><font face="Verdana" size="2" color="#000080"><%=lbl517%>:</font></td>
        <td width="4%" height="24"></td>
        <td width="52%" height="24"><input name="hostname" type="text" id="hostname" size="20"></td>
      </tr></center>
      <tr> 
        <td width="100%" colspan="3" height="20"> <p align="center"><img src="/skins/<%=session("skin")%>/elements/line.gif" width=564 height=1 border=0>	
        </td>
      </tr>
      <tr> 
        <td width="100%" colspan="3" height="27"> <p align="right">
            <input class="commonButton" type="submit" value="<%=lbl518%>" name="B1">
            <input class="commonButton" type="button" value="<%=lbl512%>" name="B2" onClick="window.location='hostentries.asp'">
        </td>
      </tr>
    </table>
  </div>

</form>
<br>
<br>
<!-- #INCLUDE FILE = "../inc/footer.asp" -->