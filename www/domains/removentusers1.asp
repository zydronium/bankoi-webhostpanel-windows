<%
	accessLevel = 1
%>
<!-- #INCLUDE FILE = "../inc/security.asp" -->
<!-- #INCLUDE FILE = "../inc/db.asp" -->
<!-- #INCLUDE FILE = "../inc/params.asp" -->
<!-- #INCLUDE FILE = "../inc/functions.asp" -->
<%
dim count
count=0
ntuser=split(request("ntuser"),",")
for i=lbound(ntuser) to ubound(ntuser)
	usertodelete=trim(ntuser(i))
	'-----------------------------------------------------------------------------------
	'Delete the user from the NT directory
	DeleteNTUser usertodelete,sComputerName

	'-----------------------------------------------------------------------------------
	'Deleting the NTusers from the table manageusers
	query="delete from manageusers where username='" & usertodelete & "'"
	'response.write query
	con.execute(query)
	count=count+1
next 
%>
<script>
	alert('<%=count & " " & msg149%>')
	window.location="/domains/manageusers.asp"
</script>