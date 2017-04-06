<%
	accessLevel = 1
%>
<!-- #INCLUDE FILE = "../inc/security.asp" -->
<!-- #INCLUDE FILE = "../inc/db.asp" -->
<!-- #INCLUDE FILE = "../inc/params.asp" -->
<!-- #INCLUDE FILE = "../inc/functions.asp" -->
<%
	dirname=request("dirname")
	username=request("username")
	domainname=session("domain")
	id=session("id")
	BasePath = Request("setPath")
	usertype=session("type")
	if(usertype="d") then
	query = "select pwdprotectdir from tblrights where id='" & id & "'"
	'response.write query
	set Chk = Server.CreateObject("ADODb.Recordset")
	Chk.open query,con
	if(ucase(chk("pwdprotectdir")) = Ucase("n")) then
%>
		<script>
			alert("<%=msg112%>");
			window.location = "/domains/edit_domain.asp";
		</script>
<%
		response.end
	end if
	end if

	'----------------------------------------------------------------------------------------------------
	'Extracting the password from manageuser table for the selected username
	query="select password from manageusers where ucase(username)='" & ucase(username) & "'"
	dim rspass
	set rspass=server.createobject("ADODB.Recordset")
	rspass.open query,con
	pass=rspass("password")

	dim userHostDir : userHostDir = sHostingDir & "\" & session("resellername") & "\" & session("ftpuser")
	'response.write "The path is" & userHostDir & request("path")

	path=userHostDir & "\" & domainname & "\www" & BasePath
	query="select count(*) as flag from tbldirpass where dirname='" & dirname & "' and id='" & id & "'"
	
	set rs = Server.createobject("ADODB.RecordSet")
	rs.open query,con
	
	if(rs("flag")>0) then
		rs.close
%>
	<script>
		alert("<%=msg73%>");
	</script>
<%
    'query="update tbldirpass set dirname='" & dirname & "',username='" & username & "',password='" & pass & "' where id='" & id & "'"
	'con.execute(query)
%>
	<script>
		//alert("The username and password updated for folder <%=dirname%>");
		//window.location='/domains/explorer.asp';
	</script>
<%
    else

		pwdDirPath = Replace(BasePath,"\","/")		
		SetPasswordProtectDir domainname, path, dirname, username,pwdDirPath

		query="insert into tbldirpass set id='" & id & "',domainname='" & domainname & "',dirname='" & dirname & "',username='" & username & "',fulldirname='" & pwdDirPath & "'"
		'response.write query
		con.execute(query)

		'----------------------------------------------------------------------------------------------------------
		'Updating the status of the user in the manageuser table so that the user is not visible for other purposes
		query="update manageusers set type='A' where ucase(username)='" & username & "'"
		con.execute(query)
%>
	<script>
		alert("<%=msg74 & " " & dirname%>");
		window.location='/domains/explorer.asp';
	</script>
<%
end if
%>
	<script>
		//alert("The username and password updated for folder <%=dirname%>");
		window.location='/domains/explorer.asp';
	</script>