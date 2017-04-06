<%
	accessLevel = 5
%>
<!-- #INCLUDE FILE = "../inc/security.asp" -->
<!-- #INCLUDE FILE="../inc/db.asp" -->
<!-- #INCLUDE FILE="../inc/params.asp" -->
<!-- #INCLUDE FILE="../inc/functions.asp" -->
<!-- #INCLUDE FILE="../inc/dbfunctions.asp" -->
<!-- #INCLUDE FILE="../inc/dnsfunctions.asp" -->

<%
dim arr
dim count
count=0
'Here we are extracting the name of the Client for the domain selected

dim clientName

arr=split(request("chk"),",") 
domainname=split(request("domainname"),",")
'response.write arr(1)

  for i=lbound(arr) to ubound(arr)
        '-----------------------------------------------------------------------------------		  
		' CreateDirs also create site in IIS
		query="select username,id from (tbldomain inner join tblloginmaster on resellerid=id) where tbldomain.domainid='" & trim(arr(i)) & "'"
		set rsname=server.createobject("ADODB.Recordset")
		rsname.open query,con
		if (not rsname.eof) then 
			clientname=rsname("username")
		end if
		query="select ftpusername from tblftpinfo where domainid='" & trim(arr(i)) & "' and type<>'D'"		
		set rs=server.createobject("ADODB.Recordset")
		rs.open query,con
		while (not rs.eof)  			
			result= DeleteFTPVirtualDirectory(rs("ftpusername"))		
		wend
		rs.close

		query="select ftpusername from tblftpinfo where domainid='" & trim(arr(i)) & "' and type='D'"		
		set rs=server.createobject("ADODB.Recordset")
		rs.open query,con
		if (not rs.eof) then 
			ftpusername=rs("ftpusername")
			query="select count(ftpusername) as ftpcount from tblftpinfo where ftpusername='" & ftpusername & "'"
			Set rsftpcount=Server.CreateObject("ADODB.Recordset")
			rsftpcount.open query,con
			dim userHostDir : userHostDir = sHostingDir & "\" & clientName & "\" & ftpusername 

			result=DeleteIISWebSite(trim(arr(i)),trim(domainname(i)))
			if(rsftpcount("ftpcount") > "1") then
				userHostDir = sHostingDir & "\" & clientName & "\" & ftpusername & "\" & trim(domainname(i))
'				result= DeleteFTPVirtualDirectory(ftpusername)		
'				result=  DeleteNTUser(ftpusername,sComputerName)
				result = DeleteDir(userHostDir)
			elseif(rsftpcount("ftpcount")="1") then
				userHostDir = sHostingDir & "\" & clientName & "\" & ftpusername
				result= DeleteFTPVirtualDirectory(ftpusername)		
				result= DeleteNTUser(ftpusername,sComputerName)
				result =DeleteDir(userHostDir)
			end if
		end if
		rs.close
		
		
		  
		DisableWebStat trim(domainname(i))  'Disabling the webstat for the selected domain

		'-----------------------------------------------------------------------------------
	    'Delete the user from the NT directory
		query="select username from manageusers where domainid='" & trim(arr(i)) & "'"
		set rs1=server.createobject("ADODB.Recordset")
		rs1.open query,con
		while(not rs1.eof) 
			user=rs1("username")
			DeleteNTUser user,sComputerName				
		wend
		rs1.close
		

		'-----------------------------------------------------------------------------------
		DeleteZone(trim(domainname(i)))

		'-----------------------------------------------------------------------------------
		' delete users created by this domain
		query="delete from manageusers where domainid='" & trim(arr(i)) & "'"		
		con.execute (query)
		'-----------------------------------------------------------------------------------
	    'Delete the host header
		query="delete from tblhostheader where domainid='" & trim(arr(i)) & "'"
		'response.write query
		con.execute query
	   '-----------------------------------------------------------------------------------
		set rs1=nothing
		query="delete from tbldomainpref  where domainid='" & trim(arr(i)) & "' "
		con.execute (query)

		strcontact="delete from tblcontactinfo where id='" & trim(arr(i)) & "'"
		con.execute(strcontact)
	
		strreseller="delete from tbldomain where domainid='" & trim(arr(i)) & "'"
	    con.execute(strreseller)

		dnsData = "delete from dns_data where domainid='" & trim(arr(i)) & "'"
	    con.execute(dnsData)

		strloginmaster="delete from tblloginmaster where id='" & trim(arr(i)) & "'"
		con.execute(strloginmaster)
		
		strftpinfo="delete from tblftpinfo where domainid='" & trim(arr(i)) & "'"
		con.execute(strftpinfo)
		
		strrights="delete from tblrights where id='" & trim(arr(i)) & "'"
		con.execute(strrights)

		str="delete from tbldirpass where id='" & trim(arr(i)) & "'"
		con.execute(str)

		query = "select * from tbldsn where id='" & trim(arr(i)) & "'"
		set recDSN=Server.CreateObject("ADODB.Recordset")
		recDSN.open query,con
		if(not recDSN.EOF) then
			While(Not recDSN.EOF)
					dsnType = recDSN("dbtype")
					dsnName = recDSN("dsnname")
					if(ucase(dsnType)=ucase("sqlServer")) then
							DeleteSQLDSN(dsnName)	  
					elseif(ucase(dsnType)=ucase("MySql")) then
							DeleteMySqlDSN(dsnName)
					elseif(ucase(dsnType)=ucase("Access")) then
						    DeleteAccessDSN dsnName
					end if
					recDSN.movenext
			Wend
		End if
		str="delete from tbldsn where id='" & trim(arr(i)) & "'"
		con.execute(str)

		str="update tblmailaddress set actiontype='0' where domainid='" & trim(arr(i)) & "'"
		con.execute(str)

		str="insert into tblmaildomain set id=" & trim(arr(i)) & ",domainname='" & trim(domainname(i)) & "',actiontype='0'"
		con.execute (str)

		set rsDB = server.createobject("ADODB.Recordset")
		rsDB.open "select id, type from cp_db_all where domain_id=" & trim(arr(i)), con
		while (not rsDB.eof )
			if(rsDB("type") = "mysql") then 
				result = DeleteMysqlDB(rsDB("id"))
			else
				result = DeleteMssqlDB(rsDB("id"))
			end if
		wend

		str="delete from cp_db_all where domain_id='" & trim(arr(i)) & "'"
		con.execute(str)
			
		'Function Used in case of IMAIL to delete the Imail Domain
		'---------------------------------------------------------
		if(ucase(sMailServer)="IMAIL") then
			call DeleteImailDomain(trim(domainname(i)))
		end if
		'Function Used in case of Mail Enable to delete the POSTOFFICE
		'---------------------------------------------------------
		if(ucase(sMailServer)="ME") then
			call DeletePostoffice(trim(domainname(i)))
		end if

		set rsname=nothing
		count=count+1
    	
  next          'End of for loop
  
'  response.write "Total " & count & " Domain deleted"
%>
<script>
if(<%=count%>==0)
	alert("<%=msgdomaindel%>")
else
  alert(<%=count%>+" <%=msgdomaindel1%>")
  window.location.replace("../server/domains.asp");
</script>