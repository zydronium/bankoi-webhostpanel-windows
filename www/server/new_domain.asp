<%
	accessLevel = 5
%>
<!-- #INCLUDE FILE = "../inc/security.asp" -->
<!-- #INCLUDE FILE = "../inc/db.asp" -->
<!-- #INCLUDE FILE = "../inc/functions.asp" -->
<html>
<head>
<title><%=lbl676%></title>

<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/general.css">
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/custom.css">
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/layout.css">
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=ISO-8859-1">
<META HTTP-EQUIV="EXPIRES" CONTENT="0">

<script language="JavaScript" src="/js/functions.js"></script>
<script language="javascript">

function showftpboxes(f)
{
	if(f.ftpusers.selectedIndex!="0")
          {
				f.ftpusername.disabled=true;
				f.password.disabled=true;
				return true;
		  }
	if(f.ftpusers.selectedIndex=="0")
          {
				f.ftpusername.disabled=false;
				f.password.disabled=false;
				return true;
		  }
}


function validate(f)
{
  if(isNaN(f.value))
     {
        alert("<%=msg79%>");
        f.value="";
	    return false;
      }
   return true;
}



function chk_dom(dom_name)
{
    //alert(dom_name);
	nore = /\.$/;
	re = /^[A-Za-z0-9]([A-Za-z0-9-]*[A-Za-z0-9])*(\.[A-Za-z0-9]([A-Za-z0-9-]*[A-Za-z0-9])*)+$/;
	return (dom_name.search(nore) == -1) && (dom_name.search(re) != -1);//Returns true or false
}

