<%
	accessLevel = 1
%>
<!-- #INCLUDE FILE = "../inc/security.asp" -->
<!-- #INCLUDE FILE = "../inc/db.asp" -->
<!-- #INCLUDE FILE = "../inc/params.asp" -->
<html>
<head>
<title><%=lbl534%></title>

<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/general.css">
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/custom.css">
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/layout.css">
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=ISO-8859-1">
<META HTTP-EQUIV="EXPIRES" CONTENT="0">
	
<script>

function validate(f)
{
	 if(f.oldpassword.value=="")
	   {
			alert("<%=msg44%>");
			f.oldpassword.focus();
			return false
	   }

    if(f.newpassword.value=="")
	   {
			alert("<%=msg24%>");
			f.newpassword.focus();
			return false
	   }

	  
	if(f.newpassword.value!=f.newpassword1.value)
	   {
			alert("<%=msg25%>");
			f.newpassword.value="";
			f.newpassword1.value="";
			f.newpassword.focus();
			return false;
	   }
     return true;
}
</script>

</head>
<%
    id=session("id")
    '---------------------------------------------------------------------------------------------
	'Here we are extracting the name of the reseller according to the id stored in the session
	query="select contactname from tblcontactinfo where id='" & id & "'"
	'response.write query
	set rs=server.createobject("ADODB.Recordset")
	rs.open query,con
	username=rs("contactname")
	rs.close
	
	query="select cgisupport from tblrights where id='" & id & "'"
	rs.open query,con
	if(rs("cgisupport")="N") then
	    cgi=lbl521
	else
	    cgi=lbl522
	end if
%>

<!-- #INCLUDE FILE = "../inc/header.asp" -->

<!------------------------------------------------------------------------------------------------>
<!--Here the menu for Client is created-->
<!-- #INCLUDE FILE = "../server/subheader.asp" -->

<!------------------------------------------------------------------------------
The header of reseller prepared here
-->
<!-- #INCLUDE FILE = "../domains/domainheader.asp" -->
<!--
----------------------------------------------------------------------------
The header ends here
-->
<body>
<form action="/domains/changepass1.asp" method="post" name="mainform" onSubmit="return validate(document.mainform)">
  <table width=370 border=0 cellpadding=0 cellspacing=0 align="center">
    <tr> 
      <td colspan="2"><%=lbl509%> <font name="verdana" color="red"><strong><%=" "&ucase(session("contactname"))%></strong></font><img src="/skins/Standard_7/elements/white.gif" width="100%" height=1 alt="" border=0></td>
      <td width=317><img src="/skins/Standard_7/elements/white.gif" alt="" width="8" height="8" border="0"></td>
    </tr>
    <tr> 
      <td colspan="3"><img src="/skins/<%=session("skin")%>/elements/line.gif" width=560 height=1 border=0></td>
    </tr>
    <tr> 
      <th height="21" colspan="3" align="center"><strong><font color="blue"><%=lbl535%></font> <font color="red"><%=session("domain")%></font></strong></td>
    </tr>
   
<%
		if(ucase(session("type"))="D") then
%>
	
	<tr> 
      <td width="223" height="28"><div align="right"><strong><%=lbl536%> </strong></div>
        <div align="center"> </div></td>
      <td width="20">&nbsp;</td>
      <td><input name="oldpassword" type="password" id="oldpassword"></td>
    </tr>
<%
		else
%>
			<input name="oldpassword" type="hidden" id="oldpassword" value="test">
<%
		end if
%>


    <tr> 
      <td height="26"><div align="right"><strong><%=lbl537%> </strong></div>
        <div align="center"> </div></td>
      <td>&nbsp;</td>
      <td><input name="newpassword" type="password" id="newpassword"></td>
    </tr>
    <tr> 
      <td height="28"><div align="right"><strong><%=lbl538%> </strong></div>
        <div align="center"> </div></td>
      <td>&nbsp;</td>
      <td><input name="newpassword1" type="password" id="newpassword1"></td>
    </tr>
    <tr> 
      <td colspan="3"><div align="right"></div>
        <div align="center"><img src="/skins/<%=session("skin")%>/elements/line.gif" width=560 height=1 border=0> 
        </div>
      </td>
    </tr>
    <tr> 
      <td colspan="3"><div align="center"> 
          <input type="submit" name="Button35" value="<%=lbl539%>" class="commonButton" >
        </div></td>
    </tr>
	 <tr> 
	
      <td colspan="2"><div align="center"> 
          &nbsp;
        </div></td>
    </tr>
  </table>
<input type="hidden" name="cgi" value="<%=cgi%>">
</form>
</body>
</html><!-- #INCLUDE FILE = "../inc/footer.asp" -->
