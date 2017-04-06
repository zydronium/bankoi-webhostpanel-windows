<%
	accessLevel = 5
%>
<!-- #INCLUDE FILE = "../inc/security.asp" -->
<!-- #INCLUDE FILE = "../inc/params.asp" -->
<!-- #INCLUDE FILE = "../inc/db.asp" -->
<html>
<head>
<title><%=lbldomaininfo%></title>

<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/general.css">
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/custom.css">
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/layout.css">
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=ISO-8859-1">
<META HTTP-EQUIV="EXPIRES" CONTENT="0">

<script language="JavaScript">
//------------------------------------------------------------------------------------------------
//Function for submitting the form
function form_submit(f)
{
	f.action="/domains/changestatus.asp";
	f.submit();
}
</script>

</head>	
<%
    id=session("id")
	resellername=session("contactname")
    set rsdomain = Server.CreateObject("ADODB.Recordset")

	'-------------------------------------------------------------------------------------------------------
	'Here getting the info for the domain from tables tblloginmaster,tblcontactinfo,tbldomain,tblrights,tblftpinfo
	query = "select * from (tblloginmaster left join tblcontactinfo on tblloginmaster.id=tblcontactinfo.id left join tbldomain on tblloginmaster.id=tbldomain.domainid left join tblrights on tblloginmaster.id=tblrights.id left join tblftpinfo on tblloginmaster.id=tblftpinfo.domainid)  where tblftpinfo.type='D' and tblloginmaster.id='" & id & "'"
	rsdomain.open query,con	
	'-------------------------------------------------------------------------------------------------------
	'Here selecting the country for the domain
	code=rsdomain("country")
	query="select * from tblcountry where code='" & code & "'"
	set rscountry = Server.CreateObject("ADODB.Recordset")
	rscountry.open query,con

	'-------------------------------------------------------------------------------------------------------
	'Selecting the IP addresses assigned to the selected Domain
	ipid=rsdomain("ipaddress")
	query="select tblserverip.ipaddress from tblserverip where id='" & ipid & "'"
	set rsip = Server.CreateObject("ADODB.Recordset")
	rsip.open query,con
	ipaddress=rsip("ipaddress")
	
	'-------------------------------------------------------------------------------------------------------
	'Here we are checking the status of the selected Domain
	query="select status from tblloginmaster where id='" & id & "'"
	set rsstatus=server.CreateObject("ADODb.Recordset")
	rsstatus.open query,con
	'-------------------------------------------------------------------------------------------------------
	if(rsstatus("status")=0)then
	   status=lbl521
	else
		status=lbl522
	end if
	rsstatus.close	
	'-------------------------------------------------------------------------------------------------------
	'Here we are setting the domainname into the session
	session("domain")=rsdomain("domainname")
%>	
<body>		
<!-- #INCLUDE FILE = "../inc/header.asp" -->


<!---------------------------------------------------------------------------------------------------------->
<!--Here the menu for Client is created-->
<!-- #INCLUDE FILE = "../server/subheader.asp" -->

<!---------------------------------------------------------------------------------------------------------->
<!--Here the menu for domain is created-->
<!-- #INCLUDE FILE = "../domains/domainheader.asp" -->

