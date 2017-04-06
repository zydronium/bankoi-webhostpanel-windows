<form name="form1" method="post" action="">
<br>
  <table width="564" border="0" align="center" cellpadding="0" cellspacing="0" class="topHead">
   <tr>
	  <td colspan="5"><div align="center"><img src="<%=session("logoname")%>"></div></td>
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
          <input type="button" name="Button" value="<%=lblClient%>" class="navigationButton" onClick="window.location='/clients/clients.asp'" title="<%=lblClient%>" onmouseover="window.status='<%=lblClient%>'" onmouseout="window.status=''">
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
          <input type="button" name="Button" value="<%=lblDomains%>" class="navigationButton" onClick="window.location='/clients/unselect.asp'" title="All Domains" onmouseover="window.status='<%=lblDomains%>'" onmouseout="window.status=''">
          <%else%>
          <input type="button" name="Button" value="<%=lblDomains%>" class="navigationButton" onClick="window.location='/domains/clientdomains.asp'" title="All Domains" onmouseover="window.status='<%=lblDomains%>'" onmouseout="window.status=''">
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

          <input type="button" name="Button" value="<%=lblServer%>" class="navigationButton" title="<%=lblServer%>" onClick="window.location='/server/server.asp'" onmouseover="window.status='<%=lblServer%>'" onmouseout="window.status=''">
<%
else
%>

<%
end if
%>
</td><td>&nbsp;</td>
	 
	  <td width="127"> <div align="left">
          <input type="button" name="Button" value="<%=lblLogout%>" class="navigationButton" id="bid-logout" onClick="window.location='/logout.asp';" title="<%=lblLogout%>" onmouseover="window.status='<%=lblLogout%>'" onmouseout="window.status=''">
        </div></td>
	</tr>
  </table>
</form>
