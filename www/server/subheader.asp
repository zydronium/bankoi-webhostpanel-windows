<%
    if(ucase(session("type"))="D") then	    
	else
		if(len(session("reselid"))=0) then
		else  
%>
<center><font name="verdana" color="red"><%=ucase(session("contactname"))%></font> Menu</center>
<table width="56%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr> 
    <tr><td>
	  <div align="center">
		  <input type="button" name="adddomain" value="<%=lblNewDomain%>" class="commonButton" onclick = "window.location='/server/new_domain.asp'"  title="<%=lblNewDomainfor%> <%=" " & ucase(session("contactname"))%>">
		</div></td>
<%
'---------------------------------------------------------------------------------------------
	'Checking the type and then deciding the navigation of the control
    usertype=session("type")
	'response.write "The type is " & usertype
	if(usertype="a") then
%>
	  <td><div align="center"> 
        <input type="button" name="Button2" value="<%=lblLimits%>" class="commonButton" onClick="window.location='/clients/clientlimits.asp'" title="<%=lblLimitsfor%> <%=" " & ucase(session("contactname"))%>">
      </div></td>
<%else%>
			<td><div align="center"> 
                <input type="button" name="Button" value="<%=lblLimits%>" class="commonButton" onClick="window.location='/clients/limits.asp'" title="<%=lblLimitsfor%> <%=" " & ucase(session("contactname"))%>">
              </div></td>
<%end if%>

	  <td ><div align="center">
		  <input type="button" name="Button" value="<%=lblContactInfo%>" class="commonButton" onclick="window.location='/clients/clientinfo.asp'" title="<%=lblContactInfofor%> <%=" " & ucase(session("contactname"))%>">
		</div></td>
		<td><div align="center">
		  <input type="button" name="Button" value="<%=lblPreference%>" class="commonButton" onClick="window.location='/clients/clientpreferences.asp'" title="<%=lblPreferencefor%> <%= " " & ucase(session("contactname"))%>">
		</div></td>
	  <td  height="35" align="right">	  
	<input type="button" class="commonButton" id="assignip" value="<%=lblIPPool%>" title="<%=lblIPPool%>" onClick="window.location='/server/assignip.asp';" >
	</td>
	</tr>
	<tr>
        <td><input type="button" name="Button32" value="<%=lbl745%>" class="commonButton" onClick="window.location='/clients/ClientDnsTemplate.asp'" title="<%=lbl731 & " " & lbl718 & " " & ucase(session("contactname"))%>"></td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td >&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td  height="35" align="right">&nbsp;</td>
      </tr>
</table>
<%
    end if
   end if
%>