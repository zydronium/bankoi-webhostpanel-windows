<%
	accessLevel = 1
%>
<!-- #INCLUDE FILE = "../inc/security.asp" -->
<!-- #INCLUDE FILE = "../inc/db.asp" -->
<!-- #INCLUDE FILE = "../inc/params.asp" -->
<html>
<head>
<title><%=lbl627%></title>

<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/general.css">
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/custom.css">
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/layout.css">
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=ISO-8859-1">
<META HTTP-EQUIV="EXPIRES" CONTENT="0">
</head>
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
<table width="56%" border="0">
<tr bordercolor="#FFFFFF"> 
        <td colspan="5"><div align="right"><font color="#003366" size="2" face="Verdana"><a href="addhostentries.asp"><%=lbl628%></a></font></div></td>
      </tr></table>
<%
	id=session("id")
	query="select * from tblhostheader where domainid='" & id & "'"
	set rs=Server.createObject("ADODB.Recordset")
	rs.open query,con
	if(not rs.eof) then
%>


<body>
<form name="form1" method="post" action="">
  <div align="center"> 
    <table width="56%" border="0">
      <tr bordercolor="#FFFFFF"> 
        <td colspan="5"><div align="center"><font color="#FF0000" size="2" face="Verdana"><strong><%=lbl629%></strong></font></div></td>
      </tr>
      
      <tr>
	  <th width="30%" height="26" align=left><center>
		<table border="0" cellpadding=0 cellspacing=0 width="0" align="left">
	      <tr>
		    <td><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="2" height="22" border="0"></td>
			<td><%=lbl515%></td>
		  </tr>
	  </table></center></th>
	  <th width="9%" height="26" align=left>
		<table border="0" cellpadding=0 cellspacing=0 width="0" align="left">
		  <tr>
		    <td><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="2" height="22" border="0"></td>
			<td><%=lbl516%></td>
		  </tr>
	  </table></th>
	  <th width="45%" height="26" align=left>
		<table border="0" cellpadding=0 cellspacing=0 width="0" align="left">
		  <tr>
		    <td><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="2" height="22" border="0"></td>
			<td><%=lbl585%></td>
		  </tr>
	  </table></th>
	  <th width="16%" height="26" align=left><table border="0" cellpadding=0 cellspacing=0 width="77" align="left">
		  <tr>
		    <td width="2"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="2" height="22" border="0"></td>
			<td width="39">Delete</td>
			<td width="2"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="2" height="22" border="0"></td>			
		  </tr>
	  </table></th>
	</tr>
	<%
		while(not rs.eof)
		arr=split(rs("hostheader"),":")

	%>
      <tr> 
        <td><div align="left"><font size="2" face="Verdana"><%=arr(0)%></font></div></td>
        <td><div align="left"><font size="2" face="Verdana"><%=arr(1)%></font></div></td>
        <td><div align="left"><font size="2" face="Verdana"><%=arr(2)%></font></div></td>
	<%if(rs("isdefault")=0) then%>
        <td colspan="2"><div align="center"><font size="2" face="Verdana"><a href="deleteentry.asp?hostid=<%=rs("hostheaderid")%>"><%=lbl630%></font></div></td>
	<%else%>
		<td colspan="2">&nbsp;</td>
	<%end if%>
      </tr>
	  <%
			arr=""
			rs.movenext
			wend
	  %>
    </table>
  </div>
</form>
</body>
<%
	else
%><center>
	<img src="/skins/<%=session("skin")%>/elements/line.gif" width=564 height=1 border=0><br><br>
<%
	Response.write  lbl631 & "</center><br>"
	end if
%><center><br>
	<img src="/skins/<%=session("skin")%>/elements/line.gif" width=564 height=1 border=0><br><br>
</html>
<br>
<br>
<!-- #INCLUDE FILE = "../inc/footer.asp" -->