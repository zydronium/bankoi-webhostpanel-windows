<%
	accessLevel = 5
%>
<table align="center">
<tr>
<td align="center" colspan="5">
<center><font name="verdana" color="red"><%=ucase(username)%></font> <%=lblmenu%></center>
</td>
</tr>
<tr> 
<%
	if(id <> 0) then
%>
  </p>
  <tr> 
    <td colspan="5"> <img src="/skins/<%=session("skin")%>/elements/white.gif" alt="" width="3" height="1" border="0"></td>
  </tr>
  <tr> 
    <td colspan="5"> <table width="539" align="center">
        <tr> 
          <td width="97"> <div align="center"> 
              <input type="button" name="adddomain" value="<%=lblNewDomain%>" class="commonButton" onclick = "window.location='/server/new_domain.asp'" title="<%=lblNewDomain%> for <%=username%>" onmouseover="window.status='<%=lblNewDomain%>'" onmouseout="window.status=''">
            </div></td>
          <%

 end if

    '---------------------------------------------------------------------------------------------
	'Checking the type and then deciding the navigation of the control
    usertype=session("type")
	'response.write "The type is " & usertype
	if(usertype="a") then
%>
            <td><div align="center"> 
                <input type="button" name="Button" value="<%=lblLimits%>" class="commonButton" onClick="window.location='/clients/clientlimits.asp'" title="<%=lblLimits%> for <%=username%>" onmouseover="window.status='<%=lblLimits%>'" onmouseout="window.status=''">
              </div></td>
<%else%>
			<td><div align="center"> 
                <input type="button" name="Button" value="<%=lblLimits%>" class="commonButton" onClick="window.location='/clients/limits.asp'" title="<%=lblLimits%> for <%=username%>" onmouseover="window.status='<%=lblLimits%>'" onmouseout="window.status=''">
              </div></td>
<%end if%>
            <td ><div align="center"> 
                <input type="button" name="Button2" value="<%=lblContactInfo%>" class="commonButton" onclick="window.location='/clients/clientinfo.asp'" title="<%=lblContactInfo%> for <%=username%>" onmouseover="window.status='<%=lblContactInfo%>'" onmouseout="window.status=''">
              </div></td>
            <td><div align="center"> 

                
            <input type="button" name="Button3" value="<%=lblPreference%>" class="commonButton" onClick="window.location='/clients/clientpreferences.asp'" title="<%=lblPreference%> for <%=username%>" onmouseover="window.status='<%=lblPreference%>'" onmouseout="window.status=''">
              </div></td>

			  <td><div align="center"> 
                <input type="button" name="Button3" value="<%=lblIPPool%>" class="commonButton" onClick="window.location='/server/assignip.asp'" title="<%=lblIPPool%> for <%=username%>" onmouseover="window.status='<%=lblIPPool%>'" onmouseout="window.status=''">
              </div></td>
            <td  height="35" align="right">&nbsp; </td>
          </tr>
		  <tr>
        <td><input type="button" name="Button32" value="<%=lbl745%>" class="commonButton" onClick="window.location='/clients/ClientDnsTemplate.asp'" title="<%=lbl731 & " " & lbl718 & " " & username%>"></td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td >&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td  height="35" align="right">&nbsp;</td>
      </tr>
</table>