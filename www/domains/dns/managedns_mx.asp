<%
accessLevel = 1
%>
<!-- #INCLUDE FILE = "../../inc/security.asp" -->
<!-- #INCLUDE FILE = "../../inc/db.asp" -->
<!-- #INCLUDE FILE = "../../inc/params.asp" -->
<!-- #INCLUDE FILE = "../../inc/functions.asp" -->
<%
  Response.Expires  = 0
  Response.ExpiresAbsolute = Now()
  Response.CacheControl = "no-cache"
%>

<html>
<head>
<title>DNS</title>
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/general.css">
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/custom.css">
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/layout.css">
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=ISO-8859-1">
<META HTTP-EQUIV="EXPIRES" CONTENT="0">
<script language="JavaScript">	
	function deleteIt(){
		if (! isNaN(document.mxform.ipcount.value)) {
			var cnt = parseInt(document.mxform.ipcount.value)
			flag = false;
			if(cnt > 1) {
				for (i = 0 ;i<cnt;++i){
					if(document.mxform.checkid[i].checked){
						flag=true;
						break;
					}
				}
			}else{
				if(document.mxform.checkid.checked)
					flag=true;
			}
			if(flag){
				document.mxform.mode.value="delete"
				document.mxform.submit();
			}else{
				alert("<%=msg139%>");
			}
		}else
			alert("<%=msg139%>");

	}
	function modifyIt(){
		for(var i=0 ; i<document.mxform.length; ++i){
			if(document.mxform.elements[i].name.indexOf("modmail_") == 0){
				if(document.mxform.elements[i].value==""){
					alert("<%=msg140%>");
					document.mxform.elements[i].focus();
					return false;
				}
			}
			if(document.mxform.elements[i].name.indexOf("rank_") == 0){
				if(document.mxform.elements[i].value==""){
					alert("<%=msg141%>");
					document.mxform.elements[i].focus();
					return false;
				}
				if(isNaN(document.mxform.elements[i].value)){
					alert("<%=msg142%>");
					document.mxform.elements[i].focus();
					return false;
				}

			}
		}
		document.mxform.mode.value="modify"
		document.mxform.submit();
	}
	function addIt(){
		if(document.mxform.addip.value==""){
			alert("<%=msg140%>");
			document.mxform.addip.focus();
			return false;
		}
		if(document.mxform.addrank.value==""){
			alert("<%=msg141%>");
			document.mxform.addrank.focus();
			return false;
		}
		if(isNaN(document.mxform.addrank.value)){
			alert("<%=msg142%>");
			document.mxform.addrank.focus();
			return false;
		}
		return true;
	}
</script>

</head>
<body>
<!-- #INCLUDE FILE = "../../inc/header.asp" -->
<!------------------------------------------------------------------------------------------------>
<!--Here the menu for Client is created-->
<!-- #INCLUDE FILE = "../../server/subheader.asp" -->
<!---------------------------------------------------------------------------

<!------------------------------------------------------------------------------
The header of reseller prepared here
-->
<!-- #INCLUDE FILE = "../domainheader.asp" -->
<!--
----------------------------------------------------------------------------
The header ends here
-->
<%
'on error resume next	
domainid = Session("id")
domainName = Session("domain")
%>
<div align="center"><strong><a href="managedns.asp" class="dnsHeadLink"><%=lbl751%></a><font size="2" face="Verdana, Arial"> | <a href="managedns_ip.asp" class="dnsHeadLink"><%=lbl747%></a> | <font color="#FF0000"><%=lbl748%></font> | <a href="managedns_cname.asp" class="dnsHeadLink"><%=lbl749%></a></font></strong></div>


          
				  <table width="60%" border="0" align="center" cellpadding="4" cellspacing="0" >
					<tr>
					  <td bgcolor="<%=sHeadColor%>" class="head">
