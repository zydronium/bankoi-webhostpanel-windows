
<center><%=lbl561%> <font name="verdana" color="red"><%=ucase(session("domain"))%></font> of <font name="verdana" color="red"><%=ucase(session("contactname"))%></font></center>
<table width="57%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr> 
    <td width="16%"> <div align="left"> 
        <%
    '------------------------------------------------------------------------------------------------
	'Here we are checking whether admin or the client has logged in and then deciding the redirection
    usertype=session("type")
	'response.write "The type is " & usertype
	query="select * from tblrights where id='" & session("id") & "'"
	'response.write query
	set rsrights=Server.CreateObject("ADODB.recordset")
	rsrights.Open query,con
	protect=rsrights("pwdprotectdir")
	cgisupport=rsrights("cgisupport")
	frontpage=rsrights("frontpageext")
	aspdotnt=rsrights("aspdotnetsupport")
	webstart=rsrights("webstats")
	set rsrights=nothing
	if(usertype="d") then
%>
        <input type="button" name="adddomain" value="<%=lbl562%>" class="commonButton" onClick = "window.location='/domains/edit_domain.asp'" style="TEXT-DECORATION: none" checked title="<%=lbl563%>" onmouseover="window.status='<%=lbl562%>'" onmouseout="window.status=''">
        <%else%>
        <input type="button" name="adddomain" value="<%=lbl562%>" class="commonButton" onClick = "window.location='/server/domaininfo.asp'" style="TEXT-DECORATION: none" checked onmouseover="window.status='<%=lbl562%>'" onmouseout="window.status=''">
        <%end if%>
      </div></td>
    <td width="21%"> <div align="left"> 
        <input type="button" name="adddomain3" value="<%=lbl564%>" class="commonButton" onClick = "window.location='/domains/mailaccount.asp'" style="TEXT-DECORATION: none" checked title='<%=lbl565 & " " & session("domain")%>' onmouseover="window.status='<%=lbl564%>'" onmouseout="window.status=''">
      </div></td>
    <td width="20%"> <div align="left"> 
        <input type="button" name="adddomain2" value="<%=lbl566%>" class="commonButton" onClick = "window.location='/domains/emailalias.asp'" title='<%=lbl567 & " " & session("domain")%>' onmouseover="window.status='<%=lbl566%>'" onmouseout="window.status=''">
      </div></td>
    <td width="23%"> <div align="left"> 
        <input type="button" name="Button3" value="<%=lbl568%>" class="commonButton" onClick="window.location='/domains/ftpusers.asp'" title="<%=lbl569 & " " & session("domain")%>" onmouseover="window.status='<%=lbl568%>'" onmouseout="window.status=''">
      </div></td>
    <td width="20%"><input type="button" name="Button32" value="<%=lbldatabases%>" class="commonButton" onClick="window.location='/domains/sqldatabase.asp'" title='<%=lbl570 & " " & session("domain")%>'  onmouseover="window.status='<%=lbldatabases%>'" onmouseout="window.status=''"></td>
    <td width="0%"  height="35" align="right">&nbsp;</td>
  </tr>
  <tr> 
    <td> <div align="left"> 
        <% if(usertype="d" and cgisupport="N") then %>
        <input type="button" name="Button33" value="<%=lbl523%>" class="commonButton" onClick="window.location='/domains/cgisupport.asp'" title='<%=lbl571 & " " & session("domain")%>' disabled onmouseover="window.status='<%=lbl523%>'" onmouseout="window.status=''">
        <%else%>
        <input type="button" name="Button33" value="<%=lbl523%>" class="commonButton" onClick="window.location='/domains/cgisupport.asp'" title='<%=lbl571 & " " & session("domain")%>' onmouseover="window.status='<%=lbl523%>'" onmouseout="window.status=''">
        <% end if %>
      </div></td>
    <td><div align="left"> 
        <% if(usertype="d" and aspdotnt="N") then %>
        <input type="button" name="Button34" value="<%=lbl519%>" class="commonButton" onClick="window.location='/domains/aspdotnetsupport.asp'" title='<%=lbl572 & " " & session("domain")%>' disabled onmouseover="window.status='<%=lbl519%>'" onmouseout="window.status=''">
        <%else%>
        <input type="button" name="Button34" value="<%=lbl519%>" class="commonButton" onClick="window.location='/domains/aspdotnetsupport.asp'" title='<%=lbl572 & " " & session("domain")%>' onmouseover="window.status='<%=lbl572%>'" onmouseout="window.status=''">
        <% end if %>
      </div></td>
    <td> <div align="left"> 
        <% if(usertype="d" and frontpage="N") then %>
        <input type="button" name="Button3322" value="<%=lbl573%>" class="commonButton" onClick="window.location='/domains/frontpageext.asp'" title='<%=lbl574 & " " & session("domain")%>' disabled onmouseover="window.status='<%=lbl574%>'" onmouseout="window.status=''">
        <%else%>
        <input type="button" name="Button3322" value="<%=lbl573%>" class="commonButton" onClick="window.location='/domains/frontpageext.asp'" title='<%=lbl574 & " " & session("domain")%>' onmouseover="window.status='<%=lbl574%>'" onmouseout="window.status=''">
        <%end if%>
      </div></td>
    <td> <div align="left"> 
        <% if(usertype="d" and webstart="N") then %>
        <input type="button" name="Button3322" value="<%=lbl575%>" class="commonButton" onClick="window.location='/domains/webstart.asp'" title='<%=lbl576 & " " & session("domain")%>' disabled onmouseover="window.status='<%=lbl575%>'" onmouseout="window.status=''">
        <%else%>
        <input type="button" name="Button3322" value="<%=lbl575%>" class="commonButton" onClick="window.location='/domains/webstart.asp'" title='<%=lbl576 & " " & session("domain")%>' onmouseover="window.status='<%=lbl575%>'" onmouseout="window.status=''">
        <%end if%>
      </div></td>
    <td> 
      <% if(usertype="d" and protect="N") then %>
      <input type="button" name="Button35" value="<%=lbl577%>" class="commonButton" onClick="window.location='/domains/explorer.asp'" title='<%=lbl578 & " " & session("domain")%>' disabled onmouseover="window.status='<%=lbl577%>'" onmouseout="window.status=''"> 
      <%else%>
      <input type="button" name="Button35" value="<%=lbl577%>" class="commonButton" onClick="window.location='/domains/explorer.asp'" title='<%=lbl578 & " " & session("domain")%>' onmouseover="window.status='<%=lbl577%>'" onmouseout="window.status=''"> 
      <%end if%>
    </td>
    <td  height="35" align="right">&nbsp;</td>
  </tr>
  <tr> 
    <td><input type="button" name="Button36" value="<%=lbl579%>" class="commonButton" onClick="window.location='/domains/changepass.asp'" title='<%=lbl580 & " " & session("domain")%>' onmouseover="window.status='<%=lbl579%>'" onmouseout="window.status=''"></td>
    <td><input type="button" name="Button362" value="<%=lbl581%>" class="commonButton" onClick="window.location='/domains/databasetype.asp'" title='<%=lbl582 & " " & session("domain")%>' onmouseover="window.status='<%=lbl582%>'" onmouseout="window.status=''"></td>
    <td><input type="button" name="Button332" value="<%=lbl583%>" class="commonButton" onClick="window.location='/domains/manageusers.asp'" title='<%=lbl584 & " " & session("domain")%>' onmouseover="window.status='<%=lbl583%>'" onmouseout="window.status=''"></td>
    <td><input type="button" name="Button3323" value="<%=lbl585%>" class="commonButton" onClick="window.location='/domains/hostentries.asp'" title='<%=lbl586 & " " & session("domain")%>' onmouseover="window.status='<%=lbl586%>'" onmouseout="window.status=''"></td>
    <td><input type="button" name="Button33882" value="<%=lbl587%>" class="commonButton" onClick="window.location='/domains/changecustomerrors.asp'" title='<%=lbl588 & " " & session("domain")%>' onmouseover="window.status='<%=lbl588%>'" onmouseout="window.status=''"></td>
    <td  height="35" align="right">&nbsp;</td>
  </tr>
  <tr>
    <td><input type="button" name="Button3372" value="<%=lbl589%>" class="commonButton" onClick="window.location='/domains/changedefaultdocs.asp'" title='<%=lbl590 & " " & session("domain")%>' onmouseover="window.status='<%=lbl590%>'" onmouseout="window.status=''"></td>
    <td><input type="button" name="Button33882" value="<%=lbl719%>" class="commonButton" onClick="window.location='/domains/permexplorer.asp'" title='<%=lbl719%><%=" " & session("domain")%>' onmouseover="window.status='<%=lbl719%>'" onmouseout="window.status=''"></td>
    <td>
	<%
			If (Ucase(dnsSupport) = "Y") then
	%>
		<input type="button" name="Button3324" value="<%=lbl730%>" class="commonButton" onClick="window.location='/domains/dns/managedns.asp'" title='<%=lbl730 & " " & lbl718 & " " & session("domain")%>' onmouseout="window.status='Bankoi Webhost Panel'" onmouseover="window.status='<%=lbl730%>'">
	<%
			Else
	%>
		<input type="button" name="Button3324" value="<%=lbl730%>" class="commonButton" onClick="window.location='/domains/dns/managedns.asp'" title='<%=lbl730 & " " & lbl718 & " " & session("domain")%>' onmouseout="window.status='Bankoi Webhost Panel'" onmouseover="window.status='<%=lbl730%>'" Disabled>
	<%
			End if
	%>
	</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td  height="35" align="right">&nbsp;</td>
  </tr>
</table>

