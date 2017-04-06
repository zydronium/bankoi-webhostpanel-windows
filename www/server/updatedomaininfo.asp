<%
	accessLevel = 5
%>
<!-- #INCLUDE FILE = "../inc/security.asp" -->
<!-- #INCLUDE FILE = "../inc/db.asp" -->
<html>
<head>
<title>Domain Information</title>

<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/general.css">
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/custom.css">
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/layout.css">
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=ISO-8859-1">
<META HTTP-EQUIV="EXPIRES" CONTENT="0">
<script language="JavaScript" src="/js/functions.js"></script>
<script language="javascript">

function validate(f)
{
  if(isNaN(f.value))
     {
        alert("Numbers Only");
        f.value="";
	    return false;
      }
   return true;
}



//---------------------------------------------------------------------------------------------------------
function chk(f)
{
  	if(!f.password.value)
          {
				alert("password is empty");
				f.password.focus();
				return false;
		  }
	
   else
      if(!f.ftpusers.value){
			f.ftpusers.value="0";
			return true;
        }
      if(!f.popmailaccount.value){
			f.popmailaccount.value="0";
			return true;
		}

	  if(!f.mssqldatabase.value){
			 f.mssqldatabase.value="0";
			 return true;
		}
  return true;
}


//-----------------------------------
function chk_form_data1(f)
{
	if(!chk(f))
	   return false
	f.submit();
	return true;
}


</script>	


</head>	
<%
    id=session("id") 
    resellerid=session("reselid")
	'-------------------------------------------------------------------------------------------------------
	'here we show only the ipaddress assigned to the reseller
	query="select tblserverip.ipaddress,tblserverip.iptype,tblserverip.id from (tblresellerip inner join tblserverip on tblresellerip.ipaddress=tblserverip.id) where tblresellerip.resellerid='" & resellerid & "'"
	dim ipadd
	set ipadd=server.createobject("ADODB.recordset")
	ipadd.open query,con
	'---------------------------------------------------------------------------------------------------
	'Here we are extracting the name of the reseller according to the id stored in the session
	if(len(session("reselid"))=0) then
	else  
		query2="select contactname from tblcontactinfo where id='" & session("reselid") & "'"
		'response.write query
		dim records
		set records=server.createobject("ADODB.Recordset")
		records.open query2,con
		resellername=records("contactname")
		'records.close
		'response.write "amit yadav" &session("reselid")
    end if
    set rsdomain = Server.CreateObject("ADODB.Recordset")
	query = "select * from (tblloginmaster left join tblcontactinfo on tblloginmaster.id=tblcontactinfo.id left join tbldomain on tblloginmaster.id=tbldomain.domainid left join tblrights on tblloginmaster.id=tblrights.id left join tblftpinfo on tblloginmaster.id=tblftpinfo.domainid)  where tblloginmaster.id='" & id & "'"
	rsdomain.open query,con	
    
	code=rsdomain("country")
	query="select * from tblcountry"
	set rscountry = Server.CreateObject("ADODB.Recordset")
	rscountry.open query,con

	query="select * from tbldomain,tblcontactinfo where tbldomain.resellerid=tblcontactinfo.id and tbldomain.domainid='" & id & "'"
	set resellername=Server.CreateObject("ADODB.Recordset")
	resellername.open query,con
	resellername=resellername("contactname")

	ipid=rsdomain("ipaddress")
	query="select tblserverip.ipaddress from tblserverip where id='" & ipid & "'"
	set rsip = Server.CreateObject("ADODB.Recordset")
	rsip.open query,con
	ipaddress=rsip("ipaddress")

	'response.write "The ftp usera are "&rsdomain("ftpusers")
%>	
<body>		
<!-- #INCLUDE FILE = "../inc/header.asp" -->

<!-- #INCLUDE FILE = "../server/subheader.asp" -->
<!---------------------------------------------------------------------------------------------------------->
<!--Here the menu for domain is created-->
<!-- #INCLUDE FILE = "../domains/domainheader.asp" -->

