<%
	accessLevel = 1
%>
<!-- #INCLUDE FILE = "../inc/security.asp" -->
<!-- #INCLUDE FILE = "../inc/db.asp" -->
<!-- #INCLUDE FILE = "../inc/params.asp" -->
<!-- #INCLUDE FILE = "../inc/functions.asp" -->
<html>
<head>
<title><%=lbldatabases%></title>
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/general.css">
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/custom.css">
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/layout.css">
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=ISO-8859-1">
<META HTTP-EQUIV="EXPIRES" CONTENT="0">
<script>
function submit_form(f)
{
//alert("Submit form called");
f.action='/domains/db/removedatabase.asp';
f.submit();
return true;
}
function validate(f)
{
    if(f.databasename.value=="")
	   {
			alert("<%=msg8%>");
			f.databasename.focus();
			return false
	   }
    if(f.username.value=="")
	   {
			alert("<%=msg57%>");
			f.username.focus();
			return false
	   }
    if(f.password.value=="")
	   {
			alert("<%=msg48%>");
			f.password.focus();
			return false
	   }
	
     return true;
}
</script>
</head>
<%
    id=session("id")
%>
<body>
<!-- #INCLUDE FILE = "../inc/header.asp" -->
<!------------------------------------------------------------------------------------------------>
<!--Here the menu for Client is created-->
<!-- #INCLUDE FILE = "../server/subheader.asp" -->
<!---------------------------------------------------------------------------

<!------------------------------------------------------------------------------
The header of reseller prepared here
-->
<!-- #INCLUDE FILE = "../domains/domainheader.asp" -->
<!--
----------------------------------------------------------------------------
The header ends here
-->
<form action="/domains/createdatabase.asp" method="post" name="mainform" onSubmit="return validate(document.mainform)">
  <table width=564 border=0 cellpadding=0 cellspacing=0 align="center">
    <tr> 
      <td colspan="8"><%=lbl509%> <font name="verdana" color="red"><strong><%=" "&ucase(session("resellername"))%></strong></font><img src="/skins/<%=session("skin")%>/elements/white.gif" width="100%" height=1 alt="" border=0><img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="8" height="8" border="0"></td>
	</tr>
	<tr> 
      <th colspan="9"><font color="#003366"><strong><%=lbl667%></strong></font> 
    </tr>
	
    <%
	query="select sqldatabase from tblrights where id='" & id & "'"
	dim rsdbMax, dbMax, isAddLink, dbUsed
	isAddLink = true
	set rsdbMax=server.createobject("ADODB.Recordset")
	rsdbMax.open query,con
	if(not rsdbMax.EOF) then
		dbMax = rsdbMax("sqldatabase")
	else
		dbMax = 0
		isAddLink = false
	end if
	if (dbMax > 0  ) then 
		query="select count(*) as dbused from cp_db_all where domain_id='" & id & "' "
		dim rsdbCount
		set rsdbCount=server.createobject("ADODB.Recordset")
		rsdbCount.open query,con
		if(not rsdbCount.EOF) then
			dbUsed = rsdbCount("dbused")
			if( cint(dbUsed) < cint(dbMax)) then isAddLink=true else isAddLink=false

	%>
			<tr> 
      <td colspan="9">You have created <%=dbUsed%> database(s) off <%=dbMax%> available.</td></tr>
	<%
	else
	%>
		<tr> 
      <td colspan="9"><%=lbl668 & " " & dbMax%> available.</td></tr>
	<%
	end if
	
	query="select * from cp_db_all where domain_id='" & id & "' order by dbname"
	dim rsdb
	set rsdb=server.createobject("ADODB.Recordset")
	rsdb.open query,con
	if(not rsdb.EOF) then
%>
	    
    <tr> 
      <td width="90" height="11" align="center">
<div align="center"><strong><%=lbl501%></strong></div></td>
	  <td width="124"  align="center"><strong><%=lbl669%></strong></td>
	  <td width="111" height="11"  align="center">
		<div align="center"><strong><%=lbl617%></strong></div></td>
	  <td width="120" align="center">
		<div align="center"><strong><%=lblPass%></strong></div></td>
	  <td width="95"  align="center">
		<div align="center"><strong><%=lbl670%></strong></div></td>
	  <td width="24" align="center">&nbsp;</td>
	</tr>
	    
    <tr> 
      <td align="center" colspan="6">&nbsp;</td>
	</tr>
    <%
    while(not rsdb.EOF)
%>
	 
    <tr bgcolor="#EEEEEE"> 
      <td height="21" align="center" valign="middle">
<div align="center"><font color="#000000"><%=rsdb("dbname")%></font></div></td>
	  <td height="21" align="center" valign="middle">
		<div align="center"><font color="#000000"><%=GetDBServerIp(rsdb("dbserver"), con)%></font></div></td>
	  <td height="21" align="center" valign="middle">
		<div align="center"><font color="#000000"><%=rsdb("dbuser")%></font></div></td>
	  <td  height="21" align="center" valign="middle">
		<div align="center"><font color="#000000"><%=rsdb("dbpassword")%></font></div></td>
	  <td height="21" align="center" valign="middle">
		<div align="center"><font color="#000000"><%=rsdb("type")%></font></div></td>
	  <td height="21"  align="center" valign="middle"><font color="#000000">
		<input type="checkbox" name="dbid" value="<%=rsdb("id")%>">
	</font></td>
	</tr>
		 
	<%
    rsdb.movenext
    wend
%>
    <tr> 
      <td colspan="6">&nbsp;</td>
	</tr>
    <tr> 
      <td colspan="6"><div align="right"> 
          <input type="button" name="Button352" value="Remove Selected" class="commonButton" onClick="return submit_form(document.mainform)">
        </div></td>
	</tr>
    <%
	else
	%>
	<tr> 
      <td colspan="6" height="30" align="center"><%=lbl671%></td>
	</tr>
	<%
	end if
%>
		    
    <tr> 
      <td colspan="6"><img src="/skins/<%=session("skin")%>/elements/line.gif" width=560 height=1 border=0></td>
	</tr>
    <tr> 
      <td colspan="6">&nbsp;</td>
	</tr>
	<%
	if (isAddLink = true) then 
	%>
	<tr>
	  <th colspan="6" height="20"><div align="center"><%=lbl672%></div></td>
	</tr>
	<tr> 
      <td colspan="6"><br>
		<p align="center">
		  <input type="button" name="addMysql" value="<%=lbl673%>" class="commonButton" onclick="location.href='db/create_mysql.asp'">
		  &nbsp;&nbsp;&nbsp;&nbsp;		
		  <input type="button" name="addMssql" value="<%=lbl674%>" class="commonButton" onclick="location.href='db/createsql.asp'">
		  		</p></td>
	</tr>
	<%
		end if
	end if
	%>
  </table>
  </form>  
  <p>&nbsp;</p>
<!-- #INCLUDE FILE = "../inc/footer.asp" -->


