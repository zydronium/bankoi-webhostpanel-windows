<%
	accessLevel = 5
%>
<!-- #INCLUDE FILE = "../inc/security.asp" -->
<!-- #INCLUDE FILE="../inc/db.asp" -->
<!-- #INCLUDE FILE = "../inc/params.asp" -->

<script>
	function disablesite(status,id,domainname)
{
	//alert(status);
	if(status=="enable")
	{
		if(confirm("This will enable the site.Would you like to start it."))
			{
					//alert("IN enable");
					window.location= "../domains/changestatus.asp?id=" + id + "&status=ENABLE&domain=" + domainname;
					return true;
			}
	}
	else if(status=="disable")
	{
		if(confirm("This will stop the site from running.Would you like to stop it."))
			{
					//alert("IN disable");
					window.location= "../domains/changestatus.asp?id=" + id + "&status=DISABLE&domain=" + domainname;
					return true;
			}
	}
	else
	{
		//alert("IN False");
		return false;
	}
			
}
</script>

<%
  
  if(len(session("reselid")) > 0) then 
	  id = session("reselid")	  
	  '---------------------------------------------------------------------------------------------
	  'Here we are extracting the name of the reseller according to the id stored in the session
	  query2="select contactname from tblcontactinfo where id='" & id & "'"
	  response.write query
	  dim rsname
	  set rsname=server.createobject("ADODB.Recordset")
	  rsname.open query2,con
	  username=rsname("contactname")

	  '----------------------------------------
	  'Reseller/Client name set into the session
	  session("resellername")=username
	  '----------------------------------------

	  'response.write "amit yadav" &session("reselid")
	   
	  dim resellername  
	  set resellername = Server.createobject("ADODB.RecordSet")  
	  query="select username from tblloginmaster where id='" & id & "'"
	  resellername.open query, con  
	  if(not resellername.eof) then name=ucase(resellername("username"))
	  resellername.close
	    queryCount="select count(*) as tot from tbldomain where resellerid=" & id 

		if(request("sort")="") then
			query="select * from tbldomain,tblloginmaster where tbldomain.domainid=tblloginmaster.id and tbldomain.resellerid='" & id & "' order by tbldomain.domainname"
		elseif(request("sort")="status") then
			query="select * from tbldomain,tblloginmaster where tbldomain.domainid=tblloginmaster.id and tbldomain.resellerid='" & id & "' order by status"
		elseif(request("sort")="regdate") then
			query="select * from tbldomain,tblloginmaster where tbldomain.domainid=tblloginmaster.id and tbldomain.resellerid='" & id & "' order by " & request("sort")
		elseif(request("sort")="name_reverse") then
			query="select * from tbldomain,tblloginmaster where tbldomain.domainid=tblloginmaster.id and tbldomain.resellerid='" & id & "' order by tbldomain.domainname"  & " desc"
		else
		    query="select * from tbldomain,tblloginmaster where tbldomain.domainid=tblloginmaster.id and tbldomain.resellerid='" & id & "' order by tbldomain.domainname"
		end if
  else
  	  response.redirect("/logout.asp")
  end if
  
%>
<head>
<title><%=ucase(username)%>'S <%=lbl546%></title>
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
<!-- #include file="../inc/header.asp" -->
<form action='/server/domain_del.asp' method='post' name="mainform">
 
  <table width="564" border="1" align="center" cellpadding=0 cellspacing=0 bordercolor="#FFFFFF">
    <tr> 
      <td colspan="5"> <img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="3" height="1" border="0"></td>
    </tr>
    <%
	if(id <> 0) then
	%>
    <tr> 
      <td colspan="5"> 
