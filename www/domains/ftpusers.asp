<%
	accessLevel = 1
%>
<!-- #INCLUDE FILE = "../inc/security.asp" -->
<!-- #INCLUDE FILE = "../inc/db.asp" -->
<!-- #INCLUDE FILE = "../inc/params.asp" -->
<html>
<head>
<title><%=lbl623%></title>

<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/general.css">
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/custom.css">
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/layout.css">
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=ISO-8859-1">
<META HTTP-EQUIV="EXPIRES" CONTENT="0">
<script>

function submit_form(f)
{
//alert("Submit form called");
f.action='/domains/removeftp.asp';
f.submit();
return true;
}


function validate(f)
{
	if(f.ftpusername.value=="")
	   {
			alert("<%=msg46%>");
			f.ftpusername.focus();
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
<body>
<form action="/domains/createftp.asp" method="post" name="mainform" onSubmit="return validate(document.mainform)">
  <table width=370 border=0 cellpadding=0 cellspacing=0 align="center">
    <tr> 
      <td colspan="2"><%=lbl509%> <font name="verdana" color="red"><strong><%=" "&ucase(session("contactname"))%></strong></font><img src="/skins/<%=session("skin")%>/elements/white.gif" width="100%" height=1 alt="" border=0></td>
      <td colspan="2"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="8" height="8" border="0"></td>
    </tr>
    <tr> 
      <td colspan="4"><img src="/skins/<%=session("skin")%>/elements/line.gif" width=560 height=1 border=0></td>
    </tr>
<%
	query="select count(*) as counter from tblftpinfo where domainid='" & id & "'"
	dim rsftp
	set rsftp=server.createobject("ADODB.Recordset")
	rsftp.open query,con
	dim count
	count=rsftp("counter")
	set rsftp=nothing

	query="select * from tblftpinfo where domainid='" & id & "' order by ftpusername"

	set rsftp=server.createobject("ADODB.Recordset")
	rsftp.open query,con
	
	if(not rsftp.EOF) then
%>
    <tr> 
      <th colspan="6"><font color="#003366"><strong><%=lbl568%></strong></font> 
    </tr>
    <tr> 
      <td height="11"  align="center"><div align="right"><strong><%=lbl594%></strong></div></td>
      <td width="32" height="11" align="center">&nbsp;</td>
      <td colspan="3" align="center"><div align="left"><strong><%=lblPass%></strong></div></td>
    </tr>
<%
    while(not rsftp.EOF)
%>
    <tr> 
      <td height="10"  align="center"><div align="right"><font color="#004080"><%=rsftp("ftpusername")%></font></div></td>
      <td width="32" height="10" align="center"><font color="#FF0000">---</font></td>
      <td width="101" align="center"><div align="left"><font color="#004080"><%=rsftp("ftppassword")%></font></div></td>
      <%
	if(rsftp("type")="D") then
%>
      <td width="160" align="center"><font color="red" face="verdana"><%=lbl624%></font></td>
      <td width="1" align="center"><div align="left"></div></td>
    </tr>
    <%
    else
%>
    <td width="267" align="center" colspan="4"> <div align="center"> 
        <input type="checkbox" name="emails" value="<%=rsftp("ftpusername")%>">
      </div></td>
    </tr>
    <%
    end if
    rsftp.movenext
    wend
	if(not cint(count)=1) then
%>
    <tr> 
      <td height="21" colspan="6" align="center"><div align="right"> 
          <input type="button" name="Button352" value="<%=lbl548%>" class="commonButton" onClick="return submit_form(document.mainform)">
        </div></td>
    </tr>
    <%
	end if
	end if
%>
    <tr> 
      <th height="11" colspan="5" align="center"><strong><font color="#FF0000" size="2" face="Verdana"><%=lbl625%></font></strong></td> 
	</tr>



<%
	query="select * from manageusers where type='F' and domainid='" & id & "' order by name"
	dim rsuser
	set rsuser=server.createobject("ADODB.Recordset")
	rsuser.open query,con
  if(rsuser.eof) then%>
  <tr>
		<td colspan=4><div align="center"><font color="red" size="2" face="Verdana"> <div align="center"><strong><%=lbl619%><a href="/domains/manageusers.asp">Click here</a></strong> </td></tr>
<%	else %>
    <tr> 
      <td width="267" height="28"><div align="right"><font size="2" face="Verdana"><strong> 
          <%=lbl617%></strong></font></div>
        <div align="center"> </div></td>
      <td width="32">&nbsp;</td>
      <td colspan="2"> 

        <select name="ftpusername" id="ftpusername" style='font-family: Verdana; color: #003366' Verdana size="1">
          <% 
	while(not rsuser.eof)
%>
          <option value="<%=rsuser("username")%>"><%=rsuser("name")%> [<%=rsuser("username")%>]</option>
          <%
	rsuser.movenext
	wend
%>
        </select></td>
		    <tr> 
      <td colspan="4"><div align="right"></div>
        <div align="center"><img src="/skins/<%=session("skin")%>/elements/line.gif" width=560 height=1 border=0> 
        </div></td>
    </tr>
    <tr> 
      <td colspan="4"><div align="center"> 
          <input type="submit" name="Button35" value="<%=lbl626%>" class="commonButton" >
        </div></td>
    </tr>
<%end if%>
     <tr> 
	
      <td colspan="2"><div align="center"> 
          &nbsp;
        </div></td>
    </tr> <tr> 
	
      <td colspan="2"><div align="center"> 
          &nbsp;
        </div></td>
    </tr>
    

  </table>
<input type="hidden" name="cgi" value="<%=cgi%>">
</form>
</body>
</html>


<!-- #INCLUDE FILE = "../inc/footer.asp" -->

