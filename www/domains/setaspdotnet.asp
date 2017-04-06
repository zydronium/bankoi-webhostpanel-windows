<%
	accessLevel = 1
%>
<!-- #INCLUDE FILE = "../inc/security.asp" -->
<!-- #INCLUDE FILE = "../inc/db.asp" -->
<!-- #INCLUDE FILE = "../inc/params.asp" -->
<!-- #INCLUDE FILE = "../inc/functions.asp" -->
<%
	'response.write "The asp support is "&ucase(request("aspdot"))
	aspdot=request("aspdot")
	id=session("id")

	usertype=session("type")
	if(usertype="d") then
	query = "select aspdotnetsupport from tblrights where id='" & id & "'"
	'response.write query
	set Chk = Server.CreateObject("ADODb.Recordset")
	Chk.open query,con
	if(ucase(chk("aspdotnetsupport")) = Ucase("n")) then
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


	if(ucase(aspdot) = Ucase(lbl521)) then
	'-----------------------------------------------------------------------------------------------------------
		'Enable dot net support
		if( EnableDotNet( userHostDir, sDomainName) = true) then 
			query="update tbldomainpref set aspdotnetsupport='Y' where domainid='" & id & "'"
		    con.execute(query)
		%>	   
	<script language="javascript">
		alert("<%=lbl519 & " " & lbl521%>");
		window.location='/domains/aspdotnetsupport.asp';
	</script>
<%
		else
		%>
			<script language="javascript">
			alert("<%=msg70%>");
			window.location='/domains/aspdotnetsupport.asp';
			</script>
		<%
		end if
    else
		'Disable dot net support
	    DisableDotNet userHostDir, sDomainName

	    query="update tbldomainpref set aspdotnetsupport='N' where domainid='" & id & "'"
	    'response.write query
		flag="0"
		con.execute(query)
		%>
	<script language="javascript">
		alert("<%=lbl519 & " " & lbl522%> ");
		window.location='/domains/aspdotnetsupport.asp';
	</script>
<%
	'-----------------------------------------------------------------------------------------------------------
	end if	
%>