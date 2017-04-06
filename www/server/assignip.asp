<%
	accessLevel = 5
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
  f.action = "/server/removeip.asp";
  f.submit();
  return true;
}
</script>

<%
 id=session("reselid")
  '---------------------------------------------------------------------------------------------
  'Here we are extracting the name of the reseller according to the id stored in the session

  query="select contactname from tblcontactinfo where id='" & session("reselid") & "'"
  dim rs
  set rs=server.createobject("ADODB.Recordset")
  rs.open query,con
  username=rs("contactname")
  '---------------------------------------------------------------------------------------------
%>

<body leftmargin=0 topmargin=0 >
<!-- #include file="../inc/header.asp" -->
 <form  method='post' name="mainform">
<!-- #include file="../clients/clientheader.asp" -->
      <p align="center">
	
<!------------------------------------------------------------------------------------------>	
<!-- This displays the selected IP of the selected client-->
<%
  'response.write "The reseller id is " & session("reselid") 
  query="select tblserverip.ipaddress,tblserverip.iptype,tblserverip.id from tblresellerip,tblserverip where tblresellerip.ipaddress=tblserverip.id and resellerid='" & session("reselid") & "'"
  dim rs2
  set rs2=server.createobject("ADODB.Recordset")
  rs2.open query,con,3
%>

   <table width="100%" align="center" bordercolor="#FFFFFF" bgcolor="#E7EFFA" class="commonButton" border="3"><tr>
    
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" dwcopytype="CopyTableCell">
      <tr> 
        <th colspan="4"><%=lblipassignedto%> <font color="red" face="verdana"><strong><%="" & username%></strong></font>	
      <tr> 
        <td colspan="3"></td>
      <tr> 
        <td colspan="3"></tr>
      <tr> 
        <td colspan="3"></tr>
      <tr> 
        <td colspan="3"><div align="center"><strong> </strong></div>
          <%
  sharedip=0
  while(not rs2.EOF)
  if(Ucase(rs2("iptype"))=Ucase("Shared")) then
		sharedip=sharedip+1
  end if
%>
      <tr> 
        <td width="226" height="20"><div align="right"><strong> 
            <%
		  if(not ucase(session("type"))="C") then
		%>
            <input type="checkbox" name="ipchk" value="<%=rs2("ipaddress")%>">
            <%
		  else
		  
		  end if
		%>
            </strong></div>
        <td width="111"><div align="center"><strong><font face="Verdana" color="Blue"><%=rs2("ipaddress")%></font></strong> 
          </div>
        <td width="223"><%=rs2("iptype")%> </tr>
      <%
  rs2.movenext
  wend
%>
      <tr> 
        <td height="34" colspan="3"> <div align="center"> </div></td>
      </tr>
      <tr> 
        <td height="10" colspan="3"> 
          <%
'-------------------------------------------------------------------------------------------------------------
'If the user is admin then this section will be displayed
    usertype=session("type")
	if(usertype="a") then

 if(not ucase(session("type"))="C") then
%>
          <div align="center"> 
            <input type="button" name="removeip" value="<%=lblRemoveSelected%>" class="commonButton" onClick = "return removeselected(document.mainform)" title="<%=lblremoveselip & " " & username%>">
          </div></td>
        <%
 else
 end if
%>
      </tr>
    </table>
	<br>
<%
	  if(sharedip=0) then
			query="select count(*) as ipcount from tblserverip where iptype='Shared' or (iptype='Exclusive' and isavailable='Y')"
      else
			query="select count(*) as ipcount from tblserverip where iptype='Exclusive' and isavailable='Y'"
	  end if
	  'response.write query

	  set rsip=server.createobject("ADODB.Recordset")
	  rsip.open query,con
	  ipcount=rsip("ipcount")
	  set rsip=nothing
	  if(cint(ipcount) > 0) then
%>
      <div align="center"><img src="skins/<%=session("skin")%>/elements/line.gif" width=564 height=1 border=0> 
    </div>
    <table width="100%" border="1" align="center" bordercolor="#FFFFFF">
      <tr> 
        <th ><%=msg104%> <font color="red" face="verdana"><strong><%="" & username%></strong></font>
    </table>
    <table width="56%" border="1" align="center" bordercolor="#FFFFFF">
      <tr> 
        <td width="49%"><div align="right"><font color="#000099" size="+1" face="Verdana"><%=lblselectip%></font></div></td>
        <td width="51%"> <div align="left">
            <select name="ipaddress" multiple>
              <%
  
  query="select * from tblserverip where iptype='Shared' or (iptype='Exclusive' and isavailable='Y')"
  'response.write query
  dim rsip
  set rsip=server.createobject("ADODB.Recordset")
  rsip.open query,con
  while(not rsip.EOF)
        str="select count(*) as flag from tblresellerip where tblresellerip.ipaddress='" & rsip("id") & "' and tblresellerip.resellerid='" & session("reselid") & "'"
		dim check
		set check =server.createobject("ADODB.Recordset")
		check.open str,con
		if(cint(check("flag"))>0) then
		   
        else
%>
              <option value="<%=rsip("id")%>"><%=rsip("ipaddress")&" / "&rsip("iptype")%></option>
              <%
        end if
  rsip.movenext

 wend
%>
            </select>
          </div></td>
      </tr>
      <tr> 
        <td colspan="2"> <div align="center"><img src="skins/<%=session("skin")%>/elements/line.gif" width=564 height=1 border=0> 
          </div></td>
      </tr>
      <tr> 
        <td colspan="2"> <div align="right"> 
          <input type="button" name="ko" value="<%=lblAssign%>" class="commonButton" onClick = "chk_form_data(document.mainform)" title="<%=lblAssignIP%>">
            <input name="Button232" type="button" class="commonButton" id="Button232" title="<%=lblCancel%>" onClick="window.location='/server/domains.asp';" value="<%=lblCancel%>" >
 <%else%>  
 <td align="center">
 
	
	<!--<input type="button" name="removeip" value="Ok" class="commonButton" onClick = "window.location='/domains/clientdomains.asp'" title="Remove Selected Ip for <%=username%>">-->
 

<%end if
 end if %>
          </td>
      </tr>
    </table>
</form>
</body>
</html>
<!-- #INCLUDE FILE = "../inc/footer.asp" -->


