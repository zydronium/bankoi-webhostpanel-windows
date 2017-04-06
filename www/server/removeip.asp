<%
	accessLevel = 10
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
<script>
function chk_form_data(f)
{
	f.action = "../server/assignip1.asp";
	f.submit();
	return true;
}

function removeselected(f)
{
  f.action = "removeip1.asp";
  f.submit();
  return true;
}
</script>

<%
	 id = session("reselid")
	 'response.write request("ipchk")
	If(len(request("ipchk"))=0) then
%>
	<script>
		alert("<%=msg87%>");
		window.location='assignip.asp';
	</script>
<%
	Else
  '---------------------------------------------------------------------------------------------
  'Here we are extracting the name of the reseller according to the id stored in the session
  query="select contactname from tblcontactinfo where id='" & session("reselid") & "'"
  'response.write query
  dim rs
  set rs=server.createobject("ADODB.Recordset")
  rs.open query,con
  username=rs("contactname")

  strsuccess=""
  strfail=""
  'response.write "amit yadav" &session("reselid")
  '----------------------------------------------------------------------------------------------	
	'response.write request("ipchk")
	if(len(request("ipchk"))=0) then
	    str="No IP selected to remove"
	else
		iparr=Split(request("ipchk"),",")
		for i=Lbound(iparr) to Ubound(iparr)
			query="select id from tblserverip where ipaddress='" & trim(iparr(i)) & "'"
			'response.write query
			set rsip=server.createobject("ADODB.Recordset")
			rsip.open query,con
			ipid=rsip("id")

			query="select count(ipaddress) as countipaddress  from tbldomain where ipaddress='" & ipid & "' and resellerid='" & session("reselid") & "'"
			'response.write query
			set rsipdomain=server.createobject("ADODB.Recordset")
			rsipdomain.open query,con

			if(cint(rsipdomain("countipaddress")) >0) then
					if(strfail="") then
						strfail=trim(iparr(i))
					else
						strfail=strfail & ", " & trim(iparr(i))
					end if
			else
					if(strsuccess="") then
						strsuccess=trim(iparr(i))
					else
						strsuccess=strsuccess & ", " & trim(iparr(i))
					end if
			end if

			rsip.close
			rsipdomain.close
		next   
	end if
%>

<body leftmargin=0 topmargin=0 >
<!-- #include file="../inc/header.asp" -->
<!-- #include file="../clients/clientheader.asp" -->
 <form  method='post' name="mainform">

  <p align="center">
<!------------------------------------------------------------------------------------------>	
<!-- This displays the selected IP of the selected client-->
<img src="skins/<%=session("skin")%>/elements/line.gif" width=564 height=8 border=0></p>
<table width="55%" align="center" bordercolor="#FFFFFF" bgcolor="#E7EFFA" class="commonButton" border="3"><tr>
    
        <table width="560" border="0" align="center" cellpadding="0" cellspacing="0" dwcopytype="CopyTableCell">
           
			
<%
	if(not len(strsuccess)=0) then
%><tr> 
            <th width="560"><%=msg105%> <font color=red face=verdana><strong><%=username%></strong></font></th></tr><tr><td align="center">
<%
		response.write strsuccess
	end if
%>
<br><br>
</td></tr>
	</tr>
	
	
	
	
<%
	if(not len(strfail)=0) then%>
		<tr> 
        <th width="560"> <%=msg106%> <font color=red face=verdana><strong><%=username%></strong></font></div></strong></th></tr><tr><td align="center">
<%
		response.write strfail
	end if
%>

<br><br></td></tr></strong></div></td>
          </tr>
<input type="hidden" name="ipchk" value="<%=strsuccess%>">


          
          
          <tr> 
            <td height="10"><div align="center"> 
                <input type="button" name="removeip" value="<%=lblProceed%>" class="commonButton" onClick = "return removeselected(document.mainform)" title="<%=lblProceed%>">
                <input name="button2" type="button" class="commonButton" id="bid-up-level" title="<%=lblCancel%>"   onClick="window.location='/server/domains.asp'" value="<%=lblCancel%>"  >
              </div></td>
          </tr>
        </table>
	  
      <div align="center"><img src="skins/<%=session("skin")%>/elements/line.gif" width=564 height=1 border=0> 
    </div>
    <!-------------------------------------------------------------------------------------------------------->
   
    <table width="56%" border="1" align="center" bordercolor="#FFFFFF">
      <tr> 
        
    </table>
        <table width="56%" border="1" align="center" bordercolor="#FFFFFF">
          <tr> 
            <td width="100%"> <div align="center"><img src="skins/<%=session("skin")%>/elements/line.gif" width=564 height=1 border=0> 
              </div></td>
          </tr>
          <tr> 
            <td> <div align="right"> </div></td>
          </tr>
        </table>
</form>
</body>
<%End if%>
<!-- #INCLUDE FILE = "../inc/footer.asp" -->