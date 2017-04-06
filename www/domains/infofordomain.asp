<%
	accessLevel = 1
%>
<!-- #INCLUDE FILE = "../inc/security.asp" -->
<!-- #INCLUDE FILE = "../inc/db.asp" -->
<!-- #INCLUDE FILE = "../inc/params.asp" -->
<html>
<head>
<title><%=lbl632%></title>

<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/general.css">
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/custom.css">
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/layout.css">
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=ISO-8859-1">
<META HTTP-EQUIV="EXPIRES" CONTENT="0">

</head>	
<%
      '---------------------------------------------------------------------------------------------
	  'Here we are extracting the name of the reseller according to the id stored in the session
	  query="select contactname from tblcontactinfo where id='" & session("reselid") & "'"
	  'response.write query
	  dim rs
	  set rs=server.createobject("ADODB.Recordset")
	  rs.open query,con
	  username=rs("contactname")
	  rs.close
	  'esponse.write "amit yadav" &session("reselid")
    set rsdomain = Server.CreateObject("ADODB.Recordset")
	query = "select * from (tblloginmaster left join tblcontactinfo on tblloginmaster.id=tblcontactinfo.id left join tbldomain on tblloginmaster.id=tbldomain.domainid left join tblrights on tblloginmaster.id=tblrights.id left join tblftpinfo on tblloginmaster.id=tblftpinfo.domainid)  where tblloginmaster.id='" & request("id") & "'"
	rsdomain.open query,con	
    
	code=rsdomain("country")
	query="select * from tblcountry where code='" & code & "'"
	set rscountry = Server.CreateObject("ADODB.Recordset")
	rscountry.open query,con


	query="sel"
%>	
<body>		
<!-- #INCLUDE FILE = "../inc/header.asp" -->

<!------------------------------------------------------------------------------------------------>
<!--Here the menu for Client is created-->
<!-- #INCLUDE FILE = "../server/subheader.asp" -->


<!--
----------------------------------------------------------------------------
The header ends here
-->