<!-- #include file="../clients/clientheader.asp" --> </td>
        </tr>
        <%
	end if
	%>
        <tr> 
          <td colspan=5><img src="/skins/<%=session("skin")%>/elements/line.gif" width=560 height=1 border=0>	
          </td>
        </tr>
        <%
  dim rs  
  set rs = Server.createobject("ADODB.RecordSet")
  
  rs.open queryCount, con
  totalClients = rs("tot")
  rs.close
  'set rs=nothing
  rs.open query, con
  if(not rs.EOF)then
	%>
        <tr> 
          <td colspan=5 height="35" valign="middle"> <div align="left">
<table width="100%" border="0">
                <tr> 
                  <td width="84%">Domains (<%=totalClients%>) 
                    <%
	  if(id <> 0) then
	  %>
                    for<font name="verdana" color="red"><strong><%=" "&username%></strong></font> 
                    <%
	  end if
	  %>
                  </td>
                  <td width="16%"><input name="button" type="button" class="commonButton" id="button" title="<%=lbl547%>" onClick="chk_form_data(document.mainform);" value="<%=lbl548%>" ></td>
                </tr>
              </table>
            </div>
            <div align="right"> </div></td>
        </tr>
        <tr> 
          <th width="2%" height="26" align=left> <table border="0" cellpadding=0 cellspacing=0 width="0" align="left">
              <tr> 
                <td><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="2" height="22" border="0"></td>
                <td><a href='/clients/clients.asp?cmd=setSort&sort=state' ><%=lbl553%></a></td>
              </tr>
            </table></th>
          <th width="6%"  height="26" align=left> <table border="0" cellpadding=0 cellspacing=0 width="0" align="left">
              <tr> 
                <td><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="2" height="22" border="0"></td>
                <td><a href='/domains/clientdomains.asp?cmd=setSort&sort=status' ><%=lbl552%></a></td>
              </tr>
            </table></th>
          <th width="18%"  height="26" align=left> <table border="0" cellpadding=0 cellspacing=0 width="0" align="left">
              <tr> 
                <td><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="2" height="22" border="0"></td>
                <td><a href='/domains/clientdomains.asp?cmd=setSort&sort=date' ><%=lbl551%></a></td>
              </tr>
            </table></th>
          <th align=left height="26"><table border="0" cellpadding=0 cellspacing=0 width="0" align="left">
              <tr> 
                <td><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="2" height="22" border="0"></td>
                <td><a href='/domains/clientdomains.asp?id=<%=id%>&cmd=setSort&sort=name_reverse' ><%=lbl549%></a></td>
                <td><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="2" height="22" border="0"></td>
                <td><img src='/skins/<%=session("skin")%>/icons/arrow_up.gif' border=0></td>
                <td><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="2" height="22" border="0"></td>
              </tr>
            </table></th>
          <th width="8%"><a href="javascript:invertChecked()" ><%=lbl550%></a></th>
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
            <img src='/skins/<%=session("skin")%>/icons/on.gif' border=0 alt="On" onclick="return disablesite('disable','<%=rs("domainid")%>','<%=rs("domainname")%>')"> 
<%
		else
%>
           <img src='/skins/<%=session("skin")%>/icons/off.gif' border=0 alt="Off" onclick="return disablesite('enable','<%=rs("domainid")%>','<%=rs("domainname")%>')">  
<%
		end if
%>
          </td>
          <td><%=FormatDateTime(rs("regdate"),0)%></td>
          <td width="66%"> <a href="../server/global.asp?id=<%=rs("domainid")%>" style=text-decoration:none><%=rs("domainname")%></a></td>
          <td><div align="center"> 
              <input type="checkbox" name="del" value="<%=rs("domainid")%>">
            </div></td>
        </tr>
<%
		rs.movenext
	wend      'end of while loop
else
   
%>
        <tr> 
          <td colspan=5><p><%=lbl554%><font name="verdana" color="red"><strong><%=" "&name%></strong></font></p></td>
        </tr>
        <%
  end if     'end of if block
%>
      </table>
</form >
<!-- #include file="../inc/footer.asp" -->
</body>
</html>
