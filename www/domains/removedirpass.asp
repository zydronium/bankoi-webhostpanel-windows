<%
	accessLevel = 1
%>
<!-- #INCLUDE FILE = "../inc/security.asp" -->
<!-- #INCLUDE FILE = "../inc/db.asp" -->
<!-- #INCLUDE FILE = "../inc/params.asp" -->
<!-- #INCLUDE FILE = "../inc/functions.asp" -->
<%
dim dsn,count
count=0
dirname=split(request("dirname"),",")
'response.write "dirname= " & request("dirname")
domainname=session("domain")
id=session("id")
dim userHostDir : userHostDir = sHostingDir & "\" & session("resellername") & "\" & session("ftpuser")


for i=0 to ubound(dirname)
	'-------------------------------------------------------------------------------------------------
	query = "Select * from tbldirpass where dirname = '" & trim(dirname(i)) & "' and id='" & id & "'"
	set rscheck=Server.CreateObject("ADODB.Recordset")
	rscheck.open query,con
	if(Not rscheck.eof) then
		pwdDirPath = rscheck("fulldirname")
		query="select username from tbldirpass where dirname='" & trim(dirname(i)) & "' and id='" & id & "'"
		'response.write query
		set rs=Server.CreateObject("ADODB.Recordset")
		rs.open query,con
		username=rs("username")

		UnsetPasswordDir domainname, userHostDir, trim(dirname(i)), username,pwdDirPath
		'-------------------------------------------------------------------------------------------------
		'Removing the password on the directory
		query="delete from tbldirpass where dirname='" & trim(dirname(0)) & "' and id='" & id & "'"
		con.execute(query)
	
		query="update manageusers set type='F' where username='" & username & "'"
		con.execute (query)
		set rs=nothing
		count=count+1
	end if
next 


	if(not Cint(count) = 0) then
%>
<script>
	alert("<%=count & " " & msg61%>")
	window.location="/domains/explorer.asp"
</script>
<%
	else
%>
<script>
	alert("<%=msg110%>")
	window.location="/domains/explorer.asp"
</script>
<%
	end if
%>