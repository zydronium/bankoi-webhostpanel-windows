<%
	accessLevel = 10
%>
<!-- #INCLUDE FILE = "../inc/security.asp" -->
<!-- #INCLUDE FILE="../inc/db.asp" -->

<html>
<head> <title><%=lblchadminpwd%></title>

<script>
function upd_oC(f)
{

	if(f.old_passwd.value=="")
	   {
			alert("Old password is blank");
			f.old_passwd.focus();
			return false;
	   }

    
	if (f.new_passwd.value=="" && f.new_passwd1.value=="") {
		alert('Password is empty');
		f.new_passwd.focus();
		return false;
	}

	if (f.new_passwd.value != f.new_passwd1.value) {
		alert('Passwords do not match!');
		f.new_passwd.value="";
		f.new_passwd1.value="";
		f.new_passwd.focus();
		return false;
	}

    f.action='/server/change_pass.asp';
	f.submit();
	return false;
}
//-->
</script>
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/general.css">
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/custom.css">
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/layout.css">
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=ISO-8859-1">
<META HTTP-EQUIV="EXPIRES" CONTENT="0">
</head>
<!-- #include file="../inc/header.asp" -->
<body leftmargin=0 topmargin=0>
<form name="mainform" method='post'>

  <table border="0" cellpadding=0 cellspacing=0 width="564" align="center">
<tr>
<td colspan="1"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="3" height="1" border="0"></td>
<td colspan="1"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="558" height="1" border="0"></td>
<td colspan="1"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="3" height="1" border="0"></td>
</tr>
<tr><td colspan=1><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="6" border="0"></td></tr>
<tr>
<td></td>
      <td><table border="0" cellpadding=0 cellspacing=0 width="558" align="left">
          <tr> 
            <td width="146" colspan="1"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="140" height="1" border="0"></td>
            <td width="17" colspan="1"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="17" height="1" border="0"></td>
            <td width="287" colspan="1"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="286" height="1" border="0"></td>
            <td width="115" colspan="1"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="115" height="1" border="0"></td>
          </tr>
          <tr> 
            <td colspan=3><font color="#003366">Administrator's password</font></td>
            <td><div align="center"> 
                <input name="button" type="button" class="commonButton" id="button3" title="<%=lbluplevel%>"   onClick="history.go(-1);" value="<%=lbluplevel%>"  >
              </div></td>
          </tr>
          <tr> 
            <td height="1" colspan=4><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="16" border="0"><img src="/skins/<%=session("skin")%>/elements/line.gif" width=564 height=1 border=0></td>
          </tr>
          <tr>
            <td colspan=4>&nbsp;</td>
          </tr>
          <tr> 
            <td colspan=4><table width="99%" border="0">
                <tr> 
                  <td width="47%" height="26"><div align="right"><%=lblOldPassword%></div></td>
                  <td width="5%"><div align="left"><font color="#FF0000">*</font></div></td>
                  <td width="48%"><input name="old_passwd" type="password" id="old_password"></td>
                </tr>
                <tr> 
                  <td><div align="right"><%=lblNewPassword%></div></td>
                  <td><div align="left"><font color="#FF0000">*</font></div></td>
                  <td> <input name="new_passwd" type="password" id="new_password"></td>
                </tr>
                <tr> 
                  <td><div align="right">Confirm New Password</div></td>
                  <td><div align="left"><font color="#FF0000">*</font></div></td>
                  <td><input name="new_passwd1" type="password" id="new_password1"></td>
                </tr>
              </table></td>
          </tr>
          <tr> 
            <td colspan=4><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="16" border="0"><img src="/skins/<%=session("skin")%>/elements/line.gif" width=564 height=1 border=0></td>
          </tr>
          <tr> 
            <td colspan=3><span class="requiredfield">*</span> <%=lblreqfield%></td>
            <td><div align="center"> 
                <input name="button2" type="button" class="commonButton" id="button23" title="<%=lblChangePassword%>"   onClick="return upd_oC(document.mainform)" value="<%=lblChange%>">
              </div></td>
          </tr>
        </table></td>
    </tr>
<tr><td colspan=1><img src="/skins/<%=session("skin")%>/elements/white.gif" width="1" height="8" border="0"></td></tr>
</table>

<input type='hidden' name='cmd' value='set_admin_passwd'>
</form>
</body>
</html>
<br>
<br>
<!-- #INCLUDE FILE = "../inc/footer.asp" -->