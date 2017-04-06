<%
	accessLevel = 1
%>
<!-- #INCLUDE FILE = "../inc/security.asp" -->
<!-- #INCLUDE FILE = "../inc/db.asp" -->
<!-- #INCLUDE FILE = "../inc/params.asp" -->

<%
    id=session("id")  'ID of the domain
    '---------------------------------------------------------------------------------------------
	'Here we will select the name of the FTP users of the domain who has logged in
	query="select ftpusername from tblftpinfo where domainid='" & id & "' and ucase(type)='D'"
	set rsftpuser=Server.CreateObject("ADODB.Recordset")
	rsftpuser.open query,con
	ftpusername=rsftpuser("ftpusername")

	'-------------------SESSION-------------------------------------------------------------------
	session("ftpuser")=ftpusername  'The FTP username set in the session
    '---------------------------------------------------------------------------------------------
		
    set rsdomain = Server.CreateObject("ADODB.Recordset")
	query = "select * from (tblloginmaster left join tblcontactinfo on tblloginmaster.id=tblcontactinfo.id left join tbldomain on tblloginmaster.id=tbldomain.domainid left join tblrights on tblloginmaster.id=tblrights.id left join tblftpinfo on tblloginmaster.id=tblftpinfo.domainid)  where tblloginmaster.id='" & id & "'"
	rsdomain.open query,con	
    
	code=rsdomain("country")
	query="select * from tblcountry where code='" & code & "'"
	set rscountry = Server.CreateObject("ADODB.Recordset")
	rscountry.open query,con

	ipid=rsdomain("ipaddress")
	query="select tblserverip.ipaddress from tblserverip where id='" & ipid & "'"
	set rsip = Server.CreateObject("ADODB.Recordset")
	rsip.open query,con
	ipaddress=rsip("ipaddress")
    'ucase(session("resellername"))
	if(session("contactname")="") then
					query="select username, tblloginmaster.id as uid from (tbldomain inner join tblloginmaster on tbldomain.resellerid=tblloginmaster.id) where tbldomain.domainid='" & id & "'"
					set rs2=server.createobject("ADODB.Recordset")
					rs2.open query,con
					uid=rs2("uid")
					rs2.close
					
					set rs3 = server.createobject("ADODB.recordset")
					query = "select contactname from tblcontactinfo where id='" & uid & "'"
					rs3.open query,con
					session("contactname")=rs3("contactname")
	end if
%>	

<html>
<head>
<title><%=lbl591%> <%=username%></title>

<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/general.css">
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/custom.css">
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/layout.css">
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=ISO-8859-1">
<META HTTP-EQUIV="EXPIRES" CONTENT="0">


</head>	

