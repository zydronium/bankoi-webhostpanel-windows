<%
	accessLevel = 1
%>
<!-- #INCLUDE FILE = "../../inc/security.asp" -->
<!-- #INCLUDE FILE = "../../inc/db.asp" -->
<!-- #INCLUDE FILE = "../../inc/params.asp" -->
<!-- #INCLUDE FILE = "../../inc/functions.asp" -->
<!-- #INCLUDE FILE = "../../inc/dbfunctions.asp" -->
<%
dim address,count, totalDB
count=0
totalDB = 0
db=split(request("db"),",")
set rsDbList = server.createobject("adodb.recordset")
rsDbList.open "select * from cp_db_all where id in ("& request("db") &")", con
while (not rsDbList.eof )
	if(rsDbList("type") = "mysql") then 
		result = DeleteMysqlDB(rsDbList("id"))
	else
		result = DeleteMssqlDB(rsDbList("id"))
	end if
	if (result = true) then count = count+ 1
	rsDbList.movenext
	totalDB = totalDB + 1
wend
set rsDbList = nothing
 %>
<script>
	alert("<%=count%> out of <%=totalDB%> database deleted")
	window.location="/domains/sqldatabase.asp"
</script>