<form action="../server/create_domain.asp" method="post" name="mainform" onSubmit="return chk(document.mainform)">
 	
  <table width=564 border=0 cellpadding=0 cellspacing=0 align="center">
		<tr><td colspan=5><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></td></tr>
		<tr><td>
	    <table border=0 cellpadding=0 cellspacing=0 align="left">
		    <tr>
			    <td width=3><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="3" height="1" border="0"></td>
			    <td width=436><%=lbl509%><font name="verdana" color="red"><strong><%=" "&username%></strong></font><img src="/skins/<%=session("skin")%>/elements/white.gif" width="100%" height=1 alt="" border=0></td>
			    <td width=7><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
			    <td width=115 align="right" class="verttop"><input type="button" class="commonButton" id="bid-up-level" value="<%=lbl633%>" title="Up Level"   onClick="history.go(-1);"  ></td>
			    <td width=3><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="3" height="1" border="0"></td>
		    </tr>
        </table></td></tr>

		<tr><td colspan=5><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="16" border="0"></td></tr>

		<tr>
			<td colspan=5>
			<table width="100%" border=0 cellpadding=0 cellspacing=0 align="left">


	<tr>
		<td width="25%" align="right"><%=lbl549%></td>
		<td width="3" align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
		<td width="72%" align="left"><font color=red>www.<%=rsdomain("domainname")&".com"%></font></td>
	</tr>
	<tr><td><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></td></tr>
	
	<tr><td><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></td></tr>
	<tr>
		<td width="25%" align="right"><%=lbl634%></td>
		<td></td>
		<td width="72%" align="left"><%=rsdomain("ipaddress")%></td>
	</tr>
	<tr><td><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="16" border="0"></td></tr>
	<tr><td colspan=3><table width="100%" border=0 cellspacing=0 cellpadding=0 align="left">
                <tr> 
                  <td width="25%" align="right"><%=lbl593%>:</td>
                  <td width="3%" align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
                  <td width="72%" align="left"><%=rsdomain("contactname")%></td>
                </tr>
                <tr> 
                  <td><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></td>
                </tr>
				<tr> 
                  <td align="right"><%=lbl568%>:</td>
                  <td align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
                  <td align="left"><%=rsdomain("ftpusers")%></td>
                </tr>
				<tr> 
                  <td><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></td>
                </tr>
                <tr>
                  <td align="right"><%=lbl594%></td>
                  <td align="center">&nbsp;</td>
                  <td align="left"><%=rsdomain("ftpusername")%></td>
                </tr>
				<tr> 
                  <td><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></td>
                </tr>
                <tr> 
                  <td align="right"><%=lbl595%></td>
                  <td align="center">&nbsp;</td>
                  <td align="left"><%=rsdomain("ftppassword")%></td>
                </tr>
				<tr> 
                  <td><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></td>
                </tr>
                <tr> 
                  <td align="right"><%=lbl596%>:</td>
                  <td align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
                  <td align="left"><%=rsdomain("companyname")%></td>
                </tr>
				<tr> 
                  <td><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></td>
                </tr>
				<tr> 
                  <td align="right"><%=lbl597%>:</td>
                  <td align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
                  <td align="left"><%=rsdomain("popmailaccount")%></td>
                </tr>
				<tr> 
                  <td><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></td>
                </tr>
				<tr> 
                  <td align="right"><%=lbl598%>:</td>
                  <td align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
                  <td align="left"><%=rsdomain("email")%></td>
                </tr>
				<tr> 
                  <td><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></td>
                </tr>
				<tr> 
                  <td align="right"><%=lbl599%></td>
                  <td align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
                  <td align="left"><%=rsdomain("sqldatabase")%></td>
                </tr>
				<tr> 
                  <td><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></td>
                </tr>
				
				<tr> 
                  <td><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></td>
                </tr>
				<tr> 
                  <td align="right"><%=lbl600%>:</td>
                  <td align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
                  <td align="left"><%=rsdomain("pwdprotectdir")%></td>
                </tr>
				<tr> 
                  <td><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></td>
                </tr>
				<tr> 
                  <td align="right"><%=lbl523%>:</td>
                  <td align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
                  <td align="left"><%=rsdomain("cgisupport")%></td>
                </tr>
				<tr> 
                  <td><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></td>
                </tr>
				<tr> 
                  <td align="right"><%=lbl601%>:</td>
                  <td align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
                  <td align="left"><%=rsdomain("frontpageext")%></td>
                </tr>
				<tr> 
                  <td><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></td>
                </tr>
				<tr> 
                  <td align="right"><%=lbl519%>:</td>
                  <td align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
                  <td align="left"><%=rsdomain("aspdotnetsupport")%></td>
                </tr>
				<tr> 
                  <td><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></td>
                </tr>
				<tr> 
                  <td align="right"><%=lbl575%>:</td>
                  <td align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
                  <td align="left"><%=rsdomain("webstart")%></td>
                </tr>
				<tr> 
                  <td><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></td>
                </tr>
                <tr> 
                  <td><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></td>
                </tr>
                <tr> 
                  <td align="right"><%=lbl602%>:</td>
                  <td align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
                  <td align="left"><%=rsdomain("phone")%></td>
                </tr>
				<tr> 
                  <td><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></td>
                </tr>
                
                <tr> 
                  <td><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></td>
                </tr>
                <tr> 
                  <td align="right"><%=lbl603%>:</td>
                  <td align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
                  <td align="left"><%=rsdomain("email")%></td>
                </tr>
                <tr> 
                  <td><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></td>
                </tr>
                <tr> 
                  <td align="right"><%=lbl604%>:</td>
                  <td align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
                  <td align="left"><%=rsdomain("address")%></td>
                </tr>
                <tr> 
                  <td><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></td>
                </tr>
                <tr> 
                  <td align="right"><%=lbl605%>:</td>
                  <td align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
                  <td align="left"><%=rsdomain("city")%></td>
                </tr>
                <tr> 
                  <td><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></td>
                </tr>
                <tr> 
                  <td align="right"><%=lbl606%>:</td>
                  <td align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
                  <td align="left"><%=rsdomain("state")%></td>
                </tr>
                <tr> 
                  <td><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></td>
                </tr>
                <tr> 
                  <td align="right"><%=lbl607%>:</td>
                  <td align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
                  <td align="left"><%=rsdomain("zipcode")%></td>
                </tr>
                <tr> 
                  <td><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></td>
                </tr>
                <tr> 
                  <td align="right"><%=lbl608%>:</td>
                  <td align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
                  <td align="left"><%=rscountry("countryname")%></td>
                </tr>
                <tr> 
                  <td><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></td>
                </tr>
		     </table>
</td></tr>
</table>

			</td>
		</tr>

		<tr><td colspan=5><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="16" border="0"></td></tr>

		<tr><td>
	    <table border=0 cellpadding=0 cellspacing=0 align="left">
		    <tr>
			    <td width=446><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="3" height="1" border="0"></td>
			    <td align="right">
				<input type="button" class="commonButton" id="bid-update" value="<%=lbl635%>" title="Update" onClick="history.go(-1)"></td>
			    <td><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="3" height="1" border="0"></td>
		    </tr>
        </table></td></tr>

		<tr><td colspan=5><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></td></tr>

	</table>
	<%
	rsdomain.close
	rscountry.close
	%>
	<input type="hidden" name="cmd" value="update">
</form>

	</body>
</html>
<br>
<br>
<!-- #INCLUDE FILE = "../inc/footer.asp" -->