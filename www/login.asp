<!--#include file = "inc/lang.asp"-->
<html>		
<head>
<title>Bankoi Webhost Panel</title>		
<script>
		<!--
		function login_oC(f1,f2)
		{
			if ((f1.login_name.value == "") || (f2.passwd.value == "")) {
				alert("<%=msg111%>");
				f1.login_name.focus();
				f1.login_name.select();
				return false;
			}
			f2.login_name.value=f1.login_name.value;
			f2.submit();
			return false;
		}
		function setFocus()
		{
			if (document.forms[0].login_name) {
				document.forms[0].login_name.focus();
				document.forms[0].login_name.select();
			}
		}
		function get_password_oC(f1, f2)
		{
			f1.login_name.value = f2.login_name.value;
			f1.submit();
		}
		//-->
		</script>
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/general.css">
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/custom.css">
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/layout.css">
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=ISO-8859-1">
<META HTTP-EQUIV="EXPIRES" CONTENT="0">
<style>
.textboxclass
	{
		Font-family: Trebuchet Ws,Verdana, Arial, Helvetica, sans-serif;
		Font-size: 11px;
		border: 1px solid #999999; 
		padding: 0;
	}
	
  .btn
  {
  		color: #000000;
		width: 60px;
  		background-color: #eeeeee;
  		background-image: url(images/btn_bg.gif);
  		border: none;
  }
</style>
</head>
<body leftmargin=0 topmargin=0 >
<table width="774" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td><img src="imgs/v.gif" width="774" height="65"></td>
  </tr>
</table>
<p><br>
</p>
<table width="447" border="0" align="center" cellpadding="1" cellspacing="1">
  <tr>
    <td width="566" bgcolor="#999999"><table width="447" border="0" align="center" cellpadding=0 cellspacing=0>
        <tr> 
          <td height="59" colspan=4 background="imgs/h.gif" bgcolor="#FFFFFF"><div align="center"><font color="#FFFFFF" size="4">Bankoi 
              Webhost Panel </font></div></td>
        </tr>
        <form name='form1' onSubmit='if ((document.forms[1]) && (!document.forms[1].passwd.value)) document.forms[1].passwd.focus(); return false;'>
          <%
  if(request("mode") = "failed") then
  %>
          <tr bgcolor="#FFFFFF"> 
            <td colspan=4 align="center" valign="middle" height="35" bgcolor="#FFFFFF">Invalid 
              User or Password</td>
          </tr>
          <%
  else
  %>
          <tr> 
            <td colspan=4 height="34" bgcolor="#FFFFFF">&nbsp;</td>
          </tr>
          <%
  end if
  %>
          <tr> 
            <td width="9" bgcolor="#FFFFFF">&nbsp;</td>
            <td width="245" align=right bgcolor="#FFFFFF"> <%=lblLogin%>:</td>
            <td width="9" bgcolor="#FFFFFF"></td>
            <td width="292" bgcolor="#FFFFFF"><input name='login_name' type='text' class="textboxclass" value='' size=25 maxlength=255></td>
          </tr>
	 
        </form>
        <tr bgcolor="#FFFFFF"> 
          <td colspan=4><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></td>
        </tr>
        <form name='form2' action='/validateuser.asp' method='post' onSubmit='return login_oC(document.forms[0], document.forms[1])'>
          <tr> 
            <td bgcolor="#FFFFFF"></td>
            <td align=right bgcolor="#FFFFFF"> <%=lblPass%>:</td>
            <td bgcolor="#FFFFFF"></td>
            <td bgcolor="#FFFFFF"><input name='passwd' type='password' class="textboxclass" size=25 ></td>
          </tr>
          <tr>
            <td bgcolor="#FFFFFF" colspan="4" >&nbsp;</td>
          </tr>
          <tr> 
            <td bgcolor="#FFFFFF" colspan="4" ><div align="center"> 
                <input name="button" type="button" class="commonButton" id="bid-login" title="<%=lblLogin%>" onClick="return login_oC(document.forms[0], document.forms[1]);" value="<%=lblLogin%>"  >
              </div></td>
          </tr>
          <input type="hidden" name="login_name" value="">
        </form>
        <tr> 
          <td colspan=4 bgcolor="#FFFFFF"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="16" border="0"></td>
        </tr>
        <tr bgcolor="#FFFFFF"> 
          <td colspan=4><img src="/skins/<%=session("skin")%>/elements/line.gif" width=448 height=1 border=0></td>
        </tr>
        <tr bgcolor="#FFFFFF"> 
          <td colspan=4><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="16" border="0"></td>
        </tr>
        <tr> 
          <td colspan=4 align="center" bgcolor="#FFFFFF"><img src="imgs/en.gif" width="16" height="10" border="0">&nbsp;<a href="setlang.asp?lang=en">English</a>&nbsp;&nbsp; 
            <img src="imgs/es.gif" width="16" height="10" border="0">&nbsp;<a href="setlang.asp?lang=es">Espanol 
            </a><a href="setlang.asp?lang=en"></a>&nbsp;&nbsp; <img src="imgs/po.gif" width="16" height="10">&nbsp;<a href="setlang.asp?lang=po">Portuguese</a>&nbsp;&nbsp; 
            <img src="imgs/be.gif" width="16" height="10">&nbsp;<a href="setlang.asp?lang=be">Dutch</a> 
            &nbsp;&nbsp; <img src="imgs/fr.gif" width="16" height="10">&nbsp;<a href="setlang.asp?lang=fr">French</a></td>
        </tr>
        <tr> 
          <td colspan=4 bgcolor="#FFFFFF"><div align="center"> 
              <p>&nbsp;</p>
              <p><font size="1" face="Verdana, Arial, Helvetica, sans-serif">Bankoi 
                WebHost Panel in your own language ? Check localization projects 
                <a href="http://www.webhost-panel.com/download/download.html" target="_blank">here</a>.</font></p>
            </div></td>
        </tr>
        <tr bgcolor="#FFFFFF"> 
          <td colspan=4><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="16" border="0"></td>
        </tr>
        <tr bgcolor="#FFFFFF"> 
          <td colspan=4><img src="/skins/<%=session("skin")%>/elements/line.gif" width=447 height=1 border=0></td>
        </tr>
        <tr> 
          <td colspan=4 bgcolor="#FFFFFF"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="16" border="0"></td>
        </tr>
        <form name='form3' action='/get_password.asp' method='post'>
          <tr> 
            <td colspan="4" bgcolor="#FFFFFF"><b><font size="1" face="Verdana, Arial, Helvetica, sans-serif"><%=msg96%></font></b><br>
              <font size="1" face="Verdana, Arial, Helvetica, sans-serif"><%=msg97%></font></td>
          </tr>
          <tr> 
            <td colspan=4 bgcolor="#FFFFFF"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="16" border="0"></td>
          </tr>
          <tr> 
            <td bgcolor="#FFFFFF" colspan="4"><div align="center"> 
                <input name="button" type="button" class="commonButton" id="bid-get-password" title="<%=lbl725%>" onClick="return get_password_oC(document.forms[2], document.forms[0]);" value="<%=lbl725%>">
              </div></td>
          </tr>
          <input type="hidden" name="login_name" value="">
        </form>
        <tr bgcolor="#FFFFFF"> 
          <td colspan=4><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></td>
        </tr>
      </table></td>
  </tr>
</table>
<p>&nbsp; </p>

</body>		
</html><!-- #include file="inc/footer.asp" -->