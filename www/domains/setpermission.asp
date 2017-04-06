<%
	accessLevel = 1
%>
<!-- #INCLUDE FILE = "../inc/params.asp" -->
<!-- #INCLUDE FILE = "../inc/security.asp" -->
<!-- #INCLUDE FILE = "../inc/db.asp" -->
<html>
<head>
<title><%=lbl612%></title>

<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/general.css">
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/custom.css">
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/layout.css">
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=ISO-8859-1">
<META HTTP-EQUIV="EXPIRES" CONTENT="0">
</head>
<body>
<!-- #INCLUDE FILE = "../inc/header.asp" -->
<!------------------------------------------------------------------------------------------------>
<!--Here the menu for Client is created-->
<!-- #INCLUDE FILE = "../server/subheader.asp" -->

<!-- #INCLUDE FILE = "../domains/domainheader.asp" -->

<form  method="post" name="mainform" action="/domains/setpermission1.asp">
<!----------------------------------------------------------------------------------------->
<%
	dirname=request("folder")
	writePerm=request("write")
	if(writePerm = "1") then 
	writePermDisp="Yes" 
	else 
		writePermDisp="No"
		writePerm = "0"
	end if
%>  
<input type="hidden" name="dirname" value="<%=dirname%>">
<input type="hidden" name="write" value="<%=writePerm%>">
<!----------------------------------------------------------------------------------------->
<table width=370 border=0 cellpadding=0 cellspacing=0 align="center">
  <tr> 
    <td><p><%=lbl509%> <font name="verdana" color="red"><strong><%=" "&ucase(session("resellername"))%></strong></font></p>
      <div align="right"></div>
      <div align="center"><img src="/skins/<%=session("skin")%>/elements/line.gif" width=560 height=1 border=0></div>
      <p><img src="/skins/<%=session("skin")%>/elements/white.gif" width="100%" height=1 alt="" border=0></p></td>
  </tr>
  <tr> 
    <td height="24"><div align="left"><font color="#003366" size="2" face="Verdana"><strong><%=lbl644%> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=dirname%></strong> </font></div>
  <tr> 
    <td><div align="left"><font color="#003366" size="2" face="Verdana"><strong><%=lbl713%>&nbsp;&nbsp;&nbsp;&nbsp;<%=writePermDisp%></strong> 
        </font></div></tr><tr>
 
    <td> <div align="center"><img src="/skins/<%=session("skin")%>/elements/line.gif" width=560 height=1 border=0> 
      </div>
  <tr>
    <td><div align="center">
        <input type="submit" name="Button35" value="<%=lbl511%>" class="commonButton">
        <input type="button" name="Button352" value="<%=lbl512%>" class="commonButton" onClick="window.location='/domains/permexplorer.asp'">
      </div>
  <tr> 
   <tr> 
	
      <td colspan="2"><div align="center"> 
          &nbsp;
        </div></td>
    </tr>
	 <tr> 
	
      <td colspan="2"><div align="center"> 
          &nbsp;
        </div></td>
    </tr>
</table>
<input type="hidden" name="path" value="<%=request("path")%>">
</form> 
<!-- #INCLUDE FILE = "../inc/footer.asp" -->

</body>
     
</html>
