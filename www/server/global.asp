<%
	accessLevel = 5
%>
<!-- #INCLUDE FILE = "../inc/security.asp" -->
<!-- #INCLUDE FILE = "../inc/db.asp" -->
<!-- #INCLUDE FILE = "../inc/params.asp" -->
<!-- #INCLUDE FILE = "../inc/functions.asp" -->


<%
	session("id")=request("id")										'setting the domain id for the selected domain
	id=request("id")
	query="select username, tblloginmaster.id as uid from (tbldomain inner join tblloginmaster on tbldomain.resellerid=tblloginmaster.id) where tbldomain.domainid='" & id & "'"
	set rs=server.createobject("ADODB.Recordset")
	rs.open query,con
	session("resellername")=rs("username")							'Setting the resellername of the reseller
	session("reselid")=rs("uid")									'Setting the id of the reseller
	uid=rs("uid")
	rs.close
	
	set rs1 = server.createobject("ADODB.recordset")
	query = "select contactname from tblcontactinfo where id='" & uid & "'"
	rs1.open query,con
	session("contactname")=rs1("contactname")						'Setting the contactname of the domain

	query="select ftpusername from tblftpinfo where domainid='" & id & "'"
	set rsname=server.createobject("ADODB.Recordset")
	rsname.open query,con
	session("ftpuser")=rsname("ftpusername")						'Setting the name of the domain Ftp


	dim clientName
    clientName = session("resellername")
    if(clientName = "") then clientName="naren"
   
	'here the name of the selected domain is extracted
	query="select * from tblloginmaster where tblloginmaster.id='" & id & "'"
	set rs2=server.createobject("ADODB.Recordset")
	rs2.open query,con
	
	domainname=rs2("username")
	dim userHostDir : userHostDir = sHostingDir & "\" & clientName & "\" & session("ftpuser") & "\" & domainname & "\" 
	session("domainspace")=UsedDomainSpace(userHostDir)				'The function calculates the domain space


	rsname.close
    response.redirect("../server/domaininfo.asp")
	
%>