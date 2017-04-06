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
dsn=split(request("dsn"),",")
for i=lbound(dsn) to ubound(dsn)-1
    dsnname=split(dsn(i),"--->")
	query="select dbtype from tbldsn where dsnname='" & trim(dsnname(0)) & "'"
	set rs=Server.createobject("ADODB.Recordset")
	rs.open query,con
	dbtype=rs("dbtype")

	if(ucase(dbtype)=ucase("sqlServer")) then
				DeleteSQLDSN(trim(dsnname(0)))
				'response.write dbtype	  
	elseif(ucase(dbtype)=ucase("MySql")) then
				DeleteMySqlDSN(trim(dsnname(0)))
				'response.write dbtype
	elseif(ucase(dbtype)=ucase("Access")) then
				'response.write trim(dsnname(0))
				 DeleteAccessDSN trim(dsnname(0))
	end if
	'-----------------------------------------------------------------------------------
	'Deleting the email av\ccounts from the table tblemail
	query="delete from tbldsn where dsnname='" & trim(dsnname(0)) & "'"
	con.execute(query)
	count=count+1
next 
%>
<script>
	alert("<%=count & " " & msg63%>")
	window.location="/domains/databasetype.asp"
</script>