<%
	accessLevel = 5
%>
<!-- #INCLUDE FILE = "../inc/security.asp" -->
<!-- #INCLUDE FILE = "../inc/db.asp" -->
<!-- #INCLUDE FILE = "../inc/params.asp" -->
<!-- #INCLUDE FILE = "../inc/functions.asp" -->
<!-- #INCLUDE FILE="../inc/dnsfunctions.asp" -->


<%
  
   id=session("reselid")
  '------------------VARIABLES-----------------------------
  domainname=request("domain_name")
  ipaddress=request("ip_addr_id")
  popmailaccount=request("popmailaccount")
  ftpUser = request("ftpusername")
  'response.write "the ftpusername " & ftpUser
  ftpusers=request("noofftpusers")
  usernameftp=request("ftpusers") 'This gives the value from the combo box
  'response.write "the ftpusername " &usernameftp
  mssqldatabase=request("mssqldatabase")
  password=request("password")
  'response.write "the password " &password
  companyname=request("companyname")
  personalname=request("personalname")
  phone=request("phone")
  email=request("email") 
  address=request("address")
  city=request("city")
  states=request("state") 
  zipcode=request("zipcode") 
  country=request("country")
  emailalias=request("emailalias")
  webstart=request("webstart")
'---------------------------------------------------------------------------------------------------
 'Here we are checking if number of FTPusers,popmailaccount,emailalias,database are not exceeding the 
 'stipulated values assigned to the selected client.If they are exceeded then we have do deny him of
 'making new domain 
 'A==>stands for actual allowed
 query="select * from tblrights where id='" & id & "'"
 'response.write query
 dim rsaccount
 set rsaccount=Server.createobject("ADODB.RecordSet")
 rsaccount.open query,con
 if(rsaccount.eof) then
 %>
 <script>
	alert("<%=msgproblem%>");
	history.go(-1);
</script>
 <%
	response.end
 end if
 Aftpuser=cint(rsaccount("ftpusers"))
 'response.write "Aftpuser" & Aftpuser &"<br>"
 Apopmailaccount=clng(rsaccount("popmailaccount"))
 'response.write "Apopmailaccount"&Apopmailaccount&"<br>"
 Aemailalias=clng(rsaccount("emailalias"))
 'response.write "Aemailalias "&Aemailalias&"<br>"
 Adatabase=clng(rsaccount("sqldatabase"))
 'response.write "Adatabase"&Adatabase&"<br>"
 '---------------------------------------------------------------------------------------
 query="select count(domainid) as cntdomain from tbldomain where tbldomain.resellerid='" & id & "'"
 set rscountdomain=Server.createobject("ADODB.RecordSet")
 rscountdomain.open query,con
 if(not cint(rscountdomain("cntdomain"))=0)then
		'----------------------------------------------------------------------------------------------------
		'Calculating the total number of various account for the selected client
		query="select sum(tblrights.ftpusers) as ftp,sum(popmailaccount) as pop,sum(tblrights.emailalias) as alias,sum(tblrights.sqldatabase) as sqldatabase from (tbldomain inner join tblrights on tbldomain.domainid=tblrights.id) where tbldomain.resellerid='" & id & "'"
		'response.write query
		dim rsactual
		set rsactual=Server.createobject("ADODB.RecordSet")
		rsactual.open query,con
		
		'-----------------------------------------------------------------------------------------------------
		'Calculating total amount of allocated rights to the selected client including the data entered for
		'the new domain to be created
		Tftpuser=clng(rsactual("ftp"))+clng(ftpusers)
		'response.write "Tftpuser" & Tftpuser &"<br>"
		Tpopmailaccount=clng(rsactual("pop"))+clng(popmailaccount)
		'response.write "Tpopmailaccount" & Tpopmailaccount &"<br>"
		Temailalias=clng(rsactual("alias"))+clng(emailalias)
		'response.write "Temailalias" & Temailalias &"<br>"
		Tdatabase=clng(rsactual("sqldatabase"))+clng(mssqldatabase)
		'response.write "Tdatabase" & Tdatabase &"<br>"
 else
				Tftpuser=clng(ftpusers)
				Tpopmailaccount=clng(popmailaccount)
				Temailalias=clng(emailalias)
				Tdatabase=clng(mssqldatabase)
				'response.write "Tftpuser1" & Tftpuser &"<br>"
				'response.write "Tpopmailaccount1" & Tpopmailaccount &"<br>"
				'response.write "Temailalias1" & Temailalias &"<br>"
				'response.write "Tdatabase1" & Tdatabase &"<br>"
 end if


