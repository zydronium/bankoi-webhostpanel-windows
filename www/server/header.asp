<style>
</style>
<form name="form1" method="post" action="">
<br>
  <table width="564" border="0" align="center" cellpadding="0" cellspacing="0" class="topHead">
    <tr>
	  <td colspan="5"><div align="center"><img src="../logos/logo.gif"></div></td>
	</tr>
	<tr>
	  <td colspan="5">&nbsp;</td>
	</tr>
    <tr>
	  <td width="110"> 
        <%
if(ucase(session("type"))="A") then
%>
        <div align="left">
          <input type="button" name="Button" value="<%=lblClient%>" class="navigationButton" onClick="window.location='../clients/clients.asp'" title="<%=lblClient%>">
          <%
else
%>
          &nbsp; 
          <%
end if
%>
        </div></td>
	  <td width="107"> 
        <%
if( (ucase(session("type"))="A") or  (ucase(session("type"))="C" )) then
%>
<%	
    usertype=session("type")
	if(usertype="a") then
%>
        <div align="left">
          <input type="button" name="Button" value="<%=lblDomains%>" class="navigationButton" onClick="window.location='/clients/unselect.asp'" title="<%=lblalldomains%>">
          <%else%>
          <input type="button" name="Button" value="<%=lblDomains%>" class="navigationButton" onClick="window.location='/domains/clientdomains.asp'" title="<%=lblalldomains%>">
          <%end if%>
          <%
else
%>
          &nbsp; 
<%
end if
%>
        </div></td>
	  <td width="110"> 
        <%
if(ucase(session("type"))="A") then
%>
        <div align="left"></div>
        <div align="left">
          <input type="button" name="Button" value="<%=lblServer%>" class="navigationButton" title="<%=lblServer%>" onClick="window.location='/server/server.asp'">
          <%
else
%>
          &nbsp; 
          <%
end if
%>
        </div></td>
	  <td width="110">&nbsp;       
                
      </td>
	  <td width="127"> <div align="left">
          <input type="button" name="Button" value="<%=lblLogout%>" class="navigationButton" id="bid-logout" onClick="window.location='/logout.asp';" title="<%=lblLogout%>">
        </div></td>
	</tr>
  </table>
</form>
