<%
	accessLevel = 1
%>
<!-- #INCLUDE FILE = "../inc/security.asp" -->
<!-- #INCLUDE FILE = "../inc/db.asp" -->
<!-- #INCLUDE FILE = "../inc/params.asp" -->
<!-- #INCLUDE FILE = "../inc/functions.asp" -->
<%
	'response.write ucase(request("cgi"))
	cgi=request("cgi")
	id=session("id")

	usertype=session("type")
	if(usertype="d") then
	query = "select cgisupport from tblrights where id='" & id & "'"
	'response.write query
	set Chk = Server.CreateObject("ADODb.Recordset")
	Chk.open query,con
	if(ucase(chk("cgisupport")) = Ucase("n")) then
%>
		<script>
			alert("<%=msg112%>");
			window.location = "/domains/edit_domain.asp";
		</script>
<%
		response.end
	end if
	end if

	sDomainName=session("domain")
	clientName=session("resellername")
	ftpuser=session("ftpuser")
	userHostDir = sHostingDir & "\" & clientName & "\" & ftpuser & "\" & sDomainName
	'response.write userHostDir
	dim clientName
    
	if(clientName ="") then clientName="naren"

	if(ucase(cgi) = Ucase(lbl521)) then
	'---------------------------------------------------------------------------------------------------------
		'enable cgi support
		EnableCGI userHostDir, sDomainName
		
		query="update tbldomainpref set cgisupport='Y' where domainid='" & id & "'"
		'response.write query
		flag="1"
		con.execute(query)
    else
		'Disable cgi support
		DisableCGI userHostDir, sDomainName

	    query="update tbldomainpref set cgisupport='N' where domainid='" & id & "'"
		'response.write query
		flag="0"
		con.execute(query)

	end if
	
	if(flag="1") then
%>	   
	<script language="javascript">
		alert("<%=lbl523 & " " & lbl521%>");
		window.location='/domains/cgisupport.asp';
	</script>
<%
	else
%>
	<script language="javascript">
		alert("<%=lbl523 & " " & lbl522%>");
		window.location='/domains/cgisupport.asp';
	</script>
<%
	end if
%>