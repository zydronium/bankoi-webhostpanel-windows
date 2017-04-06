<%
	accessLevel = 1
%>
<!-- #INCLUDE FILE = "../inc/security.asp" -->
<!-- #INCLUDE FILE = "../inc/db.asp" -->
<!-- #INCLUDE FILE = "../inc/params.asp" -->
<!-- #INCLUDE FILE = "../inc/functions.asp" -->

<%
	username=request("ftpusername")
	password=request("password")
	name=request("fullname")
	id=session("id")
	'----------------------------------------------------------------------------------------------
	'Confirming that the user name is unique in the manageuaser table
	query="select count(username) as usercount from manageusers where username='" & username & "'"
	dim rs
	set rs=server.createobject("ADODB.Recordset")
	rs.open query,con
	if(cint(rs("usercount"))>0)then 'First if starts
%>
	<script>
		alert("<%=msg41%>");
		history.go(-1);
	</script>s
<%
	else
	    set rs=nothing
		'----------------------------------------------------------------------------------------------
		'Confirming that the user name is unique in the tblftpinfo table
		query="select count(ftpusername) as usercount from tblftpinfo where ftpusername='" & username & "'"
		set rs=server.createobject("ADODB.Recordset")
		rs.open query,con
		if(cint(rs("usercount"))>0)then 'First if starts
	%>
		<script>
			alert("<%=msg41%>");
			history.go(-1);
		</script>s
	<%
		else
				set rs=nothing
				'----------------------------------------------------------------------------------------------
				'Confirming that the user name is unique in the tblloginmaster table
				query="select count(username) as usercount from tblloginmaster where username='" & username & "'"
				set rs=server.createobject("ADODB.Recordset")
				rs.open query,con
				if(cint(rs("usercount"))>0)then 'First if starts
			%>
				<script>
					alert("<%=msg41%>");
					history.go(-1);
				</script>s
			<%
				else
						sUeserDesc="User for domain " & session("domain")
						result=CreateNTUser(username, sComputerName, password, name,sUeserDesc)
						'-------------------------------------------------------------------------------
						'Insert the new user in the database
						'-------------------------------------------------------------------------------
						query="insert into manageusers set domainid='" & id & "',username='" & username & "',password='" & password & "',type='F',name='" & name & "'"
						con.execute(query)
						'response.write query
%>
<script>
		alert("<%=msg542%>");
</script>
<%
    '------------------------------------------------------------------------------------------------
	'Here we are checking whether admin or the client has logged in and then deciding the redirection
    usertype=session("type")
	if(usertype="a") then
%>
			<script>
				window.location='/domains/manageusers.asp'
			</script>
			<%else%>
			<script>
				window.location='/domains/manageusers.asp'
			</script>
<%
	end if
				end if
		end if
	end if
%>
