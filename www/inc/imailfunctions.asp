<%
Function MakeHostAdmin(sHost, sUserId)
	ON ERROR RESUME NEXT
	HelpTxt = False
   Set WShShell = server.createobject("WScript.Shell")
	RegRootKey = "HKEY_LOCAL_MACHINE"
	RegUserKey = "\Software\Ipswitch\IMail\Domains\" & sHost & "\Users\" & sUserId & "\"
	RegUserVal = "Flags"	
	Flags = 384 ' 128 + 256 
	WShShell.RegWrite RegRootKey & RegUserKey & RegUserVal, Flags, "REG_DWORD"
	MakeHostAdmin = TRUE
	WriteLogLine(sUserId & " set as HOST ADMIN for "& sHost)
	set WShShell = nothing
end function
  
  'Adding new mail account to IMail
  Function AddImailUser(sHost,sUserId,sUserName,sPassword) 		
	Dim strcommand
    Dim whs
    Dim whsRun	
    strcommand = sMailServerPath & "\adduser.exe " 
    strcommand = strcommand & "-h " & sHost & " -u " & sUserId & " -n " & """" & sUserName  & """" & " -p " & sPassword  
	WriteLogLine(strcommand)
    Set whs = server.createobject("WScript.Shell")
    whsRun = whs.Run(strcommand, 0, True)
    Set whs = nothing
	WriteLogLine(whsRun)
	If err.number<>0 Then
		AddImailUser = True
	Else
		AddImailUser =False
	End If	  
	
  End Function
  '*****************************************************************************************
  
  
  'Modifying mail account name & password
  Function ModifyImailUser(sHost,sUserId,sUserName,sPassword) 	
	If Trim(sHost)="" Or Trim(sUserId)="" Or (Trim(sUserName)="" And Trim(sPassword)="") Then
	  ModifyImailUser = False
	  Exit Function
	End If	
	
	Dim strcommand
    Dim whs
    Dim whsRun	
    strcommand = sMailServerPath & "\adduser.exe "
	If sUserName <> "" And sPassword <> "" Then
	  strcommand = strcommand & "-h " & sHost & " -m " & sUserId & " -n " & """" & sUserName  & """" & " -p " & sPassword  
	ElseIf sUserName <> "" And sPassword = "" Then
	  strcommand = strcommand & "-h " & sHost & " -m " & sUserId & " -n " & """" & sUserName  & """" 
	ElseIf sUserName = "" And sPassword <> "" Then
	  strcommand = strcommand & "-h " & sHost & " -m " & sUserId & " -p " & sPassword  
	End If
    
    Set whs = server.createobject("WScript.Shell")
    whsRun = whs.Run(strcommand, 0, True)
    Set whs = nothing
	WriteLogLine(whsRun)
	
	If err.number<>0 Then
	  ModifyImailUser = True
	Else
	  ModifyImailUser =False
	End If	  
	
  End Function
  '*****************************************************************************************

  'Deleting mail account
  Function DeleteImailUser(sHost,sUserId) 
	
	If Trim(sHost)="" Or Trim(sUserId)="" Then
	  DeleteImailUser = False
	  Exit Function
	End If
	
	Dim strcommand
    Dim whs
    Dim whsRun	
    strcommand = sMailServerPath & "\adduser.exe "  
    strcommand = strcommand & "-h " & sHost & " -k " & sUserId 
    Set whs = server.createobject("WScript.Shell")
    whsRun = whs.Run(strcommand, 0, True)
    Set whs = nothing
	WriteLogLine(whsRun)

	If err.number<>0 Then
	  DeleteImailUser = True
	Else
	  DeleteImailUser  =False
	End If	  
	
  End Function
  '*****************************************************************************************

  'Adding new mail domain to IMail
  Function AddImailDomain(sHost,sUSHost, sMailDir) 	
	Dim strcommand
    Dim whs
    Dim whsRun	
    strcommand = sMailServerPath & "\adddomain.exe " 
    strcommand = strcommand & "-h" & sHost & " -iVIRTUAL -t " & chr(34) & sMailDir & chr(34) &"  -uIM -a mail."  & sHost
	WriteLogLine(strcommand)
    Set whs = server.createobject("WScript.Shell")
    whsRun = whs.Run(strcommand, 0, True)
    Set whs = nothing
	WriteLogLine(whsRun)

	If err.number<>0 Then
	  AddImailDomain = True
	Else
	  AddImailDomain = False
	End If	  

  End Function
  '*****************************************************************************************
  
  'Deleting mail domain
  Function DeleteImailDomain(sHost) 
	on error resume next
	Dim strcommand
    Dim whs
    Dim whsRun	
    strcommand = sMailServerPath & "\adddomain.exe "
    strcommand = strcommand & "-h" & sHost & " -delete" 
	WriteLogLine(strcommand)
    Set whs = server.createobject("WScript.Shell")
    whsRun = whs.Run(strcommand, 0, True)
    Set whs = nothing
	WriteLogLine(whsRun)

	If err.number<>0 Then
	  DeleteImailDomain = True
	Else
	  DeleteImailDomain = False
	End If	  

  End Function
  '*****************************************************************************************

  'Adding new mail alias to IMail
  Function AddImailAlias(sHost,sAlias,sEmail) 
	
	Dim objExecutor
	Dim sResult	

	Dim strcommand
    Dim whs
    Dim whsRun	
    strcommand = sMailServerPath & "\addalias.exe " 
    strcommand = strcommand & " -h " & sHost & " -a " & sAlias & " " & sEmail
    Set whs = server.createobject("WScript.Shell")
    whsRun = whs.Run(strcommand, 0, True)
    Set whs = nothing
	WriteLogLine(whsRun)

	If err.number<>0 Then
	  AddImailAlias = True
	Else
	  AddImailAlias = False
	End If	  

  End Function
  '*****************************************************************************************
  
  'Modifying mail alias
  Function ModifyImailAlias(sHost,sAlias,sEmail) 
	
	Dim strcommand
    Dim whs
    Dim whsRun	
    strcommand = sMailServerPath & "\addalias.exe "
    strcommand = strcommand &  "-h " & sHost & " -m " & sAlias & " " & sEmail
    Set whs = server.createobject("WScript.Shell")
    whsRun = whs.Run(strcommand, 0, True)
    Set whs = nothing
	WriteLogLine(whsRun)

	If err.number<>0 Then
	  ModifyImailAlias = True
	Else
	  ModifyImailAlias = False
	End If	  

  End Function
  '****************************************************************************************
  
  'Deleting mail alias
  Function DeleteImailAlias(sHost,sAlias) 
	Dim strcommand
    Dim whs
    Dim whsRun	
    strcommand =sMailServerPath & "\addalias.exe " 
    strcommand = strcommand &  "-h " & sHost & " -d " & sAlias
    Set whs = server.createobject("WScript.Shell")
    whsRun = whs.Run(strcommand, 0, True)
    Set whs = nothing
	WriteLogLine(whsRun)

	If err.number<>0 Then
	  DeleteImailAlias = True
	Else
	  DeleteImailAlias = False
	End If	  

  End Function
  '****************************************************************************************  
%>