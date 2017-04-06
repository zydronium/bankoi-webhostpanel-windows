<%
	accessLevel = 5
%>
<!-- #INCLUDE FILE = "../inc/security.asp" -->
<!-- #INCLUDE FILE = "../inc/db.asp" -->
<!-- #INCLUDE FILE = "../inc/params.asp" -->
<!-- #INCLUDE FILE = "../inc/functions.asp" -->
<html>
<head>
<title><%=lblUpdateClientInformation%></title>
<link rel="stylesheet" type="text/css" href="/skins/default/css/general.css">
<link rel="stylesheet" type="text/css" href="/skins/default/css/custom.css">
<link rel="stylesheet" type="text/css" href="/skins/default/css/layout.css">
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=ISO-8859-1">
<META HTTP-EQUIV="EXPIRES" CONTENT="0">
</head>
<%
	id=session("reselid")
	contactname=request("clientname")
    cploginname=request("personalname")
	FTPUsername=request("ftpusername")
	Company=request("company")
	Phone=request("phone")
	email=request("email")
	Address=request("address")
	City=request("city")
	State=request("state")
	ZIP=request("zipcode")
	code=request("country")
	ftppassword=request("ftppassword")

	'---------------------------------------------------------------------------------------------------------------
	'Updation of the client done here
	result=updateNTUser(FTPUsername,ftppassword,sComputerName)

	query="update tblcontactinfo set contactname='" & contactname & "',cploginname='" & cploginname & "',companyname='" & company & "',phone='" & phone & "',email='" & email & "',address='" & address & "',city='" & city & "',state='" & state & "',zipcode='" & zip & "',country='" & code & "' where id='" & id & "'"
	con.execute query

	query="update tblftpinfo set ftppassword='" & ftppassword & "' where domainid='" & id & "'"
	con.execute query
	query="update tblloginmaster set password='" & ftppassword & "' where id='" & id & "'"
	con.execute query
%>
<script>
	alert("<%=msg107%>");
    window.location='/clients/clientinfo.asp';
</script>
</html> 
