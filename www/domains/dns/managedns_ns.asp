<!--#include virtual = "includes/top.asp"-->
<!--#include virtual = "includes/left.asp"-->
<!--#include virtual = "includes/functions.asp"-->

<!-- #INCLUDE FILE = "../inc/params.asp" -->
<%
If Session("Username") = "" Then Response.Redirect "default.asp"
  Response.Expires  = 0
  Response.ExpiresAbsolute = Now()
  Response.CacheControl = "no-cache"
%>
<%
IF Request.QueryString("st")="success " THEN
	Response.Write ("<Script>alert('Order Placed')</script>")
END IF
%>
<% IF Request.QueryString("avl")<>"" THEN
		Response.Write "Domain Name Not Available"
	END IF%>
<script language="JavaScript">
	function menu_popup()
	{
  	window.open("faq.htm","FAQs",0);
	}
	function deleteIt(){
		var cnt = parseInt(document.form1.ipcount.value)
		flag = false;
		if(cnt > 1) {
			for (i = 0 ;i<cnt;++i){
				if(document.form1.checkid[i].checked){
					flag=true;
					break;
				}
			}
		}else{
			if(document.form1.checkid.checked)
				flag=true;
		}
		if(flag){
			document.form1.mode.value="delete"
			document.form1.submit();
		}else{
			alert("You must select at least one alias to delete");
		}
	}
	function addIt(){
		if(document.form1.addip.value==""){
			alert("you must provide Actual domain");
			document.form1.addip.focus();
			return false;
		}
		return true;
	}
</script>
<% 'on error resume next
	dim oDb,oRs
	set oDb = Session("oCon")
	set oRs=server.CreateObject("ADODB.recordset")
	oRs.Open "select list,HomeDirectory from cp_site_details where siteId= "& session("siteid"),oDb
	Session("mlist") =trim(oRs.Fields(0).Value)
%>
<%
'On Error Resume next
dim rsSite
set rsSite = server.CreateObject("ADODB.REcordSet")
rsSite.open "select DomainName from cp_site_details where siteid=" & Session("siteid"), oDB
domainName = ""
if(not rsSite.eof ) then
	domainName = rsSite("DomainName")
else
	domainName = "No site found"
end if
	strLinuxConDB = "DSN=linux_cp_db;UID=controlpanel;PWD=qweasd;"
	dim linuxConn
	set linuxConn = Server.CreateObject("ADODB.Connection")
	linuxConn.Open strLinuxConDB
	Dim sheadColor
                          If Session("HeadColor")="" Then
							sheadColor="#336699"
						  Else
							sheadColor=Session("HeadColor")
						  End If

