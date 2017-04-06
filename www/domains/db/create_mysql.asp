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
<title><%=lblDatabases%></title>
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/general.css">
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/custom.css">
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/layout.css">
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=ISO-8859-1">
<META HTTP-EQUIV="EXPIRES" CONTENT="0">
<script language="javascript">
<!--
function chk_db_usr_name(usr)
{
	re = /^[a-zA-Z]{1}[A-Za-z0-9_]{0,15}$/;
	return usr.search(re) != -1;
}
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
  }else if (!chk_db_usr_name(addsqldb.databaseuser.value)) {
		alert("<%=msg10%>");
		addsqldb.databaseuser.focus();
		addsqldb.databaseuser.select();
		return false;
  }
  if(addsqldb.databasepassword.value=="")
  {
	alert("<%=msg11%>")
	addsqldb.databasepassword.focus()
	return false
  }else if (!chk_db_usr_name(addsqldb.databasepassword.value)) {
		alert("<%=msg12%>");
		addsqldb.databasepassword.focus();
		addsqldb.databasepassword.select();
		return false;
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
			mysql_server = ""
			mysqlID = 0
			dim rsMysql
			set rsMysql= server.CreateObject("adodb.recordset")
			query = "select mysql_server from tblrights where id="& reselId
			WriteLogLine(query)
			rsMysql.open query, Cn
			if (not rsMysql.eof) then
				mysqlID = rsMysql("mysql_server")				
				mysql_server = GetDBServerIp(mysqlID, Cn)							
				WriteLogLine(" Clients Exists in tblrights : "& mysql_server)
			end if
			set  rsMysql = nothing
			if (cint(mysqlID) = 0 ) then 
%>
			<p align="center"><%=msg14%></p>
			<p  align="center"><form><input type="button" name="Submit" value="<%=lblback%>" class="commonButton" onclick="location.href='/domains/sqldatabase.asp'"></form></p>
<%
			else			
%>                    

<form name="addsqldb" method="post" action="add_mysqldb.asp" onSubmit="return chkAddsqldb();">
  			  
  <table width="564" border="0" cellspacing="0" cellpadding="5" align="center" class="border">
    			
	<tr align="center" bgcolor="<%=sheadColor%>">
      			  		
	  <th colspan="2" ><b><%=lbl500%></b></td>
				</tr>
    			
	<tr>
      			  
	  <td width="20%" class="body"><%=lbl501%></td>
	  <td width="80%">
        <input type="text" name="databasename" class="border" maxlength="100" size="45">
      </td>
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
      			  
	  <td width="20%"><%=lbl504%> :</td>
	  <td width="80%"><%=mysql_server%>
		<input name="serverip" type="hidden" value="<%=mysqlID%>"></td>
	</tr>

    			
	<tr>
      			  
	  <td colspan="2" align="center" class="body">


       
					<br>
        </td>
	</tr>
	<tr>
	  <td colspan="2" align="center" class="body"><input type="submit" name="Submit" value="<%=lbl505%>" class="commonButton" title="<%=lbl505%>">&nbsp;<input type="button" name="Submit" value="<%=lblback%>" class="commonButton" onclick="location.href='/domains/sqldatabase.asp'" title = "<%=lblback%>"></td>
	</tr>  			  
  </table>
			  </form>		
<%
			  end if
%>
			  <p>&nbsp;</p><!-- #include file="../../inc/footer.asp" -->
</body>
</html>