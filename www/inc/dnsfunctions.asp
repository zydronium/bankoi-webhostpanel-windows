<%

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
'-----------------------------------------------------------------------------------------------

Function makeDNSEntries(sDomainName, sIP, nDomainId) 
	on error resume next
	'query ="insert into dns_data (domainid, domain, host, modifier, rside, rectype) values ("& nDomainId &", '"& sDomainName &"', '', '', '"& sIP &"', 'A')"
	'con.execute query
	'query ="insert into dns_data (domainid, domain, host, modifier, rside, rectype) values ("& nDomainId &", '"& sDomainName &"', 'www', '', '"& sIP &"', 'A')"
	'con.execute query
	'query ="insert into dns_data (domainid, domain, host, modifier, rside, rectype) values ("& nDomainId &", '"& sDomainName &"', 'ftp', '', '"& sIP &"', 'A')"
	'con.execute query
	'query ="insert into dns_data (domainid, domain, host, modifier, rside, rectype) values ("& nDomainId &", '"& sDomainName &"', 'mail', '', 'mail.korksoft.com', 'CNAME')"
	'con.execute query
	'query ="insert into dns_data (domainid, domain, host, modifier, rside, rectype) values ("& nDomainId &", '"& sDomainName &"', '', '10', 'mail."& sDomainName &"', 'MX')"
	'con.execute query
end function
'-----------------------------------------------------------------------------------------------



Function copyDNSEntriesDomain(domainID,domainName,ipAddress,resellerID)
	set rsDNS = server.CreateObject("ADODB.RecordSet")
	query = "select * from tbldnstemplate where resellerid ='" & resellerID & "'"
	rsDNS.open query,con

	if(not rsDNS.eof) then
			while(not rsDNS.eof)
						host = rsDNS("host")
						host = replace(host,"<domain>",domainName)
						recordType = rsDNS("recordtype")
						recordValue = rsDNS("value")
						recordValue = replace(recordValue,"<domain>",domainName)
						recordValue = replace(recordValue,"<ip>",ipAddress)

						MXpref = rsDNS("mxpref")
						'query = "insert into tbldnsdomain (domainid,host,recordtype,value, mxpref) values ('" & domainID & "','" & host & "','" & recordType & "','" & recordValue & "', '" & MXpref & "')"
						query ="insert into dns_data (domainid, domain, host, modifier, rside, rectype) values ("& domainID &", '"& domainName &"', '" & host & "', '" & MXpref & "', '" & recordValue & "', '" & recordType & "')"
						con.execute (query)

						if(Ucase(recordType) = "A") then
									createNewARedord domainName, host, recordValue
						elseif(Ucase(recordType) = "MX") then
									createNewMXRedord domainName, recordType, recordValue, MXpref
						elseif(Ucase(recordType) = "CNAME") then
									createNewCNAMERedord domainName, host, recordValue
						End if
					rsDNS.movenext
			wend
	end if

	createNewNSRedord domainName, host

	set rsDNS = Nothing
End Function

'-----------------------------------------------------------------------------------------------



Function CreatePrimaryZone(strNewZone, ipAddress, emailAdd)
	ON ERROR RESUME NEXT
	strMasterIP = Array(ipAddress)
	Set ObjSvc = GetObject("winMgmts:\\" & strServer & "\root\MicrosoftDNS")
    Set objDNSSet = ObjSvc.Get("MicrosoftDNS_Zone")

	if(SERVER_VERSION="2003") then
			errResult = objDNSSet.CreateZone(strNewZone, "0")
	elseif(SERVER_VERSION="2000") then
			errResult = objDNSSet.CreateZone(strNewZone, "1")
	end if
End Function

'-----------------------------------------------------------------------------------------------


Function createNewARedord(strDomain, host, strIPAddress)
	strContainer = strDomain
	strOwner = host 
	intRecordClass = 1
	intTTL = 600

	Set objWMIService = GetObject("winmgmts:\\" & strServer & "\root\MicrosoftDNS")
	Set objItem = objWMIService.Get("MicrosoftDNS_AType")
	errResult = objItem.CreateInstanceFromPropertyData(strServer, strContainer,strOwner , intRecordClass, intTTL, strIPAddress)

	writeLogLine "Creating new A Record" & errResult
	set objWMIService = Nothing
	set objItem = Nothing

	UpdateZonesFiles strDomain
