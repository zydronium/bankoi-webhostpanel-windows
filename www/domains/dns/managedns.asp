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
<div align=center>
				  <table width="564" border="0" align="center" cellpadding="4" cellspacing="0" >

				<tr bgcolor="<%=sheadColor%>">

				  <td bgcolor="<%=sheadColor%>">
<div align="center" ><font color="#FF0000" size="2" face="Verdana, Arial"><strong><%=lbl751%></strong></font> | <a href="managedns_ip.asp" class="dnsHeadLink"><%=lbl747%></a> | <a href="managedns_mx.asp" class="dnsHeadLink"><%=lbl748%></a> | <a href="managedns_cname.asp" class="dnsHeadLink"><%=lbl749%></a> </strong></div></td>
				</tr>		
				<tr>
				  <td><div align="center">
					  
      <p>&nbsp;</p>
					  
      <table width="91%" border="0" cellspacing="1" cellpadding="1">
	  
        <tr>
	  <%
			set rsIP = server.CreateObject("ADODB.RecordSet")
			rsIP.open "select * from dns_data where rectype='A' and domainid="& domainid, con
			if(not rsIP.EOF) then
	  %>
          <td width="26%" valign="top"><font size="2" face="Verdana, Arial"><a href="managedns_ip.asp" class="Link" ><%=lbl747%></a></font></td>
          <td width="74%">
		  <table width="100%" border="0" cellspacing="1" cellpadding="1">
              <tr bgcolor="#003366"> 
                <td><strong><font color="#FFFFFF" size="2" face="Verdana, Trebuchet MS" class="bodynormal"><%=lbl549%></font></strong></td>
                <td><strong><font color="#FFFFFF" size="2" face="Verdana, Trebuchet MS" class="bodynormal"><%=lbl515%></font></strong></td>
              </tr>
              <%
								  
								  while (not rsIP.eof )
								  	host = rsIP("host")
									if(len(host)>0) then
									host = host '& "." & domainName
									else
									host = domainName
									end if
								  %>
              <tr bgcolor="#EBEDF5"> 
                <td><font color="#003300" size="2" face="Verdana, Arial"><%=host%></font></td>
                <td><font color="#003300" size="2" face="Verdana, Arial"><%=rsIP("rside")%></font></td>
              </tr>
              <%
								  rsIP.movenext
								  wend
								  %>
            </table>
			<%
				else
					Response.write "<font color=red face=verdana>Sorry no HOST record for this Domain</font>"
				End if
			%>
			</td>
        </tr>
        <tr> 
          <td><font size="2" face="Verdana, Arial">&nbsp;</font></td>
          <td>&nbsp;</td>
        </tr>
        <tr> 
		<%
				set rsMAIL = server.CreateObject("ADODB.RecordSet")
				rsMAIL.open "select * from dns_data where rectype='MX' and domainid="& domainid, con
				if(not rsMAIL.EOF) then
		  %>
          <td valign="top"><font size="2" face="Verdana, Arial"><a href="managedns_mx.asp" class="Link"><%=lbl748%></a></font></td>
          <td>
		  

		  <table width="100%" border="0" cellspacing="1" cellpadding="1">
              <tr bgcolor="#003366"> 
                <td><font color="#FFFFFF" size="2" face="Verdana, Trebuchet MS"><strong class="bodynormal"><%=lbl549%></strong></font></td>
                <td><font color="#FFFFFF" size="2" face="Verdana, Trebuchet MS"><strong class="bodynormal"><%=lblServer%></strong></font></td>
                <td><font color="#FFFFFF" size="2" face="Verdana, Trebuchet MS"><strong class="bodynormal"><%=msg121%></strong></font></td>
              </tr>
              <%
								  
								  while (not rsMAIL.eof )
								  	host = rsMAIL("host")
									if(len(host)>0) then
									host = host '& "." & domainName
									else
									host = domainName
									end if

								  %>
              <tr bgcolor="#EBEDF5"> 
                <td><font color="#003300" size="2" face="Verdana, Trebuchet MS"><%=host%></font></td>
                <td><font color="#003300" size="2" face="Verdana, Trebuchet MS"><%=rsMAIL("rside")%></font></td>
                <td><font color="#003300" size="2" face="Verdana, Trebuchet MS"><%=rsMAIL("modifier")%></font></td>
              </tr>
              <%
								  rsMAIL.movenext
								  wend
								  %>
            </table>
			<%
				else
					Response.write "<br><font color=red face=verdana>Sorry no MAIL EXCHANGE record for this Domain</font>"
				End if
			%>
			</td>
        </tr>
        <tr> 
          <td><font size="2" face="Verdana, Arial">&nbsp;</font></td>
          <td>&nbsp;</td>
        </tr>
        <tr> 
		<%
			set rsCNAME = server.CreateObject("ADODB.RecordSet")
			rsCNAME.open "select * from dns_data where rectype='CNAME' and domainid="& domainid, con
			if(not rsCNAME.EOF) Then
		%>
          <td valign="top"><font size="2" face="Verdana, Arial"><a href="managedns_cname.asp" class="Link"><%=lbl749%></a></font></td>
          <td><table width="100%" border="0" cellspacing="1" cellpadding="1">
              <tr bgcolor="#003366"> 
                <td><font color="#FFFFFF" size="2" face="Verdana, Trebuchet MS"><strong class="bodynormal"><%=lbl544%></strong></font></td>
                <td><font color="#FFFFFF" size="2" face="Verdana, Trebuchet MS"><strong class="bodynormal"><%=lbl750%></strong></font></td>
              </tr>
              <%
								  
								  while (not rsCNAME.eof )
								  	host = rsCNAME("host")
									if(len(host)>0) then
									host = host '& "." & domainName
									else
									host = domainName
									end if

								  %>
              <tr bgcolor="#EBEDF5"> 
                <td><font color="#003300" size="2" face="Verdana, Trebuchet MS"><%=host%></font></td>
                <td><font color="#003300" size="2" face="Verdana, Trebuchet MS"><%=rsCNAME("rside")%></font></td>
              </tr>
              <%
								  rsCNAME.movenext
								  wend
								  %>
            </table>
			<%
				else
					Response.write "<br><font color=red face=verdana>Sorry no ALIAS record for this Domain</font>"
				End if
			%>
			</td>
        </tr>
        <tr> 
          <td valign="top"><font size="2" face="Verdana, Arial">&nbsp;</font></td>
          <td>&nbsp;</td>
        </tr>
        <!--<tr>

						  <td valign="top"><font size="2" face="Verdana, Arial"><a href="managedns_ns.asp" class="Link">Name
                                Servers</a></font></td>
						  <td><table width="92%" border="0" cellspacing="1" cellpadding="1">

							  <tr>

								<td><strong><font size="2" face="Verdana, Arial" class="bodynormal">Name
                                      Server</font></strong></td>
							  </tr>

							  <%
								  set rsNS = server.CreateObject("ADODB.RecordSet")
								  rsNS.open "select * from dns_data where rectype='NS' and domainid="& domainid, con
								  while (not rsNS.eof )
								  %>

							  <tr>

								<td><font size="2" face="Verdana, Arial"><%=rsNS("rside")%></font></td>
							  </tr>

							  <%
								  rsNS.movenext
								  wend
								  %>
						  </table></td>
						</tr>
						-->
      </table>
					  <p>&nbsp;</p>
					</div>
		<!-- #include file="../../inc/footer.asp" -->
</body>
</html>
    