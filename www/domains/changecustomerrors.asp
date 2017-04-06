<%
	accessLevel = 1
%>
<!-- #INCLUDE FILE = "../inc/security.asp" -->
<!-- #INCLUDE FILE = "../inc/db.asp" -->
<!-- #INCLUDE FILE = "../inc/params.asp" -->
<!-- #INCLUDE FILE = "../inc/functions.asp" -->
<html>
<head>
<title><%=lbl525%></title>

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
<TABLE align="Center" bgcolor="#F2F2FF">
<%
	'400  401  403  404  405  500 
	HErrors=geterrors(session("domain"))
	response.write "<Center>"
	For i=lbound(HErrors) to Ubound(HErrors)
		ListErrors=Split(HErrors(i),",")
		If((ListErrors(0)=400 OR ListErrors(0)=401 OR ListErrors(0)=403 OR ListErrors(0)=404 OR ListErrors(0)=405 OR ListErrors(0)=500) AND ListErrors(2)="URL" AND ListErrors(1)="*") then
			response.write  "<tr><td>" & HErrors(i) & "</td></tr>"
		End If
		'response.write  HErrors(i) & "<BR>"
	Next
	response.write "</Center>"
%>
</TABLE>
<body>

<form method="POST" action="setcustomerrors.asp">
  <div align="right"></div>
  <div align="center"></div>
  <div align="center">
    <center>
	
      <table border="1" width="51%" bordercolor="#FFFFFF" cellspacing="0" cellpadding="0" bgcolor="#F2F2FF" height="203">
        <tr> 
      <td bgcolor="#FFFFFF" colspan="2"><%=lbl509%> <font name="verdana" color="red"><strong><%=" "&ucase(session("contactname"))%></strong></font><img src="/skins/<%=session("skin")%>/elements/white.gif" width="100%" height=1 alt="" border=0></td>
    </tr>
        <tr bgcolor="#FFFFFF"> 
          <td height="9" colspan="2" align="center" valign="top"><img src="/skins/<%=session("skin")%>/elements/line.gif" width=560 height=1 border=0></td>
        </tr>
        <tr bgcolor="#009999"> 
          <td width="25%" height="17" align="center" valign="top"><font size="2" color="#FFFFFF"><b><%=lbl526%>.</b></font></td>
          <td width="50%" height="17" align="center" valign="top"><font size="2" color="#FFFFFF"><b><%=lbl527%></b></font></td>
        </tr>
        <tr> 
          <td width="25%" height="18" align="center"><font face="Verdana" size="2" color="#FF0000"><b>400</b></font></td>
          <td width="50%" height="18" align="center"><input type="text" name="u400" size="28"></td>
        </tr>
        <tr> 
          <td width="25%" height="16" align="center"><font face="Verdana" size="2" color="#FF0000"><b>401</b></font></td>
          <td width="50%" height="16" align="center"><input type="text" name="u401" size="28"></td>
        </tr>
        <tr> 
          <td width="25%" height="18" align="center"><font face="Verdana" size="2" color="#FF0000"><b>403</b></font></td>
          <td width="50%" height="18" align="center"><input type="text" name="u403" size="28"></td>
        </tr>
        <tr> 
          <td width="25%" height="18" align="center"><font face="Verdana" size="2" color="#FF0000"><b>404</b></font></td>
          <td width="50%" height="18" align="center"><input type="text" name="u404" size="28"></td>
        </tr>
        <tr> 
          <td width="25%" height="18" align="center"><font face="Verdana" size="2" color="#FF0000"><b>405</b></font></td>
          <td width="50%" height="18" align="center"><input type="text" name="u405" size="28"></td>
        </tr>

		<tr> 
          <td width="25%" height="18" align="center"><font face="Verdana" size="2" color="#FF0000"><b>500</b></font></td>
          <td width="50%" height="18" align="center"><input type="text" name="u500" size="28"></td>
        </tr>

        <tr bgcolor="#FFFFFF"> 
          <td width="100%" height="18" colspan="3" align="center"><div align="right"> 
              <div align="right"></div>
              <div align="center"><img src="/skins/<%=session("skin")%>/elements/line.gif" width=560 height=1 border=0></div>
            </div></td>
        </tr>
        <tr bgcolor="#FFFFFF"> 
          <td height="18" colspan="3" align="center"><div align="right"> 
              <input type="submit" name="Button3323" value="<%=lbl529%>" class="commonButton" onClick="window.location=''" title='<%=lbl529 & " " & session("domain")%>'>
              <input type="button" name="Button33232" value="<%=lbl512%>" class="commonButton" onClick="window.location='/server/domaininfo.asp'" title='<%=lbl512%>'>
            </div></td>
        </tr>
      </table>
    </center>
  </div>
</form>

</body>
<br><br>
<!-- #INCLUDE FILE = "../inc/footer.asp" -->