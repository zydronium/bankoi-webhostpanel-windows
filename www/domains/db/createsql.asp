<%
	accessLevel = 1
%>
<!-- #INCLUDE FILE = "../../inc/security.asp" -->
<!-- #INCLUDE FILE = "../../inc/db.asp" -->
<!-- #INCLUDE FILE = "../../inc/params.asp" -->
<!-- #INCLUDE FILE = "../../inc/functions.asp" -->
<!-- #INCLUDE FILE = "../../inc/dbfunctions.asp" -->
<html>
<head>
<title><%=lbldatabases%></title>
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/general.css">
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/custom.css">
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/layout.css">
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=ISO-8859-1">
<META HTTP-EQUIV="EXPIRES" CONTENT="0">
  <script language="javascript">
<!--
function chkAddsqldb()
{
  if(addsqldb.databasename.value=="")
  {
	alert("<%=msg8%>")
	addsqldb.databasename.focus()
	return false
  }

  if(addsqldb.databaseuser.value=="")
  {
	alert("<%=msg9%>")
	addsqldb.databaseuser.focus()
	return false
  }
  if(addsqldb.databasepassword.value=="")
  {
	alert("<%=msg11%>")
	addsqldb.databasepassword.focus()
	return false
  }
  if(addsqldb.serverip.value=="")
  {

	alert("<%=msg13%>")
	if(addsqldb.serverip.type.toLowerCase() != "hidden")
		addsqldb.serverip.focus()
	return false
  }
  return true
}
//-->
</script>

</head>
<body>
<!-- #INCLUDE FILE = "../../inc/header.asp" -->
<!------------------------------------------------------------------------------------------------>
<!--Here the menu for Client is created-->
<!-- #INCLUDE FILE = "../../server/subheader.asp" -->
<!---------------------------------------------------------------------------

<!------------------------------------------------------------------------------
The header of reseller prepared here
-->
<!-- #INCLUDE FILE = "../domainheader.asp" -->
<!--
----------------------------------------------------------------------------
The header ends here
-->
<%
		reselId = session("reselid")
			set Cn = con
			mssql_server = ""
			mssqlID = 0
			dim rsMssql
			set rsMssql= server.CreateObject("adodb.recordset")
			query = "select mssql_server from tblrights where id="& reselId
			WriteLogLine(query)
			rsMssql.open query, Cn
			if (not rsMssql.eof) then
				mssqlID = rsMssql("mssql_server")				
				mssql_server = GetDBServerIp(mssqlID, Cn)							
				WriteLogLine(msg15 & mssql_server)
			end if
			set  rsMssql = nothing
			if (cint(mssqlID) = 0 ) then 
			%>
			<p align="center"><%=msg16%></p>
			<p  align="center"><form><input type="button" name="Submit" value="<%=lblback%>" class="commonButton" onclick="location.href='/domains/sqldatabase.asp'"></form></p>
			<%
			else			
			%>                    
<form name="addsqldb" method="post" action="addsqldb.asp" onSubmit="return chkAddsqldb();">
  			  <table width="564" border="0" cellspacing="0" cellpadding="5" align="center" class="border">
    			<tr align="center" bgcolor="<%=sheadColor%>">
      			  		<td colspan="2" class="head"><b><font color="#FFFFFF"><%=lbl506%></font></b></td>
				</tr>
    			<tr>
      			  <td width="20%" class="body"><%=lbl501%></td>
				  <td width="80%">
        <input type="text" name="databasename" class="border" maxlength="100" size="45">
      </td>
				</tr>
    			<tr>
      			  <td colspan="2">
        <table width="100%" border="0" cellspacing="0" cellpadding="4" class="bodynormal">
          			  <tr>
            			<td colspan="6" class="body"> <input type="hidden" name="datafilesize" size="8" class="border" maxlength="2">
              <input type="hidden" name="datafilemaxsize" size="8" class="border" maxlength="2">
              <input type="hidden" name="datafilegrowth" size="8" class="border" maxlength="2">
              <input type="hidden" name="logfilesize" size="8" class="border" maxlength="2">
              <input type="hidden" name="logfilemaxsize" size="8" class="border" maxlength="2">
              <input type="hidden" name="logfilegrowth" size="8" class="border" maxlength="2">
            </td>
					  </tr>
        </table></td>
				</tr>
    			<tr>
      			  <td width="20%" class="body"><%=lbl502%></td>
				  <td width="80%">
        <input type="text" name="databaseuser" class="border" maxlength="100" size="45">
      </td>
				</tr>
    			<tr>
      			  <td width="20%" class="body"><%=lbl503%></td>
				  <td width="80%">
        <input type="text" name="databasepassword" class="border" maxlength="15">
      </td>
				</tr>
				<tr>
      			  
	  <td width="20%"><%=lbl507%> :</td>
	  <td width="80%"><%=mssql_server%>
		<input name="serverip" type="hidden" value="<%=mssqlID%>"></td>
	</tr>
	
    			<tr>
	  <td colspan="2" align="center" class="body"><input type="submit" name="Submit" value="<%=lbl505%>" class="commonButton"> &nbsp;<input type="button" name="Submit" value="<%=lblback%>" class="commonButton" onclick="location.href='/domains/sqldatabase.asp'"></td>
	</tr>  
  			  </table></form>
			  <%
			  end if
			  %>
			  <p>&nbsp;</p><!-- #include file="../../inc/footer.asp" -->
</body>
</html>