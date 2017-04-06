<%
	accessLevel = 10
%>
<!-- #INCLUDE FILE = "../inc/security.asp" -->
<!-- #INCLUDE FILE = "../inc/db.asp" -->
<!-- #INCLUDE FILE = "../inc/functions.asp" -->
<html>
<head>
 
<title><%=lbl729%></title>
<script>
<!--
function err_pass(key)
{
	var login	= "<%=msg100%>";
	var passwd	= "<%=msg101%>";
	switch (key) {
		case "login":
			alert("<%=msglogin%>" + login);
			break;
		case "passwd":
			alert("<%=lblpwd%>" + passwd);
			break;
		default:
			alert("<%=lblloginpwd%>" + login + "\n" + passwd);
			break;
	}
}

function chk_name(usr)
{
	re = /^[a-zA-Z0-9]{1}[A-Za-z0-9_.-]{0,19}$/;
	return usr.search(re) != -1;
}

function chk_sys_passwd(username, passwd)
{
	if ((passwd.length < 5) || (passwd.length > 16))
		return false;

	if (passwd.length >= username.length) {
		if (passwd.indexOf(username, 0) != -1)
			return false;
	}

	if ((passwd.indexOf('\'') != -1) || (passwd.indexOf(' ') != -1))
		return false;	
	for (i = passwd.length; i-- > 0;) {
		if (passwd.charCodeAt(i) > 127)
	 		return false;
	}	
	return true;
}

