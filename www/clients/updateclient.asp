<%
	accessLevel = 5
%>
<!-- #INCLUDE FILE = "../inc/security.asp" -->
<!-- #include file="../inc/header.asp" -->
<!-- #INCLUDE FILE="../inc/db.asp" -->

<html>
<head>
<title><%=lblUpdateClientInformation%></title>
<link rel="stylesheet" type="text/css" href="/skins/default/css/general.css">
<link rel="stylesheet" type="text/css" href="/skins/default/css/custom.css">
<link rel="stylesheet" type="text/css" href="/skins/default/css/layout.css">
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=ISO-8859-1">
<META HTTP-EQUIV="EXPIRES" CONTENT="0">
</head>
<%
    id=session("reselid")
    query="select * from tblcontactinfo where id='" & id & "'"
    set rsname=server.CreateObject("adodb.recordset")
    rsname.open query,con

    query="select * from tblftpinfo where domainid='" & id & "'"
	set rsftp=server.CreateObject("adodb.recordset")
    rsftp.open query,con
    
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
	code=rsname("country")


	query="select * from tblcountry"
	set rscountry=server.CreateObject("ADODb.Recordset")
	rscountry.open query,con
	country=rscountry("countryname")
%>
<body>
    <form action="/clients/updateclient1.asp" method="post" name="mainform">
	<input type="hidden" name="ftpusername" value="<%=ftpusername%>">
      <tr > 
        <td colspan=3 height="17" valign="middle"> 
<!-- #include file="../clients/clientheader.asp" -->
    <table width="82%" border=0 align="center" cellpadding=0 cellspacing=0>
          <tr> 
            <td align="right"><div align="right"></div>
              <div align="left">Information for client <font color="#CC0000" face="verdana"><strong><%=username%></strong></font></div></td>
            <td align="center"> 
              <%	
    usertype=session("type")
	if(usertype="a") then
