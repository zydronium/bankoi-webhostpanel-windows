<%
if(ucase(sMailServer) = "IMAIL") then
%>
<!-- #INCLUDE file="imailfunctions.asp" -->
<%
end if

If(ucase(sMailServer) = "ME") then
%>
	<!-- #INCLUDE file="mailEnablefunc.asp" -->
<%
End If

Function ExtendFrontPage(sDomainName,sUserName,sPassword)
	ON ERROR RESUME NEXT	
	sAppli = chr(34) & frontPageExtPath & chr(34)
	params = " -o install -u "& sUserName &" -pw "& sPassword &" -p 80 -m "& sDomainName
	command = sAppli & params
	WritelogLine "ExtendFrontPage: " & command
	Set whs = server.createobject("WScript.Shell")
    whsRun = whs.Run(command, 0, True)	
	If err.number<>0 Then 
		WriteLogLine "In ExtendFrontPage Success"
		WriteLogLine command
		ExtendFrontPage=False
	Else
		WriteLogLine "In ExtendFrontPage Success"
		WriteLogLine command
		ExtendFrontPage=True
	End If	
    Set whs = nothing
End Function

Function RemoveFrontPage(sDomainName,sUserName,sPassword)	
	ON ERROR RESUME NEXT
	sAppli = chr(34) & frontPageExtPath & chr(34)
	params = " -o uninstall -u "& sUserName &" -pw "& sPassword &" -p 80 -m "& sDomainName
	command = sAppli & params
	WritelogLine "RemoveFrontPage: " & command
	Set whs = server.createobject("WScript.Shell")
    whsRun = whs.Run(command, 0, True)		
	If err.number<>0 Then 
		WriteLogLine "In RemoveFrontPage Error"
		WriteLogLine command
		RemoveFrontPage=False
	Else
		WriteLogLine "In RemoveFrontPage Success"
		WriteLogLine command
		RemoveFrontPage=True
	End If
	Set whs = nothing
End Function

' Function to replace apostrophy in sql queries
function fixquote(thestring)
	fixquote = replace(thestring,"'","''")
end function




