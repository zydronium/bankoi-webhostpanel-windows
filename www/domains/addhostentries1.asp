<%
	accessLevel = 1
%>
<!-- #INCLUDE FILE = "../inc/security.asp" -->
<!-- #INCLUDE FILE = "../inc/db.asp" -->
<!-- #INCLUDE FILE = "../inc/params.asp" -->
<!-- #INCLUDE FILE = "../inc/functions.asp" -->
<%
	dim arrNewServerBinding
	ipaddress=request("ipaddress")
	port=request("port")
	hostname=request("hostname")
	id=session("id")
	
	hostheader=ipaddress & ":" & port & ":" & hostname
    
	
	query="select hostheader from tblhostheader"
	set rscheck=Server.CreateObject("ADODB.Recordset")
	rscheck.open query,con
	check=1
	while(not rscheck.eof)
		arr=split(rscheck("hostheader"),":")
		if(ucase(arr(2))=ucase(hostname)) then
		check=1
%>
<SCRIPT>
alert("<%=msg20%>");
history.go(-1);
</SCRIPT>
<%
		response.end
		else
		check=0
		end if
		rscheck.movenext
	wend
	
	if(check=0) then
	query="select hostheader from tblhostheader where domainid='" & id & "'"
	set rs=Server.createObject("ADODB.Recordset")
	rs.open query,con
	i=0
	redim arrNewServerBinding(20)
	while(not rs.eof)
		arrNewServerBinding(i)=rs("hostheader")
		i=i+1
		arr=split(rs("hostheader"),":")
		if(ucase(arr(2))=ucase(hostname)) then
		flag=1
%>
	<script>
		alert("<%=msg21%>");
		history.go(-1);
	</script>
<%
		else 
			flag=0
		end if
		rs.movenext
	wend

	arrNewServerBinding(i)=hostheader
	redim PRESERVE arrNewServerBinding(i)

	'for i=lbound(arrNewServerBinding) to ubound(arrNewServerBinding)
	'	response.write arrNewServerBinding(i)
	'next

	if(flag=0) then
	UpdateHostHeaders arrNewServerBinding, session("domain")

	query="insert into tblhostheader set domainid='" & id & "',hostheader='" & hostheader & "',isdefault=0"
	con.execute query
%>
<script>
	alert("<%=msg22%>");
	window.location='hostentries.asp';
</script>
<%end if%>
<%end if%>