<form action="../server/updatedomain.asp" method="post" name="mainform" onSubmit="return chk(document.mainform)">
<input type="hidden" name="ftpusername" value="<%=rsdomain("ftpusername")%>">
  <table width=564 border=0 cellpadding=0 cellspacing=0 align="center">
		<tr><td colspan=5><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></td></tr>
		<tr><td>
	    <table border=0 cellpadding=0 cellspacing=0 align="left">
		    <tr>
			    <td width=3><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="3" height="1" border="0"></td>
			    <td width=436>Domain Of <font name="verdana" color="red"><strong><%=" "&resellername%></strong></font><img src="/skins/<%=session("skin")%>/elements/white.gif" width="100%" height=1 alt="" border=0></td>
			    <td width=7><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
			    <td width=115 align="right" class="verttop"><input type="button" class="commonButton" id="bid-up-level" value="<%=lbluplevel%>" title="<%=lbluplevel%>"   onClick="history.go(-1);"  ></td>
			    <td width=3><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="3" height="1" border="0"></td>
		    </tr>
        </table></td></tr>

		<tr>
      <td colspan=5><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="16" border="0"><font color="#006666"><img src="/skins/<%=session("skin")%>/elements/line.gif" width=560 height=1 border=0></font></td>
    </tr>

		<tr>
			<td colspan=5>
			<table width="100%" border=0 cellpadding=0 cellspacing=0 align="left">
          <tr> 
            <td>&nbsp;</td>
          </tr>
          <tr> 
            <td><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></td>
          </tr>
          <tr> 
            <td width="25%" align="right"><%=lblAssignedIP%></td>
            <td width="3"></td>
            <td width="72%" align="left">
			<select name="ip_addr_id" >
<%
   while(not ipadd.EOF)
%>
                <option value="<%=ipadd("id")%>" <%if(ipadd("id")=ipaddress) then response.Write("Selected")%>><%=ipadd("ipaddress")&" -> "&ipadd("iptype")%> 
