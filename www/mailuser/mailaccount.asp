<%
	accessLevel = 0
%>
<!-- #INCLUDE FILE = "../inc/security.asp" -->
<!-- #INCLUDE FILE="../inc/db.asp" -->
<!-- #INCLUDE FILE="../inc/params.asp" -->
<!-- #INCLUDE FILE="../inc/functions.asp" -->
<html>
<head>
<title><%=lbl636%></title>

<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/general.css">
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/custom.css">
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/layout.css">
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=ISO-8859-1">
<META HTTP-EQUIV="EXPIRES" CONTENT="0">

<script>
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
    return true;
}
</script>

</head>
<%
	'---------------------------------------------------------------------------------------------
	mailuser = session("userid")
	maildomain = session("maildomain")
    '---------------------------------------------------------------------------------------------
	If(mailuser= "" or maildomain = "") then
			Response.Redirect("../logout.asp")
	End if
	
%>

<!-- #INCLUDE FILE = "../mailuser/mailheader.asp" -->

<br>
<body>
<form  method="post" name="mainform" action="changemailpass.asp">
  <table width=570 border=0 cellpadding=0 cellspacing=0 align="center">
    <tr> 
      <th colspan="5"><font color="#003366" size="2" face="Verdana"><strong><%=lbl535%> <font color="red"><%=mailuser & "@" & maildomain%></font></strong></font>
	</td>
    </tr>
    
    <tr> 
      <td width="287" height="28"><div align="right"><font size="2" face="Verdana"><strong><%=lbl536%> </strong></font></div>
        <div align="center"> </div></td>
      <td width="25">&nbsp;</td>
      <td colspan="3"><input name="old_passwd" type="password" id="email"></td>
    </tr>
    
    <tr> 
      <td height="26"><div align="right"><font size="2" face="Verdana"><strong><%=lbl537%> 
          </strong></font></div>
        <div align="center"> </div></td>
      <td>&nbsp;</td>
      <td colspan="3"><input name="password" type="password" id="password"></td>
    </tr>
    <tr> 
      <td height="28"><div align="right"><font size="2" face="Verdana"><strong><%=lbl538%></strong></font></div>
        <div align="center"> </div></td>
      <td>&nbsp;</td>
      <td colspan="3"><input name="password1" type="password" id="password1"></td>
    </tr>
    <tr> 
      <td colspan="5"><div align="right"></div>
        <br><div align="center"><img src="/skins/<%=session("skin")%>/elements/line.gif" width=560 height=1 border=0> 
        </div></td>
    </tr>
    
    <tr> 
      <td colspan="5"><div align="center"> 
          <br><input type="submit" name="Button35" value="<%=lbl533%>" class="commonButton" onclick="return validate(document.mainform)">
        </div></td>
    </tr>
  </table>
</form>
<br>
<br>
<!-- #INCLUDE FILE = "../inc/footer.asp" -->
</body>
</html>
