<%
'------------------------------------------------------------------------------------
'Adds The Postioffice to the domain directory with the username as the ftp username
'------------------------------------------------------------------------------------
Function CreatePostOffice(sMailDir, PostOfficeName, MailBox, MailBoxPasswd)
	set oPostoffice = server.CreateObject("MEAOPO.Postoffice")
	With oPostoffice
		.name = PostOfficeName
		.Account = PostOfficeName
		.status = 1
		.AddPostoffice()
	end with

	Set oMEOption = server.CreateObject("MEAOSO.Option")
	oMEOption.Query = PostOfficeName
	oMEOption.Scope = 1
	oMEOption.ValueName = "MAILROOT"
	oMEOption.Value = sMailDir 
	oMEOption.SetOption
	Set oMEOption = Nothing

	set oDomain = server.CreateObject("MEAOSM.Domain")
	With oDomain
		.DomainName = PostOfficeName
		.AccountName = PostOfficeName
		.status = 1
		.AddDomain()
	end with
	
	
	if len(MailBox)>0 then

		if len(PostOfficeName)=0 or len(MailBoxPasswd)=0 then
			WriteLogLine "Details not proper for creating the POSTBOX for the domain " & PostOfficeName
			response.end
		end if
		
		if len(sErr)=0 then
			sMailRoot = sMailDir		
			'---------------------------------------------------------
			'Creating the Objects
			'MEAOPO     Contains Post Office administration functions
			'MEAOAU     Contains authentication functions
			'---------------------------------------------------------
			set oMailbox = server.CreateObject("MEAOPO.Mailbox")
			set oAUTHLogin = server.CreateObject("MEAOAU.Login")
	
			With oMailbox
				.Postoffice = PostOfficeName
				.Mailbox = MailBox
				.Limit = -1
				.RedirectAddress = ""
				.RedirectStatus = 0
				.Status = 1
				lResult = oMailbox.AddMailbox()
			End With
	
			if lResult = 0 then
				WriteLogLine "MAIL ENABLE = Could not add mailbox. Make sure it doesn't already exist."
			end if

			Dim lResult, oAddressMap
			Set oAddressMap = CreateObject("MEAOAM.AddressMap")
			oAddressMap.Account = PostOfficeName
			oAddressMap.DestinationAddress = "[SF:" & PostOfficeName & "/" & MailBox & "]"
			oAddressMap.Scope = ""
			oAddressMap.SourceAddress = ConvertToMESMTPAddress(MailBox & "@" & PostOfficeName)
			lResult = oAddressMap.AddAddressMap()
		
			'When we create a mailbox we also create a pop logon
			'---------------------------------------------------------
			With oAUTHLogin
				.Account = PostOfficeName
				.Description = ""
				.Password = MailBoxPasswd
				.Rights = "ADMIN"
				.Status = 1
				.UserName = MailBox & "@" & PostOfficeName
			End With
				
			lResult = oAUTHLogin.AddLogin()

			if lResult = 0 then
				WriteLogLine "MAIL ENABLE = Could not add password."
			end if
	
			'we have to create the directories as well.. later providers will do this automatically
			set oFSO = server.CreateObject("Scripting.FileSystemObject")
		
			'is the post office there?
			If Not oFSO.FolderExists(sMailRoot & "\" & PostOfficeName) Then
				oFSO.CreateFolder sMailRoot & "\" & PostOfficeName
				If err.number=0 Then 
					WriteLogLine "The Postoffice folder created"
				else
					WriteLogLine "ERROR = Creating Postoffice folder for domain " & PostOfficeName
				end if
			End If
	
			'is the mailroot there?
			If Not oFSO.FolderExists(sMailRoot & "\" & PostOfficeName & "\mailroot") Then
				oFSO.CreateFolder sMailRoot & "\" & PostOfficeName & "\mailroot"
				If err.number=0 Then 
					WriteLogLine "The MAILROOT folder created"
				else
					WriteLogLine "ERROR = Creating MAILROOT folder for domain " & PostOfficeName
				end if
			End If
	
			If Not oFSO.FolderExists(sMailRoot & "\" & PostOfficeName & "\mailroot\" & MailBox) Then
				oFSO.CreateFolder sMailRoot & "\" & PostOfficeName & "\mailroot\" & MailBox
				If err.number=0 Then 
					WriteLogLine "The Mailbox folder created"
				else
					WriteLogLine "ERROR = Creating Mailbox folder for domain " & PostOfficeName
				end if
			End If
	
			'also create the inbox
			If Not oFSO.FolderExists(sMailRoot & "\" & PostOfficeName & "\mailroot\" & MailBox & "\inbox") Then
				oFSO.CreateFolder sMailRoot & "\" & PostOfficeName & "\mailroot\" & MailBox & "\inbox"
				If err.number=0 Then 
					WriteLogLine "The Inbox folder created"
				else
					WriteLogLine "ERROR = Creating Inbox folder for domain " & PostOfficeName
				end if
			End If


		End if
	End if
End Function
'--------------------------------------------------------------------------------------------------------


'--------------------------------------------------------------------------------------------------------
'This function adds an email user to the domain
'--------------------------------------------------------------------------------------------------------
Function AddMElUser(sMailDir, PostOfficeName, MailBox, MailBoxPasswd)
	set oPostoffice = server.CreateObject("MEAOPO.Postoffice")
	With oPostoffice
		.name = PostOfficeName
		.Account = PostOfficeName
		.status = 1			
	end with
	sMailDir = oPostoffice.GetMailRootDirectory()


	if len(sErr)=0 then
			sMailRoot = sMailDir 
			'---------------------------------------------------------
			'Creating the Objects
			'MEAOPO     Contains Post Office administration functions
			'MEAOAU     Contains authentication functions
			'---------------------------------------------------------
			set oMailbox = server.CreateObject("MEAOPO.Mailbox")
			set oAUTHLogin = server.CreateObject("MEAOAU.Login")
	
			With oMailbox
				.Postoffice = PostOfficeName
				.Mailbox = MailBox
				.Limit = -1
				.RedirectAddress = ""
				.RedirectStatus = 0
				.Status = 1
				lResult = oMailbox.AddMailbox()
			End With
	
			if lResult = 0 then
				WriteLogLine "MAIL ENABLE = Could not add mailbox. Make sure it doesn't already exist."
			end if
		

			Dim lResult, oAddressMap
			Set oAddressMap = CreateObject("MEAOAM.AddressMap")
			oAddressMap.Account = PostOfficeName
			oAddressMap.DestinationAddress = "[SF:" & PostOfficeName & "/" & MailBox & "]"
			oAddressMap.Scope = ""
			oAddressMap.SourceAddress = ConvertToMESMTPAddress(MailBox & "@" & PostOfficeName)'"[SMTP:" & PostOfficeName & "/" & MailBox & "]"
			lResult = oAddressMap.AddAddressMap()


			'When we create a mailbox we also create a pop logon
			'---------------------------------------------------------
			With oAUTHLogin
				.Account = PostOfficeName
				.Description = ""
				.Password = MailBoxPasswd
				.Rights = "USER"
				.Status = 1
				.UserName = MailBox & "@" & PostOfficeName
			End With
				
			lResult = oAUTHLogin.AddLogin()

			if lResult = 0 then
				WriteLogLine "MAIL ENABLE = Could not add password."
			end if
		End if
End Function

'--------------------------------------------------------------------------------------------------------



'--------------------------------------------------------------------------------------------------------
'This function removes the users Postoffice from the server
'--------------------------------------------------------------------------------------------------------
Function RemoveMElUser(PostOfficeName, MailBox)
'response.write "The mail box name is " & MailBox
	If len(sErr) = 0 then
			sMailRoot = sMailServerPath		
			' ---------------------------------------------------------
			' Creating the Objects
			' MEAOPO     Contains Post Office administration functions
			' MEAOAU     Contains authentication functions
			' ---------------------------------------------------------
			set oMailbox = server.CreateObject("MEAOPO.Mailbox")
			set oAUTHLogin = server.CreateObject("MEAOAU.Login")
			MailBox = split(MailBox,"@") 
			With oMailbox
				.Postoffice = PostOfficeName
				.Mailbox = MailBox(0)
				.Limit = -1
				.RedirectAddress = ""
				.RedirectStatus = 0
				lResult = oMailbox.RemoveMailbox()
			End With

			' Last of all we will remove the login that is used to authenticate access to the mailbox

			set oLogin = server.CreateObject("MEAOAU.Login")
			oLogin.Account = PostofficeName
			oLogin.LastAttempt = -1
			oLogin.LastSuccessfulLogin = -1
			oLogin.LoginAttempts = -1
			oLogin.Password  = ""
			oLogin.Rights = ""
			oLogin.Status  = -1
			oLogin.UserName = MailBox(0) & "@" & PostofficeName
			If oLogin.RemoveLogin() <> 1 Then
				Response.Write "Unable to Remove Mailbox Login"
			End If
			Set oLogin = Nothing

			Dim lResult, oAddressMap
			Set oAddressMap = CreateObject("MEAOAM.AddressMap")
			oAddressMap.Account = PostOfficeName
			oAddressMap.DestinationAddress = "[SF:" & PostOfficeName & "/" & MailBox(0) & "]"
			oAddressMap.Scope = ""
			oAddressMap.SourceAddress = ConvertToMESMTPAddress(MailBox(0) & "@" & PostOfficeName)'"[SMTP:" & PostOfficeName & "/" & MailBox & "]"
			lResult = oAddressMap.RemoveAddressMap()
			set oAddressMap=nothing
			ResetCatchAll PostOfficeName

			set oFSO = server.CreateObject("Scripting.FileSystemObject")
			'is the post office there?
			If oFSO.FolderExists(sMailRoot & "\" & PostOfficeName & "\MAILROOT\" &  MailBox(0)) Then
				oFSO.DeleteFolder sMailRoot & "\" & PostOfficeName & "\MAILROOT\" &  MailBox(0)
				If err.number=0 Then 
					WriteLogLine "The user folder deleted for domain " & PostOfficeName
				else
					WriteLogLine "ERROR = Deleting user folder for domain " & PostOfficeName
				end if
			End If
	End if
End Function

'--------------------------------------------------------------------------------------------------------


'--------------------------------------------------------------------------------------------------------
'This function changes the password for a particular account
'-----------------------------------------------------------------------------------------------
Function ChangeMElPassword(PostofficeName,username, NewPassword)
	sMailRoot = sMailServerPath		
	'response.write "Changing Password"
	Set oLogin = CreateObject("MEAOAU.Login")
	'username = split(username,"@") 
	oLogin.Account = PostofficeName
	oLogin.Description = "" 
	oLogin.Rights = "USER" 
	oLogin.Status = 1 
	oLogin.UserName = username & "@" & PostofficeName
	oLogin.getLogin() 
	WriteLogLine("ChangeMEPass: Postoffic "& oLogin.Password & " ; " & username)
	ChangeResult = oLogin.EditLogin(username & "@" & PostofficeName,1,NewPassword,PostofficeName , "", 0, 0, 0, "USER") 
	WriteLogLine("ChangeMEPass: "& ChangeResult)
End Function 
'-----------------------------------------------------------------------------------------------


'--------------------------------------------------------------------------------------------------------
'This Function delets the POSTOFFICE The postoffice is deleted when the domain is deleted
'-----------------------------------------------------------------------------------------------
Function DeletePostoffice(PostOfficeName)
		sMailRoot = sMailServerPath
		set oDomain = server.CreateObject("MEAOSM.Domain")
		With oDomain
			.DomainName = PostOfficeName
			.AccountName = PostOfficeName
			.status = 1
			.RemoveDomain()
		end with

		Set oPostoffice = CreateObject("MEAOPO.Postoffice")
		Set oFSO = CreateObject("Scripting.FileSystemObject")
		oPostoffice.Account = PostOfficeName
		oPostoffice.Name = PostOfficeName
		oPostoffice.Status = 1
		sMailDir = oPostoffice.GetMailRootDirectory()
		lResult = oPostoffice.RemovePostoffice()		
		If oFSO.FolderExists(sMailDir & "\Postoffices\" & PostOfficeName) Then
		oFSO.DeleteFolder sMailDir & "\Postoffices\" & PostOfficeName, True
		End If	
		
		set oFSO = server.CreateObject("Scripting.FileSystemObject")
	'is the post office there?
			If oFSO.FolderExists(sMailRoot & "\" & PostOfficeName) Then
				oFSO.DeleteFolder sMailRoot & "\" & PostOfficeName
				If err.number=0 Then 
					WriteLogLine "The Postoffice folder deleted for domain " & PostOfficeName
				else
					WriteLogLine "ERROR = Deleting Postoffice folder for domain " & PostOfficeName
				end if
			End If
End Function
'-----------------------------------------------------------------------------------------------



'-----------------------------------------------------------------------------------------------
'This function creats an email alias
'-----------------------------------------------------------------------------------------------
Function CreateAlias(PostofficeName, Aliasname, Redirectadd)
	set oMailbox = server.CreateObject("MEAOPO.Mailbox")
	
	With oMailbox
		.Postoffice = PostOfficeName
		.Mailbox = Aliasname
		.RedirectAddress = ConvertToMESMTPAddress(Redirectadd)
		.RedirectStatus = 1
		.Status = 1
		.Limit= -1
	End With
		lResult = oMailbox.AddMailbox()

			Set oAddressMap = CreateObject("MEAOAM.AddressMap")
			oAddressMap.Account = PostOfficeName
			oAddressMap.DestinationAddress = "[SF:" & PostOfficeName & "/" & Aliasname & "]"
			oAddressMap.Scope = ""
			oAddressMap.SourceAddress = ConvertToMESMTPAddress(Aliasname & "@" & PostOfficeName)'"[SMTP:" & PostOfficeName & "/" & Aliasname & "]"
			lResult = oAddressMap.AddAddressMap()

			
	set oAUTHLogin = server.CreateObject("MEAOAU.Login")
	'When we create a mailbox we also create a pop logon
	'---------------------------------------------------------
	With oAUTHLogin
		.Account = PostOfficeName
		.Description = ""
		.Password = "123456"
		.Rights = "USER"
		.Status = 1
		.UserName = Aliasname & "@" & PostOfficeName
	End With
	lResult = oAUTHLogin.AddLogin()
End Function
'-----------------------------------------------------------------------------------------------


'-----------------------------------------------------------------------------------------------
'Function edits the redirection address of the email alias
'-----------------------------------------------------------------------------------------------
Function ChangeRedirectAdd(PostOfficeName,Aliasname,Redirectadd)
	set oMailbox = server.CreateObject("MEAOPO.Mailbox")
	With oMailbox
		.Postoffice = PostOfficeName
		.Mailbox = Aliasname	
		.RedirectAddress = ConvertToMESMTPAddress(Redirectadd)
		.RedirectStatus = 1
		.Status = 1
		.Limit= -1
	End With
	'lResult = oMailbox.GetMailbox()
	lResult = oMailbox.EditMailbox(PostOfficeName, Aliasname, ConvertToMESMTPAddress(Redirectadd), 1, 1,-1,-1) 
End Function
'-----------------------------------------------------------------------------------------------

'-----------------------------------------------------------------------------------------------
Function SetCatchAll(PostOfficeName,Redirectadd)
	Set oAddressMap = Server.CreateObject("MEAOAM.AddressMap")
	NewAccount = PostOfficeName
	NewSourceAddress = "[SMTP:*@" & PostOfficeName & "]"
	NewDestinationAddress = "[SF:" & PostOfficeName & "/" & Redirectadd & "]"	
	NewScope = ""
	
	oAddressMap.Account = PostOfficeName
	oAddressMap.SourceAddress = "[SMTP:*@" & PostOfficeName & "]"
	oAddressMap.DestinationAddress = ""
	oAddressMap.Scope = ""
	if(oAddressMap.GetAddressMap() = 1) then
		WriteLogLine "EditAddressfound Updating"
		If oAddressMap.EditAddressMap(NewAccount,NewSourceAddress,NewDestinationAddress,NewScope) <> 1 Then
			WriteLogLine "EditAddressFailed. Adding New"
		else
			WriteLogLine "EditAddress Success. "
		end if
	else
		WriteLogLine "GetAddressMap Failed"
		'
		' We need to add it because there was not one defined  
		'
		oAddressMap.SourceAddress = "[SMTP:*@" & PostOfficeName & "]"
		oAddressMap.DestinationAddress = "[SF:" & PostOfficeName & "/" & Redirectadd & "]"
		oAddressMap.Scope = ""
		oAddressMap.Account = PostOfficeName
		oAddressMap.AddAddressMap
	End If
	set oAddressMap = nothing
End Function
'-----------------------------------------------------------------------------------------------

'-----------------------------------------------------------------------------------------------
'Function edits the redirection address of the email alias
'-----------------------------------------------------------------------------------------------
Function ResetCatchAll(PostOfficeName)
	Set oAddressMap = Server.CreateObject("MEAOAM.AddressMap")
	oAddressMap.SourceAddress = "[SMTP:*@" & PostOfficeName & "]"
	oAddressMap.DestinationAddress =  ""
	oAddressMap.Scope = ""	'
	' Change its value if it exists	'
	If oAddressMap.EditAddressMap(PostOfficeName,"[DELETE:ME]","[DELETE:ME]","0") Then
		oAddressMap.Account = PostOfficeName
		oAddressMap.DestinationAddress = "[DELETE:ME]" 
		oAddressMap.SourceAddress = "[DELETE:ME]"
		oAddressMap.Scope = "0"
		Result = oAddressMap.RemoveAddressMap
	End If
	set oAddressMap = nothing
End Function
'-----------------------------------------------------------------------------------------------

'-----------------------------------------------------------------------------------------------
'The function is called when the redirect address has to be formated
'-----------------------------------------------------------------------------------------------
Function ConvertToMESMTPAddress(ByVal MEAddress)
		If left(MEAddress,6) <> "[SMTP:" Then
			ConvertToMESMTPAddress = "[SMTP:" & MEAddress & "]"
		Else
			ConvertToMESMTPAddress = MEAddress
		End If
End Function
'-----------------------------------------------------------------------------------------------
%>