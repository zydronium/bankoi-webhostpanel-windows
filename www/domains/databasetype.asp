<%
	accessLevel = 1
%>
<!-- #INCLUDE FILE = "../inc/security.asp" -->
<!-- #INCLUDE FILE = "../inc/db.asp" -->
<!-- #INCLUDE FILE = "../inc/params.asp" -->
<html>
<head>
<title><%=lblDatabases%></title>

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

<!---------------------------------------------------------------------------

<!--
----------------------------------------------------------------------------
The header of reseller prepared here
-->
<!-- #INCLUDE FILE = "../domains/domainheader.asp" -->
<!--
----------------------------------------------------------------------------
The header ends here
-->
<body>
<form action="/domains/managedsn.asp" method="post" name="mainform" >
  <table width=590 border=0 cellpadding=0 cellspacing=0 align="center">
    <tr> 
      <td  colsoan="4"><%=lbl509%> <font name="verdana" color="red"><strong><%=" "&ucase(session("contactname"))%></strong></font><img src="/skins/<%=session("skin")%>/elements/white.gif" width="100%" height=1 alt="" border=0></td>
      <td width="370"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="8" height="8" border="0"></td>
    </tr>
    
  </table>
  <table width=370 border=0 cellpadding=0 cellspacing=0 align="center">
    <tr> 
      <td height="10" colspan="7" align="center">&nbsp;</tr>
    <tr> 
      <th height="11" colspan="7" align="center"><div align="right"></div>
        <div align="center"><strong><font color="#FF0000" size="2" face="Verdana"><%=lbl555%></font></strong> </div></td>
        </tr>
    <tr> 
      <td height="28" colspan="2"><div align="right"><font size="2" face="Verdana"><strong> 
          </strong></font></div>
        <div align="center"> </div></td>
      <td width="209"><div align="left"><font color="#003366" size="2" face="Verdana"></font></div></td>
      <td width="349" colspan="4"><font color="#003366" size="2" face="Verdana"><strong> 
        <input type="radio" name="database" value="sqlServer" checked>
        <%=lbl556%> </strong></font></td>
    </tr>
    <tr> 
      <td height="13" colspan="2"> <div align="right"><font size="2" face="Verdana"></font></div></td>
      <td> <div align="left"><font color="#003366" size="2" face="Verdana"></font></div></td>
      <td colspan="4"><font color="#003366" size="2" face="Verdana"><strong> 
        <input name="database" type="radio" value="MySql" >
       <%=lbl557%></strong></font> </td>
    </tr>
    <tr> 
      <td height="13" colspan="2"><div align="right"><font size="2" face="Verdana"><strong> 
          </strong></font></div></td>
      <td><div align="left"><font color="#003366" size="2" face="Verdana"></font></div></td>
      <td colspan="4"><font color="#003366" size="2" face="Verdana"><strong> 
        <input type="radio" name="database" value="Access">
        <%=lbl558%></strong></font></td>
    </tr>
    <tr> 
      <td colspan="7"><div align="right"></div>
        <div align="center"><img src="/skins/<%=session("skin")%>/elements/line.gif" width=560 height=1 border=0> 
        </div></td>
    </tr>
    <tr> 
      <td colspan="7"><div align="center"> 
          <input type="submit" name="Button35" value="<%=lbl559%>" class="commonButton" >
        </div></td>
    </tr> <tr> 
	
      <td colspan="2"><div align="center"> 
          &nbsp;
        </div></td>
    </tr>
  </table>
</form>
</body>
</html><!-- #INCLUDE FILE = "../inc/footer.asp" -->