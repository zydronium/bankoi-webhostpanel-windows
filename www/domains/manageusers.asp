<%
	accessLevel = 1
%>
<!-- #INCLUDE FILE = "../inc/security.asp" -->
<!-- #INCLUDE FILE = "../inc/db.asp" -->
<!-- #INCLUDE FILE = "../inc/params.asp" -->
<html>
<head>
<title><%=lbl647%></title>

<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/general.css">
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/custom.css">
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/layout.css">
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=ISO-8859-1">
<META HTTP-EQUIV="EXPIRES" CONTENT="0">

<script>
function submit_form(f)
{
	f.action='/domains/removentusers.asp';
	f.submit();
}
function chk_name(usr)
{
	re = /^[a-zA-Z0-9]{1}[A-Za-z0-9_.-]{0,19}$/;
	return usr.search(re) != -1;
}

function validate(f)
{
	if(!chk_name(f.ftpusername.value))
		{
			alert("<%=msg56%>");
			return false;
		}

	if(!chk_name(f.password.value))
		{
			alert("<%=msg55%>");
			return false;
		}

	if(f.ftpusername.value=="")
	   {
			alert("<%=msg57%>");
			f.ftpusername.focus();
			return false;
	   }
    if(f.password.value=="")
	   {
			alert("<%=msg48%>");
			f.password.focus();
			return false
	   }
	 if(f.name.value=="")
	   {
			alert("<%=msg58%>");
			f.password.focus();
			return false
	   }  
	if((f.password.value.length < 5) || (f.password.value.length > 20))
	   {
			alert("<%=msg59%>");
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
    id=session("id") 'ID of the domain
    '---------------------------------------------------------------------------------------------
	'Here we are extracting the name of the Domain according to the id stored in the session
	query="select username from tblloginmaster where id='" & id & "'"
	'response.write query
	set rs=server.createobject("ADODB.Recordset")
	rs.open query,con
	username=rs("username")
	rs.close
	
	query="select *from manageusers where domainid='" & id & "' order by username"
	dim rsdsn
	set rsdsn=server.createobject("ADODB.Recordset")
	rsdsn.open query,con
	
%>

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
<body><form action="/domains/createuser.asp" method="post" name="mainform" onSubmit="return validate(document.mainform)"> 
<%
	if(not rsdsn.EOF) then
%>
<table width="56%" border="0" align="center">
  <tr> 
    <td colspan="5"><%=lbl509%> <font name="verdana" color="red"><strong><%=" "&ucase(session("contactname"))%></strong></font></td>
  </tr>
  <tr> 
    <th colspan="5"><div align="center"><strong><font color="Blue" size="2" face="Verdana"><%=lbl649%></font><font color="#FF0000" size="2" face="Verdana"><%=username%></font></strong></div></td>
  </tr>
  <tr> 
    <td><div align="center"><strong><%=lbl617%></strong></div></td>
    <td><div align="center"><strong><%=lbl650%></strong></div></td>
    <td><div align="center"><strong><%=lbl51%></strong></div></td>
    <td><div align="center"><strong><%=lblPass%></strong></div></td>
    <td>&nbsp;</td>
  </tr><%
    while(not rsdsn.EOF)
%>
  <tr> 

      <td height="19"  align="center"><div align="center"><font color="#FF0000"><a href ="user.asp?name=<%=rsdsn("username")%>" style=text-decoration:none><%=rsdsn("username")%></a></font></div>
	  </td>

      <td height="19"  align="center"><font color="#FF0000"><%=rsdsn("name")%></font>
	  </td>
<%
  if(ucase(rsdsn("type"))=ucase("F")) then
%>
      <td align="center"><div align="center"><font color="#FF0000"><%=lbl652%></font></div>
	  </td>

<%
elseif(ucase(rsdsn("type"))=ucase("A")) then
%>
	  <td align="center"><div align="center"><font color="#FF0000"><%=lbl653%></font></div>
	  </td>
<%
end if
%>
      <td align="center"><div align="center"><font color="#FF0000"><%=rsdsn("password")%> 
      </font></div></td>
<%
  if(ucase(rsdsn("type"))=ucase("F")) then
%>
      <td colspan="4" align="center"><div align="left">
          <input type="checkbox" name="ntuser" value="<%=rsdsn("username")%>">
          </div>
      </td>
<%
end if
%>
</tr>
    <%
    rsdsn.movenext
    wend
%>
    <tr> 
      <td height="21" colspan="9" align="center"><div align="right"> 
          <input type="button" name="Button352" value="<%=lbl548%>" class="commonButton" onClick="return submit_form(document.mainform)">
        </div></td>
    </tr>
    <%
	end if
%>
</table>
<table width=370 border=0 cellpadding=0 cellspacing=0 align="center">
  <tr> 
    <td colspan="2"><img src="/skins/<%=session("skin")%>/elements/white.gif" width="100%" height=1 alt="" border=0></td>
    <td width="264"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="8" height="8" border="0"></td>
  </tr>
  <tr> 
    <td colspan="3"><div align="center"><img src="/skins/<%=session("skin")%>/elements/line.gif" width=560 height=1 border=0></div></td>
  </tr>

  <tr> 
    <th height="11" colspan="4" align="center"><strong><font color="Blue" size="2" face="Verdana"><%=lbl654%> </font><font color="#FF0000" size="2" face="Verdana"><%=username%></font></strong> 
  </tr>
  <tr> 
    <td width="260" height="28"><div align="right"><font size="2" face="Verdana"><strong> 
        <%=lbl617%></strong></font></div></td>
    <td width="36"><font size="2" face="Verdana"><strong> </strong></font></td>
    <td><font size="2" face="Verdana"><strong> 
      <input name="ftpusername" type="text">
      </strong></font></td>
  </tr>
  <tr> 
    <td height="30"><div align="right"><strong><%=lbl650%> </strong></div></td>
    <td width="36"><strong> </strong></td>
    <td><strong> 
      <input name="fullname" type="text" id="fullname3">
      </strong></td>
  </tr>
  <tr> 
    <td height="28"><div align="right"><font size="2" face="Verdana"><strong><%=lblPass%></strong> 
        </font></div></td>
    <td>&nbsp;</td>
    <td><font size="2" face="Verdana"> 
      <input name="password" type="password">
      </font></td>
  </tr>
  <tr> 
    <td height="26"><div align="right"><font size="2" face="Verdana"><strong><%=lbl538%></strong> </font></div></td>
    <td>&nbsp;</td>
    <td><font size="2" face="Verdana"> 
      <input name="password1" type="password">
      </font></td>
  </tr>
  <tr> 
    <td colspan="3"><div align="right"></div>
      <div align="center"><img src="/skins/<%=session("skin")%>/elements/line.gif" width=560 height=1 border=0> 
      </div></td>
  </tr>
  <tr> 
    <td colspan="3"><div align="center"> 
        <input type="submit" name="Button35" value="<%=lbl655%>" class="commonButton" >
      </div></td>
  </tr> <tr> 
	
      <td colspan="2"><div align="center"> 
          &nbsp;
        </div></td>
    </tr>
</table>
<input type="hidden" name="cgi" value="<%=cgi%>">
</form>
</html><!-- #INCLUDE FILE = "../inc/footer.asp" -->
</body>