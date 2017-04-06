<!-- #INCLUDE FILE = "../inc/security.asp" -->
<!-- #INCLUDE FILE = "../inc/db.asp" -->
<%
id = request("id")	
dim rs
set rs1 = server.createobject("ADODB.recordset")
query = "select contactname from tblcontactinfo where id=" & id
rs1.open query,con
session("contactname")=rs1("contactname")

set rs = server.createobject("ADODB.recordset")
query = "select username,usertype from tblloginmaster where id=" & id
rs.open query,con
if(not rs.eof) then 
	session("reselid")=id 
	session("usertype")=rs("usertype")
	session("clientname") = rs("username")
	session("resellername") = rs("username")
	response.redirect("/server/domains.asp")
else
	response.redirect("/logout.asp")
end if
%>