</td>
					</tr>
					<tr>
					  <td height="25">&nbsp;</td>
					</tr>
					<tr>
					<form name="mxform" method="post" action="managedns_mxprocess.asp" onSubmit="return addIt()">
					<%
						set rsMX = server.CreateObject("ADODB.RecordSet")
						rsMX.open "select * from dns_data where rectype='MX' and domainid="& domainid, con
						if(Not rsMX.EOF) then
					%>
					  <td><div align="center">
						  
        <p><strong><%=lbl757%></strong></p>
						  
							
          <table width="94%" border="0" align="center" cellpadding="1" cellspacing="1">
            <tr> 
              <td colspan="4" valign="top"><font size="2" face="Verdana, Arial">&nbsp;</font> 
                <table width="100%" border="0" align="center" cellpadding="1" cellspacing="1">
                  <tr bgcolor="#003366"> 
                    <td width="32%"><font color="#FFFFFF" size="2" face="Verdana, Trebuchet MS"><strong><%=lbl549%></strong></font></td>
                    <td width="38%" align="center"><font color="#FFFFFF" size="2" face="Verdana, Trebuchet MS"><strong><%=lbl757%></strong></font></td>
                    <td width="13%" align="center"><strong><font color="#FFFFFF" size="2" face="Verdana, Trebuchet MS"><%=msg121%></font></strong></td>
                    <td width="17%"><div align="center"><font color="#FFFFFF" size="2" face="Verdana, Trebuchet MS"><strong><%=lbl550%></strong></font></div></td>
                  </tr>
                  <%
								  
								  ipCount = 0
								  while (not rsMX.eof )
								  	host = rsMX("host")
									if(len(host)>0) then
										host = host '& "."
									end if
									dns_id=rsMX("id")
									rank = rsMX("modifier")
								  %>
                  <tr bgcolor="#EBEDF5"> 
                    <td><font color="#009900" size="2" face="Verdana, Trebuchet MS"><%=host%><font color="#000000"> 
                      <%'=domainName%>
                      </font></font></td>
                    <td align="center"><font size="2" face="Verdana, Trebuchet MS"> 
                      <input name="modmail_<%=dns_id%>" type="text" value="<%=rsMX("rside")%>" >
                      </font></td>
                    <td align="center"><font size="2" face="Verdana, Trebuchet MS"> 
                      <input name="rank_<%=dns_id%>" type="text" value="<%=rank%>" maxlength="2" size="4">
                      </font></td>
                    <td><div align="center"> <font size="2" face="Verdana, Trebuchet MS"> 
                        <input name="checkid" type="checkbox" id="checkid" value="<%=dns_id%>">
                        </font></div></td>
                  </tr>
                  <%
								  rsMX.movenext
								  ipCount = ipCount + 1
								  wend
								  %>
                  <input name="ipcount" type="hidden" value="<%=ipCount%>">
                </table></td>
            </tr>
            <tr> 
              <td colspan="2"><font size="2" face="Verdana, Arial">&nbsp;</font></td>
              <td colspan="2">&nbsp;</td>
            </tr>
            <tr> 
              <td colspan="4"><div align="center"> 
                  <p> 
                    
                    <input type="button" name="Submit2" value="<%=lbl754%>" onClick="deleteIt()" class="commonButton">
                    &nbsp;&nbsp;&nbsp; 
                    <input type="button" name="Submit3" value="<%=lbl693%>" onClick="modifyIt()" class="commonButton">
                  </p>
                  <p>&nbsp; </p>
                </div></td>
            </tr>

			<%
				else
					Response.write "<tr><td colspan='2'><font color=red face=verdana>Sorry no MAIL EXCHANGE record for this Domain</font></td><td width='47%'>&nbsp;</td>"
				End if
			%>
			<input name="mode" type="hidden" id="mode" value="add">
            <tr bgcolor="#003366"> 
              <td bgcolor="#FFFFFF"><font color="#FFFFFF" size="2" face="Verdana, Trebuchet MS">&nbsp;<br>
                </font></td>
              <td valign="bottom"><font color="#FFFFFF" size="2" face="Verdana, Trebuchet MS"><strong><%=lbl549%></strong></font></td>
              <td><font color="#FFFFFF" size="2" face="Verdana, Trebuchet MS"><strong><%=lbl757%></strong><br>
                </font></td>
              <td><strong><font color="#FFFFFF" size="2" face="Verdana, Trebuchet MS"><%=msg121%></font></strong></td>
            </tr>
            <tr bgcolor="#EBEDF5"> 
              <td bgcolor="#FFFFFF"><font color="#003366" size="2" face="Verdana, Trebuchet MS"> 
                <input name="addhost" type="hidden" id="addhost2" value="">
                </font></td>
              <td valign="bottom"><font color="#003366" size="2" face="Verdana, Trebuchet MS"><%=domainname%></font></td>
              <td><font color="#003366" size="2" face="Verdana, Trebuchet MS"> 
                <input name="addip" type="text" id="addip">
                </font></td>
              <td><font color="#003366" size="2" face="Verdana, Trebuchet MS"><strong> 
                <input name="addrank" type="text" id="addrank2" size="4" maxlength="2">
                </strong></font></td>
            </tr>
            <tr> 
              <td colspan="4">&nbsp;</td>
            </tr>
            <tr> 
              <td colspan="4"><div align="center"> 
                  <!--	<input name="imageField" type="image" src="images/button_add.gif" width="43" height="17" border="0">-->
                  <input type="submit" name="Submit" value="<%=lbl755%>" class="commonButton">
                </div></td>
            </tr>
          </table>
						  </form>
						  
						</td>
					</tr>
				  </table>
</td></tr></table>
        <br><!-- #include file="../../inc/footer.asp" -->
</body>
</html>