<%
ipadd.movenext
wend
%>
              </select></td>
          </tr>
          <tr> 
            <td><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="16" border="0"></td>
          </tr>
          <tr> 
            <td colspan=3><table width="100%" border=0 cellspacing=0 cellpadding=0 align="left">
                <tr> 
                  <td width="25%" align="right"><%=lblpersonalname%></td>
                  <td width="3%" align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
                  <td width="72%" align="left"> <input type="text" name="personalname" value="<%=rsdomain("contactname")%>" size=25 maxlength=255></td>
                </tr>
                <tr> 
                  <td><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></td>
                </tr>
                <tr> 
                  <td align="right"><%=lblFtpUsers%></td>
                  <td align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
                  <td align="left"> <input type="text" name="ftpusers" value="<%=rsdomain("ftpusers")%>" size=25 maxlength=255 onChange="return validate(document.mainform.ftpusers)"></td>
                </tr>
                                
                <tr> 
                  <td><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></td>
                </tr>
                <tr> 
                  <td align="right"><%=lblcpftpuserpasswd%></td>
                  <td align="center">&nbsp;</td>
                  <td align="left"> <input type="password" name="password" value="<%=rsdomain("ftppassword")%>" size=25 maxlength=255></td>
                </tr>
                <tr> 
                  <td><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></td>
                </tr>
                <tr>
                  <td align="right"><%=lblcompanyname%></td>
                  <td align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
                  <td align="left"> <input type="text" name="companyname" value="<%=rsdomain("companyname")%>" size=25 maxlength=255></td>
                </tr>
                <tr> 
                  <td><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></td>
                </tr>
                <tr> 
                  <td align="right"><%=lblPopmailAccount%></td>
                  <td align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
                  <td align="left"> <input type="text" name="popmailaccount" value="<%=rsdomain("popmailaccount")%>" size=25 maxlength=255 onChange="return validate(document.mainform.popmailaccount)"></td>
                </tr>
                <tr> 
                  <td><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></td>
                </tr>
                <tr> 
                  <td align="right"><%=lblEmailAlias%></td>
                  <td align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
                  <td align="left"> <input type="text" name="emailalias" value="<%=rsdomain("emailalias")%>" size=25 maxlength=255></td>
                </tr>
                <tr> 
                  <td><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></td>
                </tr>
                <tr> 
                  <td align="right"><%=lblmssqldb%></td>
                  <td align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
                  <td align="left"> <input type="text" name="mssqldatabase" value="<%=rsdomain("sqldatabase")%>" size=25 maxlength=255 onChange="return validate(document.mainform.mssqldatabase)"></td>
                </tr>
                <tr> 
                  <td><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></td>
                </tr>
                <tr> 
                  <td><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></td>
                </tr>
                <tr> 
                  <td align="right"><%=lblpwdprotect%></td>
                  <td align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
                  <td align="left"><input type="checkbox" name="pwdprotect" value="Y" size=25 maxlength=255 <%if(rsdomain("pwdprotectdir")="Y") then response.Write("Checked")%>></td>
                </tr>
                <tr> 
                  <td><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></td>
                </tr>
                <tr> 
                  <td align="right"><%=lblcgisupport%></td>
                  <td align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
                  <td align="left"><input type="checkbox" name="cgisupport" value="Y" size=25  <%if(rsdomain("cgisupport")="Y") then response.Write("Checked")%>></td>
                </tr>
                <tr> 
                  <td><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></td>
                </tr>
                <tr> 
                  <td align="right"><%=lblfrontpage%></td>
                  <td align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
                  <td align="left"><input type="checkbox" name="frontpageext" value="Y" size = "7" <%if(rsdomain("frontpageext")="Y") then response.Write("Checked")%>></td>
                </tr></td>
                </tr>
                <tr> 
                  <td><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></td>
                </tr>
                <tr> 
                  <td align="right"><%=lblaspsupport%></td>
                  <td align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
                  <td align="left"> <input type="checkbox" name="aspdotnetsupport" value="Y" size=25 <%if(rsdomain("aspdotnetsupport")="Y") then response.Write("Checked")%>></td>
                </tr>
                <tr> 
                  <td><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></td>
                </tr>
                <tr> 
                  <td align="right"><%=lblwebstart%></td>
                  <td align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
                  <td align="left"> <input type="checkbox" name="webstart" value="Y" size=25 <%if(rsdomain("webstats")="Y") then response.Write("Checked")%>></td>
                </tr>
                <tr> 
                  <td><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></td>
                </tr>
                <tr> 
                  <td><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></td>
                </tr>
                <tr> 
                  <td align="right"><%=lblphone%></td>
                  <td align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
                  <td align="left"> <input type="text" name="phone" value="<%=rsdomain("phone")%>" size=25 maxlength=255></td>
                </tr>
                <tr> 
                  <td><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></td>
                </tr>
                <tr> 
                  <td><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></td>
                </tr>
                <tr> 
                  <td align="right"><%=lblemail%></td>
                  <td align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
                  <td align="left"> <input type="text" name="email" value="<%=rsdomain("email")%>" size=25 maxlength=255></td>
                </tr>
                <tr> 
                  <td><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></td>
                </tr>
                <tr> 
                  <td align="right"><%=lbladdress%></td>
                  <td align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
                  <td align="left"> <input type="text" name="address" value="<%=rsdomain("address")%>" size=25 maxlength=255></td>
                </tr>
                <tr> 
                  <td><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></td>
                </tr>
                <tr> 
                  <td align="right"><%=lblcity%></td>
                  <td align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
                  <td align="left"> <input type="text" name="city" value="<%=rsdomain("city")%>" size=25 maxlength=255></td>
                </tr>
                <tr> 
                  <td><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></td>
                </tr>
                <tr> 
                  <td align="right"><%=lblstate%></td>
                  <td align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
                  <td align="left"> <input type="text" name="state" value="<%=rsdomain("state")%>" size=25 maxlength=255></td>
                </tr>
                <tr> 
                  <td><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></td>
                </tr>
                <tr> 
                  <td align="right"><%=lblzipcode%></td>
                  <td align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
                  <td align="left"> <input type="text" name="zipcode" value="<%=rsdomain("zipcode")%>" size=25 maxlength=255></td>
                </tr>
                <tr> 
                  <td><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></td>
                </tr>
                <tr> 
                  <td align="right"><%=lblCountry%></td>
                  <td align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
                  <td align="left">
				  <select name="country" >
                      <%  while(not rscountry.EOF) %>
                      <option value="<%=rscountry("code")%>"><%=rscountry("countryname")%> 
                      </option>
                      <%  rscountry.movenext
					   wend 	   %>
                    </select></td>
                </tr>
                <tr> 
                  <td><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></td>
                </tr>
              </table></td>
          </tr>
        </table>

			</td>
		</tr>

		<tr>
      <td colspan=5><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="16" border="0"><font color="#006666"><img src="/skins/<%=session("skin")%>/elements/line.gif" width=560 height=1 border=0></font></td>
    </tr>

		<tr><td>
	    <table border=0 cellpadding=0 cellspacing=0 align="left">
		    <tr>
			    <td width=446><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="3" height="1" border="0"></td>
			    <td align="right">
				<input name="Submit" type="submit" class="commonButton" id="bid-update" title="<%=lblUpdate%>" value="<%=lblUpdate%>"><input name="cancel" type="button" class="commonButton" id="cancel" title="<%=lblCancel%>" value="<%=lblCancel%>" onClick="window.location='domaininfo.asp'"></td>
			    <td><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="3" height="1" border="0"></td>
		    </tr>
        </table></td></tr>

		

	</table>
	<input type="hidden" name="cmd" value="<%=lblupdate%>">
	<input type="hidden" name="id" value="<%=id%>">
<script>
   for(i=0;i<document.mainform.country.length;i++)
      {
           if(document.mainform.country[i].value=="<%=rsdomain("country")%>") 
		    {
				    document.mainform.country[i].selected=true;
					break;
			}
	  }
</script>	
</form>

	</body>
</html>
<!-- #INCLUDE FILE = "../inc/footer.asp" -->