dim flag
flag=0
'-----------------------------------------------------------------------------------------
'Checking whether the clients limits are not exceeding the stipulated limits
if(not usernameftp="New User") then
	if(not cint(Aftpuser)=0) then
				if(Aftpuser < Tftpuser) then
%>

						<script>
							alert("<%=msgsory%>");
							history.go(-1);
						</script>

<% 
				flag=1
				end if
	end if
end if

if(not cint(Apopmailaccount)=0) then
				if(Apopmailaccount<Tpopmailaccount) then
			%>
			<script>
				alert("<%=msgsorry%>);
				history.go(-1);
			</script>
			<%
			flag=1
end if
end if			

if(not cint(Aemailalias)=0) then
				if( Aemailalias<Temailalias) then
			%>
			<script>
				alert("<%=msgsorry1%>");
				history.go(-1);
			</script>
			<%
			flag=1
end if
end if
if(not cint(Adatabase)=0) then
				if(Adatabase<Tdatabase) then
			%>
			<script>
				alert("<%=msgsorry2%>");
				history.go(-1);
			</script>
			<%	
			flag=1
end if
end if
if(flag=0) then
if(usernameftp="New User") then
		'-----------------------------------------------------------------------------------------------------
		'Here we are checking for the duplicate values for ftpusername
		query="select count(*) as ftpcount from tblftpinfo where ftpusername='" & ftpUser & "'"
		dim rsftpinfo
		set rsftpinfo=Server.createobject("ADODB.RecordSet")
		rsftpinfo.open query,con
		if(cint(rsftpinfo("ftpcount"))>0) then
%>
				  <script>
					  alert("<%=msgftperror%>")
					  history.go(-1)
				  </script>
<%
		response.end
		end if

		str="select count(username) as cntuser from manageusers where username='" & ftpUser & "'"
		set rsuser = Server.createobject("ADODB.RecordSet")
		rsuser.open str,con
		if(cint(rsuser("cntuser"))>0) then
%>
				<script language="JavaScript">
					alert("<%=msgftperror1%>");
					history.go(-1);
				</script>
<%		
		set rsuser=nothing
		response.end
		end if		
		str="select count(username) as cntuser from tblloginmaster where username='" & ftpUser & "'"
		set rsuser = Server.createobject("ADODB.RecordSet")
		rsuser.open str,con
		if(cint(rsuser("cntuser"))>0) then
%>
			<script language="JavaScript">
				alert("<%=msgftperror12%>");
				history.go(-1);
			</script>
<%		response.end
		end if
end if

		

dim str
str="select count(*) as flag from tbldomain where domainname='" & domainname & "'"

set rsdom = Server.createobject("ADODB.RecordSet")
rsdom.open str,con
if(cint(rsdom("flag"))>0) then
%>
		<script language="JavaScript">
		alert("<%=msgdomainerror%>");
		history.go(-1);
		</script>
<%
response.end
end if 
	
'-------------------------------------------------------------------------------------
if(not usernameftp="New User") then
	query="select * from tblftpinfo where ftpusername='" & usernameftp & "'"
	set rsgetpass=Server.CreateObject("ADODB.Recordset")
	rsgetpass.open query,con

	ftpUser = rsgetpass("ftpusername")
	password=rsgetpass("ftppassword")
	set rsgetpass=Nothing
end if
'-------------------------------------------------------------------------------------

 dim rsid,query1 
 query1="select max(id) as maxid from tblloginmaster"  
 'response.Write(str) 
 set rsid = Server.createobject("ADODB.RecordSet")
 rsid.Open query1,con
 
 newid=rsid("maxid")+1
 rsid.close

 if(len(request("www_prefix"))=0) then
		isWWW = False
 else
		isWWW = True
 end if

 if(len(request("pwdprotect"))=0) then
	  pwdprotect="N"
 else
	  pwdprotect="Y"
 end if
 
 if(len(request("cgisupport"))=0) then
	  cgisupport="N"
	   bcgi = False
 else
	  cgisupport="Y"
	   bcgi = True
 end if
 
 if(len(request("frontpageext"))=0) then
	  frontpageext="N"
 else
	  frontpageext="Y"
 end if
 
 if(len(request("aspdotnetsupport"))=0) then
	  aspdotnetsupport="N"
	  bDotNet  = False
 else
	  aspdotnetsupport="Y"
	  bDotNet  = True
 end if 
 
 if(len(request("webstart"))=0) then
	  webstart="N"
 else
	  webstart="Y"
 end if
'------------------------------------------------------------------------------------------
	  'Formatting the date to the MySql format
	  dt=date()
	  dateofcre=Year(dt) & "-" & Month(dt) & "-" & Day(dt)
	  '-------------------------------------------------------------------------------------
	  dim clientName
	  clientName = session("clientname")
	  if(clientName = "") then 
%>
<script>
		alert("There is some error the client name is missing");
		history.go(-1);
</script>
<%
	  Response.end
	  end if
	   
	  dim userHostDir : userHostDir = sHostingDir & "\" & clientName & "\"
	  
	  sUserDesc = "Domain Owner " & domainname
	  ' get actual Ip address from ID
	  sIp = GetIpAddress(ipaddress, con)  
	  
	  if(usernameftp="New User") then
			result= CreateNTUser(ftpUser, sComputerName, password, personalname,sUserDesc)
	  end if

	  ' CreateDirs also create site in IIS
	  result =CreateDirs(userHostDir, ftpUser, domainname, bcgi, bDotNet, sIp, newid, isWWW) 							  
	  if(usernameftp="New User") then
			result=CreateFTPVirtualDirectory(ftpUser, userHostDir & ftpUser)
	  end if
	

	  'Making the DNS entry
		'----------------------
		'makeDNSEntries domainname, sIP, newid
	    sHomeDir=sHostingDir & "\" & clientName & "\" & ftpUser &  "\" & domainname

	  if(len(request("webstart"))=0) then
		  webstart="N"
	 else
		  webstart="Y"
		  EnableWebStat domainname, sHomeDir, newid
	 end if

	  '-------------------------------------------------------------------------------------

	  'response.write dateofcre
	  query = "insert into tblloginmaster(username,password,usertype,status,id,regdate) values('" & domainname & "','" & password & "','d','1'," & newid & ",'" & dateofcre & "')"
	  con.execute(query)
	  'response.write date


	  query = "insert into tbldomain (domainid,domainname,resellerid,ipaddress,hdspace,skinname) values (" & newid & ",'" & domainname & "'," & session("reselid") & ",'" & ipaddress & "','','')"
	  'response.write query
	  con.execute(query)  

	  query = "insert into tblmaildomain (id, domainname, actiontype) values (" & newid & ", '" & domainname & "', 1)"
	  'response.write query
	  con.execute(query) 
	   
	   query = "Insert into tblrights(id,popmailaccount,ftpusers,sqldatabase,pwdprotectdir,cgisupport,frontpageext,aspdotnetsupport,webstats,emailalias)values (" & newid & "," & popmailaccount & "," & ftpusers & "," & mssqldatabase & ",'" & pwdprotect & "','" & cgisupport & "','" & frontpageext & "','" & aspdotnetsupport & "','" & webstart & "','" & emailalias & "')"
	   con.execute(query)	
	   'response.write query

	   query = "Insert into tbldomainpref (domainid,pwdprotect,cgisupport,frontpageext,aspdotnetsupport,webstart) values (" & newid & ",'" & pwdprotect & "','" & cgisupport & "','" & frontpageext & "','" & aspdotnetsupport & "','" & webstart & "')"
	   con.execute(query)
	   
	   query="insert into tblftpinfo (domainid,ftpusername,ftppassword,type) values(" & newid & ",'" & ftpUser & "','" & password & "','D')"
	   con.execute(query)
	   'response.write query

	   query  = "Insert into tblcontactinfo (companyname,contactname,cploginname,cppassword,phone,email,address,city,state,zipcode,country,id) values('" & companyname & "','" & personalname & "','" & domainname & "','" & password & "','" & phone & "','" & email & "','" & address & "','" & city & "','" & states & "','" & zipcode & "','" & country & "',"& newid & ")"
	   'response.write query
	   con.execute(query)

	   set rsip = server.createobject("ADODB.recordset")
	   rsip.open "select ipaddress from tblresellerip where resellerid = "& session("reselid"),con
	   IpAddress = rsip("ipaddress")
	   set rsip = nothing
	   sIp = GetIpAddress(IpAddress, con)

	   hostheader=sIp & ":" & "80" & ":" & domainname
	   query="insert into tblhostheader set domainid='" & newid & "',hostheader='" & hostheader & "',isdefault=1"
	   con.execute query
	   
	   'response.write "The value is= " & request("www_prefix")
	   if(request("www_prefix")=1) then
		   hostheader=sIp & ":" & "80" & ":" & "www." & domainname
		   query="insert into tblhostheader set domainid='" & newid & "',hostheader='" & hostheader & "',isdefault=1"
		   con.execute query
	   end if
		err.clear
	   if(ucase(sMailServer) <> "QMAIL") then
			sMailDir = sHomeDir & "\Special"
			if(not logFSO.folderexists(sMailDir) ) then
				logFSO.CreateFolder sMailDir					
			end if

			If(ucase(sMailServer) = "IMAIL") then
				call AddImailDomain(domainname, domainname, sMailDir)
				call AddImailUser(domainname,ftpUser,ftpUser,password) 				
				query="insert into tblmailaddress (domainname,  domainid, mailname, mailpass, isalias, actiontype, processed) values ('" & domainname & "', " & newid & ", '" & ftpUser & "', '" & password & "', 0, 1, 0)"
				call MakeHostAdmin(domainname, ftpUser)
				 con.execute query
			End If


			If(ucase(sMailServer) = "ME") then
				'Response.write "Using MAIL ENABLE MAIL SERVER"
				response.flush
				Call CreatePostOffice(sMailServerPath, domainname, ftpUser, password)
				query="insert into tblmailaddress (domainname,  domainid, mailname, mailpass, isalias, actiontype, processed) values ('" & domainname & "', " & newid & ", '" & ftpUser & "', '" & password & "', 0, 1, 0)"
				con.execute query
			End If

	   end if

	   'If the DNS support is enabled only then the DNS ZONE and DNS RECORDS will be created else not!!!
		'---------------------------------------------------------------------------------------------------------------------------------------
		if (Ucase(dnsSupport) = "Y") then
				'The DNS entries for the domain is made through this function defined in function.asp
				'---------------------------------------------------------------------------------------------------------------------------------------
				query = "select * from tblserverip where id='" & ipaddress & "'"
				'response.write query & "<br>"
				Set rsGetIp = Server.CreateObject("ADODB.RecordSet")
				rsGetIp.open query,con
				if(not rsGetIp.EOF) then
						dmnIpAddress = rsGetIp("ipaddress")
						CreatePrimaryZone domainname,dmnIpAddress,email
						copyDNSEntriesDomain newid,domainname,dmnIpAddress,session("reselid")
				End if				'-----------------------------------------------------------------------------------------------------------------
		End if
%>
		<script>
		  alert("<%=msgdomainadded%>")
		  window.location.replace("/server/domains.asp");
		</script>
<%
end if
%>

