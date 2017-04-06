<!-- #include file="inc/lang.asp" -->
<html>
<head>
<title>Get password</title>
<script>
function chk(f)
{
	if(f.loginname.value=="")
	{
		alert("<%=msg99%>");
		f.loginname.focus();
		return false;
	}

	emailExp= /^\w+(\-\w+)*(\.\w+(\-\w+)*)*@\w+(\-\w+)*(\.\w+(\-\w+)*)+$/;
   if (!(emailExp.test(f.email.value)))
      { 
		   alert("<%=lbl541%>");
		   f.email.value="";
		   f.email.focus();
		   return false;  
	  }

	if(f.email.value=="")
	{
		alert("Email is blank");
		f.email.focus();
		return false;
	}

	return true;
}
</script>
<link rel="stylesheet" type="text/css" href="/skins/default/css/general.css">
<link rel="stylesheet" type="text/css" href="/skins/default/css/custom.css">
<link rel="stylesheet" type="text/css" href="/skins/default/css/layout.css">
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=ISO-8859-1">
<META HTTP-EQUIV="EXPIRES" CONTENT="0">

</head>

<body leftmargin=0 topmargin=0 >
 <form name=form1 action="validatelogin.asp" method="post" onSubmit="return chk(document.form1)">
<table border="0" cellpadding=0 cellspacing=0 width="564" align="center">
  <tr>
    <td colspan="1"><img src="/skins/green/elements/white.gif" alt="" width="3" height="1" border="0"></td>
	<td colspan="1"><img src="/skins/green/elements/white.gif" alt="" width="247" height="1" border="0"></td>
	<td colspan="1"><img src="/skins/green/elements/white.gif" alt="" width="7" height="1" border="0"></td>
	<td colspan="1"><img src="/skins/green/elements/white.gif" alt="" width="304" height="1" border="0"></td>
	<td colspan="1"><img src="/skins/green/elements/white.gif" alt="" width="3" height="1" border="0"></td>
  </tr>
  <tr>
	<td colspan=1><img src="/skins/default/elements/white.gif" alt="" width="1" height="6" border="0"></td>
  </tr>
  <tr>
    <td></td>
	<td colspan=3 align="center"><img src='/skins/default/images/def_logo.gif' name='logo' width=100 height=100 border=0></td>
  </tr>
  <tr>
	<td colspan=5><img src="/skins/default/elements/line.gif" width=564 height=1 border=0></td>
  </tr>
  <tr>
	<td colspan=1><img src="/skins/default/elements/white.gif" alt="" width="1" height="32" border="0"></td>
  </tr>
  <tr>
	<td align=right colspan="5">
	
	<input type="button" class="commonButton" id="bid-up-level" value="<%=lbl633%>" title="<%=lbl633%>" onClick="window.location='login.asp'"></td>
  </tr>
  <tr>
	<td colspan=1><img src="/skins/default/elements/white.gif" alt="" width="1" height="32" border="0"></td>
  </tr>
  <tr>
	<td colspan="5"><b>Attention!!!</b><br>
<%=msg98%><br>
<%=msg97%></td>
  </tr>
  <tr>
	<td colspan=1><img src="/skins/default/elements/white.gif" alt="" width="1" height="16" border="0"></td>
  </tr>
 
    <tr>
	  <td></td>
	  <td align="right"> <%=lblLogin%>:</td>
	  <td></td>
	  <td><input type='text' name="loginname" value='' size=25 maxlength=255></td>
	</tr>
  <tr>
	<td colspan=1><img src="/skins/default/elements/white.gif" alt="" width="1" height="8" border="0"></td>
  </tr>
      <tr>
	  <td></td>
	  <td align="right"><%=lbl603%>:</td>
	  <td></td>
	  <td><input type='text' name='email' value='' size=25 maxlength=255></td>
	</tr>
	<tr>
	  <td colspan=1><img src="/skins/default/elements/white.gif" alt="" width="1" height="8" border="0"></td>
	</tr>
    <tr>
	  <td colspan="3"><img src="/skins/default/elements/white.gif" alt="" width="1" height="22" border="0"></td>
	  <td><input type="submit" class="commonButton" id="bid-send-by-email" value="<%=lbl724%>" title="<%=lbl724%>" ></td>
	</tr>
  </form>
</table>
</body>
</html>
<br>
<br>
</html>
<!-- #include file="inc/footer.asp" -->