//---------------------------------------------------------------------------------------------------------
function chk(f)
{
  if(!chk_dom(f.domain_name.value))
	{
		alert("<%=msg19%>");
		f.domain_name.value="";
		f.domain_name.focus();
		return false;
	}

	if(f.email.value=="")
	{
		alert("<%=msg47%>");
		f.email.focus();
		return false;
	}

	emailExp= /^\w+(\-\w+)*(\.\w+(\-\w+)*)*@\w+(\-\w+)*(\.\w+(\-\w+)*)+$/;
   if (!(emailExp.test(f.email.value)))
      { 
		   alert("<%=lbl541%>");
		   f.email.focus();
		   return false;  
	  }

  //alert("Amit");
  if(!f.domain_name.value)
     {
		alert("<%=msg80%>");
		f.domain_name.focus();
		return false;
	 }
   if(f.noofftpusers.value==0)
     {
				alert("<%=msg81%>");
				f.noofftpusers.focus();
				return false;
     }
   else
      f.noofftpusers.value="1";

if(f.ftpusers.selectedIndex=="0")
    {
	    if(!f.ftpusername.value)
          {
				alert("<%=msg82%>");
				f.ftpusername.focus();
				return false;
		  }
	

		if(!f.password.value)
          {
				alert("<%=msg11%>");
				f.password.focus();
				return false;
		  }
	}
	
if(!f.popmailaccount.value){
    f.popmailaccount.value="0";
	return true;
	}

if(!f.mssqldatabase.value){
     f.mssqldatabase.value="0";
	 return true;
	 }

if(f.country.value=="Select Country")
          {
				alert("<%=msg83%>");
				f.country.focus();
				return false;
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

		function chk_form_data(f)
		{
			if (!chk_dom(f.domain_name.value)) {
				alert("<%=msg84%>");
				f.domain_name.focus();
				f.domain_name.select();
				return false;
			}			
			f.submit();
			return true;
		}

		function setFocus()
		{
			if (document.forms[0].domain_name)
				document.forms[0].domain_name.focus();
		}
		

</script>	
</head>	
<% 
id=session("reselid")
'response.write "The usertype is " & session("reselid")
	'---------------------------------------------------------------------------------------------
	  'Here we are extracting the name of the reseller according to the id stored in the session
	  query="select contactname from tblcontactinfo where id='" & session("reselid") & "'"
	  'response.write query
	  dim rs
	  set rs=server.createobject("ADODB.Recordset")
	  rs.open query,con
	  'esponse.write "amit yadav" &session("reselid")
	 

    '--------------------------------------------------------------------------------------------------
	'Here we are getting the name of the countries with there codes
    dim rscountry , query
	set rscountry = Server.CreateObject("ADODB.Recordset")
	query = "select * from tblcountry"
	set rscountry = con.execute(query)

	'---------------------------------------------------------------------------------------------------
	'Here we are checking whether the client has been assigned an IP address
	query="select count(*) as ipcount from tblresellerip where resellerid='" & session("reselid") & "'"
    set rsip = Server.CreateObject("ADODB.Recordset")
	rsip.open query,con
	flag=rsip("ipcount")
	'response.write "the flags value is "& flag
	if(cint(flag)>0) then
	else
%>
<script>
	window.location='/server/assignip.asp'
</script>
<%
	end if
%>	
<body>
		
<%username=rs("contactname")%>
<!-- #INCLUDE FILE = "../inc/header.asp" -->


<!--
----------------------------------------------------------------------------
The header of reseller prepared here
-->


  <!-- #include file="../clients/clientheader.asp" -->
<table width="57%" border="0" align="center">
      <tr>
    <td> 
      <%	
    usertype=session("type")
	if(usertype="a") then%>
      
      <div align="right">
        <input name="button" type="button" class="commonButton" id="bid-up-level" title="<%=lbl697%>"   onClick="window.location='../server/domains.asp';;" value="<%=lbl697%>"  >
        <%  else%>
        <input name="button" type="button" class="commonButton" id="bid-up-level" title="<%=lbl697%>"   onClick="window.location='../domains/clientdomains.asp';;" value="<%=lbl697%>"  >
        <% end if%>
      </div></tr>
    </table> 
    
		

<!--
----------------------------------------------------------------------------
The header ends here
-->
   
    



<form action="../server/create_domain.asp" method="post" name="mainform" onSubmit="return chk(document.mainform)">
	
  <table width=564 border=0 cellpadding=0 cellspacing=0 align="center">
  <tr >	 
	  <td colspan=5 align="center"><img src="/skins/<%=session("skin")%>/elements/line.gif" width=560 height=1 border=0>	  
	  </td>
	</tr>
		<tr><td colspan=5><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></td></tr>
		<tr><td>
	    <table border=0 cellpadding=0 cellspacing=0 align="left">
		    <tr>
			    <td width=3><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="3" height="1" border="0"></td>
			    <td width=436><%=lbl698%> <font name="verdana" color="red"><strong><%=username%></strong></font></b><img src="/skins/<%=session("skin")%>/elements/white.gif" width="100%" height=1 alt="" border=0></img></td>
			    <td width=7><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
			    
            <td width=115 align="right" class="verttop">&nbsp;</td>
			    <td width=3><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="3" height="1" border="0"></td>
		    </tr>
        </table></td></tr>

		<tr><td colspan=5><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="16" border="0"></td></tr>

		<tr>
			<td colspan=5>
			<table width="100%" border=0 cellpadding=0 cellspacing=0 align="left">
          <%
    
    str="select username,resellerid from tblloginmaster,tblreseller where resellerid=id order by username"
	dim reseller
	set reseller=Server.CreateObject("ADODB.Recordset")
	reseller.open str,con
	if(request("new")=1) then
%>
          <%
end if

%>
          <tr> 
            <td width="41%" align="right"><strong><%=lbl549%></strong></td>
                <td width="5%" align="center"><font color="#FF0000">*</font></td>
            <td width="54%" align="left">WWW 
              <input type="checkbox" value=1 name="www_prefix" CHECKED> &nbsp; <input type="text" name="domain_name" value="" size=25 maxlength=255 onblur="this.value=this.value.toLowerCase()"></td>
          </tr>
          <tr> 
            <td><strong><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></strong></td>
          </tr>
          <tr> 
            <td><strong><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></strong></td>
          </tr>
          <tr> 
            <td width="41%" align="right"><strong><%=lbl634%></strong></td>
            <td></td>
            <%
'-------------------------------------------------------------------------------------------------------
'here we show only the ipaddress assigned to the reseller
query="select tblserverip.ipaddress,tblserverip.iptype,tblserverip.id from (tblresellerip inner join tblserverip on tblresellerip.ipaddress=tblserverip.id) where tblresellerip.resellerid='" & id & "'"
dim ipadd
set ipadd=server.createobject("ADODB.recordset")
ipadd.open query,con
%>
            <td width="54%" align="left"><select name="ip_addr_id" >
                <%
   while(not ipadd.EOF)
%>
                <option value="<%=ipadd("id")%>"><%=ipadd("ipaddress")&" -> "&ipadd("iptype")%> 
                <%
ipadd.movenext
wend
%>
              </select> </td>
          </tr>
          <tr> 
            <td><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="16" border="0"></td>
          </tr>
          <tr> 
            <td colspan=3><table width="100%" border=0 cellspacing=0 cellpadding=0 align="left">
                <tr> 
                  <td width="41%" align="right"><strong><%=lbl699%>:</strong></td>
                  <td width="5%" align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
                  <td width="54%" align="left"><input type="text" name="personalname" value="" size=25 maxlength=255></td>
                </tr>
				<tr> 
                  <td><strong><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></strong></td>
                </tr>
				<tr> 
                      <td width="41%" align="right"><strong><%=lbl700%>:</strong></td>
                  <td width="5%" align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
                      <td width="54%" align="left">
					  <select name="ftpusers" onChange="return showftpboxes(document.mainform)">
					  <option value="New User">New User</option>
<%
				ftpusername=split(GetAllFtpAccounts(id),",")
				
				for i=Lbound(ftpusername) to Ubound(ftpusername)
%>
					<option value="<%=ftpusername(i)%>"><%=ftpusername(i)%></option>	
<%
				next
%>
				</select></td>
                </tr>
                
                <tr> 
                  <td><strong><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></strong></td>
                </tr>
                <tr> 
                  <td align="right"><strong><%=lbl568%>:</strong></td>
                      <td align="center"><font color="#FF0000">*</font></td>
                  <td align="left"><input type="text" name="noofftpusers" value="1" size=25 maxlength=255 onChange="return validate(document.mainform.noofftpusers)"></td>
                </tr>
                <tr> 
                  <td><strong><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></strong></td>
                </tr>
                <tr> 
                  <td align="right"><strong><%=lbl594%></strong></td>
                      <td align="center"><font color="#FF0000">*</font></td>
                  <td align="left"><input type="text" name="ftpusername" value="" size=25 maxlength=15 ></td>
                </tr>
                <tr> 
                  <td><strong><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></strong></td>
                </tr>
                <tr> 
                  <td align="right"><strong><%=lbl595%></strong></td>
                      <td align="center"><font color="#FF0000">*</font></td>
                  <td align="left"><input type="password" name="password" value="" size=25 maxlength=255 ></td>
                </tr>
                <tr> 
                  <td><strong><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></strong></td>
                </tr>
                <tr> 
                  <td align="right"><strong><%=lbl596%>:</strong></td>
                  <td align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
                  <td align="left"><input type="text" name="companyname" value="" size=25 maxlength=255></td>
                </tr>
                <tr> 
                  <td><strong><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></strong></td>
                </tr>
                <tr> 
                  <td align="right"><strong><%=lbl597%>:</strong></td>
                      <td align="center">&nbsp;</td>
                  <td align="left"><input type="text" name="popmailaccount" value="10" size=25 maxlength=255 onChange="return validate(document.mainform.popmailaccount)"></td>
                </tr>
                <tr> 
                  <td><strong><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></strong></td>
                </tr>
                <tr> 
                  <td align="right"><strong><%=lbl598%></strong></td>
                      <td align="center">&nbsp;</td>
                  <td align="left"><input type="text" name="emailalias" value="10" size=25 maxlength=255></td>
                </tr>
                <tr> 
                  <td><strong><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></strong></td>
                </tr>
                <tr> 
                  <td align="right"><strong><%=lbl599%>:</strong></td>
                      <td align="center">&nbsp;</td>
                  <td align="left"><input type="text" name="mssqldatabase" value="1" size=25 maxlength=255 onChange="return validate(document.mainform.mssqldatabase)"></td>
                </tr>
                <tr> 
                  <td><strong><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></strong></td>
                </tr>
                <tr> 
                  <td align="right"><strong><%=lbl603%>:</strong></td>
                      <td align="center"><font color="#FF0000">*</font></td>
                  <td align="left"><input type="text" name="email" value="" size=25 maxlength=255></td>
                </tr>
                <tr> 
                  <td><strong><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></strong></td>
                </tr>
                <tr> 
                  <td align="right"><strong><%=lbl600%>:</strong></td>
                  <td align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
                  <td align="left"><input type="checkbox" name="pwdprotect" value="Y" size=25 maxlength=255></td>
                </tr>
                <tr> 
                  <td><strong><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></strong></td>
                </tr>
                <tr> 
                  <td align="right"><strong><%=lbl523%>:</strong></td>
                  <td align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
                  <td align="left"><input type="checkbox" name="cgisupport" value="Y" size=25 ></td>
                </tr>
                <tr> 
                  <td><strong><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></strong></td>
                </tr>
                <tr> 
                  <td align="right"><strong><%=lbl601%>:</strong></td>
                  <td align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
                  <td align="left"><input type="checkbox" name="frontpageext" value="Y" size = "7" ></td>
                </tr>
                <tr> 
                  <td><strong><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></strong></td>
                </tr>
                <tr> 
                  <td align="right"><strong><%=lbl519%>:</strong></td>
                  <td align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
                  <td align="left"><input type="checkbox" name="aspdotnetsupport" value="Y" size=25 ></td>
                </tr>
                <tr> 
                  <td><strong><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></strong></td>
                </tr>
                <tr> 
                  <td align="right"><strong><%=lbl575%>:</strong></td>
                  <td align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
                  <td align="left"><input type="checkbox" name="webstart" value="Y" size=25 ></td>
                </tr>
                <tr> 
                  <td><strong><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></strong></td>
                </tr>
                <tr> 
                  <td><strong><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></strong></td>
                </tr>
                <tr> 
                  <td align="right"><strong><%=lbl602%>:</strong></td>
                  <td align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
                  <td align="left"><input type="text" name="phone" value="" size=25 maxlength=255></td>
                </tr>
                <tr> 
                  <td><strong><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></strong></td>
                </tr>
                <tr> 
                  <td><strong><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></strong></td>
                </tr>
                
                <tr> 
                  <td align="right"><strong><%=lbl604%>:</strong></td>
                  <td align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
                  <td align="left"><input type="text" name="address" value="" size=25 maxlength=255></td>
                </tr>
                <tr> 
                  <td><strong><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></strong></td>
                </tr>
                <tr> 
                  <td align="right"><strong><%=lbl605%>:</strong></td>
                  <td align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
                  <td align="left"><input type="text" name="city" value="" size=25 maxlength=255></td>
                </tr>
                <tr> 
                  <td><strong><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></strong></td>
                </tr>
                <tr> 
                  <td align="right"><strong><%=lbl606%>:</strong></td>
                  <td align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
                  <td align="left"><input type="text" name="state" value="" size=25 maxlength=255></td>
                </tr>
                <tr> 
                  <td><strong><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></strong></td>
                </tr>
                <tr> 
                  <td align="right"><strong><%=lbl607%>:</strong></td>
                  <td align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
                  <td align="left"><input type="text" name="zipcode" value="" size=25 maxlength=255></td>
                </tr>
                <tr> 
                  <td><strong><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></strong></td>
                </tr>
                <tr> 
                  <td align="right"><strong><%=lbl608%>:</strong></td>
                  <td align="center"><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="7" height="1" border="0"></td>
                  <td align="left">
				  <select name="country" style="color: #000080; font-family: Verdana" >
				  <option value="Select Country"><%=msg83%></Option>
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

		<tr><td colspan=5><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="16" border="0"></td></tr>

		<tr><td>
	    <table border=0 cellpadding=0 cellspacing=0 align="left">
		<tr >	 
	  <td colspan=5 align="center"><img src="/skins/<%=session("skin")%>/elements/line.gif" width=560 height=1 border=0>	  
	  </td>
	</tr>
		    <tr>
			    <td width=446><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="3" height="1" border="0"></td>
			    <td align="right">
				<input type="button" class="commonButton" id="bid-update" value="<%=lbl701%>" title="<%=lbl701%>" onClick="chk_form_data1(document.mainform);" ></td>
			    <td><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="3" height="1" border="0"></td>
		    </tr>
        </table></td></tr>

		<tr><td colspan=5><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="1" height="8" border="0"></td></tr>

	</table>
	<input type="hidden" name="cmd" value="update">
</form>
<!-- #INCLUDE FILE = "../inc/footer.asp" -->
	</body>
</html>


