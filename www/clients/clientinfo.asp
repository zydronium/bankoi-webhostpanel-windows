<%
	accessLevel = 5
%>
<!-- #INCLUDE FILE = "../inc/security.asp" -->
<!-- #include file="../inc/header.asp" -->
<!-- #INCLUDE FILE="../inc/db.asp" -->

<html>
<head>
<title><%=lblclientcontinfo%></title>
<link rel="stylesheet" type="text/css" href="/skins/default/css/general.css">
<link rel="stylesheet" type="text/css" href="/skins/default/css/custom.css">
<link rel="stylesheet" type="text/css" href="/skins/default/css/layout.css">
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=ISO-8859-1">
<META HTTP-EQUIV="EXPIRES" CONTENT="0">

<script>
function chk(f)
{
	f.action="/clients/changestatus.asp";
	f.submit();
}
</script>

</head>
<body>
<form name="mainform" action='/clients/updateclient.asp' method="post">
<%
    id=session("reselid")
    query="select * from tblcontactinfo where id='" & id & "'"
    set rsname=server.CreateObject("adodb.recordset")
    rsname.open query,con

	query="select * from tblftpinfo where domainid='" & id & "'"
	set rsftp=server.CreateObject("adodb.recordset")
    rsftp.open query,con
	'-----------------------------------------------------------------------------------------    
	username=rsname("contactname")
    Personalname=rsname("cploginname")
	FTPUsername=rsftp("ftpusername")
	Password=rsftp("ftppassword")
	Company=rsname("companyname")
	Phone=rsname("phone")
	email=rsname("email")
	Address=rsname("address")
	City=rsname("city")
	State=rsname("state")
	ZIP=rsname("zipcode")
	Country=rsname("country")
	'-----------------------------------------------------------------------------------------

	query="select status from tblloginmaster where id='" & id & "'"
	set rsstatus=server.CreateObject("ADODb.Recordset")
	rsstatus.open query,con

	if(rsstatus("status")=0)then
	   status=lbl521
	else
		status=lbl522
	end if
	rsstatus.close
	
	query="select * from tblcountry where code='" & country & "'"
	set rscountry=server.CreateObject("ADODb.Recordset")
	rscountry.open query,con
	country=rscountry("countryname")
   
    query="select tblserverip.ipaddress from (tblresellerip inner join tblserverip on tblresellerip.ipaddress=tblserverip.id) where resellerid='" & id & "'"
    set rs=server.CreateObject("adodb.recordset")
    rs.open query,con
%>
<input type="hidden" name="statusname" value="<%=status%>">
    <table width="564" border="0" align="center" cellpadding=0 cellspacing=0>
      <tr > 
        <td colspan=3 height="17" valign="middle"> 
<!-- #include file="../clients/clientheader.asp" -->
<br><br>
    <table width="82%" border=0 align="center" cellpadding=0 cellspacing=0>
      <tr> 
        <td width="345" align="right"><div align="left"><%=lblclientinfo%>
            <font color="#CC0000" face="	vwerdana"><strong><%=username%></strong></font></div></td>
        <td width="1" align="center"><div align="right"></div></td>
        <td width="369" align="right"> 
<%	
    usertype=session("type")
	if(usertype="a") then
%>
          <input name="Button2" type="button" class="commonButton" id="Button" title="<%=lblup1level%>" onClick="window.location='/server/domains.asp';" value="<%=lbluplevel%>" > 
          <%else%>
          <input name="Button2" type="button" class="commonButton" id="Button" title="<%=lblup1level%>" onClick="window.location='/domains/clientdomains.asp';" value="<%=lbluplevel%>" > 
<%end if%>
        </td>
      </tr>
      <tr> 
        <td colspan="3" align="right"><div align="center"><font color="#006666"><img src="/skins/<%=session("skin")%>/elements/line.gif" width=560 height=1 border=0></font></div></td>
      </tr>
    </table>    
          <table width="79%" border=0 align="center" cellpadding=0 cellspacing=0>
            <tr> 
              <td align="right"><strong><font color="#003366"><%=lblclientname%></font></strong></td>
              <td width="24" align="center">&nbsp;</td>
              <td width="444" align="left"><font color="#993300" face="	vwerdana"><strong><%=username%></strong></font></td>
            </tr>
            <tr> 
              <td><strong><font color="#003366"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></font></strong></td>
            </tr>
            <tr> 
              <td width="295" align="right"><strong><font color="#003366"><%=lblassignedIP%>:</font></strong></td>
              <td><div align="center"></div></td>
              <td width="444" align="left"><font color="#993300">&nbsp;</font></td>
            </tr>
            <%
	while(not rs.eof)
%>
            <tr> 
              <td width="295" align="right"><strong><font color="#003366">&nbsp;</font></strong></td>
              <td><div align="center"></div></td>
              <td width="444" align="left"><font color="#993300"><%=rs("ipaddress")%>:</font></td>
            </tr>
            <%
	rs.movenext
	wend
