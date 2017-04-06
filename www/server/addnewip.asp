<%
	accessLevel = 10
%>
<!-- #INCLUDE FILE = "../inc/security.asp" -->
<!-- #INCLUDE FILE="../inc/db.asp" --><head>
<title>
Add Ip Address
</title>
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/general.css">
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/custom.css">
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/layout.css">
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=ISO-8859-1">
<META HTTP-EQUIV="EXPIRES" CONTENT="0">
</head>
<script>
function chk(f)
{
	if(f.ipaddress.value=="")
		{
			alert("Please provide an IP address!");
			f.ipaddress.focus();
			return false;
		}
	return true;
}

function submit_form(f)
{
	f.action="removeipadd.asp";
	f.submit();
	return false;
}
</script>

<%
dim count : count =0
  query="select count(*) as ipcount from tblserverip where upper(iptype)=Upper('shared')"
  dim rsiptype
  set rsiptype=server.createobject("ADODB.Recordset")
  rsiptype.open query,con
  count=rsiptype("ipcount")
  '---------------------------------------------------------------------------------------------
%>

<!-- #include file="../inc/header.asp" -->

<br>
<br>
<body>

<form method="POST" action="addnewip1.asp" name="mainform">
  <div align="center">
<%
  query="select * from tblserverip"
  dim rsip
  set rsip=server.createobject("ADODB.Recordset")
  rsip.open query,con
%>
    <table border="0" width="56%" cellspacing="0" cellpadding="0">
      <tr> 
        <td colspan="3">IP Listing</td>
      <tr> 
      <tr> 
        <td colspan="5"> <p align="left"><img src="/skins/<%=session("skin")%>/elements/line.gif" width=564 height=1 border=0></td>
      </tr>
      <tr> 
        <td colspan="2">&nbsp;</td>
        <td width="7%">&nbsp;</td>
        <td width="54%" colspan="2">&nbsp;</td>
      </tr></center>
      <%
	If(not rsip.EOF) then
	While(not rsip.EOF)
%>
      <tr> 
        <td colspan="2"><div align="right"><font color="blue" face="verdana" size="2"><%=rsip("ipaddress")%></font></div></td>
        <td width="7%">&nbsp;</td>
        <td width="27%"><font color="Red" face="verdana" size="2"><%=rsip("iptype")%></font></td>
        <td width="27%"> <div align="center">
            <input type="checkbox" name="ipaddresses" Value="<%=rsip("ipaddress")%>">
          </div></td>
      </tr>
      <%
	rsip.movenext
	wend
	Else
		Response.write "No Ip address added"
	End if
%>
	  <tr> 
      <tr> 
        <td colspan="5"> <p align="Right">&nbsp;</td>
      </tr>
      <tr> 
      <tr> 
      <tr> 
        <td colspan="5"> <p align="Right"><input type="button" name="remove" value="<%=lblRemoveIp%>" class="commonButton" onClick = "return submit_form(document.mainform)" title="<%=lblRemoveIpAddress%>"></td>
      </tr>
      <tr> 
        <td colspan="5"><img src="/skins/<%=session("skin")%>/elements/line.gif" width=564 height=1 border=0></td>
      </tr>
    </table>

<br><br>


        <table border="0" width="56%" cellspacing="0" cellpadding="0">
          <tr> 
        <td colspan="3"><%=lblAddnewIPaddress%></td>	
         <tr> 
		  <tr> 
            <td colspan="4"> <p align="left"><img src="/skins/<%=session("skin")%>/elements/line.gif" width=564 height=1 border=0></td>
          </tr>
          <tr> 
            <td colspan="4"  align="center"><font color="red" size="1"><%=lblthere%> <font color="blue">shared</font> IP</font></td>
          </tr>
		  <tr> 
            <td colspan="4"  align="center">&nbsp;</td>
          </tr>
          <tr> 
            <td colspan="2"><div align="right"><font face="Verdana" size="2"><%=lblNewIP%></font></div></td>
            <td width="7%"></td>
            <td width="54%"><input type="text" name="ipaddress" size="28" style="border-style: groove"></td>
          </tr></center> 

		  <tr> 
            <td colspan="2"><div align="right"><font face="Verdana" size="2"><%=lblIPType%></font></div></td>
            <td width="7%"></td>
            <td width="54%">

				<select name="iptype" style="border-style: groove">
					<%

					if((cint(count) < 1)) then
					%>
						<option><%=lblShared%></option>
					<% end if %>
					<option><%=lblExclusive%></option>
				</select>
			</td>
          </tr><td width="29%"></center> 
          <tr> 

          <tr> 
            <td colspan="4"> <p align="center">&nbsp;</td>
          </tr>
          <tr> 
            <td colspan="4"><img src="/skins/<%=session("skin")%>/elements/line.gif" width=564 height=1 border=0></td>
          </tr>
          <tr>
            <td colspan="4"> <div align="center"> 
                <input type="submit" name="Addip" value="<%=lbladdip%>" class="commonButton" onClick = "return chk(document.mainform)" title="<%=lblNewIP%>">
                <input type="button" name="cancel2" value="<%=lblCancel%>" class="commonButton" onClick = "window.location='server.asp'" title="<%=lblCancel%>">
              </div></td>
          </tr>
        </table>
  </div>
</form>
</body>
</html>
<br>
<br>
<!-- #INCLUDE FILE = "../inc/footer.asp" -->








