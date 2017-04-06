<%
	accessLevel = 10
%>
<!-- #INCLUDE FILE = "../inc/security.asp" -->
<!-- #INCLUDE FILE = "../inc/db.asp" -->
<head>
<title>
Clients
</title>
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/general.css">
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/custom.css">
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/layout.css">
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=ISO-8859-1">
<META HTTP-EQUIV="EXPIRES" CONTENT="0">
</head>
<script>
function chk_form_data(f)
{
	f.submit();
	return true;
}

function disablesite(status,id,clientname)
	{
		
		if(status=="enable")
		{
			if(confirm("<%=msg108%>" + clientname))
				{
						window.location= "../clients/changeclientstatus.asp?id=" + id + "&status=<%=Ucase(lbl521)%>&resellername=" + clientname;
						return true;
				}
		}
		else if(status=="disable")
		{
			if(confirm("<%=msg109%>" + clientname))
				{
						window.location= "../clients/changeclientstatus.asp?id=" + id + "&status=<%=Ucase(lbl522)%>&resellername=" + clientname;
						return true;
				}
		}
		else
		{
			return false;
		}
			
	}

function invertChecked()
			{
				f = document.mainform;
				for (i = 0 ; i < f.elements.length; i++) {
					if ((f.elements[i].type == "checkbox") && (f.elements[i].name == "del")) {
						if (f.elements[i].checked || (f.elements[i].value == "DISABLED") || f.elements[i].disabled) {
							f.elements[i].checked = false;
						} else {
							f.elements[i].checked = true;
						}
					}
				}
			}
</script>
<body leftmargin=0 topmargin=0 >
<!-- #include file="../inc/header.asp" -->

<form action='/server/cl_del.asp' method='post' name="mainform">
  <table width="564" border="0" align="center" cellpadding=0 cellspacing=0 bordercolor="#FFFFFF">
    <tr>
	  <td colspan="5">
	  <img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="3" height="1" border="0"></td>
	</tr>
	<tr>
	  <td colspan="5" height="35">
	<input type="button" class="commonButton" id="bid-new-client" value="<%=lblNewClient%>" title="<%=lblNewClient%>" onClick="window.location='/server/cl_new.asp';" >		
	</td>
	</tr>
	
	<tr>	 
	  <td colspan=5><img src="/skins/<%=session("skin")%>/elements/line.gif" width=564 height=1 border=0>	  
	  </td>
	</tr>
<%

	id=session("reselid")
	'response.write "The usertype is " & session("type")
	session("id")=""
	session("domain")=""
	session("resellername")=""							'Setting the resellername of the reseller
	session("reselid")=""
	session("contactname")=""
	session("ftpuser")=""
	session("domainspace")=""



	dim rs  
	set rs = Server.createobject("ADODB.RecordSet")
	query="select count(*) as tot from tblreseller "
	rs.open query, con
	totalClients = rs("tot")
	rs.close
	if(request("sort")="") then
		query="select * from tblcontactinfo,tblloginmaster where tblloginmaster.id=tblcontactinfo.id and tblloginmaster.usertype='c' order by contactname"
	elseif(request("sort")="status") then
		query="select * from tblcontactinfo,tblloginmaster where tblloginmaster.id=tblcontactinfo.id and tblloginmaster.usertype='c' order by status"
	elseif(request("sort")="regdate") then
		query="select * from tblcontactinfo,tblloginmaster where tblloginmaster.id=tblcontactinfo.id and tblloginmaster.usertype='c' order by " & request("sort")
	elseif(request("sort")="name_reverse") then
		query="select * from tblcontactinfo,tblloginmaster where tblloginmaster.id=tblcontactinfo.id and tblloginmaster.usertype='c' order by contactname"  & " desc"
	else
		query="select * from tblcontactinfo,tblloginmaster where tblloginmaster.id=tblcontactinfo.id and tblloginmaster.usertype='c' order by contactname"
	end if
  rs.open query, con
  if(not rs.EOF)then
%>
	<tr >
	  <td colspan=3 height="35" valign="middle"><%=lbl717 & " "%>(<%=totalClients%>)</td>
	  <td colspan="2" align="right" valign="middle"><input name="button" type="button" class="commonButton" id="button" title="<%=lbl547%>" onClick="chk_form_data(document.mainform);" value="<%=lbl548%>" ></td>
	</tr>
	<tr>
	  <th align=left height="26">
		<table border="0" cellpadding=0 cellspacing=0 width="0" align="left">
	      <tr>
		    <td><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="2" height="22" border="0"></td>
			<td><a href='/clients/clients.asp?cmd=setSort&sort=state' ><%=lbl553%></a></td>
		  </tr>
	  </table></th>
	  <th width="7%" height="26" align=left>
		<table border="0" cellpadding=0 cellspacing=0 width="0" align="left">
		  <tr>
		    <td><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="2" height="22" border="0"></td>
			<td><a href='/clients/clients.asp?cmd=setSort&sort=status' ><%=lbl552%></a></td>
		  </tr>
	  </table></th>
	  <th width="21%" height="26" align=left>
		<table border="0" cellpadding=0 cellspacing=0 width="0" align="left">
		  <tr>
		    <td><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="2" height="22" border="0"></td>
			<td><a href='/clients/clients.asp?cmd=setSort&sort=date' ><%=lbl551%></a></td>
		  </tr>
	  </table></th>
	  <th align=left height="26"><table border="0" cellpadding=0 cellspacing=0 width="0" align="left">
		  <tr>
		    <td><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="2" height="22" border="0"></td>
			<td><a href='/clients/clients.asp?cmd=setSort&sort=name_reverse' ><%=lblclientname%></a></td>
			<td><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="2" height="22" border="0"></td>
			<td><img src='/skins/<%=session("skin")%>/icons/arrow_up.gif' border=0></td>
			<td><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="2" height="22" border="0"></td>
		  </tr>
	  </table></th>
	  <th><a href="javascript:invertChecked()" ><%=lbl550%></a></th>
	</tr>
    <tr>
	  <td colspan=1><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="3" border="0"></td>
	</tr>
    <br>
	<br>
	<br>
<%
	while (not rs.EOF)
%>
    <tr>
	  <td>&nbsp;</td>
	  <td>
<% 
		if(rs("status")="1") then
%>
		<img src='/skins/<%=session("skin")%>/icons/on.gif' border=0 alt="On" onclick="return disablesite('disable','<%=rs("id")%>','<%=rs("username")%>')">
<%
		else
%>
	  <img src='/skins/<%=session("skin")%>/icons/off.gif' border=0 alt="On" onclick="return disablesite('enable','<%=rs("id")%>','<%=rs("username")%>')">
<%
	  end if
%>
	  </td>
	  <td><%=FormatDateTime(rs("regdate"), 0)%></td>
	  <td width="59%">
	  <a href="/clients/choose.asp?id=<%=rs("id")%>" style=text-decoration:none><%=rs("contactname")%> <font color="red" face="verdana">[<%=rs("username")%>]</font></a></td>
	  <td><input type="checkbox" name="del" value="<%=rs("id")%>"></td>
	</tr>
<%
		rs.movenext
	wend      'end of while loop
else
   
%>
    <tr>
	  <td colspan=5><p>NO Clients.</p></td>
	</tr>
    <%
  end if     'end of if block
%>
			
  </table>
</form >
<br>
<br>
<!-- #include file="../inc/footer.asp" -->
</body>
</html>
