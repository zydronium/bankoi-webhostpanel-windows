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
</head>
<body>

<%

Dim oDBConn
  Dim sDatabaseName, sUsername, sPassword
  Dim nDataFileSize, nDataFileMaxSize, nDataFileGrowth
  Dim nLogFileSize, nLogFileMaxSize, nLogFileGrowth
  Dim bResult, bResult1, sMsg : sMsg = ""
id = session("id")

sDatabaseName = Request.Form("databasename")
sUsername = Request.Form("databaseuser")
sPassword = Request.Form("databasepassword")
serverId = Request.Form("serverip")

set rsServer = server.CreateObject("adodb.recordset")
rsServer.open "select * from cp_db_servers where id="& serverId, con
if(not rsServer.eof) then
	serverIp = rsServer("serverip")
	serverUser = rsServer("serveruser")
	serverPassword = rsServer("serverpassword")
	sConnectionString = "Driver={SQL Server};Server="& serverIp &";Database=master;UID="& serverUser &";PWD="& serverPassword 
	Set SQLDB = Server.CreateObject("Adodb.Connection")
	SQLDB.Open sConnectionString
	set sql=sqldb
  bResult = CreateSQLDatabase(sql,sDatabaseName,nDataFileSize,nDataFileMaxSize,nDataFileGrowth,nLogFileSize,nLogFileMaxSize,nLogFileGrowth)
  If bResult Then
	  bResult1 = CreateSQLLogin(sql,sUsername,sPassword,sDatabaseName)
	  If bResult1 Then
		AssignSQLDBAccessRoles sql,sUsername,sDatabaseName
		GrantSQLDBPermissions sql,sUsername,sDatabaseName
		con.execute("insert into cp_db_all ( domain_id, dbname, dbpassword, dbuser, type, dbserver) values ("& id &",'"& sDatabaseName & "','"& sPassword  & "','"& sUsername & "','mssql', '"& serverId & "')")
		sMsg=msg4
	  Else
		sMsg = msg6
	  End If
  Else
	 sMsg = msg3
  End If
  else
  	sMsg = msg7
  end if
%>
<script>
	alert('<%=sMsg%>')
	window.location.replace('/domains/sqldatabase.asp')
	</script>
</body>
</html>
