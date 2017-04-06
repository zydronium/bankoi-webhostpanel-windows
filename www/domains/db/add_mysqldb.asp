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

	Set oDBConn = con

	sDatabaseName = Request.Form("databasename")
	sUsername = Request.Form("databaseuser")
	sPassword = Request.Form("databasepassword")
	serverId = Request.Form("serverip")
	on error resume next
	id = session("id")

	set rsServer = server.CreateObject("adodb.recordset")
	rsServer.open "select * from cp_db_servers where id="& serverId, oDBConn
	if(not rsServer.eof) then
		serverIp = rsServer("serverip")
		serverUser = rsServer("serveruser")
		serverPassword = rsServer("serverpassword")
		strConnection = "driver={" & sMySQLDriverName &"};server="& serverIp &";uid="& serverUser &";pwd="& serverPassword &";database=mysql;"
		'response.write strConnection & "<br>"
		dim linuxConn
		set linuxConn = Server.CreateObject("ADODB.Connection")
		'response.flush
		linuxConn.Open strConnection
		if(err.number <> 0) then
			message = msg1
%>
		<script>
		alert("<%=message%>")
		window.location.replace('/domains/sqldatabase.asp')
		history.back()
		</script>
<%
	else	
		linuxConn.execute("use mysql")
		message = ""
		set rsDB = server.createobject("adodb.recordset")
		rsDB.open "select * from user where user.User='"& sUsername  &"'", linuxConn
		if(not rsDB.eof) then
			message = msg3 & ": " & msg2
		%>
		<script>
		alert("<%=message%>")
		history.back()
		</script>
		<%
		else
			linuxConn.execute("create database " & sDatabaseName)
			if(err.number = 0) then
				  linuxConn.execute("grant all privileges on  " & sDatabaseName &".* to " & sUsername & "@'%' identified by '"& sPassword &"'" )
				  WriteLogLine("Create remote user: " & err.description) 
				  linuxConn.execute("grant all privileges on  " & sDatabaseName &".* to " & sUsername & "@localhost identified by '"& sPassword &"'" )
				  WriteLogLine("Create local user: " & err.description)
				  oDBConn.execute("insert into cp_db_all (domain_id, dbname, dbpassword, dbuser, type, dbserver) values ("& id &", '"& sDatabaseName & "','"& sPassword  & "','"& sUsername & "','mysql','"& serverId & "')")
				  WriteLogLine("insert into cp: " & err.description)
				 message=msg4
			Else
				 message = msg3	& err.description
				  WriteLogLine("Error creating database:"& sDatabaseName &" : " & err.description)
			  End If
			linuxConn.close
			%>
		<script>
		alert("<%=message%>")
		window.location.replace('/domains/sqldatabase.asp')
		</script>
		<%
		end if
	end if
 else
 	%>
	<script>
	alert("<%=msg5%>")
	window.location.replace('/domains/sqldatabase.asp')
	</script>
	<%
 end if
%>
</body>
</html>