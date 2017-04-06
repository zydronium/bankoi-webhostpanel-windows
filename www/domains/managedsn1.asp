<%
	accessLevel = 1
%>
<!-- #INCLUDE FILE = "../inc/security.asp" -->
<!-- #INCLUDE FILE = "../inc/db.asp" -->
<!-- #INCLUDE FILE = "../inc/params.asp" -->
<!-- #INCLUDE FILE = "../inc/functions.asp" -->
<%
    id=session("id")
	dsn=request("dsn")                  'DSN Name
	servername=request("servername")
	source=request("path") & request("databasename")
	database=source
	database=replace(database,"\","\\")	
	username=request("username")
	pass=request("password")
	dbtype=request("dbtype")
	'response.write dbtype
	ext=right(database,3)
	'response.write "the path is " & request("path")

	if(dsn="" or source="" or username="" or pass="") then
%>
<script>
	    alert("<%=msg52%>");
		history.go(-1);
</script>
<%	
else
	query="select count(*) as flag from tbldsn where dsnname='" & dsn & "'"
	set rs=server.createobject("ADODB.Recordset")
	rs.open query,con
	if(cint(rs("flag"))>0) then
%>
	<script>
	    
		alert("<%=msg53%>");
		history.go(-1);
	</script>
<%
	else
		query="insert into tbldsn set id='" & session("id") & "',dsnname='" & dsn & "',databasename='" & database & "',username='" & username & "',password='" & pass & "',dbtype='" & dbtype & "'"
		'response.write query
		con.execute(query)
		
		if(ucase(dbtype)=ucase("sqlServer")) then
				sDesc="Sql Server user account"
				CreateSQLDSN database,dsn ,username , sDesc, servername
				'response.write "SQL SERVER"
		 elseif(ucase(dbtype)=ucase("MySql")) then
				sDesc="MySql user account"
				CreateMySqlDSN database, dsn, username, pass, sDesc, servername
				'response.write "MYSQL"
		 elseif(ucase(dbtype)=ucase("access")) then
				sDesc="Access user account"
				CreateAccessDSN source, dsn ,username, pass, sDesc
				'response.write "ACCESS"
		 else
		 end if
	end if
	end if
%>
	<script>
		alert("<%=msg54%>");	
		window.location='/domains/databasetype.asp';
	</script>