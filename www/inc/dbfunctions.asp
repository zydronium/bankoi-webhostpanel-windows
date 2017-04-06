<%
function DeleteMysqlDB(dbid)
	set rsDB = server.createobject("adodb.recordset")
	query = "select * from (cp_db_servers inner join cp_db_all on cp_db_all.dbserver=cp_db_servers.id) where cp_db_all.id="& dbid 
	WriteLogLine(query)
	rsDB.open query, con
	if(not rsDB.eof) then
		sDatabaseName = rsDB("dbname")
		'response.write (sDatabaseName & "<br>")
		sUsername = rsDB("dbuser")
		serverIp = rsDB("serverip")
		serverUser = rsDB("serveruser")
		serverPassword = rsDB("serverpassword")

		strLinuxConDB = "driver={"& sMySQLDriverName &"};server="& serverIp &";uid="& serverUser &";pwd="& serverPassword &";database=mysql;"
		dim linuxConn
		set linuxConn = Server.CreateObject("ADODB.Connection")
		linuxConn.Open strLinuxConDB

		rsDB.close
		linuxConn.execute("use mysql")
		linuxConn.execute("delete from user where User='"& sUsername & "'" )
		linuxConn.execute("delete from db where User='"& sUsername & "'" )
		linuxConn.execute("drop database " & sDatabaseName)
		linuxConn.execute("flush privileges" )
		if(err.number = 0) then
			  con.execute("delete from cp_db_all where id="& dbid)
			  DeleteMysqlDB = true
		 Else
			DeleteMysqlDB = false
		 End If
		 linuxConn.close
	else
		DeleteMysqlDB = false
	end if
end function

function DeleteMssqlDB(dbid)
	set rsDB = server.createobject("adodb.recordset")
	rsDB.open "select * from (cp_db_servers inner join cp_db_all on cp_db_all.dbserver=cp_db_servers.id) where cp_db_all.id="& dbid , con
	if(not rsDB.eof) then
		sDatabaseName = rsDB("dbname")
		'response.write (sDatabaseName & "<br>")
		sUsername = rsDB("dbuser")
		serverIp = rsDB("serverip")
		serverUser = rsDB("serveruser")
		serverPassword = rsDB("serverpassword")

		strLinuxConDB = "driver={SQL Server};server="& serverIp &";uid="& serverUser &";pwd="& serverPassword &";database=master;"
		dim linuxConn
		set linuxConn = Server.CreateObject("ADODB.Connection")
		linuxConn.Open strLinuxConDB

		rsDB.close
		if(DeleteSQLDatabase(linuxConn, sDatabaseName, sUsername)) then
			  con.execute("delete from cp_db_all where id="& dbid)
			  DeleteMssqlDB = true
		 Else
			DeleteMssqlDB = false
		 End If
		 linuxConn.close
	else
		DeleteMssqlDB = false
	end if
end function

