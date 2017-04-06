<%
	accessLevel = 1
%>
<!-- #INCLUDE FILE = "../inc/security.asp" -->
<!-- #INCLUDE FILE = "../inc/db.asp" -->
<!-- #INCLUDE FILE = "../inc/params.asp" -->
<html>
<head>
<title><%=lbl611%></title>
<style fprolloverstyle>A:hover {color: #800000}
</style>


<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/general.css">
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/custom.css">
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/layout.css">
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=ISO-8859-1">
<META HTTP-EQUIV="EXPIRES" CONTENT="0">
<script>
function submit_form(f)
{
//alert("Submit form called");
f.action='/domains/removealias.asp';
f.submit();
return true;
}


function validate(f)
{
   emailExp= /^\w+(\-\w+)*(\.\w+(\-\w+)*)*@\w+(\-\w+)*(\.\w+(\-\w+)*)+$/;
   if (!(emailExp.test(f.redirectadd.value)))
      { 
		   alert("<%=lbl541%>");
		   f.redirectadd.value="";
		   f.redirectadd.focus();
		   return false;  
	  }

	if(f.aliasname.value=="")
	   {
			alert("<%=msg45%>");
			f.aliasname.focus();
			return false;
	   }
	return true
}
</script>

</head>
<%
	'---------------------------------------------------------------------------------------------
	id=session("id")
    '---------------------------------------------------------------------------------------------
	'Here we are extracting the name of the reseller according to the id stored in the session
	query="select contactname from tblcontactinfo where id='" & id & "'"
	'response.write query
	set rs=server.createobject("ADODB.Recordset")
	rs.open query,con
	username=rs("contactname")
	rs.close
	'---------------------------------------------------------------------------------------------
%>

<!-- #INCLUDE FILE = "../inc/header.asp" -->
<!------------------------------------------------------------------------------------------------>
<!--Here the menu for Client is created-->
<!-- #INCLUDE FILE = "../server/subheader.asp" -->


<!---------------------------------------------------------------------------

<!--#INCLUDE FILE = "../domains/domainheader.asp"-->

<body>
<form action="/domains/createemailalias.asp" method="post" name="mainform" onSubmit="return validate(document.mainform)">
  <table width=370 border=0 cellpadding=0 cellspacing=0 align="center">
    <tr> 
      <td colspan="4">Domain Of <font name="verdana" color="red"><strong><%=" "&ucase(session("contactname"))%></strong></font><img src="/skins/<%=session("skin")%>/elements/white.gif" width="100%" height=1 alt="" border=0><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="8" height="8" border="0"></td>
    </tr>
    <%
	query="select actiontype,mailname,redirectadd from tblmailaddress where domainid='" & id & "' and isalias='1' and actiontype<> 0 order by mailname"
	'response.write query
	dim rsalias
	set rsalias=server.createobject("ADODB.Recordset")
	rsalias.open query,con
	if(not rsalias.EOF) then
%>
    <tr> 
      <th colspan="6"><font color="#003366"><strong><%=lbl566%></strong></font> 
    </tr>
    <tr> 
      <td height="11"  align="left"><div align="right"><strong><%=lbl544%></strong></div></td>
      <td width="25" height="11" align="center">&nbsp;</td>
      <td colspan="3" align="left"><div align="left"><strong><%=lbl545%></strong></div></td>
    </tr>
<%
    while(not rsalias.EOF)
	if(Cint(rsalias("actiontype")) = 0 ) then

	else
%>
    <tr> 
      <td height="10"  align="left"><div align="right"><font color="Green"><a href="changeredirectadd.asp?alias=<%=rsalias("mailname")%>" Style= text-decoration:none><%=rsalias("mailname")%></a></font></div></td>
      <td width="25" height="10" align="center"><font color="#FF0000">---</font></td>
      <td width="110" align="left">
          <font color="#004080"><%=rsalias("redirectadd")%></font></td>
      <td width="182" align="center"> <input type="checkbox" name="emails" value="<%=rsalias("mailname")%>"> 
<%
	end if
%>
		</td>
		<td width="1" align="center"><div align="left"></div></td>
		</tr>
<%
    rsalias.movenext
    wend
%>
    <tr> 
      <td height="10" colspan="6" align="center"><div align="right"> </div></td>
    </tr>
    <tr>
      <td height="11" colspan="6" align="center"><div align="right">
          <input type="button" name="Button352" value="<%=lbl548%>" class="commonButton" onClick="return submit_form(document.mainform)">
        </div></td>
    </tr>
    <%
	end if
%>
    <tr> <th colspan="5" align="center"><strong><font color="#FF0000" size="2" face="Verdana"><%=lbl566%> </font></strong></td></tr>
    <tr> 
      <td width="243" height="28"><div align="right"><font size="2" face="Verdana"><strong> 
          <%=lbl544%></strong></font></div>
        <div align="center"> </div></td>
      <td width="25">&nbsp;</td>
      <td colspan="2"><input name="aliasname" type="text" size="15">&nbsp;&nbsp;<font color="red" size="1"><%="@" & session("domain")%></font></td>
    </tr>
    <tr> 
      <td height="26"><div align="right"><font size="2" face="Verdana"><strong><%=lbl545%></strong> </font></div></td>
      <td>&nbsp;</td>
      <td colspan="2"><input name="redirectadd" type="text" size="15"></td>
    </tr>
    <tr> 
      <td colspan="4"><div align="right"></div>
        <div align="center"><img src="/skins/<%=session("skin")%>/elements/line.gif" width=560 height=1 border=0> 
        </div></td>
    </tr>
    <tr> 
      <td colspan="4"><div align="center"> 
          <input type="submit" name="Button35" value="<%=lbl611%>" class="commonButton" >
        </div></td>
    </tr> <tr> 
	
      <td colspan="2"><div align="center"> 
          &nbsp;
        </div></td>
    </tr>
  </table>
</form>
</body>
</html>
<!-- #INCLUDE FILE = "../inc/footer.asp" -->