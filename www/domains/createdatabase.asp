<%
	accessLevel = 1
%>
<!-- #INCLUDE FILE = "../inc/security.asp" -->
<!-- #INCLUDE FILE = "../inc/db.asp" -->
<!-- #INCLUDE FILE = "../inc/params.asp" -->
<%
	database=request("databasename")
	password=request("password")
	username=request("username")
	id=session("id")
	'-----------------------------------------------------------------------------------
	'Here we are checking the numbere of database allowed to this domain
	'If the domain exceeds its limit then deny him of making the database
	query="select count(databasename) as dbcount from tbldatabase where domainid='" & id & "'"
	dim rs
	set rs=server.createobject("ADODB.Recordset")
	rs.open query,con
	dbcount=rs("dbcount")
	set rs=nothing
	
	query="select sqldatabase from tblrights where id='" & id & "'"
	
	set rs=server.createobject("ADODB.Recordset")
	rs.open query,con
	count=rs("sqldatabase")
	rs.close

	'Comparing the two counts if they are equal the deny him of making the account
	if(dbcount >= count) then
%>
	<script>
		alert("<%=msg32%>");
		history.go(-1);
	</script>
<%
	elseif(dbcount < count) then

	query="select count(databasename) as flag from tbldatabase where domainid='" & id & "' and databasename='" & database & "'"
	rs.open query,con
	if(rs("flag") > 0) then
		rs.close
%>
	<script>
		alert("<%=msg33%>");
		history.go(-1);
	</script>
<%
    else
		query="insert into tbldatabase set domainid='" & id & "',databasename='" & database & "',dbusername='" & username & "',dbpassword='" & password & "',dbtype='MsSql'"
		con.execute(query)
%>
	<script>
		alert("|| <%=database%> || <%=" " & msg4%>");
		window.location='/domains/sqldatabase.asp';
	</script>
<%
	end if
	end if
%>