function DeleteSQLDatabase(oDBConnection,sDBName, sUsername)
		On Error Resume Next	
		Err.clear
		oDBConnection.Execute("Use Master")
		oDBConnection.Execute("EXEC sp_dboption '"& sDBName&"', 'offline', 'true'")		
	    oDBConnection.Execute("drop database "& sDBName)
		 If (Err.number <> 0)  Then
			WriteLogLine "DB to delete: " & sDBName & " :Could not delete"
			DeleteSQLDatabase = False
		Else
			WriteLogLine "DB to delete: " & sDBName & " : deleted"			
			oDBConnection.Execute("EXEC sp_dropuser '"& sUsername & "'")
		oDBConnection.Execute("EXEC sp_droplogin '"& sUsername & "'")	
			DeleteSQLDatabase = True
		End If	    		     
	end function

  Function CreateSQLDatabase(oDBConnection,sDBName,nDataFileSize,nDataFileMaxsize,nDataFileGrowth,nLogFileSize,nLogFileMaxsize,nLogFileGrowth)
  nDataFileSize =10
  nDataFileMaxsize=10
  nDataFileGrowth=10
  nLogFileSize=10
  nLogFileMaxsize=10
  nLogFileGrowth=10
	  Dim sCreateDatabaseQry : sCreateDatabaseQry = ""
	  Dim rsError	  
	  Set rsError = Server.CreateObject("ADODB.Recordset")	  
	  sCreateDatabaseQry = sCreateDatabaseQry & "CREATE DATABASE " & sDBName 												
	  On Error Resume Next
	  oDBConnection.Execute("Use Master")
	  oDBConnection.Execute(sCreateDatabaseQry)
	  
	  rsError.Open "Select @@error",oDBConnection	  
	  
	  If Err.number > 0 Or rsError(0) > 0 Then
		CreateSQLDatabase = False
	  Else
		CreateSQLDatabase = True
	  End If
  End Function
  '************************************************************************************
  Function CreateSQLLogin(oDBConnection,sSQLLoginName,sSQLLoginPassword,sSQLDatabase)
	Dim sCreateSQLLoginQry, sSQLGrantDBAccess
	Dim rsError
	
	Set rsError = Server.CreateObject("ADODB.Recordset")
	
	sCreateSQLLoginQry = "EXEC sp_addlogin '" & sSQLLoginName & "', '" & sSQLLoginPassword & "', '" & sSQLDatabase & "'"
	sSQLGrantDBAccess = "EXEC sp_grantdbaccess '" & sSQLLoginName & "'"
	
	On Error Resume Next
	oDBConnection.Execute("Use Master")
	oDBConnection.Execute(sCreateSQLLoginQry)
	oDBConnection.Execute("Use " & sSQLDatabase)
	oDBConnection.Execute(sSQLGrantDBAccess)

	rsError.Open "Select @@error",oDBConnection
	  
	If Err.number > 0 Or rsError(0) > 0 Then
	  CreateSQLLogin = False
	Else
	  CreateSQLLogin = True
	End If

  End Function
    
  Function AssignSQLDBAccessRoles(oDBConnection,sSQLLoginName,sSQLDatabase)
	Dim sSQLDBRole
	
	oDBConnection.Execute("Use " & sSQLDatabase)
	sSQLDBRole = "EXEC sp_addrolemember 'db_owner', '" & sSQLLoginName & "'"
	oDBConnection.Execute(sSQLDBRole)
	sSQLDBRole = "EXEC sp_addrolemember 'db_accessadmin', '" & sSQLLoginName & "'"
	oDBConnection.Execute(sSQLDBRole)
	sSQLDBRole = "EXEC sp_addrolemember 'db_securityadmin', '" & sSQLLoginName & "'"
	oDBConnection.Execute(sSQLDBRole)
	sSQLDBRole = "EXEC sp_addrolemember 'db_ddladmin', '" & sSQLLoginName & "'"
	oDBConnection.Execute(sSQLDBRole)
	sSQLDBRole = "EXEC sp_addrolemember 'db_backupoperator', '" & sSQLLoginName & "'"
	oDBConnection.Execute(sSQLDBRole)
	sSQLDBRole = "EXEC sp_addrolemember 'db_datareader', '" & sSQLLoginName & "'"
	oDBConnection.Execute(sSQLDBRole)
	sSQLDBRole = "EXEC sp_addrolemember 'db_datawriter', '" & sSQLLoginName & "'"
	oDBConnection.Execute(sSQLDBRole)
	sSQLDBRole = "EXEC sp_addrolemember 'db_accessadmin', '" & sSQLLoginName & "'"
	oDBConnection.Execute(sSQLDBRole)
	
  End Function

  Function GrantSQLDBPermissions(oDBConnection,sSQLLoginName,sSQLDatabase)	
	Dim sGrantSQLDBPermissionQry	
	oDBConnection.Execute("Use " & sSQLDatabase)
	sGrantSQLDBPermissionQry = "GRANT ALL TO " & sSQLLoginName
	oDBConnection.Execute(sGrantSQLDBPermissionQry)	
  End Function

%>