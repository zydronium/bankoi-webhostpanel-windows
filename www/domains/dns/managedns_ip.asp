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
		var cnt = parseInt(document.ipform.ipcount.value)
		flag = false;
		if(cnt > 1) {
			for (i = 0 ;i<cnt;++i){
				if(document.ipform.checkid[i].checked){
					flag=true;
					break;
				}
			}
		}else{
			if(document.ipform.checkid.checked)
				flag=true;
		}
		if(flag){
			document.ipform.mode.value="delete"
			document.ipform.submit();
		}else{
			alert("<%=msg136%>");
		}
	}
	function modifyIt(){
		for(var i=0 ; i<document.ipform.length; ++i){
			if(document.ipform.elements[i].name.indexOf("modip_") == 0){
				if(document.ipform.elements[i].value==""){
					alert("<%=msg137%>");
					document.ipform.elements[i].focus();
					return false;
				}
				if(!parseIP(document.ipform.elements[i].value)){
					alert("<%=msg138%>");
					document.ipform.elements[i].focus();
					return false;
				}
			}
		}
		document.ipform.mode.value="modify"
		document.ipform.submit();
	}
	function addIt(){
		if(document.ipform.addip.value==""){
			alert("<%=msg137%>");
			document.ipform.addip.focus();
			return false;
		}
		if(!parseIP(document.ipform.addip.value)){
			alert("<%=msg138%>");
			document.ipform.addip.focus();
			return false;
		}
		return true;
	}
	function parseIP(par){
		var ipArr = par.split(".");
		if(ipArr.length != 4)
			return false;
		else{
			for (j=0;j<4;++j){
				if((isNaN(ipArr[j])) || (ipArr[j] > 255) || (ipArr[j] < 0) ){
					return false;
				}
			}
			return true;
		}
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

<% 'on error resume next
	dim oDb,oRs
	set oDb = con	

%>


<div align="center"><strong><font size="2" face="Verdana, Arial">
<a href="managedns.asp" class="dnsHeadLink"><%=lbl751%></a> 
| <font color="#FF0000"><%=lbl747%></font> | <a href="managedns_mx.asp" class="dnsHeadLink"><%=lbl748%></a> | <a href="managedns_cname.asp" class="dnsHeadLink"><%=lbl749%></a></font></strong></div>


<table width="60%" border="0" align="center" cellpadding="3" cellspacing="1" >
<tr>
<td bgcolor="<%=sheadColor%>" class="head" width="100%">
</td>
</tr>
<tr>
<td>&nbsp;</td>
</tr>
<form name="ipform" method="post" action="managedns_ipprocess.asp" onSubmit="return addIt()">
		<%
			set rsIP = server.CreateObject("ADODB.RecordSet")
			rsIP.open "select * from dns_data where rectype='A' and domainid="& domainid, con
			if(Not rsIP.EOF) then
		%>
		<tr>
		  <td><div align="center">
			  <p><strong><font size="2" face="Verdana, Arial"><strong><%=lbl515%></strong></font> "<%=domainName%>"</strong></p>
			  
							
          <table width="88%" border="0" align="center" cellpadding="1" cellspacing="1">
            <tr> 
              <td colspan="3" valign="top"><font size="2" face="Verdana, Arial">&nbsp;</font> 
                <table width="100%" border="0" align="center" cellpadding="1" cellspacing="1">
                  <tr bgcolor="#003366"> 
                    <td width="48%"><strong><font color="#FFFFFF" size="2" face="Verdana, Trebuchet MS"><%=lbl549%></font></strong></td>
                    <td width="36%"><strong><font color="#FFFFFF" size="2" face="Verdana, Trebuchet MS"><%=lbl515%></font></strong></td>
                    <td width="16%"><div align="center"><font color="#FFFFFF" face="Verdana, Trebuchet MS"><strong><font size="2"><%=lbl550%></font></strong></font></div></td>
                  </tr>
                  <%
								  
								  ipCount = 0
								  while (not rsIP.eof )
								  	host = rsIP("host")
									if(len(host)>0) then
										host = host '& "."
									end if
									dns_id=rsIP("id")

								  %>
                  <tr bgcolor="#EBEDF5"> 
                    <td><font color="#009900" size="2" face="Verdana, Arial"><%=host%><font color="#000000"> 
                      <%'=domainName%>
                      </font></font></td>
                    <td><font size="2" face="Verdana, Arial"> 
                      <input name="modip_<%=dns_id%>" type="text" value="<%=rsIP("rside")%>" maxlength="15">
                      </font></td>
                    <td><div align="center"> 
                        <input name="checkid" type="checkbox" id="checkid" value="<%=dns_id%>">
                      </div></td>
                  </tr>
                  <%
								  rsIP.movenext
								  ipCount = ipCount + 1
								  wend
				  %>
                  <input name="ipcount" type="hidden" value="<%=ipCount%>">
                </table>
				
				</td>
            </tr>
            <tr> 
              <td colspan="2"><font size="2" face="Verdana, Arial">&nbsp;</font></td>
              <td width="47%">&nbsp;</td>
            </tr>
            <tr> 
              <td colspan="3"><div align="center"> 
                  <p> 
                    
                    &nbsp;&nbsp;&nbsp; 
                    <input type="button" name="Submit2" value="<%=lbl754%>" onClick="deleteIt()" class="commonButton">
                    &nbsp;&nbsp;&nbsp; 
                    <input type="button" name="Submit32" value="<%=lbl693%>" onClick="modifyIt()" class="commonButton">
                    &nbsp;&nbsp;&nbsp; </p>
                  <p>&nbsp;</p>
                </div>
				</td>
            </tr>
			<%
				else
					Response.write "<tr><td colspan='2'><font color=red face=verdana>Sorry no HOST record for this Domain</font></td><td width='47%'>&nbsp;</td>"
				End if
			%>
			<input name="mode" type="hidden" id="mode" value="add">
            <tr valign="middle"> 
              <td width="45%" bgcolor="#003366"><font color="#FFFFFF" size="2" face="Verdana, Trebuchet MS"><%=lbl753%>: 
                </font><font color="#FFFFFF" size="2" face="Verdana, Trebuchet MS">&nbsp; 
                </font></td>
              <td width="8%" bgcolor="#003366">&nbsp;</td>
              <td bgcolor="#003366"><font color="#FFFFFF" size="2" face="Verdana, Trebuchet MS"><%=lbl756%> </font><font color="#FFFFFF" size="2" face="Verdana, Trebuchet MS">&nbsp; 
                </font></td>
            </tr>
            <tr valign="middle" bgcolor="#EBEDF5"> 
              <td><font color="#003366" size="2" face="Verdana, Trebuchet MS"> 
                <input name="addhost" type="text" id="addhost2">
                </font></td>
              <td><font color="#003366" size="2" face="Verdana, Trebuchet MS">.<%=domainname%></font></td>
              <td><font color="#003366" size="2" face="Verdana, Trebuchet MS"> 
                <input name="addip" type="text" id="addip3" maxlength="15">
                </font></td>
            </tr>
            <tr> 
              <td colspan="3">&nbsp;</td>
            </tr>
            <tr> 
              <td colspan="3"><div align="center"> 
                  <input type="submit" name="Submit" value="<%=lbl755%>" class="commonButton">
                </div></td>
            </tr>
          </table>
						  </form>
</div></td>
</tr>
 </table>
</td></tr></table>
          
</body>
</html>
<br>
<!-- #include file="../../inc/footer.asp" -->