End Function

'-----------------------------------------------------------------------------------------------



Function createNewNSRedord(strDomain, recordValue)
	ON ERROR RESUME NEXT
		
	strContainer = strDomain
	strOwner = strDomain
	intRecordClass = 1
	intTTL = 600 
	strNSHost = nameServer1
	 
	Set objWMIService = GetObject("winmgmts:\\" & strServer & "\root\MicrosoftDNS")
	Set objItem = objWMIService.Get("MicrosoftDNS_NSType")
	
	errResult = objItem.CreateInstanceFromPropertyData(strServer, strContainer, strOwner, intRecordClass, intTTL, strNSHost)

	strNSHost = nameServer2
	errResult = objItem.CreateInstanceFromPropertyData(strServer, strContainer, strOwner, intRecordClass, intTTL, strNSHost)

	set objWMIService = Nothing
	set objItem = Nothing

	UpdateZonesFiles strDomain
End Function

'-----------------------------------------------------------------------------------------------


Function createNewMXRedord(strDomain, recordType, recordValue, MXpref)
	ON ERROR RESUME NEXT
	strContainer = strDomain
	strOwner = strDomain
	intRecordClass = 1
	intTTL = 600 
	intPreference = MXpref
	strMailExchanger = recordValue
	 
	Set objWMIService = GetObject("winmgmts:\\" & strServer & "\root\MicrosoftDNS")
	Set objItem = objWMIService.Get("MicrosoftDNS_MXType")
	errResult = objItem.CreateInstanceFromPropertyData(strServer, strContainer, strOwner, intRecordClass, intTTL,intPreference, strMailExchanger)
	
	set objWMIService = Nothing
	set objItem = Nothing

	UpdateZonesFiles strDomain
End Function

'-----------------------------------------------------------------------------------------------


Function createNewCNAMERedord(strDomain, host, recordValue)
	ON ERROR RESUME NEXT
	strContainer = strDomain
	strOwner = host
	intRecordClass = 1
	intTTL = 600 
	intPreference = recordValue
	 
	Set objWMIService = GetObject("winmgmts:\\" & strServer & "\root\MicrosoftDNS")
	Set objItem = objWMIService.Get("MicrosoftDNS_CNAMEType")
	errResult = objItem.CreateInstanceFromPropertyData(strServer, strContainer, strOwner, intRecordClass, intTTL,intPreference)
	
	set objWMIService = Nothing
	set objItem = Nothing

	UpdateZonesFiles strDomain

End Function

'--------------------------------------------------------------------------------------------------


Function ageAllRecords(strZone)
		strComputer = strServer
		Set objWMIService = GetObject ("winmgmts:\\" & strServer & "\root\MicrosoftDNS")
		Set colItems = objWMIService.ExecQuery("Select * from MicrosoftDNS_Zone Where Name ='" & strZone &"'")
		For Each objItem in colItems
		errResult = objItem.AgeAllRecords(,1)
		Next
End Function 


'-------------------------------------------------------------------------------------------------

Function changeZoneType(strZone)
		intPrimaryZone = 1
		strComputer = strServer
		Set objWMIService = GetObject("winmgmts:\\" & strServer & "\root\MicrosoftDNS")
		Set colItems = objWMIService.ExecQuery("Select * from MicrosoftDNS_Zone Where Name ='" & strZone &"'")
		For Each objItem in colItems
			errResult = objItem.ChangeZoneType(intPrimaryZone, true)
		Next
End Function


'--------------------------------------------------------------------------------------------------
'This function delets the record with a given ID from the .dns file

