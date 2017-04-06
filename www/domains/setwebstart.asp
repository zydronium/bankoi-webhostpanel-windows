<%
	accessLevel = 1
%>
<!-- #INCLUDE FILE = "../inc/security.asp" -->
<!-- #INCLUDE FILE = "../inc/db.asp" -->
<!-- #INCLUDE FILE = "../inc/params.asp" -->
<!-- #INCLUDE FILE = "../inc/functions.asp" -->
<%
	ext=request("ext")
	id=session("id")
    sDomainName=session("domain")

	usertype=session("type")
	if(usertype="d") then
	query = "select webstats from tblrights where id='" & id & "'"
	'response.write query
	set Chk = Server.CreateObject("ADODb.Recordset")
	Chk.open query,con
	if(ucase(chk("webstats")) = Ucase("n")) then
%>
		<script>
			alert("<%=msg112%>");
			window.location = "/domains/edit_domain.asp";
		</script>
<%
		response.end
	end if
	end if

	'-----------------------------------------------------------------------------------------------
	'Here selecting the default username and password of the FTP
	query="select ftpusername,ftppassword from tblftpinfo where domainid='" & id & "'"
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.open query,con
	sUserName=rs("ftpusername")
	sPassword=rs("ftppassword")
	sDomainName=session("domain")
	clientName=session("resellername")
	ftpuser=session("ftpuser")
	
	'response.write userHostDir
	dim clientName
	userHostDir = sHostingDir & "\" & clientName & "\" & ftpuser & "\" & sDomainName

	if(ucase(ext) = Ucase(lbl521)) then
	'---------------------------------------------------------------------------------------------------------
		'enable frontpage extension
		EnableWebStat sDomainName,userHostDir, id
		
		query="update tbldomainpref set webstart='Y' where domainid='" & id & "'"
		WriteLogLine(query)
		flag="1"
		con.execute(query)
    else
		'Disable frontpage extension
		 DisableWebStat sDomainName

	    query="update tbldomainpref set webstart='N' where domainid='" & id & "'"
		WriteLogLine(query)
		flag="0"
		con.execute(query)

	end if
if(flag="1") then
%>	   
	<script language="javascript">
		alert("<%=msg75%>");
		window.location='/domains/webstart.asp';
	</script>
<%
	else
%>
	<script language="javascript">
		alert("<%=msg76%>");
		window.location='/domains/webstart.asp';
	</script>
<%
	end if
%>