function chk_form_data(f)
{
	if(f.pname.value == "")
		{
			alert("<%=msg103%>");
			f.pname.focus();
			return false;
		}

	if(!chk_name(f.login.value))
		{
			alert("<%=msg102%>");
			f.login.focus();
			return false;
		}


	if (f.passwd[0].value && (f.passwd[0].value != f.passwd[1].value)) {
		alert("<%=msg25%>");
		f.passwd[0].focus();
		f.passwd[0].select();
		return false;
	}

	    
	if (!chk_sys_passwd(f.login.value, f.passwd[0].value)) {
		f.passwd[0].focus();
		f.passwd[0].select();
		err_pass();
		return false;
	}

	


	if (f.email.value=="") {
		alert("<%=msg47%>");
		f.email.focus();
		return false;
	}
	if(f.country.value == "<%=lblselcountry%>")
          {
				alert("<%=lblselcountry%>");
				f.country.focus();
				return false;
		  }

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
<body leftmargin=0 topmargin=0 >
<!-- #include file="../inc/header.asp" -->
<form action='../clients/addclient.asp' method='post' name="mainform">
  <p>&nbsp;</p>
  <table border="0" cellpadding=0 cellspacing=0 width="564" align="center">
    <tr> 
      <td colspan="1"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="3" height="1" border="0"></td>
      <td colspan="1"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="436" height="1" border="0"></td>
      <td colspan="1"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
      <td colspan="1"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="115" height="1" border="0"></td>
      <td colspan="1"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="3" height="1" border="0"></td>
    </tr>
    <tr> 
      <td colspan=1><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="7" border="0"></td>
    </tr>
    <tr> 
      <td rowspan="2"></td>
      <td colspan="3"><div align="center"><font color="#006666"><img src="/skins/<%=session("skin")%>/elements/line.gif" width=560 height=1 border=0></font></div></td>
    </tr>
    <tr> 
      <td><font color="#FF0000"><%=lbl716%>:</font></td>
      <td></td>
      <td class="verttop"><input name="button" type="button" class="commonButton" id="bid-up-level" title="<%=lbluplevel%>"  onClick="window.location='/clients/clients.asp';" value="<%=lbluplevel%>"  ></td>
    </tr>
    <tr> 
      <td colspan=1><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="15" border="0"></td>
    </tr>
    <tr> 
      <td></td>
      <td colspan=3> <table border="0" cellpadding=0 cellspacing=0 width="558" align="left">
          <tr> 
            <td width="142" colspan="1"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="140" height="1" border="0"></td>
            <td width="17" colspan="1"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="17" height="1" border="0"></td>
            <td width="401" colspan="1"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="401" height="1" border="0"></td>
          </tr>
          <tr> 
            <td align='right'><%=lblcompanyname%></td>
            <td align='center'></td>
            <td><input type='text' name='cname' size=25 maxlength=255 value=""></td>
          </tr>
          <tr> 
            <td colspan=1><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></td>
          </tr>
          <tr> 
            <td align='right'><%=lblcontactname%></td>
            <td align='center'><font color="#FF0000"><span class="requiredfield">*</span></font></td>
            <td><input type='text' name='pname' size=25 maxlength=60 value=""></td>
          </tr>
          <tr> 
            <td colspan=1><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></td>
          </tr>
          <tr> 
            <td align='right'><%=lbl714%>:</td>
            <td align='center'><font color="#FF0000"><span class="requiredfield">*</span></font></td>
            <td><input type='text' name='login' size=25 maxlength=15 value=""></td>
          </tr>
          <tr> 
            <td colspan=1><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></td>
          </tr>
          <tr> 
            <td align='right'><%=lblcppasswd%></td>
            <td align='center'><font color="#FF0000"><span class="requiredfield">*</span></font></td>
            <td><input type='password' name='passwd' size=25 maxlength=14 value=""></td>
          </tr>
          <tr> 
            <td colspan=1><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></td>
          </tr>
          <tr> 
            <td align='right'><%=lblconfirmpwd%></td>
            <td align='center'><span class="requiredfield"><font color="#FF0000">*</font></span></td>
            <td><input type='password' name='passwd' size=25 maxlength=14 value=""></td>
          </tr>
          <tr> 
            <td colspan=1><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></td>
          </tr>
          <tr> 
            <td align='right'><%=lblphone%></td>
            <td align='center'></td>
            <td><input type='text' name='phone' size=25 maxlength=30 value=""></td>
          </tr>
          <tr> 
            <td colspan=1><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></td>
          </tr>
          <tr> 
            <td align='right'><%=lblFax%></td>
            <td align='center'></td>
            <td><input type='text' name='fax' size=25 maxlength=30 value=""></td>
          </tr>
          <tr> 
            <td colspan=1><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></td>
          </tr>
          <tr> 
            <td align='right'><%=lblemail%></td>
            <td align='center'><font color="#FF0000">*</font></td>
            <td><input type='text' name='email' size=25 maxlength=255 value=""></td>
          </tr>
          <tr> 
            <td colspan=1><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></td>
          </tr>
          <tr> 
            <td align='right'><%=lbladdress%></td>
            <td align='center'></td>
            <td><input type='text' name='address' size=25 maxlength=255 value=""></td>
          </tr>
          <tr> 
            <td colspan=1><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></td>
          </tr>
          <tr> 
            <td align='right'><%=lblcity%></td>
            <td align='center'></td>
            <td><input type='text' name='city' size=25 maxlength=50 value=""></td>
          </tr>
          <tr> 
            <td colspan=1><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></td>
          </tr>
          <tr> 
            <td align='right'><%=lblstate%></td>
            <td align='center'></td>
            <td><input type='text' name='state' size=25 maxlength=255 value=""></td>
          </tr>
          <tr> 
            <td colspan=1><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></td>
          </tr>
          <tr> 
            <td align='right'><%=lblzipcode%></td>
            <td align='center'></td>
            <td><input type='text' name='pcode' size=25 maxlength=10 value=""></td>
          </tr>
          <tr> 
            <td colspan=1><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></td>
          </tr>
          <tr> 
            <td align='right'><%=lblCountry%></td>
            <td></td>
            <%
'--------------------------------------------------------------------------------------------------
	'Here we are getting the name of the countries with there codes
    dim rscountry , query
	set rscountry = Server.CreateObject("ADODB.Recordset")
	query = "select * from tblcountry"
	set rscountry = con.execute(query)
%>
            <td><select name="country" style="color: #000080; font-family: Verdana" >
                <option value="Select Country"><%=lblselcountry%></option>
                <%  while(not rscountry.EOF) %>
                <option value="<%=rscountry("code")%>"><%=rscountry("countryname")%> 
                </option>
                <%  rscountry.movenext
					   wend 	   %>
              </select> </td>
          </tr>
          <tr> 
            <td colspan=1><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></td>
          </tr>
          <tr> 
            <td align='right'><%=lblinterlang%></td>
            <td></td>
            <td><select name="locale_var" >
                <option value="en" selected>English 
                <option value="es">Spanish </select> </td>
          </tr>
          <tr> 
            <td colspan="3" align='right'><div align="center"><font color="#006666"><img src="/skins/<%=session("skin")%>/elements/line.gif" width=560 height=1 border=0></font></div></td>
          </tr>
        </table></td>
    </tr>
    <tr> 
      <td colspan=1> <img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="16" border="0"></td>
    </tr>
    <tr> 
      <td></td>
      <td><span class="requiredfield">*</span>&nbsp;<%=lbl715%>.</td>
      <td colspan=2 align="right"> <input name="button" type="button" class="commonButton" id="bid-update" title="<%=lblUpdate%>"  onClick="return chk_form_data(document.mainform);" value="<%=lblCreate%>" > 
      </td>
    </tr>
    <tr> 
      <td colspan=1><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></td>
    </tr>
  </table>
  <input type=hidden name=cmd value="<%=lblUpdate%>">
</form>
</body>
</html>
<br>
<br>
<!-- #INCLUDE FILE = "../inc/footer.asp" -->