<%
	accessLevel = 5
%>
<!-- #INCLUDE FILE = "../inc/security.asp" -->
<!-- #INCLUDE FILE = "../inc/db.asp" -->
<!-- #INCLUDE FILE = "../inc/params.asp" -->
<!-- #INCLUDE FILE = "../inc/functions.asp" -->

<%
  
  '------------------VARIABLES-----------------------------
  ipaddress=request("ip_addr_id")
  popmailaccount=request("popmailaccount")
  ftpusername=request("ftpusername")
  ftpusers=request("ftpusers")
  mssqldatabase=request("mssqldatabase")
  password=request("password")
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
  id=request("id")
  '--------------------------------------------------------
  query="select * from tblftpinfo where domainid='" & id & "'"
  set rs=Server.CreateObject("ADODB.Recordset")
  rs.open query,con
  ftpusername=rs("ftpusername")
  '--------------------------------------------------------
  sDomainName=session("domain")
  clientName=session("resellername")
  ftpuser=session("ftpuser")
  userHostDir = sHostingDir & "\" & clientName & "\" & ftpusername & "\" & sDomainName
  'response.write userHostDir
  dim clientName

  if(clientName ="") then clientName="naren"



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
	  'Disable cgi support
	  DisableCGI userHostDir, sDomainName
	   bcgi = False
  else
      cgisupport="Y"
	  'enable cgi support
	  EnableCGI userHostDir, sDomainName
	   bcgi = True
  end if
  if(len(request("frontpageext"))=0) then
      frontpageext="N"
  else
      frontpageext="Y"
  end if
  if(len(request("aspdotnetsupport"))=0) then
      aspdotnetsupport="N"
	  'Disable dot net support
	    DisableDotNet userHostDir, sDomainName
	  bDotNet  = False
  else
      aspdotnetsupport="Y"
	  'Enable dot net support
	   EnableDotNet userHostDir, sDomainName
	  bDotNet  = True
  end if 
  sHomeDir=sHostingDir & "\" & clientName & "\" & ftpusername & "\" & sDomainName
  if(len(request("webstart"))=0) then
      webstart="N"
	  DisableWebStat sDomainName  'Disabling the webstat for the selected domain
  else
      webstart="Y"
	  EnableWebStat sDomainName, sHomeDir,id
  end if

  query = "update tblloginmaster set password='" & password & "' where id='" & id & "'"
  con.execute(query)
  'response.write query


  query = "update  tbldomain set ipaddress='" & ipaddress & "' where domainid='" & id & "'"
  'response.write query
  con.execute(query)  
   
   query = "update tblrights set popmailaccount=" & popmailaccount & ", ftpusers=" & ftpusers & ", sqldatabase=" & mssqldatabase & ",pwdprotectdir='" & pwdprotect & "',cgisupport='" & cgisupport & "',frontpageext='" & frontpageext & "',aspdotnetsupport='" & aspdotnetsupport & "',webstats='" & webstart & "',emailalias='" & emailalias & "' where id='" & id & "'"

   con.execute(query)	
   'response.write query
   
   query="update tblftpinfo set ftppassword='" & password & "' where type='D' and domainid='" & id & "'"
   con.execute(query)
   'response.write query

   query  = "update tblcontactinfo set companyname='" & companyname & "',contactname='" & personalname & "',cppassword='" & password & "',phone='" & phone & "',email='" & email & "',address='" & address & "',city='" & city & "',state='" & states & "',zipcode='" & zipcode & "',country='" & country & "' where id='" & id & "'"
   'response.write query
   con.execute(query)  
%>
<script>
  alert("<%=msgupdatedomain%>");
</script>
<%	
    usertype=session("type")
	'response.write "The type is " & usertype
	if(usertype="a") then
%>
		  <script>
		  		window.location.replace("/server/domains.asp");
		  </script>
<%else%>
		<script>
				window.location.replace("/domains/clientdomains.asp");
		</script>
<%end if%>



