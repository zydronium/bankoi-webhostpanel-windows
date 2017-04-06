<%
	accessLevel = 1
%>
<!-- #INCLUDE FILE = "../inc/security.asp" -->
<!-- #INCLUDE FILE = "../inc/db.asp" -->
<!-- #INCLUDE FILE = "../inc/params.asp" -->
<!-- #INCLUDE FILE = "../inc/functions.asp" -->
<%
	'response.write ucase(request("cgi"))
	ext=request("ext")
	id=session("id")
    sDomainName=session("domain")

	usertype=session("type")
	if(usertype="d") then
	query = "select frontpageext from tblrights where id='" & id & "'"
	'response.write query
	set Chk = Server.CreateObject("ADODb.Recordset")
	Chk.open query,con
	if(ucase(chk("frontpageext")) = Ucase("n")) then
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

	'response.write "Domainname= " & sDomainName & "<br>"
	'response.write "Username= " & sUserName & "<br>"
	'response.write "Password= " & sPassword & "<br>"
	sDomainName=session("domain")
	clientName=session("resellername")
	ftpuser=session("ftpuser")
	userHostDir = sHostingDir & "\" & clientName & "\" & ftpuser & "\" & sDomainName
	'response.write userHostDir
	dim clientName
    
	if(clientName ="") then clientName="naren"

	if(ucase(ext) = Ucase(lbl521)) then
	'---------------------------------------------------------------------------------------------------------
		'enable frontpage extension
		ExtendFrontPage sDomainName,sUserName,sPassword
		
		query="update tbldomainpref set frontpageext='Y' where domainid='" & id & "'"
		WriteLogLine(query)
		flag="1"
		con.execute(query)
    else
		'Disable frontpage extension
		RemoveFrontPage sDomainName,sUserName,sPassword

	    query="update tbldomainpref set frontpageext='N' where domainid='" & id & "'"
		WriteLogLine(query)
		flag="0"
		con.execute(query)

	end if
if(flag="1") then
%>	   
	<script language="javascript">
		alert("<%=msg571%>");
		window.location='/domains/frontpageext.asp';
	</script>
<%
	else
%>
	<script language="javascript">
		alert("<%=msg572%>");
		window.location='/domains/frontpageext.asp';
	</script>
<%
	end if
%>