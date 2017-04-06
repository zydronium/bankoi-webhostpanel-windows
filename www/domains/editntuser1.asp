<%
	accessLevel = 1
%>
<!-- #INCLUDE FILE = "../inc/security.asp" -->
<!-- #INCLUDE FILE = "../inc/db.asp" -->
<!-- #INCLUDE FILE = "../inc/params.asp" -->
<!-- #INCLUDE FILE = "../inc/functions.asp" -->
<%
	NTuser=session("NTuser")
	'response.write "username: " & NTuser
	pass=request("password")
	old_pass=request("old_passwd")
	'response.write old_pass

	query="select password from manageusers where ucase(username)='" & ucase(NTuser) & "'"
	dim rsuser
	set rsuser=server.createobject("ADODB.Recordset")
	rsuser.open query,con
	if(not old_pass=rsuser("password")) then
%>
	<script>
		alert("<%=msg26%>");
		history.go(-1);
	</script>

<%
	else
	'--------------------------------------------------------------------------------------------------------------
	'Updating the NT user
	result=updateNTUser(NTuser,pass,sComputerName)

	query="update manageusers set password='" & pass & "' where ucase(username)='" & ucase(NTuser) & "'"
	'response.write query & "<br>"
	con.execute (query)
	'--------------------------------------------------------------------------------------------------------------
session("NTuser")=""
%>

<script>
	alert("<%=msg27%>");
	window.location="/domains/manageusers.asp"
</script>
<%
   	end if
%>