Function DeleteRecords(recordID)
	
	query = "select * from dns_data where  id ='" & recordID & "'"
	set rsRecord = Server.CreateObject("ADODB.Recordset")
	rsRecord.open query,con

	if(Not rsRecord.EOF) then
		domainName = rsRecord("domain")
		host = rsRecord("host")
		recordValue = rsRecord("rside")
		recType = rsRecord("rectype")
		rank = rsRecord("modifier")
		if(not Ucase(host) = Ucase(domainName)) then
		    pos = Instr(host,".")
			modHost = Left(host,pos-1)
		else
			modHost = "@"
		end if


		if(Ucase(rectype) = "A") then
			str = modHost & "                     A	" &    recordValue
		elseif(Ucase(rectype) = "MX") then
			str = modHost & "                       MX	" & rank & "	" & recordValue
		elseif(Ucase(rectype) = "CNAME") then
			str = modHost & "                    CNAME	" & recordValue
		end if


		'response.Write("<br>The record to delete is " & str & "<br><br><br><br>")
		Set fso = CreateObject("Scripting.FileSystemObject")
		Set ts = fso.OpenTextFile(databaseDNSFile & domainName & ".dns")
		do while ts.AtEndOfStream = false
			s = ts.ReadLine
			if(not Ucase(str) = Ucase(s)) then
				'response.write "False:  " & s & "<br>"
				strFile = strFile & s & vbcrlf
			end If
		loop
		ts.Close
		'response.write "The contents are " & strFile & "<br>"
		
		Set objFSO= Nothing
		Set objFSO = Server.CreateObject("Scripting.FileSystemObject")

		'Here we r rewriting the dns file
		'-------------------------------------------------------------------------------------
		pathToFile = databaseDNSFile & domainName & ".dns"
		set objFilWrite = objFSO.OpenTextFile(pathToFile, fsoForWriting, True)
		objFilWrite.Write strFile
		objFilWrite.Close
		Set objFilWrite=Nothing

		'Here we r reloading the dns zone
		reloadZones(domainName)
	end if
End Function


'---------------------------------------------------------------------------------------------
'This function delets the zone from the registry

