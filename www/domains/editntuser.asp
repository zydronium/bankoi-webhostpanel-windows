<%
	accessLevel = 1
%>
<!-- #INCLUDE FILE = "../inc/security.asp" -->
<!-- #INCLUDE FILE = "../inc/db.asp" -->
<!-- #INCLUDE FILE = "../inc/params.asp" -->
<html>
<head>
<title><%=lbl610%></title>

<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/general.css">
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/custom.css">
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/layout.css">
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=ISO-8859-1">
<META HTTP-EQUIV="EXPIRES" CONTENT="0">
<script>
function submit_form(f)
{
//alert("Submit form called");
f.action='/domains/removemailacc.asp';
f.submit();
return true;
}



function validate(f)
{
    //alert(f.email.value);
    if(f.old_passwd.value=="")
	   {
			alert("<%=msg44%>");
			f.email.focus();
			return false;
	   }
    if(f.password.value=="")
	   {
			alert("<%=msg24%>");
			f.password.focus();
			return false;
	   }
	if(f.password.value!=f.password1.value)
	   {
			alert("<%=msg25%>");
			f.password.value="";
			f.password1.value="";
			f.password.focus();
			return false;
	   }
	f.action='/domains/editntuser1.asp';
	f.submit();
    return true;
}
</script>

</head>
<%
	'---------------------------------------------------------------------------------------------
	id=session("id")
	'---------------------------------------------------------------------------------------------
	username=session("resellername")
	NTusername=session("NTuser")
	'---------------------------------------------------------------------------------------------
%>

<!-- #INCLUDE FILE = "../inc/header.asp" -->


<!------------------------------------------------------------------------------------------------>
<!--Here the menu for Client is created-->
<!-- #INCLUDE FILE = "../server/subheader.asp" -->

<!----------------------------------------------------------------------------
The header of reseller prepared here-->
<!-- #INCLUDE FILE = "../domains/domainheader.asp" -->
<!--
----------------------------------------------------------------------------
The header ends here
-->
<body>
<form  method="post" name="mainform" >
  <table width=370 border=0 cellpadding=0 cellspacing=0 align="center">
    <tr> 
      <td colspan="2"><%=lbl509%> <font name="verdana" color="red"><strong><%=" "&ucase(session("contactname"))%></strong></font><img src="/skins/<%=session("skin")%>/elements/white.gif" width="100%" height=1 alt="" border=0></td>
      <td colspan="3"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="8" height="8" border="0"></td>
    </tr>
    
    <tr> 
      <th colspan="5"><font color="#003366" size="2" face="Verdana"><strong><%=lbl610%>  <font color="red"><%=NTusername%></font> for domain <font color="red"><%=session("domain")%></font></strong></font> </tr>
    <tr> 
      <td width="287" height="28"><div align="right"><font size="2" face="Verdana"><strong><%=lbl536%> </strong></font></div>
        <div align="center"> </div></td>
      <td width="25">&nbsp;</td>
      <td colspan="3"><input name="old_passwd" type="text" id="email"></td>
    </tr>
    <tr> 
      <td height="26"><div align="right"><font size="2" face="Verdana"><strong><%=lbl537%> 
          </strong></font></div>
        <div align="center"> </div></td>
      <td>&nbsp;</td>
      <td colspan="3"><input name="password" type="password" id="password"></td>
    </tr>
    <tr> 
      <td height="28"><div align="right"><font size="2" face="Verdana"><strong><%=lbl538%> </strong></font></div>
        <div align="center"> </div></td>
      <td>&nbsp;</td>
      <td colspan="3"><input name="password1" type="password" id="password1"></td>
    </tr>
    <tr> 
      <td colspan="5"><div align="right"></div>
        <div align="center"><img src="/skins/<%=session("skin")%>/elements/line.gif" width=560 height=1 border=0> 
        </div></td>
    </tr>
    <tr> 
      <td colspan="5"><div align="center"> 
          <input type="button" name="Button35" value="<%=lbl533%>" class="commonButton" onclick="return validate(document.mainform)">
        </div></td>
    </tr>
  </table>
<input type="hidden" name="NTuser" value="<%=NTusername%>">
</form>
</body>
</html><br>
<br>
<!-- #INCLUDE FILE = "../inc/footer.asp" -->