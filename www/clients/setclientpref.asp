<%
	accessLevel = 10
%>
<!-- #INCLUDE FILE = "../inc/security.asp" -->
<!-- #INCLUDE FILE="../inc/db.asp" -->
<html>
<head>
<title><%=lblSetClientPreferences%></title>
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/general.css">
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/custom.css">
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/layout.css">
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=ISO-8859-1">
<META HTTP-EQUIV="EXPIRES" CONTENT="0">
</head>
<%
	filename=request("logo")
	response.write "The filename is " & filename
	skinname=request("select")
	response.write "The skinname is " & skinname
	username=session("resellername")
%> 
<body>
<!-- #include file="../inc/header.asp" -->
<!--#INCLUDE file= "../clients/clientheader.asp"-->   
<form  method='post' enctype="multipart/form-data" name="mainform">
   <table width="564" border="0" align="center" cellpadding=0 cellspacing=0>
        <tr > 
          <td colspan=2 height="19" valign="middle">&nbsp;</td>
          <td height="19" valign="middle"><div align="right"> 
              <%	
    usertype=session("type")
	if(usertype="a") then
%>		  
              <input name="Button2" type="button" class="commonButton" id="Button" title="<%=lblup1level%>" onClick="window.location='/server/domains.asp';" value="<%=lbluplevel%>" >
<%else%>
			  <input name="Button2" type="button" class="commonButton" id="Button" title="<%=lblup1level%>" onClick="window.location='/domains/clientdomains.asp';" value="<%=lbluplevel%>" >
<%end if%>
            </div></td>
        </tr>
        <br>
        <br>
        <br>
      </table>
	  <table align="center">
        <tr> 
          <td height="21" align="center"> <div align="center"><img src="/skins/<%=session("skin")%>/elements/line.gif" width=560 height=1 border=0> 
            </div></td>
        </tr>
      </table>
      <table width="58%" border="0" align="center">
        <tr> 
          <td><div align="center"><%=lblPreferencesforclient%> <font color="#CC0000" face="	vwerdana"><strong><%=" "&username&" "%> 
               </strong></font>set</div>
            <div align="left"> </div></td>
        </tr>
        <tr> 
          <td> <div align="center"><img src="/skins/<%=session("skin")%>/elements/line.gif" width=560 height=1 border=0> 
            </div></td>
        </tr>
        <tr> 
          <td><div align="center"> 
              <input name="Button23" type="button" class="commonButton" id="Button23" title="<%=lblOk%>" onClick="window.location='upload.asp';" value="<%=lblOk%>" >
            </div></td>
        </tr>
      </table>
      <p>&nbsp;</p></form>
</body>
</html>
<!-- #INCLUDE FILE = "../inc/footer.asp" -->