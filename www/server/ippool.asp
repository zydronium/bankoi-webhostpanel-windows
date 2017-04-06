<%
	accessLevel = 10
%>
<img src="skins/<%=session("skin")%>/elements/line.gif" width=564 height=1 border=0></p>
      
	  
  <table width="55%" align="center" bordercolor="#FFFFFF" bgcolor="#E7EFFA" class="commonButton" border="3"><tr>
    <table width="560" border="0" align="center" cellpadding="0" cellspacing="0" dwcopytype="CopyTableCell">
      <tr> 
        <th><%=lbl680%> <font color="red" face="verdana"><strong><%="" & username%></strong></font>	</td></tr>
    </tr>
    <tr> 
      <td><div align="center"><strong> </strong></div>
    <tr>
<%
  query="select tblserverip.ipaddress from tblresellerip,tblserverip where tblresellerip.ipaddress=tblserverip.id and resellerid='" & session("reselid") & "'"
  dim rs2
  set rs2=server.createobject("ADODB.Recordset")
  rs2.open query,con
  while(not rs2.EOF)
%>
      <td><div align="center"><strong><font face="Verdana"><%=rs2("ipaddress")%></font></strong></div> 
<%
  wend
%>
  </table>
	  
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <div align="center"> </div>
      <div align="center"><img src="skins/<%=session("skin")%>/elements/line.gif" width=564 height=1 border=0> 
      </div>
      <!-- #INCLUDE FILE = "../inc/footer.asp" -->