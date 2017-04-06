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


<!-- #INCLUDE FILE = "../inc/header.asp" -->
<!------------------------------------------------------------------------------------------------>
<!--Here the menu for Client is created-->
<!-- #INCLUDE FILE = "../server/subheader.asp" -->

<!-- #INCLUDE FILE = "../domains/domainheader.asp" -->

<body>
<form  method="post" name="mainform" action="/domains/setpassword1.asp">
<!----------------------------------------------------------------------------------------->


<%
	dirname=request("folder")
	username=request("username")
    id=session("id")
	GetPath = Request("DirPath")
	'Response.write "the path is " & GetPath & "<br>"
	usertype=session("type")
	if(usertype="d") then
	query = "select pwdprotectdir from tblrights where id='" & id & "'"
	'response.write query
	set Chk = Server.CreateObject("ADODb.Recordset")
	Chk.open query,con
	if(ucase(chk("pwdprotectdir")) = Ucase("n")) then
%>
		<script>
			alert("<%=msg112%>");
			window.location = "/domains/edit_domain.asp";
		</script>
<%
		response.end
	end if
	end if

%>  
<input type="hidden" name="dirname" value="<%=dirname%>">
<input type="hidden" name="username" value="<%=username%>">


<!----------------------------------------------------------------------------------------->

<table width=370 border=0 cellpadding=0 cellspacing=0 align="center">
  <tr> 
    <td><p><%=lbl509%> <font name="verdana" color="red"><strong><%=" "&ucase(session("resellername"))%></strong></font></p>
      <div align="right"></div>
      <div align="center"><img src="/skins/<%=session("skin")%>/elements/line.gif" width=560 height=1 border=0></div>
      <p><img src="/skins/<%=session("skin")%>/elements/white.gif" width="100%" height=1 alt="" border=0></p></td>
  </tr>
  <tr> 
    <td height="24"><div align="center"><font color="#003366" size="2" face="Verdana"><strong><%=lbl644%> &nbsp;&nbsp;&nbsp;&nbsp;<%=dirname%></strong> </font></div>
  <tr> 
    <td><div align="center"><font color="#003366" size="2" face="Verdana"><strong><%=lbl617%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=username%></strong> 
        </font></div></tr><tr>
 
    <td> <div align="center"><img src="/skins/<%=session("skin")%>/elements/line.gif" width=560 height=1 border=0> 
      </div>
  <tr>
    <td><div align="center">
        <input type="submit" name="Button35" value="<%=lbl511%>" class="commonButton">
        <input type="button" name="Button352" value="<%=lbl512%>" class="commonButton" onClick="window.location='/domains/explorer.asp'">
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
</body>
 <input type="hidden" name="path" value="<%=request("path")%>">
<input type="hidden" name="setPath" value="<%=request("DirPath")%>">
</form>     
</html>
<!-- #INCLUDE FILE = "../inc/footer.asp" -->
