<%
	accessLevel = 1
%>
<!-- #INCLUDE FILE = "../inc/security.asp" -->
<!-- #INCLUDE FILE = "../inc/db.asp" -->
<!-- #INCLUDE FILE = "../inc/params.asp" -->
<!-- #INCLUDE FILE = "../inc/functions.asp" -->
<html>
<head>
<title><%=lbl530%></title>

<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/general.css">
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/custom.css">
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/layout.css">
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=ISO-8859-1">
<META HTTP-EQUIV="EXPIRES" CONTENT="0">
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
The header ends here-->
<%
dim DefaultDocs
	DefaultDocs = ViewDefaultDocs(session("domain"))

%>
<body>
<form name="mainform" method="POST" Action="changedefaultdocs1.asp">
<table width="57%" border="0" align="center">
  <tr>
    <td><%=lbl509%> <font name="verdana" color="red"><strong><%=" "&ucase(session("contactname"))%></strong></font></td>
  </tr>
  <tr>
    <td><div align="left"><img src="/skins/<%=session("skin")%>/elements/line.gif" width=560 height=1 border=0></div></td>
  </tr>
</table>
<table width="52%" border="0" align="center">
  <tr> 
    <td bgcolor="#F5F4FD"><div align="center"><strong><font color="#FF0000" size="2" face="Verdana"><%=lbl531%></font></strong></div></td>
  </tr>
  <tr> 
    <td bgcolor="#F5F4FD" align="center"><font color="#FF0000" size="2" face="Verdana"><%=lbl532%>:</font><font color="Blue" size="1" face="Verdana"><%=msg95%></font></td>
  </tr>
  <tr> 
    <%
		For i=Lbound(DefaultDocs) to Ubound(DefaultDocs)
			Docs=Docs & DefaultDocs(i) & VBCRLF 
		Next
%>
    <td bgcolor="#F5F4FD"><center> <textarea name="docs" cols="44" rows="13" style="color: #000080; font-family: Verdana; font-size: 13px  border-style: groove"><%=Docs%></textarea>
      <center> </td>
  </tr>
  <tr> 
    <td bgcolor="#FFFFFF">&nbsp;</td>
  </tr>
  <tr>
    <td bgcolor="#F5F4FD"> <div align="center">
        <input type="Submit" name="Button3372" value="<%=lbl533%>" class="commonButton" onClick="window.location='/domains/changedefaultdocs1.asp'" title='<%=lbl533%>'>
        <input type="button" name="Button33722" value="<%=lbl512%>" class="commonButton" onClick="window.location='/server/domaininfo.asp'" title='<%=lbl512%>'>
      </div></td>
  </tr>
</table>
<table width="57%" border="0" align="center">
  <tr> 
    <td>&nbsp;</td>
  </tr>
  <tr> 
    <td><div align="left"><img src="/skins/<%=session("skin")%>/elements/line.gif" width=560 height=1 border=0></div></td>
  </tr>
</table>

