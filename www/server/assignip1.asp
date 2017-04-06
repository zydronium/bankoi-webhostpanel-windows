<%
	accessLevel = 10
%>
<%
'response.write "amit yadav" &request("ipaddress")
dim arrip
arrip = split(request("ipaddress"),",")
%>
<!-- #INCLUDE FILE = "../inc/security.asp" -->
<!-- #INCLUDE FILE="../inc/db.asp" -->
<head>
<title>
Clients
</title>
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/general.css">
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/custom.css">
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/layout.css">
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=ISO-8859-1">
<META HTTP-EQUIV="EXPIRES" CONTENT="0">
</head>


<%
'---------------------------------------------------------------------------------------------
'Selecting the name of the reseller/client
query="select username from tblloginmaster where id='" & session("reselid") & "'"
  dim rs
  set rs=server.createobject("ADODB.Recordset")
  rs.open query,con
  username=rs("username")
  set rs=nothing 
'------------------------------------------------------------------------------------
'Here we are inserting the IP's assigned to the client
for i=0 to ubound(arrip)
      query ="select count(*) as flag from tblresellerip where resellerid='" & session("reselid") & "' and ipaddress='" & trim(arrip(i)) & "'"
	  set rs=server.createobject("ADODB.Recordset")
      rs.open query,con
	  if(cint(rs("flag"))<=0) then
	       query="insert into tblresellerip values('" & session("reselid") & "','" & trim(arrip(i)) & "')"
	       'response.write query
	       con.execute(query)

		   query="update tblserverip set isavailable='N' where iptype='Exclusive' and id='" & trim(arrip(i)) & "'"
	       'response.write query
	       con.execute(query)
      end if
	  rs.close
  next 
%>

<body leftmargin=0 topmargin=0 >
<!-- #include file="../inc/header.asp" -->
 <form action='../server/assignip1.asp' method='post' name="mainform">
<table border="0" cellpadding=0 cellspacing=0 width="564" align="center">
    <p>&nbsp;</p><tr>  
	  <td colspan="5">
	  <img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="3" height="1" border="0"></td>
	</tr>
    <tr>
	  <td colspan="5">
	  <table align="center">
	  <tr><td>
	  <div align="center">
		  <input type="button" name="adddomain" value="<%=lblNewDomain%>" class="commonButton" onclick = "window.location='/server/new_domain.asp?name=<%=name%>'">
		</div></td>

	  <td><div align="center">
		  <input type="button" name="Button" value="<%=lblLimits%>" class="commonButton">
		</div></td>
	  <td ><div align="center">
		  <input type="button" name="Button" value="<%=lblContactInfo%>" class="commonButton">
		</div></td>
		<td><div align="center">
		  <input type="button" name="Button" value="<%=lblPreference%>" class="commonButton">
		</div></td>
	  <td  height="35" align="right">	  
	<input type="button" class="commonButton" id="assignip" value="<%=lblIPPool%>" title="<%=lblIPPool%>" onClick="window.location='/server/assignip.asp';" >		
	</td>
	</tr>	
	  </table>
      <div align="center"> </div>
      <div align="center"><img src="/skins/<%=session("skin")%>/elements/line.gif" width=564 height=1 border=0> 
      </div>
<!------------------------------------------------------------------------------------------>	
<!-- This displays the selected IP of the selected client-->
<%
  'response.write "The reseller id is " & session("reselid") 
  query="select tblserverip.ipaddress,tblserverip.iptype from tblresellerip,tblserverip where tblresellerip.ipaddress=tblserverip.id and resellerid='" & session("reselid") & "'"
  dim rs2
  set rs2=server.createobject("ADODB.Recordset")
  rs2.open query,con,3
  'response.write "the count is " &rs2.RecordCount 
  'if(rs2.RecordCount>0)then
%>
<img src="skins/<%=session("skin")%>/elements/line.gif" width=564 height=1 border=0></p>
      
	  
  <table width="55%" align="center" bordercolor="#FFFFFF" bgcolor="#E7EFFA" class="commonButton" border="3">
      <tr> <table width="560" border="0" align="center" cellpadding="0" cellspacing="0" dwcopytype="CopyTableCell">
        <tr> 
          <th colspan="3"><%=lblipassignedto%> <font color="red" face="verdana"><strong><%="" & username%></strong></font>	
        <tr> 
          <td colspan="3"></td>
        <tr> 
          <td colspan="3"></tr>
        <tr> 
          <td colspan="3"></tr>
        <tr> 
          <td colspan="3"><div align="center"><strong> </strong></div>
<%
  while(not rs2.EOF)
%>
        <tr> 
          <td width="124" height="20"><div align="center"><strong> </strong></div>
          <td width="125"><div align="center"><strong><font face="Verdana" color="Blue"><%=rs2("ipaddress")%></font></strong> 
            </div>
			<%
				if(Ucase(rs2("iptype")) = Ucase("Shared")) then
					typelbl = lblShared
				else
					typelbl = lblExclusive
				end if
			%>
          <td width="311"><div align="center"><font face="Verdana" color="Blue"><%=typelbl%></font></strong></div></tr>
        <div align="center">
          <%
  rs2.movenext
  wend
%>
        </div>
        <div align="center"><tr></div><div align="center"><td colspan="5"></div>
        <table width="554" align="center">
  <img src="/skins/<%=session("skin")%>/elements/line.gif" width=564 height=1 border=0>
			<tr> <br>
            <div align="center">
<%	
    '---------------------------------------------------------------------------------------------
	'Checking the type and then deciding the navigation of the control
    usertype=session("type")
	'response.write "The type is " & usertype
	if(usertype="a") then
%>
              <input name="Button23" type="button" class="commonButton" id="Button23" title="<%=lblup1level%>" onClick="window.location='/server/domains.asp';" value="<%=lblOk%>" >
<%else%>
			  <input name="Button23" type="button" class="commonButton" id="Button23" title="<%=lblup1level%>" onClick="window.location='/domains/clientdomains.asp';" value="<%=lblOk%>" >
<%end if%>
</div>
</td>
</tr>
<tr>
<td>&nbsp;

</td>
</tr>
</table>
</form>
</body>
</html><!-- #INCLUDE FILE = "../inc/footer.asp" -->