<body>
<!-- #INCLUDE FILE = "../inc/header.asp" -->
<!--The header of the domain prepared here-->
<!-- #INCLUDE FILE = "../domains/domainheader.asp" -->
<form action="" method="post" name="mainform">
  <% 'response.Write(date())%> 
  <table width=370 border=0 align="center" cellpadding=0 cellspacing=0 bordercolor="#FFFFFF">
		<tr><td width="370" colspan=5><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></td></tr>
		<tr><td>
	    <table border=0 cellpadding=0 cellspacing=0 align="left">
		    <tr>
			    <td width=3><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="3" height="1" border="0"></td>
			    <td width=436><%=lbl509%> <font name="verdana" color="red"><strong><%=" "&ucase(session("resellername"))%></strong></font><img src="/skins/<%=session("skin")%>/elements/white.gif" width="100%" height=1 alt="" border=0></td>
			    <td width=7><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
			    
            <td width=115 align="right" class="verttop">&nbsp;</td>
			    <td width=3><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="3" height="1" border="0"></td>
		    </tr>
        </table></td></tr>

		<tr>
      <td colspan=5><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="16" border="0"><img src="/skins/<%=session("skin")%>/elements/line.gif" width=560 height=1 border=0></td>
    </tr>

		<tr>
			<td colspan=5>
			<table border=0 align="left" cellpadding=0 cellspacing=0 bordercolor="#FFFFFF">
          <tr bgcolor="#FFFFFF"> 
            <td width="239" align="right"><font color="#FF6600"><strong><%=lbl549%></strong></font></td>
            <td width="29" align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
            <td width="292" align="left"><font color=red><%=rsdomain("domainname")%></font></td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td colspan="3"><font color="#FF6600"><strong><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></strong></font></td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td colspan="3"><font color="#FF6600"><strong><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></strong></font></td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td width="239" align="right"><font color="#FF6600"><strong><%=lbl592%></strong></font></td>
            <td></td>
            <td width="292" align="left"><font color="#003399"><%=ipaddress%></font></td>
          </tr>
          <tr bgcolor="#FFFFFF"> 
            <td colspan="3"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="16" border="0"></td>
          </tr>
           
            <tr bgcolor="#FFFFFF"><td colspan=3>
                <tr bgcolor="#FFFFFF"> 
                  <td width="43%" align="right"><strong><font color="#FF6600"><%=lbl593%>:</font></strong></td>
                  <td width="5%" align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
                  <td width="52%" align="left"><font color="#003399"><%=rsdomain("contactname")%></font></td>
                </tr>
                <tr bgcolor="#FFFFFF"> 
                  <td colspan="3"><strong><font color="#FF6600"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></font></strong></td>
                </tr>
                <tr bgcolor="#FFFFFF"> 
                  <td align="right"><strong><font color="#FF6600"><%=lbl568%>:</font></strong></td>
                  <td align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
                  <td align="left"><font color="#003399"><%=rsdomain("ftpusers")%></font></td>
                </tr>
                <tr bgcolor="#FFFFFF"> 
                  <td colspan="3"><strong><font color="#FF6600"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></font></strong></td>
                </tr>
                <tr bgcolor="#FFFFFF"> 
                  <td align="right"><strong><font color="#FF6600"><%=lbl594%></font></strong></td>
                  <td align="center">&nbsp;</td>
                  <td align="left"><font color="#003399"><%=rsdomain("ftpusername")%></font></td>
                </tr>
                <tr bgcolor="#FFFFFF"> 
                  <td colspan="3"><strong><font color="#FF6600"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></font></strong></td>
                </tr>
                <tr bgcolor="#FFFFFF"> 
                  <td align="right"><strong><font color="#FF6600"><%=lbl595%></font></strong></td>
                  <td align="center">&nbsp;</td>
                  <td align="left"><font color="#003399"><%=rsdomain("ftppassword")%></font></td>
                </tr>
                <tr bgcolor="#FFFFFF"> 
                  <td colspan="3"><strong><font color="#FF6600"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></font></strong></td>
                </tr>
                <tr bgcolor="#FFFFFF"> 
                  <td align="right"><strong><font color="#FF6600"><%=lbl596%>:</font></strong></td>
                  <td align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
                  <td align="left"><font color="#003399"><%=rsdomain("companyname")%></font></td>
                </tr>
                <tr bgcolor="#FFFFFF"> 
                  <td colspan="3"><strong><font color="#FF6600"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></font></strong></td>
                </tr>
                <tr bgcolor="#FFFFFF"> 
                  <td align="right"><strong><font color="#FF6600"><%=lbl597%>:</font></strong></td>
                  <td align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
                  <td align="left"><font color="#003399"><%=rsdomain("popmailaccount")%></font></td>
                </tr>
                <tr bgcolor="#FFFFFF"> 
                  <td colspan="3"><strong><font color="#FF6600"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></font></strong></td>
                </tr>
                <tr bgcolor="#FFFFFF"> 
                  <td align="right"><strong><font color="#FF6600"><%=lbl598%>:</font></strong></td>
                  <td align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
                  <td align="left"><font color="#003399"><%=rsdomain("emailalias")%></font></td>
                </tr>
                <tr bgcolor="#FFFFFF"> 
                  <td colspan="3"><strong><font color="#FF6600"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></font></strong></td>
                </tr>
                <tr bgcolor="#FFFFFF"> 
                  <td align="right"><strong><font color="#FF6600"><%=lbl599%>:</font></strong></td>
                  <td align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
                  <td align="left"><font color="#003399"><%=rsdomain("sqldatabase")%></font></td>
                </tr>
                <tr bgcolor="#FFFFFF"> 
                  <td colspan="3"><strong><font color="#FF6600"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></font></strong></td>
                </tr>
                <tr bgcolor="#FFFFFF"> 
                  <td colspan="3"><strong><font color="#FF6600"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></font></strong></td>
                </tr>
                <tr bgcolor="#FFFFFF"> 
                  <td align="right"><strong><font color="#FF6600"><%=lbl600%>:</font></strong></td>
                  <td align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
                  <td align="left"><font color="#003399"><%=rsdomain("pwdprotectdir")%></font></td>
                </tr>
                <tr bgcolor="#FFFFFF"> 
                  <td colspan="3"><strong><font color="#FF6600"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></font></strong></td>
                </tr>
                <tr bgcolor="#FFFFFF"> 
                  <td align="right"><strong><font color="#FF6600"><%=lbl523%>:</font></strong></td>
                  <td align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
                  <td align="left"><font color="#003399"><%=rsdomain("cgisupport")%></font></td>
                </tr>
                <tr bgcolor="#FFFFFF"> 
                  <td colspan="3"><strong><font color="#FF6600"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></font></strong></td>
                </tr>
                <tr bgcolor="#FFFFFF"> 
                  <td align="right"><strong><font color="#FF6600"><%=lbl601%>:</font></strong></td>
                  <td align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
                  <td align="left"><font color="#003399"><%=rsdomain("frontpageext")%></font></td>
                </tr>
                <tr bgcolor="#FFFFFF"> 
                  <td colspan="3"><strong><font color="#FF6600"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></font></strong></td>
                </tr>
                <tr bgcolor="#FFFFFF"> 
                  <td align="right"><strong><font color="#FF6600"><%=lbl519%>:</font></strong></td>
                  <td align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
                  <td align="left"><font color="#003399"><%=rsdomain("aspdotnetsupport")%></font></td>
                </tr>
                <tr bgcolor="#FFFFFF"> 
                  <td colspan="3"><strong><font color="#FF6600"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></font></strong></td>
                </tr>
                <tr bgcolor="#FFFFFF"> 
                  <td align="right"><strong><font color="#FF6600"><%=lbl575%>:</font></strong></td>
                  <td align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
                  <td align="left"><font color="#003399"><%=rsdomain("webstats")%></font></td>
                </tr>
                <tr bgcolor="#FFFFFF"> 
                  <td colspan="3"><strong><font color="#FF6600"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></font></strong></td>
                </tr>
                <tr bgcolor="#FFFFFF"> 
                  <td align="right"><strong><font color="#FF6600"><%=lbl602%>:</font></strong></td>
                  <td align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
                  <td align="left"><font color="#003399"><%=rsdomain("phone")%></font></td>
                </tr>
                <tr bgcolor="#FFFFFF"> 
                  <td colspan="3"><strong><font color="#FF6600"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></font></strong></td>
                </tr>
                <tr bgcolor="#FFFFFF"> 
                  <td align="right"><strong><font color="#FF6600"><%=lbl603%>:</font></strong></td>
                  <td align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
                  <td align="left"><font color="#003399"><%=rsdomain("email")%></font></td>
                </tr>
                <tr bgcolor="#FFFFFF"> 
                  <td colspan="3"><strong><font color="#FF6600"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></font></strong></td>
                </tr>
                <tr bgcolor="#FFFFFF"> 
                  <td align="right"><strong><font color="#FF6600"><%=lbl604%>:</font></strong></td>
                  <td align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
                  <td align="left"><font color="#003399"><%=rsdomain("address")%></font></td>
                </tr>
                <tr bgcolor="#FFFFFF"> 
                  <td colspan="3"><strong><font color="#FF6600"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></font></strong></td>
                </tr>
                <tr bgcolor="#FFFFFF"> 
                  <td align="right"><strong><font color="#FF6600"><%=lbl605%>:</font></strong></td>
                  <td align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
                  <td align="left"><font color="#003399"><%=rsdomain("city")%></font></td>
                </tr>
                <tr bgcolor="#FFFFFF"> 
                  <td colspan="3"><strong><font color="#FF6600"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></font></strong></td>
                </tr>
                <tr bgcolor="#FFFFFF"> 
                  <td align="right"><strong><font color="#FF6600"><%=lbl606%>:</font></strong></td>
                  <td align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
                  <td align="left"><font color="#003399"><%=rsdomain("state")%></font></td>
                </tr>
                <tr bgcolor="#FFFFFF"> 
                  <td colspan="3"><strong><font color="#FF6600"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></font></strong></td>
                </tr>
                <tr bgcolor="#FFFFFF"> 
                  <td align="right"><strong><font color="#FF6600"><%=lbl607%>:</font></strong></td>
                  <td align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
                  <td align="left"><font color="#003399"><%=rsdomain("zipcode")%></font></td>
                </tr>
                <tr bgcolor="#FFFFFF"> 
                  <td colspan="3"><strong><font color="#FF6600"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></font></strong></td>
                </tr>
                <tr bgcolor="#FFFFFF"> 
                  <td align="right"><strong><font color="#FF6600"><%=lbl608%>:</font></strong></td>
                  <td align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
                  <td align="left"><font color="#003399"><%=rscountry("countryname")%></font></td>
                </tr>
                <tr bgcolor="#FFFFFF"> 
                  <td colspan="3"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></td>
                </tr>
              </table></td>
          </tr>
        </table>

			<tr>
      <td colspan=5><div align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="16" border="0"><img src="/skins/<%=session("skin")%>/elements/line.gif" width=560 height=1 border=0></div></td>
    </tr>

		<tr><td>
	    <table border=0 cellpadding=0 cellspacing=0 align="left">
		    <tr>
			    <td width=446><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="3" height="1" border="0"></td>
			    <td><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="3" height="1" border="0"></td>
		    </tr>
        </td></tr>

		<tr><td colspan=5><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></td></tr>

	</table>
	<input type="hidden" name="cmd" value="update">
</form>

	</body>
</html>
<br>
<br>
<!-- #INCLUDE FILE = "../inc/footer.asp" -->