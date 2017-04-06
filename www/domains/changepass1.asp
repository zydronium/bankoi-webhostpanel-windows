<%
	accessLevel = 1
%>
<!-- #INCLUDE FILE = "../inc/security.asp" -->
<!-- #INCLUDE FILE = "../inc/db.asp" -->
<!-- #INCLUDE FILE = "../inc/params.asp" -->
<!-- #INCLUDE FILE = "../inc/functions.asp" -->
<%
    id=session("id")
	oldpass=request("oldpassword")
	newpass=request("newpassword")
	
	query="select * from tblftpinfo where domainid='" & id & "'"
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.open query,con
	NTuser=rs("ftpusername")


	if(ucase(session("type"))="D") then

		query="select count(*) as flag from tblloginmaster where id='" & id & "' and password='" & oldpass & "'"
		dim rs
		set rs=server.createobject("ADODB.Recordset")
		rs.open query,con

		if(rs("flag")=0) then
		   rs.close
	%>
	 <script>
		  alert("<%=msg26%>");
		  history.go(-1);
	 </script>
	<%
		response.end
		end if
	end if
	  '--------------------------------------------------------------------------------------------------------------
	  'Updating the NT user
	  'response.write NTuser
	  result=updateNTUser(NTuser,newpass,sComputerName)

	  query="update tblloginmaster set password='" & newpass & "' where id='" & id & "'"
	  con.execute(query)
	  'response.write query
      
	  query="update tblftpinfo set ftppassword='" & newpass & "' where domainid='" & id & "'"
	  con.execute(query)
	  'response.write query
%>
 <script>
      alert("<%=msg27%>");
	  window.location='/domains/edit_domain.asp';
 </script>