<form action="/server/updatedomaininfo.asp" method="post" name="mainform">
<input type="hidden" name="id" value="<%=request("id")%>">
  <table width=564 border=0 cellpadding=0 cellspacing=0 align="center">
		<tr><td colspan=5><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></td></tr>
		<tr><td>
	    <table border=0 cellpadding=0 cellspacing=0 align="left">
		    <tr>
			    <td width=3 align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="3" height="1" border="0"></td>
			    <td width=436>Domain Of <font name="verdana" color="red"><strong><%=" "&resellername%></strong></font><img src="/skins/<%=session("skin")%>/elements/white.gif" width="100%" height=1 alt="" border=0></td>
			    <td width=7><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
			    <td width=115 align="right" class="verttop"><input type="button" class="commonButton" id="bid-up-level" value="<%=lbluplevel%>" title="<%=lbluplevel%>"   onClick="history.go(-1);"  ></td>
			    <td width=3><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="3" height="1" border="0"></td>
		    </tr>
        </table></td></tr>
		<tr>
      <td colspan=5 align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="16" border="0"><img src="/skins/<%=session("skin")%>/elements/line.gif" width=564 height=1 border=0>	
      </td>
    </tr>


		<tr>
			<td colspan=5>
			<table width="100%" border=0 align="left" cellpadding=0 cellspacing=0 bgcolor="#FFFFFF">
          <tr bgcolor="#FFFFFF"> 
            <td width="273" align="right"><strong><font face="verdana" size="2" color="blue">
              <%response.write "The space used by " & rsdomain("domainname") & " is:"%></font>
              </strong></td>
            <td width="31" align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
            <td width="260" align="left"><font color=red><b><%=session("domainspace")%></b></font></td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td align="right"><strong></strong></td>
            <td width="31" align="center">&nbsp;</td>
            <td width="260" align="left">&nbsp;</td>
          </tr>
          <tr bgcolor="#FFFFFF">
            <td align="right"><strong><font color="#FF6600"><%=lbl562%></font></strong></td>
            <td width="31" align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="8" height="8" border="0"></td>
            <td align="left"><font color=red><%=rsdomain("domainname")%></font></td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td><strong><font color="#FF6600"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></font></strong></td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td width="273" align="right"><strong><font color="#FF6600"><%=lblAssigned%>
              IP</font></strong></td>
            <td><font color="#003366">&nbsp;</font></td>
            <td width="260" align="left"><font color="#003366"><%=ipaddress%> 
              </font></td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td><strong><font color="#FF6600"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></font></strong></td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td width="48%" align="right"><strong><font color="#FF6600"><%=lblPersonal%> 
              name:</font></strong></td>
            <td width="6%" align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
            <td width="46%" align="left"><font color="#003366"><%=rsdomain("contactname")%> 
              </font></td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td><strong><font color="#FF6600"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></font></strong></td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td align="right"><strong><font color="#FF6600"><%=lblFtpUsers%></font></strong></td>
            <td align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
            <td align="left"><font color="#003366"><%=rsdomain("ftpusers")%> </font></td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td><strong><font color="#FF6600"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></font></strong></td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td align="right"><strong><font color="#FF6600"><%=lblftpusername%></font></strong></td>
            <td align="center">&nbsp;</td>
            <td align="left"><font color="#003366"><%=rsdomain("ftpusername")%> 
              </font></td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td><strong><font color="#FF6600"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></font></strong></td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td align="right"><strong><font color="#FF6600"><%=lblcpftpuserpasswd%></font></strong></td>
            <td align="center">&nbsp;</td>
            <td align="left"><font color="#003366"><%=rsdomain("ftppassword")%> 
              </font></td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td><strong><font color="#FF6600"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></font></strong></td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td align="right"><strong><font color="#FF6600"><%=lblcompanyname%></font></strong></td>
            <td align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
            <td align="left"><font color="#003366"><%=rsdomain("companyname")%> 
              </font></td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td><strong><font color="#FF6600"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></font></strong></td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td align="right"><strong><font color="#FF6600"><%=lblPopmailAccount%></font></strong></td>
            <td align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
            <td align="left"><font color="#003366"><%=rsdomain("popmailaccount")%> 
              </font></td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td><strong><font color="#FF6600"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></font></strong></td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td align="right"><strong><font color="#FF6600"><%=lblEmailAlias%></font></strong></td>
            <td align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
            <td align="left"><font color="#003366"><%=rsdomain("emailalias")%> 
              </font></td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td><strong><font color="#FF6600"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></font></strong></td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td align="right"><strong><font color="#FF6600"><%=lblmssqldb%></font></strong></td>
            <td align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
            <td align="left"><font color="#003366"><%=rsdomain("sqldatabase")%> 
              </font></td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td><strong><font color="#FF6600"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></font></strong></td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td><strong><font color="#FF6600"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></font></strong></td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td align="right"><strong><font color="#FF6600"><%=lblpwdprotect%></font></strong></td>
            <td align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
            <td align="left"><font color="#003366"><%=rsdomain("pwdprotectdir")%> 
              </font></td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td><strong><font color="#FF6600"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></font></strong></td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td align="right"><strong><font color="#FF6600"><%=lblcgisupport%></font></strong></td>
            <td align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
            <td align="left"><font color="#003366"><%=rsdomain("cgisupport")%> 
              </font></td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td><strong><font color="#FF6600"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></font></strong></td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td align="right"><strong><font color="#FF6600"><%=lblfrontpage%>
              </font></strong></td>
            <td align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
            <td align="left"><font color="#003366"><%=rsdomain("frontpageext")%> 
              </font></td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td><strong><font color="#FF6600"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></font></strong></td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td align="right"><strong><font color="#FF6600"><%=lblaspsupport%></font></strong></td>
            <td align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
            <td align="left"><font color="#003366"><%=rsdomain("aspdotnetsupport")%> 
              </font></td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td><strong><font color="#FF6600"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></font></strong></td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td align="right"><strong><font color="#FF6600"><%=lblwebstart%></font></strong></td>
            <td align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
            <td align="left"><font color="#003366"><%=rsdomain("webstats")%> </font></td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td><strong><font color="#FF6600"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></font></strong></td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td><strong><font color="#FF6600"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></font></strong></td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td align="right"><strong><font color="#FF6600"><%=lblphone%></font></strong></td>
            <td align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
            <td align="left"><font color="#003366"><%=rsdomain("phone")%> </font></td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td><strong><font color="#FF6600"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></font></strong></td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td><strong><font color="#FF6600"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></font></strong></td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td align="right"><strong><font color="#FF6600"><%=lblemail%></font></strong></td>
            <td align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
            <td align="left"><font color="#003366"><%=rsdomain("email")%> </font></td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td><strong><font color="#FF6600"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></font></strong></td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td align="right"><strong><font color="#FF6600"><%=lbladdress%></font></strong></td>
            <td align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
            <td align="left"><font color="#003366"><%=rsdomain("address")%> </font></td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td><strong><font color="#FF6600"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></font></strong></td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td align="right"><strong><font color="#FF6600"><%=lblcity%></font></strong></td>
            <td align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
            <td align="left"><font color="#003366"><%=rsdomain("city")%> </font></td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td><strong><font color="#FF6600"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></font></strong></td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td align="right"><strong><font color="#FF6600"><%=lblstate%></font></strong></td>
            <td align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
            <td align="left"><font color="#003366"><%=rsdomain("state")%> </font></td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td><strong><font color="#FF6600"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></font></strong></td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td align="right"><strong><font color="#FF6600"><%=lblzipcode%></font></strong></td>
            <td align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
            <td align="left"><font color="#003366"><%=rsdomain("zipcode")%> </font></td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td><strong><font color="#FF6600"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></font></strong></td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td align="right"><strong><font color="#FF6600"><%=lblCountry%></font></strong></td>
            <td align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
            <td align="left"><font color="#003366"><%=rscountry("countryname")%> 
              </font></td>
          </tr>
          <tr> 
            <td><strong><font color="#FF6600"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></font></strong></td>
          </tr>
        </table></td>
          </tr>
        </table>

			<tr>
      <td colspan=5><div align="center">
        <p><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="16" border="0"><img src="/skins/<%=session("skin")%>/elements/line.gif" width=564 height=1 border=0></p>
        <table width="980" border=0 align="left" cellpadding=0 cellspacing=0>
          <tr> 
            <td colspan="3" align="center"><div align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="3" height="1" border="0"> 
              </div>
              
            <td width="1"></td>
            <div align="center"></div>
          </tr>
<tr>
<div align="center">
        <input type="hidden" name="cmd" value="update">
        <input type="hidden" name="id" value="<%=request("id")%>">
        <input name="Submit" type="Button" class="commonButton" title="<%=lblStatus%>" value="<%=status%>" onClick="form_submit(document.mainform)">
		<input name="Submit" type="submit" class="commonButton" title="<%=lblUpdate%>" value="<%=lblUpdate%>">
        <input name="button" type="button" class="commonButton" id="bid-update" title="<%=lblOk%>" onClick="history.go(-1)" value="<%=lblOK%>">
</div>
</tr>

<tr>
      <td>
			<div align="right">
				<!-- #INCLUDE FILE = "../inc/footer.asp" -->
			</div>
	  </td>
</tr>     
</table>
<input type="hidden" name="id" value="<%=request("id")%>">
<input type="hidden" name="status" value="<%=status%>">

<%
    '---------------------------------------------------------------------------------------------
	'Closing the connection
	rsdomain.close
	rscountry.close
    '---------------------------------------------------------------------------------------------
%>
</form>
</body>
</html>
