<!-- #include file="../inc/lang.asp" -->

<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/general.css">
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/custom.css">
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/layout.css">
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=ISO-8859-1">
<META HTTP-EQUIV="EXPIRES" CONTENT="0">
<form name="form1" method="post" action="">
<br>
  <table width="564" border="0" align="center" cellpadding="0" cellspacing="0" class="topHead">
   <tr>
	  <td colspan="5"><div align="center"><img src="<%=session("logoname")%>"></div></td>
	</tr>
	<tr>
	  <td colspan="5">&nbsp;</td>
	</tr>
    <tr>
<%
	If(session("isalias") <> "1") then
%>
	  <td width="119"><input type="button" name="adddomain3" value="<%=lbl534%>" class="commonButton" onClick = "window.location='/mailuser/mailaccount.asp'" style="TEXT-DECORATION: none" checked title='<%=lbl534 & " " & session("domain")%>' onmouseover="window.status='<%=lbl534%>'" onmouseout="window.status=''"> 
        <div align="left"> </div></td>
<%
	End If
	If(session("isalias") = "1") then
%>
	  <td width="120"><input type="button" name="adddomain2" value="<%=lbl566%>" class="commonButton" onClick = "window.location='/domains/emailalias.asp'" title='<%=lbl567 & " " & session("domain")%>' onmouseover="window.status='<%=lbl566%>'" onmouseout="window.status=''"> 
      </td>
<%
	End If
%>
	  <td width="128"><input type="button" name="Button" value="<%=lblLogout%>" class="navigationButton" id="bid-logout" onClick="window.location='/logout.asp';" title="<%=lblLogout%>" onmouseover="window.status='<%=lblLogout%>'" onmouseout="window.status=''"></td>
      <td width="70">&nbsp;</td>
	 
	  <td width="127"> <div align="left"> </div></td>
	</tr>
  </table>
</form>