' Create Directories for domain
Function CreateDirs(sRootDir, sAccountUser,sDomainName, bcgi, bDotNet, sIP, sInstance, isWWW)
	WriteLogLine "In CreateDirs"
	'On Error Resume Next
	Dim  oFso
	sMainDir  = sRootDir  & sAccountUser
	sMainNewDir = sMainDir
	sMainDir = sMainDir & "\" & sDomainName
	sWWWPath  = sMainDir & "\www"
	sCgiPath = sWWWPath & "\cgi-bin"
	sDBPath = sMainDir & "\DB"
	sReportPath = sWWWPath & "\stats"
	sLogPath = sMainDir & "\log"
	'response.write "Domain Dir: " & sMainDir
	
	Set oFso = Server.CreateObject("Scripting.FileSystemObject")
	if(not oFso.folderexists(sMainNewDir)) then 	oFso.CreateFolder sMainNewDir
	Call AddUserToFolder(sAccountUser , sMainNewDir)
	
	if(not oFso.folderexists(sMainDir)) then oFso.CreateFolder sMainDir			
	if(not oFso.folderexists(sWWWPath)) then oFso.CreateFolder sWWWPath    
  	if(not oFso.folderexists(sDBPath)) then oFso.CreateFolder sDBPath
	'Give permission to update Database
	Call AddUserToFolder("IUSR_" & sComputerName , sDBPath) 	
    if(not oFso.folderexists(sReportPath)) then oFso.CreateFolder sReportPath
    if(not oFso.folderexists(sLogPath)) then oFso.CreateFolder sLogPath
	If Err.number > 0 Then
		CreateDirs = False
	Else
		result = CreateNewWebSite(sDomainName, sLogPath, sWWWPath, bcgi, bDotNet, sAccountUser, sIP, sInstance, isWWW)
		result =CopyDomainFiles(sWWWPath & "\", sDomainName)
		If bcgi Then
			if(not oFso.folderexists(sCgiPath)) then oFso.CreateFolder sCgiPath
			result = EnableCGI(sWWWPath, sDomainName)
		End If
		If bDotNet Then			
			result = EnableDotNet(sWWWPath, sDomainName)
		End If
		CreateDirs = True
	End If
	
	Set oFso = Nothing
End Function

Function CreateDir(sPath)
	On Error Resume Next  
	Dim  oFso  
	Set oFso = Server.CreateObject("Scripting.FileSystemObject")
	if(not (oFso.FolderExists(sPath) ) ) then
		oFso.CreateFolder spath	
		If Err.number > 0 Then
			CreateDir = False
		Else
			CreateDir = True
		End If
	else
		CreateDir = True
	end if
	Set oFso = Nothing
End Function

function DeleteDir(sPath)
	On Error Resume Next  
	Dim  oFso  
	Set oFso = Server.CreateObject("Scripting.FileSystemObject")
	if((oFso.FolderExists(sPath) ) ) then
		oFso.DeleteFolder spath	
		If Err.number > 0 Then
			DeleteDir = False
		Else
			DeleteDir = True
		End If
	else
		DeleteDir = True
	end if
	Set oFso = Nothing
end function
Function isNTUserExists(sNewUser,sComputerName)
	On Error Resume Next
	Set adsUser = GetObject("WinNT://" &  sComputerName & "/" & sNewUser)	
	If (err.number=0) Then 'If 0 then user ID already exists		
		WriteLogLine "In isNTUserExists User Already exists : " & sNewUser 
		isNTUserExists =True 
	Else
		WriteLogLine "In isNTUserExists User Does not exists: " & sNewUser & " : " & err.description
		isNTUserExists = False
	End If
End Function

Function CreateNTUser(sNewUser,sComputerName,sFtpPassword,sFullName,sUserDesc)
	On Error Resume Next
	Const ADS_UF_DONT_EXPIRE_PASSWD = &h10000		
	objPasswordExpirationFlag = ADS_UF_DONT_EXPIRE_PASSWD
	Dim sNewPassword

	Set adsDomain = GetObject("WinNT://" &  sComputerName)
	Set adsUser = adsDomain.Create("user",sNewUser)		
	adsUser.SetInfo
	If (err.number=0) Then 'If not 0 then user ID already exists		
		adsUser.SetPassword sFtpPassword
		adsUser.FullName =sFullName
		adsUser.Description =sUserDesc 
	'	response.write objuserflags	
		AdsUser.Put "userFlags", objPasswordExpirationFlag 
		AdsUser.setInfo
		WriteLogLine "In CreateNTUser created : " & sNewUser 
		CreateNTUser = True 
	Else
		WriteLogLine "In CreateNTUser Could not created : " & sNewUser & " : " & err.description
		CreateNTUser = False
	End If
End Function




Function DeleteNTUser(sNewUser,sComputerName)
	On Error Resume Next
	Set adsDomain = GetObject("WinNT://" &  sComputerName)
	adsUser = adsDomain.Delete("user",sNewUser)
	'adsUser.SetInfo	
	If Err.number > 0 Then 
		WriteLogLine "In DeleteNTUser Could not deleted : " & sNewUser & " : " & err.description
		DeleteNTUser = False 
	Else 
		WriteLogLine "In DeleteNTUser deleted : " & sNewUser 
		DeleteNTUser = True
	End IF
End Function




Function updateNTUser(sUserName ,sPassword,sComputerName)
	On Error Resume Next
	Set adsUser = GetObject("WinNT://" &  sComputerName & "/" & sUserName & ",user")
	adsUser.SetPassword sPassword
	adsUser.SetInfo		
	If Err.number > 0 Then 
	updateNTUser = False 
	WriteLogLine "IN updateNTUser Failed " & sUserName
	Else 
	updateNTUser = True
	WriteLogLine "IN updateNTUser Success " & sUserName
	end if
	
End Function




Function CreateFTPVirtualDirectory(sVirtualDirName,sPath)	
	'On Error Resume Next
	Dim oMsftpsvc
	Dim oNewFtpServer
	Dim oRootDir
	Dim oVirtualDir
	Set oMsftpsvc = GetObject("IIS://LocalHost/MSFTPSVC")	
	Set oNewFtpServer = oMsftpsvc.GetObject("IIsFtpServer", ftpSiteIndex)
	Set oRootDir = oNewFtpServer.GetObject("IIsFtpVirtualDir", "ROOT")
	set oVirtualDir = oRootDir.Create("IIsFtpVirtualDir", sVirtualDirName)
    
	oVirtualDir.Path = sPath
	oVirtualDir.AccessRead = True
	oVirtualDir.AccessWrite = True	
	oVirtualDir.setinfo
	
	If Err.number > 0 Then
		CreateFTPVirtualDirectory = False
	Else
		CreateFTPVirtualDirectory = True
	End If		
End Function



Function DeleteFTPVirtualDirectory(sVirtualDirName)	
	On Error Resume Next
	Dim oMsftpsvc
	Dim oNewFtpServer
	Dim oRootDir
	Dim oVirtualDir	
	Set oMsftpsvc = GetObject("IIS://LocalHost/MSFTPSVC")	
	Set oNewFtpServer = oMsftpsvc.GetObject("IIsFtpServer",ftpSiteIndex)
	Set oRootDir = oNewFtpServer.GetObject("IIsFtpVirtualDir", "ROOT")		
	oVirtualDir = oRootDir.Delete("IIsFtpVirtualDir", sVirtualDirName)		
	If Err.number > 0 Then	
		DeleteFTPVirtualDirectory = False 
		WriteLogLine "DeleteFTPVirtualDirectory "& sVirtualDirName &" Directory Could Not Delete"
	Else 
		DeleteFTPVirtualDirectory = True
		WriteLogLine "DeleteFTPVirtualDirectory "& sVirtualDirName &" Directory Deleted"
	end if
End Function



'-----------------------------------------------------------------------------------------------------------------

'The first thing is open a command window and pointing out that I want to see what's happening. After that I pipe the letter Y to the CACLS.exe by using the y| symbol. By piping Y, I avoid the "Are you Sure" question. Then I give the name of the folder (or file) I want to edit, followed by /E and /C. The /E says that I want to edit the user rights. Without the /E the rights will be overwritten. The /C says that the code should continue even if an error occurs. The last part is where I grant to user strUser (this can also be a group) a specific right. In the example I use C. But there are more rights:

'- R (read only)
'- W (write only)
'- C (change (read/write))
'- F (Full Control)


function RemoveUserFromFolder(strUser, strFolderPath)
	Dim caclscommand
    Dim whs
    Dim whsRun
	Caclscommand = "cmd /c echo y| CACLS " & strFolderPath	
    Caclscommand = Caclscommand & " /E /C /R " & strUser
    Set whs = server.createobject("WScript.Shell")
    whsRun = whs.Run(Caclscommand, 0, True)
    Set whs = nothing
	RemoveUserFromFolder = TRue
end function


function AddUserToFolder(strUser, strFolderPath)
	'On Error RESUME NEXT
	Dim caclscommand
    Dim whs
    Dim whsRun
	dim strPermission
	strPermission = "F"
   Caclscommand = "cmd /c echo y| CACLS " & strFolderPath	
    Caclscommand = Caclscommand & " /E /C /G " & strUser & ":" & strPermission
    Set whs = server.createobject("WScript.Shell")
    whsRun = whs.Run(Caclscommand, 0, True)
    Set whs = nothing
	AddUserToFolder = TRue
end function

'-----------------------------------------------------------------------------------------------------------------



' create Web Site in IIS
Function CreateNewWebSite(sDomain, sLogfileDir, sSiteRootDir, bcgi, bDotNet, sAccountUser, sIP, sInstance, isWWW)
	On Error Resume Next
	dim nPort : nPort=80
	Dim IIsObj, IIsNewObj, IIsNewRootObj
	Dim oWebServer, oCgi, oDB
	Dim sLogfileDirectory	
	Dim aServerBindings 
	if(isWWW) then 
		aServerBindings = Array(sIP & ":" & nPort & ":" & sDomain , sIP & ":" & nPort & ":" & "www." & sDomain)
	else
		aServerBindings = Array(sIP & ":" & nPort & ":" & sDomain )
	end if

	nInstanceID= sInstance + wwwSiteIndex

'	Response.Write  "<br>" & nInstanceID & "your id"
	WriteLogLine nInstanceID & " your id : " & sDomain

	Set IIsObj = GetObject("IIS://LocalHost/w3svc")	

	Set IIsNewObj = IIsObj.Create("IIsWebServer", nInstanceID)	
	IIsNewObj.ServerComment = sDomain 
	IISNewObj.AccessExecute = False
	IISNewObj.AccessScript = True
	IISNewObj.AccessRead = True
	IISNewObj.AccessWrite = False
	IISNewObj.FrontPageWeb = True
	IISNewObj.EnableDirBrowsing = False
	IISNewObj.EnableDefaultDoc = True
	IISNewObj.DefaultDoc = Join(sArrDefaultDecuments,",")
	IISNewObj.ServerBindings = aServerBindings
	'IISNewObj.CPULimitsEnabled = 1
	'IISNewObj.CPULimitLogEvent = 10000
	'IISNewObj.CPULimitPriority = 15000
	'IISNewObj.CPULimitProcStop = 20000
	'IISNewObj.MaxBandwidth = 1048576
	IIsNewObj.LogFileDirectory = sLogfileDir
	sLogClsId = ReturnLogfileFormatCLSID(sLogFileFormat)
	if(sLogClsId <> "Unknown") then	IIsNewObj.LogPluginClsId = sLogClsId

	IIsNewObj.LogExtFileBytesRecv = True
	IIsNewObj.LogExtFileBytesSent = True
	IIsNewObj.LogExtFileReferer = True
	IIsNewObj.LogExtFileBytesRecv = True
	IIsNewObj.LogExtFileBytesSent = True
	IIsNewObj.LogExtFileClientIp = True
	IIsNewObj.LogExtFileComputerName = True
	IIsNewObj.LogExtFileCookie = True
	IIsNewObj.LogExtFileDate = True
	IIsNewObj.LogExtFileHttpStatus = True
	IIsNewObj.LogExtFileMethod = True
	IIsNewObj.LogExtFileProtocolVersion = True
	IIsNewObj.LogExtFileReferer = True
	IIsNewObj.LogExtFileServerIp = True
	IIsNewObj.LogExtFileServerPort = True
	IIsNewObj.LogExtFileSiteName = True
	IIsNewObj.LogExtFileTime = True
	IIsNewObj.LogExtFileTimeTaken = True
	IIsNewObj.LogExtFileUriQuery = True
	IIsNewObj.LogExtFileUriStem = True
	IIsNewObj.LogExtFileUserAgent = True
	IIsNewObj.LogExtFileUserName = True
	IIsNewObj.LogExtFileWin32Status = True
	IIsNewObj.LogFilePeriod  = 2	
	IIsNewObj.SetInfo

		
	'Create the server's ROOT Directory
	'i.e. for the server's root virtula dir IIS://MachineName/W3SVC/N/ROOT 
	'For a specific virtual directory, 
	'i.e. IIS://MachineName/W3SVC/N/ROOT/vdirName 

	Set IIsNewRootObj = IIsNewObj.Create("IIsWebVirtualDir", "Root")
	IIsNewRootObj.Path = sSiteRootDir   'CHECK THIS THING...should pass sWWWPath here...think same values
	IIsNewRootObj.AppFriendlyName = "Default Application"
	'commit the changes to metabase
	IIsNewRootObj.SetInfo
	IIsNewRootObj.AppCreate2 2 ' mark the app with 0-inproc, 1-outproc, 2-pooled
	IIsNewRootObj.SetInfo
	'Start the server
	
	Set oWebServer = GetObject("IIS://Localhost/W3SVC/" & nInstanceID & "/ROOT")
	
	'::Create CGI Bin Support If Allowed
	If bcgi=True Then
		Set oCgi = oWebServer.Create("IIsWebDirectory", "cgi-bin")
		oCgi.AccessExecute = True
		oCgi.AccessScript = True
		oCgi.SetInfo
	Else
		Set oCgi = oWebServer.Create("IIsWebDirectory", "cgi-bin")
		oCgi.SetInfo	
	End If	

	'::Create .Net Directory if allowed
	IIsNewObj.Start 
	
	If Err.number > 0 Then
		Response.Write Err.description
		CreateNewWebSite = False
	Else
		CreateNewWebSite = True
	End If
	
	Set IISNewRootObj = Nothing
	Set IISNewObj = Nothing
	Set IISObj = Nothing
	Set oWebServer = Nothing
	Set oCgi = Nothing
	Set oDB = Nothing
End Function

Function ReturnLogfileFormatCLSID(sLogFormat)
	Set LoggingModules = GetObject("IIS://localhost/logging") 
	'Loop through the installed modules to find the currently selected module at this server. 
	for Each LogModule in LoggingModules 
	  if (LogModule.Class = "IIsLogModule") then
			 If LogModule.Name = sLogFormat Then 
				ReturnLogfileFormatCLSID = LogModule.LogModuleID 
					Exit Function
			end if
	  end if
	 Next 
	 ReturnLogfileFormatCLSID = "Unknown"	
end function




function DeleteIISWebSite(nSiteId, sDomainName)
	ON ERROR RESUME NEXT
	Dim oWebService
	nInstanceID= nSiteId + wwwSiteIndex
	Set oWebService = GetObject("IIS://LocalHost/w3svc")
	oWebService.Delete "IIsWebServer", nInstanceID
	If Err.number > 0 Then 
		DeleteIISWebSite = False 
		WriteLogLine "DeleteIISWebSite Site could not deleted : " & nSiteId & "(" & nInstanceID & ")" & " : " & sDomainName & " : " & err.description
	Else 
		DeleteIISWebSite = True
		WriteLogLine "DeleteIISWebSite Site deleted : " & nSiteId & "(" & nInstanceID & ")"  & " : " & sDomainName
	end if
end function





function CopyDomainFiles(sWWWPath, sDomainName)
	dim oFSO
	set oFSO = Server.createobject("Scripting.FileSystemObject")	
	oFSO.CopyFile newDomFiles & "*.gif", sWWWPath
	set oFile = oFso.opentextfile(newDomFiles & "default.htm",1)
	strContents = oFile.ReadAll
	strContents = replace(strContents, "{domain}", sDomainName)
	ofile.close
	set oFile = oFso.opentextfile(sWWWPath & "default.htm", fsoForWriting, True)
	oFile.write(strContents)
	ofile.close
	set ofile=nothing
	set oFSO = nothing	
	CopyDomainFiles = true
End function





function GetIpAddress(ipID, dbCon)
	dim rs 
	set rs = server.createobject("ADODB.recordset")
	rs.open "select ipaddress from tblserverip where id = "& ipID, dbCon
	if(not rs.eof) then
		GetIpAddress = rs("ipaddress")
	else
		GetIpAddress = "0"
	end if
	set rs = nothing
end function






'This function returns the site index of the site specified.The index value is the index in the IIS

Function GetWebInstance(sSiteName)
	Dim oWebSite
	Dim oWebServer
	On Error Resume Next
	Set oWebSite = GetObject("IIS://LocalHost/W3SVC")

	For each oWebServer in oWebSite
		If oWebServer.Class = "IIsWebServer" Then
			If lcase(oWebServer.ServerComment) = LCase(sSiteName) Then
				GetWebInstance = CInt(oWebServer.Name)
				Exit Function
			End If
		End If
	next
	GetWebInstance = -1
End Function









Function SetPasswordProtectDir(sDomainName, sWwwDirPath, sDirectory, sUserName,sPath)

	sDomainName = Trim(sDomainName)
	sWwwDirPath = Trim(sWwwDirPath)
	sDirectory = Trim(sDirectory) 
	sUserName = Trim(sUserName)

	Dim sErrMsg : sErrMsg = ""
	Dim oIIS, nInst	
	'on error resume next
	Set oIIS = GetObject("IIS://LocalHost/w3svc")
  	nInst = GetWebInstance(sDomainName)
	if (nInst = -1) then
		SetPasswordProtectDir = false
	else
		set oIISRED = GetObject("IIS://LocalHost/w3svc/" & nInst & "/ROOT")
		
		For each oPop in oIISRED
			on error goto 0
			if oPop.name=trim(sDirectory) then
				findflag=1
				exit for
			end if
		Next

		
		if findflag=1 then
			Set oDir = GetObject("IIS://LocalHost/w3svc/" & nInst & "/ROOT/" & sDirectory)	
		else
			Set oDir = oIISRED.Create("IIsWebDirectory", sDirectory)
		end if

		strCmd = "cscript  " & chr(34) & sCpHomeDir  &"\bin\adsutil.vbs " & chr(34) & " SET W3SVC/" & nInst & "/ROOT" &  sPath & "/Authntlm TRUE"
		WriteLogLine "SetPasswordProtectDir : " & strCmd
		Set whs = server.createobject("WScript.Shell")
		whs.Run strCmd, 1,True

		strCmd = "cscript  " & chr(34) & sCpHomeDir  &"\bin\adsutil.vbs " & chr(34) & " SET W3SVC/" & nInst & "/ROOT" &  sPath & "/AuthAnonymous FALSE"
		whs.Run strCmd, 1,True
		WriteLogLine "SetPasswordProtectDir : " & strCmd
		if err.number <> 0 then
		response.write err.description
		WriteLogLine "SetPasswordProtectDir"
		end if
		Set whs = nothing


		'oDir.AuthAnonymous = False
		'Response.write oDir.AppRoot
		'oDir.AuthNTLM=True
		'oDir.SetInfo
		set oDir = Nothing		
		Set oIISRED=Nothing
		Set oIIS = Nothing		

		result = AddUserToFolder(sUserName, sWwwDirPath)
		writeLogLine "AddUserToFolder :" & result
		'result = AddUserToFolder(sUserName, sWwwDirPath & "\" & sDirectory)
		SetPasswordProtectDir = True
	end if
end function




Function UnsetPasswordDir(sDomainName, sWwwDirPath, sDirectory, sUserName,sPath)
  	oinst = GetWebInstance(sDomainName)
	strCmd = "cscript  " & chr(34) & sCpHomeDir  &"\bin\adsutil.vbs " & chr(34) & " SET W3SVC/" & oinst & "/ROOT" &  sPath & "/Authntlm FALSE"
	WriteLogLine "UnSetPasswordProtectDir : " & strCmd
	Set whs = server.createobject("WScript.Shell")
	whs.Run strCmd, 1,True

	strCmd = "cscript  " & chr(34) & sCpHomeDir  &"\bin\adsutil.vbs " & chr(34) & " SET W3SVC/" & oinst & "/ROOT" &  sPath & "/AuthAnonymous TRUE"
	WriteLogLine "UnSetPasswordProtectDir : " & strCmd
	whs.Run strCmd, 1,True

	if err.number <> 0 then
	response.write err.description
	WriteLogLine "SetPasswordProtectDir"
	end if
	Set whs = nothing


	'ocgi.AuthAnonymous = True
	'ocgi.AuthNTLM=False
	'ocgi.SetInfo	
	
	Result = RemoveUserFromFolder(sUserName, sWwwDirPath)
	If IsObject(ocgi) Then Set ocgi=Nothing
	UnsetPasswordDir = True
end function



'sHomeDirPath is path of www folder of domain
Function EnableDotNet(sHomeDirPath, sDomainName)
	on error resume next
	result = AddUserToFolder("ASPNET", sHomeDirPath)
	dim netArray(18)
	dim aspiDllPath, aspnetVer 

	keyPath = "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\ASP.NET\"
	Set objReg = Server.CreateObject("WScript.Shell")
	aspnetVer  = objReg.RegRead(keyPath & "RootVer")
	if (err.number = 0) then 
		aspiDllPath = objReg.RegRead(keyPath & aspnetVer &"\DllFullPath")
		if (err.number = 0) then 
			netArray(0)=".asax,"& aspiDllPath  &",5,GET,HEAD,POST,DEBUG"
			netArray(1)=".ascx,"& aspiDllPath  &",5,GET,HEAD,POST,DEBUG"
			netArray(2)=".ashx,"& aspiDllPath  &",1,GET,HEAD,POST,DEBUG"
			netArray(3)=".asmx,"& aspiDllPath  &",1,GET,HEAD,POST,DEBUG"
			netArray(4)=".aspx,"& aspiDllPath  &",1,GET,HEAD,POST,DEBUG"
			netArray(5)=".axd,"& aspiDllPath  &",1,GET,HEAD,POST,DEBUG"
			netArray(6)=".vsdisco,"& aspiDllPath  &",1,GET,HEAD,POST,DEBUG"
			netArray(7)=".rem,"& aspiDllPath  &",1,GET,HEAD,POST,DEBUG"
			netArray(8)=".soap,"& aspiDllPath  &",1,GET,HEAD,POST,DEBUG"
			netArray(9)=".config,"& aspiDllPath  &",5,GET,HEAD,POST,DEBUG"
			netArray(10)=".cs,"& aspiDllPath  &",5,GET,HEAD,POST,DEBUG"
			netArray(11)=".csproj,"& aspiDllPath  &",5,GET,HEAD,POST,DEBUG"
			netArray(12)=".vb,"& aspiDllPath  &",5,GET,HEAD,POST,DEBUG"
			netArray(13)=".vbproj,"& aspiDllPath  &",5,GET,HEAD,POST,DEBUG"
			netArray(14)=".webinfo,"& aspiDllPath  &",5,GET,HEAD,POST,DEBUG"
			netArray(15)=".licx,"& aspiDllPath  &",5,GET,HEAD,POST,DEBUG"
			netArray(16)=".resx,"& aspiDllPath  &",5,GET,HEAD,POST,DEBUG"
			netArray(17)=".resources,"& aspiDllPath  &",5,GET,HEAD,POST,DEBUG"

			nInst =  GetWebInstance(sDomainName)
			Set IISOBJ = GetObject("IIS://LocalHost/w3svc/"& nInst &"/root")		
			ScriptMaps = IISOBJ.Scriptmaps
			xpos = UBound(ScriptMaps) + 1
			redim Preserve ScriptMaps(UBound(ScriptMaps)+UBound(netArray)+1)	
			for pos = LBound(netArray) to UBOund(netArray)
				ScriptMaps(xpos) = netArray(pos)
				xpos = xpos + 1		
			next
			IISOBJ.ScriptMaps = ScriptMaps
			IISOBJ.SetInfo
			set IISOBJ = nothing
			EnableDotNet=True	
		else
			writelogline("Can not get aspnet DLL PATH "& err.description)
			EnableDotNet=False	
		end if
	else
		writelogline("Can not get aspnet rootver "& err.description)
		EnableDotNet=False	
	end if
End Function

'sHomeDirPath is path of www folder of domain
Function DisableDotNet(sHomeDirPath, sDomainName)
	dim NewScriptMaps
	result = RemoveUserfromFolder("ASPNET", sHomeDirPath)	
	nInst =  GetWebInstance(sDomainName)
	Set IISOBJ = GetObject("IIS://LocalHost/w3svc/"& nInst &"/root")		
	ScriptMaps = IISOBJ.Scriptmaps
	xpos = 0
	for pos = lbound(ScriptMaps) to UBOund(ScriptMaps)
		Items = Split(Scriptmaps(Pos), ",")
        if (lcase(right(items(1),16)) <> "aspnet_isapi.dll") then
			if (xpos = 0) then
				reDim NewScriptMaps(0)
			else
                Redim Preserve NewScriptMaps(UBound(NewScriptMaps)+1)
			end if
            NewScriptMaps(UBound(NewScriptMaps)) = ScriptMaps(Pos)
			xpos = xpos + 1
		end if
	next
	IISOBJ.ScriptMaps = NewScriptMaps
	IISOBJ.SetInfo
	set IISOBJ = nothing
	DisbaleDotNet=True
End Function

'sHomeDirPath is path of www folder of domain
Function EnableCGI(sHomeDirPath, sDomainName)
	Dim oExecutor,sResult,ocgi
	Set Fso=Server.CreateObject("Scripting.FileSystemObject")
	If fso.FolderExists(sHomeDirPath & "\cgi-bin")=False Then
		If CreateDir(sHomeDirPath & "\cgi-bin")=False Then
			EnableCGI=False
			Exit Function
		End If
	End If	
	result = AddUserToFolder("IUSR_" & sComputerName,  sHomeDirPath & "\cgi-bin")
	
	nInst = GetWebInstance(sDomainName)
	
	dim oIIRED	
	Set oMsW3svc = GetObject("IIS://LocalHost/w3svc/"& nInst &"/root")		
	k=0
	for each i in oMsW3svc			
		if i.name="cgi-bin" then 
			k=1
			exit for			
		end if
	next
	Set oMsW3svc = nothing
	if k=0 then
		Set oIIRED = oMsW3svc.Create("IIsWebDirectory", "cgi-bin")
	else
		set oIIRED = GetObject("IIS://LocalHost/w3svc/"& nInst &"/ROOT/cgi-bin")
	end if
	
	oIIRED.AccessExecute = True
	oIIRED.Accesswrite = True
	oIIRED.AccessScript = False
	oIIRED.SetInfo
	
	If IsObject(oIISRED) Then Set oIISRED=Nothing

	If err.number<>0 Then	
		EnableCGI=False
	Else
		EnableCGI=True
	End If
End Function

Function DisableCGI(sHomeDirPath, sDomainName)
	Set Fso=Server.CreateObject("Scripting.FileSystemObject")
	If fso.FolderExists(sHomeDirPath & " \cgi-bin")=False Then
		DisableCGI = False
	Else
		result = RemoveUserFromFolder("IUSR_" & sComputerName,  sHomeDirPath & "\cgi-bin")
		Dim sIISWWWPath,sIIsLogPath

		Set oIIS = GetObject("IIS://LocalHost/w3svc")
		nInst = GetWebInstance(sDomainName)		
		on error resume next
		Set oMsW3svc = GetObject("IIS://LocalHost/w3svc/"& nInst &"/root")		
		k=0
		for each i in oMsW3svc			
			if i.name="cgi-bin" then 
				k=1
				exit for			
			end if
		next
		if k=0 then
			Set oCgi = oMsW3svc.Create("IIsWebDirectory", "cgi-bin")
		end if
		Set oMsW3svc1 = GetObject("IIS://LocalHost/w3svc/"& nInst &"/root")
		set oIIRED = GetObject("IIS://LocalHost/w3svc/"& nInst &"/ROOT/cgi-bin")
		oIIRED.AccessExecute = False
		oIIRED.Accesswrite = False
		oIIRED.AccessScript = True
		oIIRED.SetInfo	
		
		If IsObject(oIISRED) Then Set oIISRED=Nothing		
		If err.number<>0 Then
			DisableCGI=False
		Else
			DisableCGI=True
		End If		
	End If
End Function



Function CreateSQLDSN(sDatabase, sDsnName, sDSNUser, sDesc, sServer)
	Set objReg = Server.CreateObject("WScript.Shell")
	sRootKey = "HKEY_LOCAL_MACHINE\Software\ODBC\ODBC.INI\"
	sNewKey = sRootKey & sDsnName & "\"
	objReg.RegWrite sNewKey, ""
	objReg.RegWrite sNewKey & "Database" , sDatabase, "REG_SZ"
	objReg.RegWrite sNewKey & "Description" , sDesc, "REG_SZ"
	objReg.RegWrite sNewKey & "Driver" , sMsSQLDriver, "REG_SZ"
	objReg.RegWrite sNewKey & "LastUser" , sDSNUser, "REG_SZ"
	objReg.RegWrite sNewKey & "Server" , sServer, "REG_SZ"
	
	sRootKey = "HKEY_LOCAL_MACHINE\Software\ODBC\ODBC.INI\ODBC Data Sources\"
	objReg.RegWrite sRootKey & sDsnName , "SQL Server", "REG_SZ"
	
	If err.number<>0 Then
		CreateSQLDSN=false
	Else
		CreateSQLDSN=True
	End IF	
	Set objReg = nothing
End Function

Function DeleteSQLDSN(sDsnName)
	Set objReg = Server.CreateObject("WScript.Shell")
	sRootKey = "HKEY_LOCAL_MACHINE\Software\ODBC\ODBC.INI\"
	sNewKey = sRootKey & sDsnName & "\"
	
	objReg.RegDelete sNewKey & "Database"
	objReg.RegDelete sNewKey & "Description"
	objReg.RegDelete sNewKey & "Driver" 
	objReg.RegDelete sNewKey & "LastUser"
	objReg.RegDelete sNewKey & "Server"
	objReg.RegDelete sNewKey

	sRootKey = "HKEY_LOCAL_MACHINE\Software\ODBC\ODBC.INI\ODBC Data Sources\"
	objReg.RegDelete sRootKey & sDsnName
	
	If err.number<>0 Then
		DeleteSQLDSN=false
	Else
		DeleteSQLDSN=True
	End IF	
	Set objReg = nothing
End Function


Function CreateMySqlDSN(sDatabase, sDsnName, sDSNUser, sDSNPass, sDesc, sServer)
	Set objReg = Server.CreateObject("WScript.Shell")
	sRootKey = "HKEY_LOCAL_MACHINE\Software\ODBC\ODBC.INI\"
	sNewKey = sRootKey & sDsnName & "\"
	objReg.RegWrite sNewKey, ""
	objReg.RegWrite sNewKey & "Database" , sDatabase, "REG_SZ"
	objReg.RegWrite sNewKey & "Description" , sDesc, "REG_SZ"
	objReg.RegWrite sNewKey & "Driver" , sMySQLDriver, "REG_SZ"
	objReg.RegWrite sNewKey & "Option" , "0", "REG_SZ"
	objReg.RegWrite sNewKey & "Password" , sDSNPass, "REG_SZ"
	objReg.RegWrite sNewKey & "Port" , "", "REG_SZ"
	objReg.RegWrite sNewKey & "Server" , sServer, "REG_SZ"
	objReg.RegWrite sNewKey & "Stmt" , "", "REG_SZ"
	objReg.RegWrite sNewKey & "User" , sDSNUser, "REG_SZ"
	
	sRootKey = "HKEY_LOCAL_MACHINE\Software\ODBC\ODBC.INI\ODBC Data Sources\"
	objReg.RegWrite sRootKey & sDsnName , sMySQLDriverName, "REG_SZ"
	
	If err.number<>0 Then
		CreateMySqlDSN=false
	Else
		CreateMySqlDSN=True
	End IF	
	Set objReg = nothing
End Function





Function DeleteMySqlDSN(sDsnName)
	Set objReg = Server.CreateObject("WScript.Shell")
	sRootKey = "HKEY_LOCAL_MACHINE\Software\ODBC\ODBC.INI\"	
	sNewKey = sRootKey & sDsnName & "\"

	objReg.RegDelete sNewKey & "Database"
	objReg.RegDelete sNewKey & "Description"
	objReg.RegDelete sNewKey & "Driver"
	objReg.RegDelete sNewKey & "Option"
	objReg.RegDelete sNewKey & "Password"
	objReg.RegDelete sNewKey & "Port" 
	objReg.RegDelete sNewKey & "Server"
	objReg.RegDelete sNewKey & "Stmt"
	objReg.RegDelete sNewKey & "User"	
	objReg.RegDelete sNewKey

	sRootKey = "HKEY_LOCAL_MACHINE\Software\ODBC\ODBC.INI\ODBC Data Sources\"
	objReg.RegDelete sRootKey & sDsnName
	
	If err.number<>0 Then
		DeleteMySqlDSN=false
	Else
		DeleteMySqlDSN=True
	End IF	
	Set objReg = nothing
End Function



Function CreateAccessDSN(sSource, sDsnName ,sDSNUser, sDSNPass, sDesc)
	Dim s,sRootKey,sNewKey,objReg,sEngKey,sJetKey
	Set objReg = Server.CreateObject("WScript.Shell")
	sRootKey = "HKEY_LOCAL_MACHINE\Software\ODBC\ODBC.INI\"
	':: First Create root key as dsnname provided
	sNewKey = sRootKey & sDsnName & "\"
	objReg.RegWrite sNewKey, ""
	objReg.RegWrite sNewKey & "DBQ" , sSource, "REG_SZ"
	objReg.RegWrite sNewKey & "Description" , sDesc, "REG_SZ"
	objReg.RegWrite sNewKey & "Driver" , sAccessDriver, "REG_SZ"
	objReg.RegWrite sNewKey & "DriverId" , 25, "REG_DWORD"
	objReg.RegWrite sNewKey & "FIL" , "MS Access;", "REG_SZ"
	objReg.RegWrite sNewKey & "SafeTransactions" , 0, "REG_DWORD"
	objReg.RegWrite sNewKey & "UID" , sDSNUser, "REG_SZ"
	objReg.RegWrite sNewKey & "PWD" , sDSNPass, "REG_SZ"
		
	':: Create Engines key under dsn key
	sRootKey = sNewKey
	sNewKey = sRootKey & "Engines" & "\"
	objReg.RegWrite sNewKey, ""
	

	':: Create Jet Driver key under dsn/Engines key	
	sRootKey = sNewKey
	sNewKey = sRootKey & "Jet" & "\"
	objReg.RegWrite sNewKey, ""
	objReg.RegWrite sNewKey & "ImplicitCommitSync" , "Yes", "REG_SZ"
	objReg.RegWrite sNewKey & "MaxBufferSize" , 2048, "REG_DWORD"
	objReg.RegWrite sNewKey & "PageTimeout" , 5, "REG_DWORD"
	objReg.RegWrite sNewKey & "Threads" , 5, "REG_DWORD"
	objReg.RegWrite sNewKey & "UserCommitSync" , "Yes", "REG_SZ"
		
	'::Set the key to database source name (ODBC)
	sRootKey = "HKEY_LOCAL_MACHINE\Software\ODBC\ODBC.INI\ODBC Data Sources\"
	objReg.RegWrite sRootKey & sDsnName , "Microsoft Access Driver (*.mdb)", "REG_SZ"
	

   ' If err.number<>0 Then
	'	 createAccessDSN=False
	'Else
		createAccessDSN=True
	'End If
	Set objReg = nothing
End Function

Function DeleteAccessDSN(sDsnName)
	ON ERROR RESUME NEXT
	Dim sRootKey,sNewKey,objReg,sDelKey

	Set objReg = Server.CreateObject("WScript.Shell")
	sRootKey = "HKEY_LOCAL_MACHINE\Software\ODBC\ODBC.INI\"	
	sDelKey = sRootKey & sDsnName & "\"		

	objReg.RegDelete sDelKey & "DBQ"
	objReg.RegDelete sDelKey & "Description"
	objReg.RegDelete sDelKey & "Driver" 
	objReg.RegDelete sDelKey & "DriverId" 
	objReg.RegDelete sDelKey & "FIL" 
	objReg.RegDelete sDelKey & "SafeTransactions" 
	objReg.RegDelete sDelKey & "UID" 
	objReg.RegDelete sDelKey & "PWD" 

	sNewKey = sDelKey & "Engines\Jet\"	
	objReg.RegDelete sNewKey & "ImplicitCommitSync"
	objReg.RegDelete sNewKey & "MaxBufferSize" 
	objReg.RegDelete sNewKey & "PageTimeout"
	objReg.RegDelete sNewKey & "Threads" 
	objReg.RegDelete sNewKey & "UserCommitSync" 
	objReg.RegDelete sNewKey	
	sNewKey = sDelKey & "Engines\" 
	objReg.RegDelete sNewKey	
	objReg.RegDelete sDelKey	

	'::Delete the key to database source name (ODBC)
	sRootKey = "HKEY_LOCAL_MACHINE\Software\ODBC\ODBC.INI\ODBC Data Sources\"
	objReg.RegDelete sRootKey & sDsnName	

    If err.number<>0 Then
		DeleteAccessDSN=False
	Else
		DeleteAccessDSN=True
	End If
	Set objReg = nothing
End Function

'########################
SUB WriteLogLine(msg)
'########################
	'If Application("Debugging")=False Then On Error resume next	
	If cpLogFilePath <> "" Then
		If err<> 0 then sErr=VbTab & "Error: " & err.description Else sErr=""
		Set fLog=logFSO.OpenTextFile(cpLogFilePath,8,True)
		fLog.WriteLine Now & Vbtab & msg & sErr
		fLog.close
		err.clear
	End If
End SUB


Function EnableWebStat(sDomainName, sHomeDir, nDomainId)
	if(ucase(isWebalizerStats) = "YES") then
		EnableWebalizer sDomainName, sHomeDir, nDomainId
	end if
	if(ucase(isAwstats) = "YES") then
		EnableAwstat sDomainName, sHomeDir & "\log", nDomainId
	end if
	EnableWebStat = True
End Function

Function EnableWebalizer(sDomainName, sHomeDir, nDomainId)
	dim nInst
	if(not logFSO.FileExists(sWebalizerConfDir & sDomainName & ".conf")) then 
		set oFso = server.createobject("Scripting.FileSystemObject")
		set oFile = oFso.opentextfile(sWebalizerTempFile ,1)
		strContents = oFile.ReadAll
		sStatDir = sHomeDir & "\www\stats"
		writelogline "EnableWebStat : " & sStatDir
		if(not oFso.folderexists(sStatDir)) then
			oFso.createfolder sStatDir
		end if
		sLogDir = sHomeDir & "\log"
		nInst = nDomainId + wwwSiteIndex
		strContents = replace(strContents, "{logfile}", sLogDir & "\W3SVC" & nInst & "\ex*.log")
		strContents = replace(strContents, "{outpath}", sStatDir)
		strContents = replace(strContents, "{hostname}", sDomainName)
		strContents = replace(strContents, "{folderlog}", sLogDir & "\W3SVC" & nInst & "\")		
		ofile.close
		set oFile = oFso.opentextfile(sWebalizerConfDir & sDomainName & ".conf", fsoForWriting, True)
		oFile.write(strContents)
		ofile.close

		set oBatFile = oFso.opentextfile(sCpHomeDir & "\bin\stats.bat", fsoForAppending , True)
		oBatFile.WriteLine(sCpHomeDir & "\bin\webalizer.exe -c "& sWebalizerConfDir & sDomainName & ".conf")
		oBatFile.close
	end if	
	EnableWebalizer = True
End Function

Function EnableAwstat(sDomainName, slogDir, nDomainId)
	'on error resume next
	dim nInst
	nInst = nDomainId + wwwSiteIndex
	Set oW3svc = GetObject("IIS://LocalHost/w3svc/"& nInst )
	Set oRootDir = oW3svc.GetObject("IIsWebVirtualDir", "ROOT")	
	k=0
	for each i in oRootDir			
		if i.name="webstat" then 
			k=1
			exit for			
		end if
	next
	if k=0 then
		Set oVirtualDir = oRootDir.Create("IIsWebVirtualDir", "webstat")
		WriteLogLine("Create webstat virtual dir")
	else
		set oVirtualDir = GetObject("IIS://LocalHost/w3svc/"& nInst &"/ROOT/webstat")
		WriteLogLine(" webstat virtual dir exist")
	end if
	oVirtualDir.Path = awstatsDir & "\wwwroot"
	oVirtualDir.AppFriendlyName="webstat"
	oVirtualDir.SetInfo
	oVirtualDir.AppCreate2 2 ' mark the app with 0-inproc, 1-outproc, 2-pooled
	oVirtualDir.AccessExecute = True
	oVirtualDir.AccessScript = True
	oVirtualDir.SetInfo
	oVirtualDir.SetInfo
	set oVirtualDir = nothing
	Set oRootDir =nothing
	Set oW3svc =nothing

	if(not logFSO.FileExists(awstatsDir & "\wwwroot\cgi-bin\awstats." & sDomainName & ".conf")) then 
		set oFso = server.createobject("Scripting.FileSystemObject")
		set oFile = oFso.opentextfile(sAwstatTempFile ,1)
		strContents = oFile.ReadAll				
		ofile.close		
		strContents = replace(strContents, "{LOGDIR}", sLogDir & "\W3SVC" & nInst )
		strContents = replace(strContents, "{DOMAIN}", sDomainName)		
		strContents = replace(strContents, "{cachedir}", awstatsCacheDir)			
		
		set oFile = oFso.opentextfile(awstatsDir & "\wwwroot\cgi-bin\awstats." & sDomainName & ".conf", fsoForWriting, True)
		oFile.write(strContents)
		ofile.close

		set oBatFile = oFso.opentextfile(sCpHomeDir & "\bin\stats.bat", fsoForAppending , True)
		oBatFile.WriteLine(perlExePath & " " & awstatsDir & "\wwwroot\cgi-bin\awstats.pl -update -config="& sDomainName)
		oBatFile.close
		WriteLogLine(" File does not exist: awstats." & sDomainName & ".conf" )
	end if
	EnableAwstat = True
End Function

Function DisableWebStat(sDomainName)
	on error resume next
	dim nInst
	nInst = GetWebInstance(sDomainName)
	Set oW3svc = GetObject("IIS://LocalHost/w3svc/"& nInst )
	Set oRootDir = oW3svc.GetObject("IIsWebVirtualDir", "ROOT")	
	k=0
	for each i in oRootDir			
		if i.name="webstat" then 
			k=1
			exit for			
		end if
	next
	if k=1 then		
		set oVirtualDir = oRootDir.Delete("IIsWebVirtualDir", "webstat")
		oVirtualDir.SetInfo
	end if


	if(logFSO.FileExists(sWebalizerConfDir & sDomainName & ".conf")) then 
		logFSO.DeleteFile sWebalizerConfDir & sDomainName & ".conf"
	end if
	if(logFSO.FileExists(awstatsDir & "\wwwroot\cgi-bin\awstats." & sDomainName & ".conf")) then 
		logFSO.DeleteFile awstatsDir & "\wwwroot\cgi-bin\awstats." & sDomainName & ".conf"
	end if
	strContents = ""
	strLine = ""
	set oFso = server.createobject("Scripting.FileSystemObject")
	set oBatFile = oFso.opentextfile(sCpHomeDir & "\bin\stats.bat", 1)
	Do While oBatFile.AtEndOfStream <> True
      strLine = oBatFile.ReadLine
	  if((inStr(1, strLine, sWebalizerConfDir & sDomainName & ".conf", 1) = 0 ) and (inStr(1, strLine, awstatsDir & "\wwwroot\cgi-bin\awstats.pl -update -config="& sDomainName, 1) = 0)) then
		strContents = strContents & strLine & vbCrLf
	  end if
    Loop
	oBatFile.close
	
	set oBatFile = oFso.opentextfile(sCpHomeDir & "\bin\stats.bat", fsoForWriting , True)
	oBatFile.Write(strContents)
	oBatFile.close
	DisableWebStat = True
End Function



Function UsedDomainSpace(homeDir)
	On Error Resume Next 
	Dim objFs,UsedDiskSpace, countSpaceWWW, countSpaceDB
	Set objFs=Server.CreateObject("Scripting.FilesystemObject")
	
	if(objFs.folderexists(homedir )) then
		countSpaceWWW=objFs.GetFolder(homedir).Size
	else
		WriteLogLine  homedir & " does not exists." 
	end if
	countSpace = countSpaceWWW
	UsedDiskSpace=cdbl((countSpace/1024)/1024)
	If Int(UsedDiskSpace) = 0 Then
		nSpaceKB = CDbl(countSpace/1024)
		UsedDomainSpace = FormatNumber(Round(nSpaceKB,2),2) & " KB"
	Else
		UsedDomainSpace =  FormatNumber(round(UsedDiskSpace),2) &" MB"		
	End If
	set objFs = nothing

End Function


Sub RestartIIS()
	
	Set whs = server.createobject("WScript.Shell")
	command = "net stop ""World Wide Web Publishing Service"" "	
	whsRun = whs.Run(command, 0, True)	
	command = "net start ""World Wide Web Publishing Service"" "	
	whsRun = whs.Run(command, 0, True)		
	If err.number<>0 Then 
		WriteLogLine "In WWW Services Restarted"		
	Else
		WriteLogLine "In ExtendFrontPage Success"		
	End If	

	command = "net stop ""FTP Publishing Service"" "	
	whsRun = whs.Run(command, 0, True)	
	command = "net start ""FTP Publishing Service"" "	
	whsRun = whs.Run(command, 0, True)		
	If err.number<>0 Then 
		WriteLogLine "In WWW Services Restarted"		
	Else
		WriteLogLine "In ExtendFrontPage Success"		
	End If	

	command = "net stop ""Simple Mail Transport Protocol (SMTP)"" "	
	whsRun = whs.Run(command, 0, True)	
	command = "net start ""Simple Mail Transport Protocol (SMTP)"" "	
	whsRun = whs.Run(command, 0, True)		
	If err.number<>0 Then 
		WriteLogLine "In WWW Services Restarted"		
	Else
		WriteLogLine "In ExtendFrontPage Success"		
	End If	
	set whsRun = nothing
End Sub






Sub RebootServer()
	WriteLogLine  "Rebooting Server " 
	strComputer = "."
	Set objWMIService = GetObject("winmgmts:{impersonationLevel=impersonate,(Shutdown)}!\\" & strComputer & "\root\cimv2")
	Set colOperatingSystems = objWMIService.ExecQuery	("Select * from Win32_OperatingSystem")
	For Each objOperatingSystem in colOperatingSystems
		ObjOperatingSystem.Reboot()
	Next
End Sub




Function UpdateHostHeaders(arrNewServerBinding, sDomainName)
	on error resume next
	Dim oIIS
	Dim nInst,i

	nInst = GetWebInstance(sDomainName)
    If cint(nInst) <=0 Then		
		UpdateHostHeaders = False
		WriteLogLine " Domain name not found" & sDomainName
		Exit Function
	End If
	Set oIIS = GetObject("IIS://localhost/W3svc/" & nInst)		
	oIIS.ServerBindings = arrNewServerBinding
	oIIS.SetInfo
	UpdateHostHeaders = True
End Function






Function geterrors(sDomainName)
  'This gets the site ID of the Domain name specified
  nInst = GetWebInstance(sDomainName)

  SiteID = "IIS://" & sComputerName & "/W3SVC/" &   nInst & "/Root"
  Set IIS = GetObject(SiteID)
  geterrors = IIS.HTTPErrors
End Function



Function seterrors(sDomainName,ArrayErrors)
  'This gets the site ID of the Domain name specified
  nInst = GetWebInstance(sDomainName)

  SiteID = "IIS://" & sComputerName & "/W3SVC/" &   nInst & "/Root"
  Set IIS = GetObject(SiteID)
  IIS.HTTPErrors=ArrayErrors
  IIS.SetInfo
End Function

Function ViewDefaultDocs(sDomainName)
	'This gets the site ID of the Domain name specified
	dim IIS, SiteID, nInst
	nInst = GetWebInstance(sDomainName)
	SiteID = "IIS://" & sComputerName & "/W3SVC/" &   nInst & "/Root"
	Set IIS = GetObject(SiteID)
	ViewDefaultDocs = split(IIS.DefaultDoc,",")
	set IIS = nothing
End Function

Function AddDefaultDocs(sDomainName, DocArray)
		nInst = GetWebInstance(sDomainName)
		SiteID = "IIS://" & sComputerName & "/W3SVC/" &   nInst & "/Root"
		Set IIS = GetObject(SiteID)
		IIS.DefaultDOC = Array(DocArray)
		IIS.SetInfo
		set IIS = nothing
End Function

function GetDBServerIp(serverID, dbCon)
	dim rs 
	set rs = server.createobject("ADODB.recordset")
	rs.open "select serverip from cp_db_servers where id = "& serverID, dbCon
	if(not rs.eof) then
		GetDBServerIp = rs("serverip")
	else
		GetDBServerIp = ""
	end if
	set rs = nothing
end function






function GetSkins()
	FoldersName=""
	Set objFSO = CreateObject("Scripting.FileSystemObject") 
	' Get a handle on the folder 
	SkinDir= sCpHomeDir & "\www\skins\"
	Set objFolder = objFSO.GetFolder(SkinDir) 

	For Each objSubFolder In objFolder.SubFolders 
		if(FoldersName="") then
			FoldersName = objSubFolder.Name 
		else
			FoldersName = FoldersName & "," & objSubFolder.Name  
		end if
	Next 
	GetSkins=FoldersName
end function



function GetAllFtpAccounts(resellerid)
		dim domainList
		domainList = ""
		ftpusername=""		
		query="select domainid from tbldomain where resellerid=" & resellerid & ""
		Set rsdomain=Server.CreateObject("ADODB.Recordset")
		rsdomain.open query,con
		if(rsdomain.eof) then
			ftpusers=""
		else
			while(not rsdomain.eof)
				domainid=rsdomain("domainid")
				if(len(domainList) = 0) then 
					domainList = domainid
				else
					domainList = domainList & ", " & domainid
				end if
				rsdomain.movenext
			wend 
			query="select distinct(ftpusername),ftppassword from tblftpinfo where domainid in (" & domainList & ") order by ftpusername"
			Set rsftp=Server.CreateObject("ADODB.Recordset")
			rsftp.open query,con				
			if(rsftp.eof) then
				ftpusername=""
				ftppassword=""
			else
				while(not rsftp.eof)
					if(ftpusername="") then
						ftpusername=rsftp("ftpusername")
					else
						ftpusername=ftpusername & "," & rsftp("ftpusername")
					end if
					rsftp.movenext
				wend
			end if
			set rsftp=nothing		
			set rsdomain = nothing
		end if
		GetAllFtpAccounts=ftpusername
end function





'-----------------------------------------------------------------------------------------------

Function StopIISWebSite(sDomainName)
	on error resume next 
	nInstanceID= GetWebInstance(sDomainName)
	Set IIsObj = GetObject("IIS://LocalHost/w3svc/"& nInstanceID)
	IIsObj.stop
	IIsObj.SetInfo
	Set IIsObj = Nothing
End Function

'-----------------------------------------------------------------------------------------------

Function StartIISWebSite(sDomainName)
	on error resume next 
	nInstanceID= GetWebInstance(sDomainName)
	Set IIsObj = GetObject("IIS://LocalHost/w3svc/"& nInstanceID)
	IIsObj.start
	IIsObj.SetInfo
	Set IIsObj = Nothing
End Function

function SetWritePermission(strFolderPath, writePerm)
	'On Error RESUME NEXT
	Dim caclscommand
    Dim whs
    Dim whsRun
	dim strPermission
	if(writePerm ="1") then 
		strPermission = "C"	
	else
		strPermission = "R"
	end if

	strUser = "IUSR_"& sComputerName
	Caclscommand = "cmd /c echo y| CACLS " & strFolderPath	
    Caclscommand = Caclscommand & " /E /C /P " & strUser & ":" & strPermission
    Set whs = server.createobject("WScript.Shell")
	writelogline Caclscommand
    whsRun = whs.Run(Caclscommand, 0, True)
    Set whs = nothing
	SetWritePermission = TRue
end function


Function copyDNSTemplateClient(resellerId)
	set rsDNS = server.CreateObject("ADODB.RecordSet")
	query = "select * from tbldnstemplate where resellerid ='0'"
	rsDNS.open query,con

	if(not rsDNS.eof) then
			while(not rsDNS.eof)
						host = rsDNS("host")
						recordType = rsDNS("recordtype")
						recordValue = rsDNS("value")
						MXpref = rsDNS("mxpref")
						query = "insert into tbldnstemplate (host,recordtype,value,resellerid,mxpref) values ('" & host & "','" & recordType & "','" & recordValue & "','" & resellerId & "', '" & MXpref & "')"
						con.execute (query)
					rsDNS.movenext
			wend
	end if
	set rsDNS = Nothing
End Function
%>