%>
              <div align="right"> 
                <input name="Button2" type="button" class="commonButton" id="Button" title="<%=lblup1level%>" onClick="window.location='/server/domains.asp';" value="<%=lbluplevel%>" >
                <%else%>
                <input name="Button2" type="button" class="commonButton" id="Button" title="<%=lblup1level%>" onClick="window.location='/domains/clientdomains.asp';" value="<%=lbluplevel%>" >
                <%end if%>
              </div></td>
          </tr>
          <tr> 
            <td colspan="2" align="right"><div align="center"><font color="#006666"><img src="/skins/<%=session("skin")%>/elements/line.gif" width=560 height=1 border=0></font></div></td>
          </tr>
        </table>
    <p>&nbsp;</p>
    
        <table width="68%" border=0 align="center" cellpadding=0 cellspacing=0>
          <tr> 
            <td align="right"><strong><font color="#003366">Client name:</font></strong></td>
            <td width="22" align="center">&nbsp;</td>
            <td width="342" align="left"><font color="#993300" face="	vwerdana"><strong> 
              <input name="clientname" type="text" id="clientname" value="<%=username%>">
              </strong></font></td>
          </tr>
          <tr> 
            <td><strong><font color="#003366"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></font></strong></td>
          </tr>
          <tr> 
            <td width="293" align="right"><strong><font color="#003366"><%=lblpersonalname%></font></strong></td>
            <td width="22" align="center">&nbsp;</td>
            <td width="342" align="left"><font color="#993300"> 
              <input name="personalname" type="text" id="personalname" value="<%=Personalname%>">
              </font></td>
          </tr>
          <tr> 
            <td><strong><font color="#003366"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></font></strong></td>
          </tr>
          <tr> 
            <td align="right"><strong><font color="#003366"><%=lblFTPPassword%></font></strong></td>
            <td align="center">&nbsp;</td>
            <td align="left"><font color="#993300"> 
              <input name="ftppassword" type="text" id="ftpusername" value="<%=password%>">
              </font></td>
          </tr>
          <tr> 
            <td><strong><font color="#003366"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></font></strong></td>
          </tr>
          <tr> 
            <td align="right"><strong><font color="#003366"><%=lblcompanyname%></font></strong></td>
            <td align="center">&nbsp;</td>
            <td align="left"><font color="#993300"> 
              <input name="company" type="text" id="company" value="<%=company%>">
              </font></td>
          </tr>
          <tr> 
            <td><strong><font color="#003366"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></font></strong></td>
          </tr>
          <tr> 
            <td align="right"><strong><font color="#003366"><%=lblphone%></font></strong></td>
            <td align="center">&nbsp;</td>
            <td align="left"><font color="#993300"> 
              <input name="phone" type="text" id="phone" value="<%=phone%>">
              </font></td>
          </tr>
          <tr> 
            <td><strong><font color="#003366"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></font></strong></td>
          </tr>
          <tr> 
            <td align="right"><strong><font color="#003366"><%=lblemail%></font></strong></td>
            <td align="center">&nbsp;</td>
            <td align="left"><font color="#993300"> 
              <input name="email" type="text" id="email" value="<%=email%>">
              </font></td>
          </tr>
          <tr> 
            <td><strong><font color="#003366"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></font></strong></td>
          </tr>
          <tr> 
            <td align="right"><strong><font color="#003366"><%=lbladdress%></font></strong></td>
            <td align="center">&nbsp;</td>
            <td align="left"><font color="#993300"> 
              <input name="address" type="text" id="address" value="<%=Address%>">
              </font></td>
          </tr>
          <tr> 
            <td><strong><font color="#003366"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></font></strong></td>
          </tr>
          <tr> 
            <td align="right"><strong><font color="#003366"><%=lblcity%></font></strong></td>
            <td align="center">&nbsp;</td>
            <td align="left"><font color="#993300"> 
              <input name="city" type="text" id="city" value="<%=city%>">
              </font></td>
          </tr>
          <tr> 
            <td><strong><font color="#003366"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></font></strong></td>
          </tr>
          <tr> 
            <td align="right"><strong><font color="#003366"><%=lblstate%></font></strong></td>
            <td align="center">&nbsp;</td>
            <td align="left"><font color="#993300"> 
              <input name="state" type="text" id="state" value="<%=state%>">
              </font></td>
          </tr>
          <tr> 
            <td><strong><font color="#003366"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></font></strong></td>
          </tr>
          <tr> 
            <td align="right"><strong><font color="#003366"><%=lblzipcode%></font></strong></td>
            <td align="center">&nbsp;</td>
            <td align="left"><font color="#993300"> 
              <input name="zipcode" type="text" id="zipcode" value="<%=zip%>">
              </font></td>
          </tr>
          <tr> 
            <td><strong><font color="#003366"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></font></strong></td>
          </tr>
          <tr> 
            <td align="right"><strong><font color="#003366"><%=lblCountry%></font></strong></td>
            <td align="center">&nbsp;</td>
            <td align="left"><font color="#993300"> 
              <select name="country">
                <%	while(not rscountry.EOF) %>
                <option value="<%=rscountry("code")%>" <%if(code=rscountry("code")) then response.write "Selected"%>><%=rscountry("countryname")%></option>
                <%  
							rscountry.movenext
							wend
					  %>
              </select>
              </font></td>
          </tr>
          <tr> 
            <td colspan="3" height="28" align="right"><div align="center"><font color="#006666"><img src="/skins/<%=session("skin")%>/elements/line.gif" width=560 height=1 border=0></font></div></td>
          </tr>
          <tr> 
            <td height="28" colspan="3" align="center">
<input name="Button222" type="submit" class="commonButton" id="Button22" title="<%=lblUpdate%>" accept=""onClick="" value="<%=lblUpdate%>" >
<%	
    usertype=session("type")
	if(usertype="a") then
%>
<input name="Button22" type="button" class="commonButton" id="Button2" title="<%=lblOk%>" onClick="window.location='/server/domains.asp';" value="<%=lblOk%>" >
<%else%>
<input name="Button22" type="button" class="commonButton" id="Button2" title="<%=lblup1level%>" onClick="window.location='/domains/clientdomains.asp';" value="<%=lblOk%>" >
<%end if%>
</td>
</tr>
</table>
</body>
</form>
</html>
<br>
<!-- #INCLUDE FILE = "../inc/footer.asp" -->