%>
            <tr> 
              <td><strong><font color="#003366"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></font></strong></td>
            </tr>
            <tr> 
              <td width="295" align="right"><strong><font color="#003366"><%=lblpersonalname%></font></strong></td>
              <td width="24" align="center">&nbsp;</td>
              <td width="444" align="left"><font color="#993300"><%=Personalname%></font></td>
            </tr>
            <tr> 
              <td><strong><font color="#003366"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></font></strong></td>
            </tr>
            <tr> 
              <td align="right"><strong><font color="#003366"><%=lblftpusername%>:</font></strong></td>
              <td align="center">&nbsp;</td>
              <td align="left"><font color="#993300"><%=FTPUsername%></font></td>
            </tr>
            <tr> 
              <td><strong><font color="#003366"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></font></strong></td>
            </tr>
            <tr> 
              <td align="right"><strong><font color="#003366"><%=lblcpftpuserpasswd%>:</font></strong></td>
              <td align="center">&nbsp;</td>
              <td align="left"><font color="#993300"><%=password%></font></td>
            </tr>
            <tr> 
              <td><strong><font color="#003366"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></font></strong></td>
            </tr>
            <tr> 
              <td align="right"><strong><font color="#003366"><%=lblcompanyname%>:</font></strong></td>
              <td align="center">&nbsp;</td>
              <td align="left"><font color="#993300"><%=company%></font></td>
            </tr>
            <tr> 
              <td><strong><font color="#003366"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></font></strong></td>
            </tr>
            <tr> 
              <td align="right"><strong><font color="#003366"><%=lblphone%></font></strong></td>
              <td align="center">&nbsp;</td>
              <td align="left"><font color="#993300"><%=phone%></font></td>
            </tr>
            <tr> 
              <td><strong><font color="#003366"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></font></strong></td>
            </tr>
            <tr> 
              <td align="right"><strong><font color="#003366"><%=lblemail%></font></strong></td>
              <td align="center">&nbsp;</td>
              <td align="left"><font color="#993300"><%=email%></font></td>
            </tr>
            <tr> 
              <td><strong><font color="#003366"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></font></strong></td>
            </tr>
            <tr> 
              <td align="right"><strong><font color="#003366"><%=lbladdress%></font></strong></td>
              <td align="center">&nbsp;</td>
              <td align="left"><font color="#993300"><%=Address%></font></td>
            </tr>
            <tr> 
              <td><strong><font color="#003366"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></font></strong></td>
            </tr>
            <tr> 
              <td align="right"><strong><font color="#003366"><%=lblcity%></font></strong></td>
              <td align="center">&nbsp;</td>
              <td align="left"><font color="#993300"><%=city%></font></td>
            </tr>
            <tr> 
              <td><strong><font color="#003366"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></font></strong></td>
            </tr>
            <tr> 
              <td align="right"><strong><font color="#003366"><%=lblstate%></font></strong></td>
              <td align="center">&nbsp;</td>
              <td align="left"><font color="#993300"><%=state%></font></td>
            </tr>
            <tr> 
              <td><strong><font color="#003366"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></font></strong></td>
            </tr>
            <tr> 
              <td align="right"><strong><font color="#003366"><%=lblzipcode%></font></strong></td>
              <td align="center">&nbsp;</td>
              <td align="left"><font color="#993300"><%=zip%></font></td>
            </tr>
            <tr> 
              <td><strong><font color="#003366"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></font></strong></td>
            </tr>
            <tr> 
              <td height="19" align="right"><strong><font color="#003366"><%=lblCountry%></font></strong></td>
              <td align="center">&nbsp;</td>
              <td align="left"><font color="#993300"><%=country%></font></td>
            </tr>
            <tr> 
              <td colspan="3" height = "38" align="right"><div align="center"><font color="#006666"><img src="/skins/<%=session("skin")%>/elements/line.gif" width=560 height=1 border=0></font></div></td>
            </tr>
            <br>
            <br>
            <tr> 
              <td height="30" colspan="3" align="center"> 
                <%	
    rs.close
	rsname.close
	rscountry.close
    usertype=session("type")
	if(usertype="a") then
%>
                <input name="Button2222" type="button" class="commonButton" id="Button222" title="<%=status%>" onClick="return chk(document.mainform)" value="<%=status%>" > 
                <input name="Button222" type="button" class="commonButton" id="Button22" title="<%=lblUpdate%>" accept=""onClick="window.location='/clients/updateclient.asp'" value="<%=lblUpdate%>" > 
                <input name="Button22" type="button" class="commonButton" id="Button2" title="<%=lblOk%>" onClick="window.location='/server/domains.asp';" value="<%=lblOk%>" > 
                <%else%>
                <input name="Button222" type="submit" class="commonButton" id="Button22" title="<%=lblUpdate%>" accept="" value="<%=lblUpdate%>" > 
                <input name="Button22" type="button" class="commonButton" id="Button2" title="<%=lblup1level%>" onClick="window.location='/domains/clientdomains.asp';" value="<%=lblOk%>" > 
                <%end if%>
              </td>
            </tr>
          </table>
</form>
</body>
</html> 
<br>
<!-- #INCLUDE FILE = "../inc/footer.asp" -->