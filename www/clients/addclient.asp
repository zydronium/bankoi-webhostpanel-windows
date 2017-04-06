<%
	accessLevel = 10
%>
<!-- #INCLUDE FILE = "../inc/security.asp" -->
<!-- #INCLUDE FILE = "../inc/db.asp"	 -->
<!-- #INCLUDE FILE = "../inc/params.asp" -->
<!-- #INCLUDE FILE = "../inc/functions.asp" -->
<html>
<head>
<title><%=lblAddClient%></title>
<link rel="stylesheet" type="text/css" href="/skins/default/css/general.css">
<link rel="stylesheet" type="text/css" href="/skins/default/css/custom.css">
<link rel="stylesheet" type="text/css" href="/skins/default/css/layout.css">
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=ISO-8859-1">
<META HTTP-EQUIV="EXPIRES" CONTENT="0">
</head>
<body leftmargin=0 topmargin=0 >

<%
  pass=trim(split(request("passwd"),",")(0))
  '------------------------------------------------------------------
  'Here we are checking for the duplicate values for loginname
  str="select count(*) as flag from tblloginmaster where tblloginmaster.username='" &request("login") & "'"

  set rs1 = Server.createobject("ADODB.RecordSet")
  rs1.open str,con
  if(cint(rs1("flag"))>0) then
%>
  <script>
	  alert("<%=lbl727 & " " & request("login") & " " & lbl728%>")
	  history.go(-1)
  </script>
<%
else
  set rs1=nothing
  str="select count(*) as flag from tblftpinfo where tblftpinfo.ftpusername='" &request("login") & "' "
  'response.write str
  set rs1 = Server.createobject("ADODB.RecordSet")
  rs1.open str,con
  if(cint(rs1("flag"))>0) then
%>
  <script>
	  alert("<%=lbl727 & " " & request("login") & " " & lbl728%>")
	  history.go(-1)
  </script>
<%
else 
set rs1=nothing
  str="select count(*) as flag from manageusers where username='" &request("login") & "' "
  'response.write str
  set rs1 = Server.createobject("ADODB.RecordSet")
  rs1.open str,con
	if(cint(rs1("flag"))>0) then
%>
			  <script>
				  alert("<%=lbl727 & " " & request("login") & " " & lbl728%>")
				  history.go(-1)
			  </script>
<%
	else 
		  set rs1=nothing  
		  'rs1.close
		  '---------------------------------------------------------------------------------------------------------------
		  str="select max(id) as maxid from tblloginmaster"
		  dim rs
		  set rs = Server.createobject("ADODB.RecordSet")
		  rs.Open str,con
		  loginid=rs("maxid")+1
		  set rs=nothing

		  dim userName : userName = request("login")
		  dim userPass : userPass =  trim(split(request("passwd"),",")(0))
		  dim sFullName : sFullName = request("pname") 
		  dim userDir : userDir = sHostingDir & "\" & userName
		  sUeserDesc = "Hosting Reseller"
		  'Creating the Object of the windows control panel DLL
		  '----------------------------------------------------
		  'set winObj = Server.createobject("WINDOWSCP.WinClass")
		  '----------------------------------------------------

		  'Here we check whether the NT user with this name already exists or not if yes then send him back
		  '---------------------------------------------------------------------------------------------------------
		  if(not isNTUserExists(userName,sComputerName)) then
			  '------------------------------------------------------------------------------------------------------
			  CreateDir(userDir)
			  result= CreateNTUser(userName, sComputerName, userPass, sFullName, sUeserDesc)
			  result=CreateFTPVirtualDirectory(userName, userDir)
			  call AddUserToFolder(userName, userDir)
			  call copyDNSTemplateClient(loginid) '----------------------------------------------------------------------------------------------------------
			  'This is the entry in tblloginmaster 
			  str="insert into tblloginmaster(id, username, password, usertype, status, regdate) values ('" & loginid &"', '" &request("login") & "', '" & pass & "', 'c', '1', CURDATE())"
			  con.execute(str)
			  '----------------------------------------------------------------------------------------------------
			  'Here we are adding the entry to the tblreseller
			  query="insert into tblreseller(resellerid, logo, supportlink)values('" & loginid &"','','')"
			  con.execute(query)
		 	  '----------------------------------------------------------------------------------------------------
			  'Here we are adding the entry to the tblcontactinfo
			  query="insert into tblcontactinfo(companyname, contactname, phone, email, address, city, state, zipcode, country, id) values ('" & request("cname") & "', '" & request("pname") & "', '" &request("phone") & "','" &request("email") & "', '" &request("address") & "', '" &request("city") & "', '" &request("state") & "', '" &request("pcode") & "', '" &request("country") & "', '" & loginid &"')"
			  con.execute(query)
			  '----------------------------------------------------------------------------------------------------
			  'Here we are adding the entry to the tblftpinfo
			  query="insert into tblftpinfo set domainid='" & loginid &"',ftpusername='" & request("login") & "',ftppassword='" & pass & "',type='D'"
			  con.execute(query)
			  '-------------------------------------------------------------------------------------------------
			  'Here we are adding the entry to the tblrights
			  query = "Insert into tblrights values (" & loginid & ",'0','0','0','Y','Y','Y','Y','Y','Y','0000','0000')"
			  con.execute(query)	
		      '-------------------------------------------------------------------------------------------------
%>   
			  <script>
					alert("<%=msgAddClient%>")
					window.location.replace("/clients/clients.asp");
			  </script>
<%
		else
%>
			 <script>
					alert("<%=lbl727 & " " & request("login") & " " & lbl728%>")
					history.go(-1)
			</script>
<%end if
	end if
  end if
end if

%>

</body>
</html>
