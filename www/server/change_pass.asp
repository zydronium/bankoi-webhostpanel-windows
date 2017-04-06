<%
	accessLevel = 10
%>
<!-- #INCLUDE FILE = "../inc/security.asp" -->
<!-- #INCLUDE FILE = "../inc/db.asp" -->
<%
    id=session("adminid")
	newpass=request("new_passwd")
	oldpass=request("old_passwd")

	query="Select password from tblloginmaster where id='" & session("adminid") & "'"
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.open query,con
	password=rs("password")
	'password=password*23
	rs.close

	if(not oldpass=password) then
%>
<script>
	alert("<%=msgoldpwd%>");
	history.go(-1);
</script>

<%
    else
    query="update tblloginmaster set password='" & newpass & "' where id='" & id & "'"
	con.execute(query)
	'response.write query
	end if
%>
 <script>
      alert("<%=msgadminpwd%>");
	  window.location='/clients/clients.asp';
 </script>
