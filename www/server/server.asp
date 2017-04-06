<%
	accessLevel = 10
%>
<!-- #INCLUDE FILE = "../inc/security.asp" -->
<!-- #INCLUDE FILE = "../inc/db.asp" -->
<head>
<title>
<%=lblClient%>
</title>
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/general.css">
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/custom.css">
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/layout.css">
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=ISO-8859-1">
<META HTTP-EQUIV="EXPIRES" CONTENT="0">
</head>

<script>

function reboot()
{
	if(confirm("<%=msg85%>"))
	{
		location.href ="/server/reboot.asp";
	}
	else
	{
		return false;
	}		
}


function chk_form_data(f)
{
	f.submit();
	return true;
}

function invertChecked()
			{
				f = document.mainform;
				for (i = 0 ; i < f.elements.length; i++) {
					if ((f.elements[i].type == "checkbox") && (f.elements[i].name == "del")) {
						if (f.elements[i].checked || (f.elements[i].value == "DISABLED") || f.elements[i].disabled) {
							f.elements[i].checked = false;
						} else {
							f.elements[i].checked = true;
						}
					}
				}
			}

function restartIIS(){
	if(confirm('<%=msg86%>')){
		window.location='/server/restartiis.asp'
	}
}
</script>
<body leftmargin=0 topmargin=0 >
<div align="center">
  <!-- #include file="../inc/header.asp" -->
  <p><%=lbl702%></p>
  <table width="564" border="0" align="center" cellpadding="0" cellspacing="0" >
    <tr>
	  <td>
  <input type="button" name="changepass" value="<%=lbl534%>" class="commonButton" onClick="window.location='../server/ch_pass.asp'" title="<%=lbl534%>">
        <input type="button" name="ko2" value="<%=lbl703%>" class="commonButton" onClick = "window.location='addnewip.asp'" title="<%=lbl704%>"> 
      </td>
	</tr>
	<tr>
	  <td>&nbsp;</td>
	</tr>
	<tr>
	  <td>
	  <%
		  dim IISVer
		Set ObjVer=CreateObject("WScript.SHELL")
		IISVer = ObjVer.RegRead("HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\W3SVC\Parameters\MajorVersion")
		Set ObjVer = Nothing
		if(IISVer > 4) then 
	  %>
	  <input type="button" name="restartiis" value="<%=lbl705%>" class="commonButton" title="<%=lbl705%>" onClick="restartIIS()" Disabled>
	  <%
	  else
	  %>
		<input type="button" name="restartiis" value="<%=lbl705%>" class="commonButton" title="<%=lbl706%>" Disabled>
	  <%
	  end if
	  %>
	   <input type="button" name="Databaseservers" value="<%=lbl707%>" class="commonButton" title="<%=lbldatabases%>" onClick="window.location='manage_dbserver.asp'">
	  </td>
	</tr>
	<tr>
	  <td>&nbsp;</td>
	</tr>
	<tr>
	  <td><input type="button" name="restart" value="<%=lbl708%>" class="commonButton" title="<%=lbl709%>" id="bid-reboot" onClick="return reboot()">
	  <input type="button" name="dns" value="<%=lbl731%>" class="commonButton" title="<%=lbl731%>" onClick="window.location='dnstemplate.asp'"></td>
	</tr>
  </table>
  <!-- #include file="../inc/footer.asp" -->
</div>
</body>
</html>