Function DeleteZone(zoneName)
	ON ERROR RESUME NEXT
	strComputer = strServer
	Set objWMIService = GetObject("winmgmts:\\" & strServer & "\root\MicrosoftDNS")
	set objServer = objWMIService.Get("MicrosoftDNS_Server.name="".""")
    Set objDNS = objWMIService.Get("MicrosoftDNS_Zone.ContainerName=""" & zoneName & """,DnsServerName=""" & objServer.Name & """,Name=""" & zoneName & """")
    objDns.Delete_
	Set objWMIService = Nothing
	set objServer = Nothing
    Set objDNS = Nothing

	reloadZones(zoneName)
End Function


'---------------------------------------------------------------------------------------------

Function reloadZones(zoneName)
	'ON ERROR RESUME NEXT
	Set objWMIService = GetObject("winmgmts:\\" & strComputer & "\root\MicrosoftDNS")
	set objServer = objWMIService.Get("MicrosoftDNS_Server.name="".""")
    Set objDNS = objWMIService.Get("MicrosoftDNS_Zone.ContainerName=""" & zoneName & """,DnsServerName=""" & objServer.Name & """,Name=""" & zoneName & """")
    objDns.ReloadZoneFromItsDatabase
	Set objWMIService = Nothing
	set objServer = Nothing
    Set objDNS = Nothing
End Function


'---------------------------------------------------------------------------------------------


Function UpdateZonesFiles(zoneName)
	ON ERROR RESUME NEXT
	strComputer = strServer
	Set objWMIService = GetObject("winmgmts:\\" & strComputer & "\root\MicrosoftDNS")
	Set colItems = objWMIService.ExecQuery("Select * from MicrosoftDNS_Zone Where Name = '" & zoneName& "'")
	For Each objItem in colItems
		objItem.UpdateFromDS()
	Next

	Set colItems = Nothing

	Set colItems = objWMIService.ExecQuery("Select * from MicrosoftDNS_Zone Where Name = '" & zoneName& "'")
	For Each objItem in colItems
		objItem.WriteBackZone()
	Next

	Set objWMIService = Nothing
	set colItems = Nothing
End Function



'----------------------------------------------------------------------------------------------------------------------------------------------------------


Function UpdateARecord(strDomain,newIpAddress,oldIpAddress,ownerName)
	ON ERROR RESUME NEXT
	Response.Write "The IP address is " & newIpAddress & "<br>" & "<br>"

	intTTL = 600 
	Set objWMIService = GetObject ("winmgmts:\\" & strServer & "\root\MicrosoftDNS")
	Set colItems = objWMIService.ExecQuery("Select * from MicrosoftDNS_AType where ownername='" & ownerName & "' and recorddata='" & oldIpAddress &"'")
	
	For Each objItem in colItems
		Result = objItem.Modify(intTTL,newIpAddress)
	Next

	UpdateZonesFiles strDomain
End Function


'----------------------------------------------------------------------------------------------------------------------------------------------------------

Function DeleteARecords(strDomain,oldIpAddress,ownerName)
	ON ERROR RESUME NEXT
	intTTL = 600 
	Set objWMIService = GetObject ("winmgmts:\\" & strServer & "\root\MicrosoftDNS")
	Set colItems = objWMIService.ExecQuery("Select * from MicrosoftDNS_AType where ownername='" & ownerName & "' and recorddata='" & oldIpAddress &"'")

	For Each objItem in colItems
		objItem.delete_
	Next
	UpdateZonesFiles strDomain
End Function
'----------------------------------------------------------------------------------------------------------------------------------------------------------


Function UpdateMXRecord(strDomain,MailExchange,Preference,MailExchange_Old,Preference_Old)
	ON ERROR RESUME NEXT
	intTTL = 600 
	Set objWMIService = GetObject ("winmgmts:\\" & strServer & "\root\MicrosoftDNS")
	Set colItems = objWMIService.ExecQuery("Select * from MicrosoftDNS_MXType where mailExchange='" & MailExchange_Old & "' and preference=" & Preference_Old &"")
	For Each objItem in colItems
		Result = objItem.Modify(intTTL,Preference,MailExchange)
	Next
	UpdateZonesFiles strDomain
End Function



'----------------------------------------------------------------------------------------------------------------------------------------------------------

Function DeleteMXRecords(strDomain,MailExchange_Old,Preference_Old)
	ON ERROR RESUME NEXT
	intTTL = 600 
	Set objWMIService = GetObject ("winmgmts:\\" & strServer & "\root\MicrosoftDNS")
	Set colItems = objWMIService.ExecQuery("Select * from MicrosoftDNS_MXType where mailExchange='" & MailExchange_Old & "' and preference=" & Preference_Old &"")
	For Each objItem in colItems
		objItem.delete_
	Next
	UpdateZonesFiles strDomain
End Function

'----------------------------------------------------------------------------------------------------------------------------------------------------------



Function UpdateCNAMERecord(strDomain,primaryName,primaryName_Old)
	ON ERROR RESUME NEXT
	intTTL = 600 
	Set objWMIService = GetObject ("winmgmts:\\" & strServer & "\root\MicrosoftDNS")
	Set colItems = objWMIService.ExecQuery("Select * from MicrosoftDNS_CNAMEType where ownername='" & primaryName_Old & "'")
	For Each objItem in colItems
		Result = objItem.Modify(intTTL,primaryName)
	Next
	UpdateZonesFiles strDomain
End Function



'----------------------------------------------------------------------------------------------------------------------------------------------------------

Function DeleteCNAMERecords(strDomain,primaryName_Old)
	ON ERROR RESUME NEXT
	intTTL = 600 
	Set objWMIService = GetObject ("winmgmts:\\" & strServer & "\root\MicrosoftDNS")
	Set colItems = objWMIService.ExecQuery("Select * from MicrosoftDNS_CNAMEType where ownername='" & primaryName_Old & "'")
	
	For Each objItem in colItems
		objItem.delete_
	Next
	UpdateZonesFiles strDomain
End Function

'----------------------------------------------------------------------------------------------------------------------------------------------------------


%>