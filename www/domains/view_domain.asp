<%
	accessLevel = 1
%>
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

<form action='/clients/cl_del.asp' method='post' name="mainform">
  <table border="0" cellpadding=0 cellspacing=0 width="564" align="center">
  <tr >
	  <td colspan=3 height="35" valign="middle"><%=lbl675%> (<%=session("reseller")%>)</td>
	  
	</tr>
   
<% 
   'getting reseller id
   dim rsresid,query1
   query1 = "select id from tblloginmaster where username='" & session("reseller") & "'"
   set rsresid = server.createobject("ADODB.Recordset")
   set rsresid = con.execute(query1)

   'count of domains only for the login reseller
   dim query3,rscount
   query3 = "select count(domainname) as tot from tbldomain where resellerid = " & rsresid("id")
   set rscount = server.createobject("ADODB.Recordset")
   set rscount = con.execute(query3)
   total = rscount("tot")

   'retreiving domains only for the login reseller
   dim query4,rsdom
   query4 = "select * from tbldomain where resellerid = " & rsresid("id")
   set rsdom = server.createobject("ADODB.Recordset")
   set rsdom = con.execute(query4)
   if(not rsdom.EOF)then
%>
	<tr >
	  <td colspan=3 height="35" valign="middle"><%=lbl546%> : (<%=total%>)</td>
	  <td colspan="2" align="right" valign="middle"><input name="button" type="button" class="commonButton" id="button" title="<%=lbl676%>" onClick="chk_form_data(document.mainform);" value="Remove Selected" ></td>
	</tr>
	<tr>
	  <th align=left height="26">
		<table border="0" cellpadding=0 cellspacing=0 width="0" align="left">
	      <tr>
		    <td><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="2" height="22" border="0"></td>
			<td><a href='/domains/domains.asp?cmd=setSort&sort=state' ><%=lbl553%></a></td>
		  </tr>
	  </table></th>
	  <th width="7%" height="26" align=left>
		<table border="0" cellpadding=0 cellspacing=0 width="0" align="left">
		  <tr>
		    <td><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="2" height="22" border="0"></td>
			<td><a href='/domains/domains.asp?cmd=setSort&sort=status' ><%=lbl552%></a></td>
		  </tr>
	  </table></th>
	  <th width="21%" height="26" align=left>
		<table border="0" cellpadding=0 cellspacing=0 width="0" align="left">
		  <tr>
		    <td><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="2" height="22" border="0"></td>
			<td><a href='/domains/domains.asp?cmd=setSort&sort=date' ><%=lbl551%></a></td>
		  </tr>
	  </table></th>
	  <th align=left height="26"><table border="0" cellpadding=0 cellspacing=0 width="0" align="left">
		  <tr>
		    <td><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="2" height="22" border="0"></td>
			<td><a href='/domains/domains.asp?cmd=setSort&sort=name_reverse' ><%=lbl549%></a></td>
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
    <% while (not rsdom.EOF) %>
    <tr>
	  <td>&nbsp;</td>
	  <td>&nbsp;</td>
	  <td>&nbsp;</td>
	  <td width="59%"><a href="../domains/domaindetails.asp?id=<%=rsdom("domainid")%>"><%=rsdom("domainname")%></a></td>
	  <td><input type="checkbox" name="del" value="<%=rsdom("domainid")%>"></td>
	</tr>
    <%
		rsdom.movenext
	wend      'end of while loop
else
   
%>
    <tr>
	  <td colspan=5><p><%=lbl677%></p></td>
	</tr>
    <%
  end if     'end of if block
%>
			
  </table>
</form >
<!-- #include file="../inc/footer.asp" -->
</body>
</html>
