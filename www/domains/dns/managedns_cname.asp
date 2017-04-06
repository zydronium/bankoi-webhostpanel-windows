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
		var cnt = parseInt(document.aliasform.ipcount.value)
		flag = false;
		if(cnt > 1) {
			for (i = 0 ;i<cnt;++i){
				if(document.aliasform.checkid[i].checked){
					flag=true;
					break;
				}
			}
		}else{
			if(document.aliasform.checkid.checked)
				flag=true;
		}
		if(flag){
			document.aliasform.mode.value="delete"
			document.aliasform.submit();
		}else{
			alert("<%=msg122%>");
		}
	}
	function addIt(){
		if(document.aliasform.addip.value==""){
			alert("<%=msg123%>");
			document.aliasform.addip.focus();
			return false;
		}

		if(document.aliasform.addhost.value==""){
			alert("<%=msg124%>");
			document.aliasform.addhost.focus();
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

<div align="center"><strong><font size="2" face="Verdana, Arial"><a href="managedns.asp" class="dnsHeadLink"><%=lbl751%></a> | <a href="managedns_ip.asp" class="dnsHeadLink"><%=lbl747%></a> | <a href="managedns_mx.asp" class="dnsHeadLink"><%=lbl748%></a> | <font color="#FF0000"><%=lbl749%></font></font></strong></div>


<table width="564" border="0" align="center" cellpadding="3" cellspacing="1">
<tr>
<td bgcolor="<%=sheadColor%>" class="head">
</td>
</tr>
<tr>
  <td>&nbsp;</td>
</tr>
<tr>
  <td><div align="center">
	  <p><strong><font size="2" face="Verdana, Arial">Aliases </font>"<%=domainName%>"</strong></p>
	  <form name="aliasform" method="post" action="managedns_cnameprocess.asp" onSubmit="return addIt()">
							
        <table width="97%" border="0" cellspacing="1" cellpadding="1">
          <tr> 
            <td colspan="3" valign="top"><font size="2" face="Verdana, Arial">&nbsp;</font> 
              <table width="100%" border="0" align="center" cellpadding="1" cellspacing="1">
                
				<%
					set rsCNAME = server.CreateObject("ADODB.RecordSet")
					rsCNAME.open "select * from dns_data where rectype='CNAME' and domainid="& domainid, con
					if(Not rsCNAME.EOF) then
				%>
				
				<tr bgcolor="#003366"> 
                  <td><strong><font color="#FFFFFF" size="2" face="Verdana, Trebuchet MS"><%=lbl544%></font></strong></td>
                  <td><font color="#FFFFFF" size="2" face="Verdana, Trebuchet MS">&nbsp;</font></td>
                  <td><strong><font color="#FFFFFF" size="2" face="Verdana, Trebuchet MS"><%=lbl750%></font></strong></td>
                  <td><div align="center"><font color="#FFFFFF" size="2" face="Verdana, Trebuchet MS"><strong><%=lbl550%></strong></font></div></td>
                </tr>
                <%
								  
								  ipCount = 0
								  while (not rsCNAME.eof )
								  	host = rsCNAME("host")
									if(len(host)>0) then
										host = host '& "."
									end if
									dns_id=rsCNAME("id")

								  %>
                <tr bgcolor="#EBEDF5"> 
                  <td><font color="#003366" size="2" face="Verdana, Trebuchet MS"><%=host%> 
                    <%'=domainName%>
                    </font></td>
                  <td><div align="center"><font color="#003366" size="2" face="Verdana, Trebuchet MS"><%=lbl752%> </font></div></td>
                  <td><font color="#003366" size="2" face="Verdana, Trebuchet MS"> 
                    <%=rsCNAME("rside")%> </font></td>
                  <td><div align="center"> <font color="#003366" size="2" face="Verdana, Trebuchet MS"> 
                      <input name="checkid" type="checkbox" id="checkid" value="<%=dns_id%>">
                      </font></div></td>
                </tr>
                <%
								  rsCNAME.movenext
								  ipCount = ipCount + 1
								  wend
								  %>
                <input name="ipcount" type="hidden" value="<%=ipCount%>">
              </table></td>
          </tr>
          <tr> 
            <td colspan="2"><font size="2" face="Verdana, Arial">&nbsp;</font></td>
            <td>&nbsp;</td>
          </tr>
          <tr> 
            <td colspan="3"><div align="center"> 
                <p> 
                  
                  <input type="button" name="Submit2" value="<%=lbl754%>" class="commonButton" onClick="deleteIt()">
                </p>
                <p>&nbsp; </p>
              </div></td>
          </tr>
			<%
				else
					Response.write "<tr><td colspan='2'><font color=red face=verdana>Sorry no CNAME record for this Domain</font></td><td width='47%'>&nbsp;</td>"
				End if
			%>
		  <input name="mode" type="hidden" id="mode" value="add">
          <tr bgcolor="#003366"> 
            <td><strong><font color="#FFFFFF" size="2" face="Verdana, Trebuchet MS"><%=lbl753%>:<br>
              </font></strong></td>
            <td valign="bottom">&nbsp;</td>
            <td><strong><font color="#FFFFFF" size="2" face="Verdana, Trebuchet MS"><%=lbl750%></font></strong></td>
          </tr>
          <tr bgcolor="#EBEDF5"> 
            <td><font color="#003366" size="2" face="Verdana, Arial"> 
              <input name="addhost" type="text" id="addhost">
              </font></td>
            <td valign="bottom"><font color="#003366" size="2" face="Verdana, Arial">.<%=domainname%></font></td>
            <td><font color="#003366" size="2" face="Verdana, Arial"> 
              <input name="addip" type="text" id="addip2">
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
	  </td>
	  </tr>
	  </table>						  
</body>
</html>
<!-- #include file="../../inc/footer.asp" -->