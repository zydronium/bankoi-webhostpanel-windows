<%
	accessLevel = 10
%>
<!-- #INCLUDE FILE = "../inc/security.asp" -->
<!-- #INCLUDE FILE = "../inc/db.asp" -->
<%
serverIp = request("hostserver")
serverUser=request("rootusername")
serverPassword=request("rootpassword")
serverType=request("databasetype")
serverStatus=request("status")
mode = request("mode")
serverport=1433
if( serverType="mysql") then serverport=3306

set dbCon=con
dim rsCheck
set rsCheck=server.CreateObject("adodb.recordset")
if( mode ="add") then
	rsCheck.open "select * from cp_db_servers  where serverip='"& serverIp &"' and servertype='"& serverType &"'", dbCon
	if( rsCheck.eof) then
		dbCon.execute "insert into cp_db_servers (serverip, serveruser, serverpassword, servertype, status, serverport) values ('"& serverIp &"', '"& serverUser &"', '"& serverPassword &"', '"& serverType &"', "& serverStatus &", "& serverport &" )", roweffected
		if(roweffected =1 ) then message = lbl694 else message = lbl695
	else
		message = lbl696
	end if
elseif (mode ="modify") then
	serverid=request("servers")
	rsCheck.open "select * from cp_db_servers  where serverip='"& serverIp &"' and servertype='"& serverType &"' and id<>"& serverid , dbCon
	if( rsCheck.eof) then
		dbCon.execute "update cp_db_servers set serverip='"& serverIp &"', serveruser='"& serverUser &"', serverpassword='"& serverPassword &"', servertype='"& serverType &"', status="& serverStatus &", serverport="& serverport &" where id="& serverid, roweffected
		if(roweffected =1 ) then message = "Server Modified" else message = "Server could not Modified"
	else
		message = lbl696
	end if
end if
%>
<script>
alert("<%=message%>")
window.location.replace("manage_dbserver.asp")
</script>