%>

			<table width="80%" height="100%" border="1" cellspacing="0" cellpadding="0" bgcolor="<%=Session("TableColor")%>" class=border>
              <tr valign="middle">
                <td class="bodynormal">
                  <table width="100%" cellspacing="0" cellpadding="4" border="0">
                    <tr>
                      <td bgcolor="<%=sheadColor%>" height="55" class="bodynormal" valign="top">
                        <table width="65%" border="0" cellspacing="0" cellpadding="3" align="center">
                          <tr>
                            <td class="head"><font color="#FFFFFF">Current</font><font color="#FFFFFF">
                              Site:</font></td>
                            <td class="head"><font color="#FFFFFF"><b><%=Session("SiteName")%></b></font></td>
                          </tr>
                          <tr>
                            <td class="head"><font color="#FFFFFF"> Webspace Allocated:</font></td>
                            <td class="head"><font color="#FFFFFF"><b><%=Session(session("Siteid"))%>
                              MB</b></font></td>
                          </tr>
                          <tr>
                            <td class="head"><font color="#FFFFFF">Actual Usage:</font></td>
                            <td class="head"><font color="#FFFFFF"><b><%=FormatNumber(Session("UsedDiskSpace"),2) %>
                              MB</b> </font> </td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr valign="top">
                <td>
				  <table width="100%" border="0" align="center" cellpadding="3" cellspacing="0" bgcolor="<%=Session("TableColor")%>">
					<tr bgcolor="<%=sheadColor%>">
					  <td>
                        <div align="center"><strong><font size="2" face="Verdana, Arial"><a href="managedns.asp" class="dnsHeadLink">View</a>
                          | <a href="managedns_ip.asp" class="dnsHeadLink">IP addresses
                          (A)</a> | <a href="managedns_mx.asp" class="dnsHeadLink">Mail
                          Servers (MX)</a> | <a href="managedns_cname.asp" class="dnsHeadLink">Aliases
                          (CNAME)</a> </font></strong></div>
                      </td>
					</tr>
					<tr>
					  <td>&nbsp;</td>
					</tr>
					<tr>
					  <td><div align="center">
						  <p><strong><font size="2" face="Verdana, Arial" class="head">Name
                            Servers </font>"<%=domainName%>"</strong></p>
						  <form name="form1" method="post" action="managedns_nsprocess.asp" onSubmit="return addIt()">
							<table width="69%" border="0" cellspacing="1" cellpadding="1">
							  <tr>
							    <td colspan="3" valign="top"><font size="2" face="Verdana, Arial">&nbsp;</font>
								  <table width="100%" border="0" align="center" cellpadding="1" cellspacing="1">
								    <tr>
							  		  <td><strong><font size="2" face="Verdana, Arial" class="head">Domain</font></strong></td>
									  <td>&nbsp;</td>
									  <td><strong><font size="2" face="Verdana, Arial" class="head">Name
                                        Server</font></strong></td>
									  <td>
                                        <div align="center"><strong><font size="2" face="Verdana, Arial" class="head">Select</font></strong></div>
                                      </td>
									</tr>
								    <%
								  set rsCNAME = server.CreateObject("ADODB.RecordSet")
								  rsCNAME.open "select * from dns_detail where type='NS' and site_id="& Session("siteid"), linuxConn
								  ipCount = 0
								  while (not rsCNAME.eof )
								  	host = rsCNAME("hostname")
									if(len(host)>0) then
										host = host & "."
									end if
									dns_id=rsCNAME("id")

								  %>
								    <tr>
							  		  <td><font color="#009900" size="2" face="Verdana, Arial"><%=host%><font color="#000000"><%=domainName%></font></font></td>
									  <td>
                                        <div align="center"><font size="1" face="Verdana, Arial" class="bodynormal">IN
                                          NS</font></div>
                                      </td>
									  <td><font size="2" face="Verdana, Arial">
										<%=rsCNAME("pointsto")%>
										</font></td>
									  <td><div align="center">
										  <input name="checkid" type="checkbox" id="checkid" value="<%=dns_id%>">
										</div></td>
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
									  <input name="mode" type="hidden" id="mode" value="add">

									 <!-- <input type="button" name="Submit2" value="Delete Selected" onClick="deleteIt()"> -->
									  <input name="imageField" type="image" src="images/button_delete.gif" width="63" height="17" border="0" onClick="deleteIt(); return false;">
									  									</p>
								  </div></td>
							  </tr>
							  <tr>
								<td><font size="2" face="Verdana, Arial"><span class="head">Domain:</span><br>
								  <input name="addhost" type="text" id="addhost">
								  </font></td>
								<td valign="bottom"><font size="2" face="Verdana, Arial">.<%=domainname%></font></td>
								<td><font size="2" face="Verdana, Arial"><span class="head">Name
                                  Server</span><br>
								  <input name="addip" type="text" id="addip">
								  </font></td>
							  </tr>
							  <tr>
								<td colspan="3">&nbsp;</td>
							  </tr>
							  <tr>
								<td colspan="3"><div align="center">
									<input name="imageField2" type="image" src="images/button_add.gif" width="43" height="17" border="0">
								<!--	<input type="submit" name="Submit" value="Add New"> -->
								  </div></td>
							  </tr>
						    </table>
						  </form>
						  <p><strong></strong></p>
						  <p>&nbsp;</p>
</div></td>
					</tr>


				  </table>
			</td></tr></table>
            <!--table width="80%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td align="center">
            <h3><font face="Verdana, Arial, Helvetica, sans-serif" color="#336699">Control
              Panel</font></h3>
          </td>
        </tr>
        <tr>
          <td>&nbsp;</td>
        </tr>
        <tr>
          <td align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2"><a href="managewebsitemenu.asp" class="link">Manage
            WebSite</a></font></td>
        </tr>
        <tr>
          <td align="center">
            <hr size="1" noshade>
          </td>
        </tr>
        <tr>
          <td align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2" class="link"><a href="dns/menu.htm">Manage
            DNS</a></font></td>
        </tr>
        <tr>
          <td align="center">
            <hr size="1" noshade>
          </td>
        </tr>
        <tr>
          <td align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2" class="link"><a href="chgpassform.asp">Change
            FTP Password</a></font></td>
        </tr>
        <tr>
          <td align="center">
            <hr size="1" noshade>
          </td>
        </tr>
        <tr>
          <td align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2" class="link">Manage
            DSN </font></td>
        </tr>
        <tr>
          <td align="center">
            <hr size="1" noshade>
          </td>
        </tr>
        <tr>
          <td align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2" class="link">Send
            New Order</font></td>
        </tr>
        <tr>
          <td align="center">
            <hr size="1" noshade>
          </td>
        </tr>
        <tr>
          <td align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2" class="link"><a href="orderhistory.asp" class="link">Order
            History </a></font></td>
        </tr>
        <tr>
          <td align="center">
            <hr size="1" noshade>
          </td>
        </tr>
        <tr>
          <td align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2" class="link"><a href="supportdesk.asp">Support
            Desk</a></font></td>
        </tr>
        <tr>
          <td align="center">
            <hr size="1" noshade>
          </td>
        </tr>
        <tr>
          <td align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2" class="link"><a href="logout.asp">Logout</a></font></td>
        </tr>

      </table>
    </td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
</table-->
 <!--#include virtual="includes/leftend.asp"-->
<!--#include virtual="includes/bottom.asp"-->
