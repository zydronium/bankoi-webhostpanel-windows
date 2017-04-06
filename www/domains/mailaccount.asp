<%
	accessLevel = 1
%>
<!-- #INCLUDE FILE = "../inc/security.asp" -->
<!-- #INCLUDE FILE = "../inc/db.asp" -->
<!-- #INCLUDE FILE = "../inc/params.asp" -->
<html>
<head>
<title><%=lbl636%></title>

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

function chk_mn(mail_name)
{
	re = /^[\w-\+]+((\.)[\w-\+]+)*$/;
	return mail_name.search(re) != -1;
}

function validate(f)
{   //alert(f.email.value);

    if(!chk_mn(f.email.value))
	   {
			alert("<%=lbl541%>");
			f.email.focus();
			return false;
	   }
    if(f.email.value=="")
	   {
			alert("<%=msg47%>");
			f.email.focus();
			return false;
	   }

  
    if(f.password.value=="")
	   {
			alert("<%=msg48%>");
			f.password.focus();
			return false;
	   }
	if(f.password.value!=f.password1.value)
	   {
			alert("<%=25%>");
			f.password.value="";
			f.password1.value="";
			f.password.focus();
			return false;
	   }
	f.action='/domains/createmailaccount.asp';
	f.submit();
    return true;
}
</script>

</head>
<%
	'---------------------------------------------------------------------------------------------
	id=session("id")
	domainname=session("domain")
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
    <%
	'---------------------------------------------------------------------------------------------
	query="select distinct * from tblmailaddress where domainid=" & id & " and isalias='0' order by mailname"
	'response.Write(query)
	dim rsemail
	set rsemail=server.createobject("ADODB.Recordset")
	rsemail.open query,con
	if(not rsemail.EOF) then

%>
    <tr> 
      <th colspan="5"><font color="#003366"><strong><%=lbl637%></strong></font> 
    </tr>
    <tr> 
      <td height="11" colspan="3"><div align="center"><strong><%=lbl638%></strong></div></td>
    </tr>
    <%
    while(not rsemail.EOF)
%>
    <tr> 
<%
			if(rsemail("actiontype") = 0) then

			else
%>
				  <td width="321" height="10"  align="center">
				  <div align="right">
				  <font color="#004080">
				  <a href="editmailacc.asp?mail=<%=rsemail("mailname")%>" style=text-decoration:none>
				  <%=rsemail("mailname") & "@" & session("domain")%>
				  </a></font></div></td>
				  <td width="19" height="10" align="center">&nbsp;</td>
				  <td width="220" align="center"> <div align="left"> 
<%
				 if(ucase(sMailServer) <> "QMAIL") then
					'response.write "The Value is " & Cint(rsemail("processed"))
					if(Cint(rsemail("processed")) = Cint("1")) then
%>
		 				<input type="checkbox" name="emails" value="<%=rsemail("mailname")%>">
<%
					else
%>
						<%=lbl639%>
<%
					end if
	 			else
%>
          		<input type="checkbox" name="emails" value="<%=rsemail("mailname")%>">
<%
			end if
	end if
%>
        </div></td>
    </tr>
<%
    rsemail.movenext
    wend
%>
    <tr> 
      <td height="21" colspan="5" align="center"><div align="right"> 
          <input type="button" name="Button352" value="<%=lbl548%>" class="commonButton" onClick="return submit_form(document.mainform)">
        </div></td>
    </tr>
    <%
end if
%>
    <tr> 
      <th colspan="5"><font color="#003366" size="2" face="Verdana"><strong><%=Ucase(lbl636)%></strong></font> </tr>
    <tr> 
      <td colspan="5"><table width="100%" border="0">
          <tr> 
            <td width="27%"><div align="right"><font size="2" face="Verdana"><strong><%=lbl638%></strong></font></div></td>
            <td width="2%">&nbsp;</td>
            <td width="71%"><input name="email" type="text" id="email"> <font color=Red size="1">@<%=session("domain")%></font></td>
          </tr>
          <tr> 
            <td><div align="right"><font size="2" face="Verdana"><strong><%=lblPass%></strong></font></div></td>
            <td>&nbsp;</td>
            <td><input name="password" type="password" id="password2"></td>
          </tr>
          <tr> 
            <td><div align="right"><font size="2" face="Verdana"><strong><%=lbl538%></strong></font></div></td>
            <td>&nbsp;</td>
            <td><input name="password1" type="password" id="password12"></td>
          </tr>
        </table></tr>
    <tr> 
      <td colspan="4"><img src="/skins/<%=session("skin")%>/elements/line.gif" width=560 height=1 border=0></td>
    </tr>
    <tr> 
      <td colspan="5"><div align="right"></div>
        <div align="right">
          <input type="button" name="Button35" value="<%=lbl640%>" class="commonButton" onClick="return validate(document.mainform)">
        </div></td>
    </tr>
    <tr> 
      <td colspan="5"><div align="center"> </div>
        <div align="center">&nbsp;</div></td>
    </tr>
    <tr> 
      <td colspan="5"><div align="center">&nbsp;</div></td>
    </tr>
  </table>
<input type="hidden" name="cgi" value="<%=cgi%>">
</form>
<!-- #INCLUDE FILE = "../inc/footer.asp" -->
</body>
</html>
