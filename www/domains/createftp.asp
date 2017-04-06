<%
	accessLevel = 1
%>
<!-- #INCLUDE FILE = "../inc/security.asp" -->
<!-- #INCLUDE FILE = "../inc/db.asp" -->
<!-- #INCLUDE FILE = "../inc/params.asp" -->
<!-- #INCLUDE FILE = "../inc/functions.asp" -->

<%
	ftpusername=request("ftpusername")
	password=request("password")
	id=session("id")
	domainname=session("domain")
	'----------------------------------------------------------------------------------------------------
	'Extracting the password from manageuser table for the selected username
	query="select password from manageusers where ucase(username)='" & ucase(ftpusername) & "'"
	dim rspass
	set rspass=server.createobject("ADODB.Recordset")
	rspass.open query,con
	pass=rspass("password")

	'----------------------------------------------------------------------------------------------------
	'Here we are checking the numbere of ftp accounts allowed to this domain
	'If the domain exceeds its limit then deny him of making the ftp account
	query="select count(ftpusername) as ftpcount from tblftpinfo where domainid='" & id & "' and type='N'"
	dim rs
	set rs=server.createobject("ADODB.Recordset")
	rs.open query,con
	ftpcount=rs("ftpcount")
	set rs=nothing
	
	query="select ftpusers from tblrights where id='" & id & "'"
	
	set rs=server.createobject("ADODB.Recordset")
	rs.open query,con
	count=rs("ftpusers")
	rs.close

	'Comparing the two counts if they are equal the deny him of making the account
	if(ftpcount>=count) then
%>
	<script>
		alert("<%=msg36%>");
		history.go(-1);
	</script>
<%
	elseif(ftpcount<count) then

	query="select count(ftpusername) as flag from tblftpinfo where domainid='" & id & "' and ftpusername='" & ftpusername & "'"
	rs.open query,con

	'----------------------------------------------------------------------------------------------------------
	'Updating the status of the user in the manageuser table so that the user is not visible for other purposes
	query="update manageusers set type='A' where ucase(username)='" & ucase(ftpusername) & "'"
	con.execute(query)


	if(rs("flag")>0) then
		rs.close
%>
	<script>
		alert("<%=msg37%>");
		history.go(-1);
	</script>
<%
    else
		'------------------------------------------------------------------------------------
		sUeserDesc="Domain's FTP User"
		ftpuser=session("ftpuser")

		dim clientName
	    clientName=session("resellername")
		if(clientName ="") then clientName="naren"

		userHostDir = sHostingDir & "\" & clientName & "\" & ftpuser & "\" & domainname 
		
		result=CreateFTPVirtualDirectory(ftpusername, userHostDir)
		call AddUserToFolder(ftpusername,  userHostDir)
		'------------------------------------------------------------------------------------

		query="insert into tblftpinfo set domainid='" & id & "',ftpusername='" & ftpusername & "',ftppassword='" & pass & "',type='N'"
		con.execute(query)
%>
	<script>
		alert("<%=ftpusername%> FTP user created");
		window.location='/domains/ftpusers.asp';
	</script>
<%
	end if
	end if
%>