<%
accessLevel = 10
%>
<!-- #INCLUDE FILE = "../inc/security.asp" -->
<!-- #INCLUDE FILE="../inc/db.asp" -->
<!-- #INCLUDE FILE="../inc/functions.asp" -->

<head>
<title>
Add Ip Address
</title>
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/general.css">
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/custom.css">
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/layout.css">
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=ISO-8859-1">
<META HTTP-EQUIV="EXPIRES" CONTENT="0">
</head>

<body>
<!-- #include file="../inc/header.asp" -->
<!---------------------------------------------------------------------------------------------------------->
<!--Here the menu for Client is created-->
<!-- #INCLUDE FILE = "../server/subheader.asp" -->
<%
		recordType  = request("recordType")
%>
<body topmargin="0">

<form name="mainform" action="addnewdnstemplate.asp" method="post">

  
  <table width="60%" border="0" align="center">
    <tr> 
      <td height="29" colspan="2"><hr></td>
    </tr>
<%
	'------------------------------------------------------------------------------------------------------------
	 if(recordType="A") then
	 	response.Write "<tr><td align='center' class='clientheading'>" & lbl737 & "</td></tr></center>"
%>
		<tr> 
		  <td><br><div align="center" class="headings">
			  <input type="text" name="typeof" value="" class="textboxclass">
			  &middot;&lt;domain&gt;&middot; A <input type="text" name="ipaddr"  class="textboxclass">  <font color="#000066">*</font> </div><br> 
			</div></td>
		</tr>
<% 
	end if
  '-------------------------------------------------------------------------------------------------------------------------------------
  if(recordType="PTR") then
  		response.Write "<tr><td align='center' class='clientheading'>Add DNS entry for recordtype 'PTR' </td></tr></center>"
%>
		<tr>
			<td align="center" class="headings">
				&lt;IP&gt;/
			  <select name="subnet" id="select">
				<option value="8">8</option>
				<option value="16">16</option>
				<option value="24">24</option>
				<option value="32">32</option>
			  </select>PTR&lt;domain&gt;
			  </td>
		<tr>
<%  
end if
 '------------------------------------------------------------------------------------------------------------
  if(recordType="NS") then
	  response.Write "<tr><td align='center' class='clientheading'>Add NS entry for recordtype 'NS' </td></tr></center>"
%>
			<tr> 
   				 <td align="center" class="headings">
					&lt;domain&gt;.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;NS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="ns" value="" class="textboxclass">
        . 
        <select name="dmnname" id="dmnname"  class="headings">
          <option value="domain">&lt;Domain&gt;</option>
		  <option value=""></option>
        </select>
        . </td>
			</tr>
<%
end if
'------------------------------------------------------------------------------------------------------------
	if(recordType="MX") then
		response.Write "<tr><td align='center' class='clientheading'>" & lbl741 & "</td></tr></center>"
%>
			<tr> 
			    <td align="center" class="headings"><%=lbl742%>
				    <select name="mx">
						<option value="5">5</option>
						<option value="10">10</option>
						<option value="15">15</option>
						<option value="20">20</option>
						<option value="25">25</option>
						<option value="30">30</option>
						<option value="35">35</option>
						<option value="40">40</option>
						<option value="45">45</option>
						<option value="50">50</option>
						<option value="60">60</option>
						<option value="70">70</option>
						<option value="80">80</option>
						<option value="90">90</option>
						<option value="100">100</option>
					</select>&nbsp;&nbsp;
        <input type="text" name="exchangeval"  class="textboxclass"> 
				</td>
			</tr>
<% 
end if
'------------------------------------------------------------------------------------------------------------ 
  if(recordType="CNAME")  then
	  response.Write "<tr><td align='center' class='clientheading'>" & lbl743 & "</td></tr></center>"
%>
    <tr> 
      <td align="center" class="headings"><input type="text" name="cnametype" value="" class="textboxclass">.&lt;domain&gt;.&nbsp;&nbsp;CNAME&nbsp;&nbsp; 
			<input type="text" name="cnameval"  class="textboxclass"></td>
    </tr>
<%
   end if  
%>	


    <tr> 
      <td colspan="2"><div align="right" class="headings">
          <input type="submit" class="commonbutton" name="Add" value="<%=lbl739%>" title="<%=lbl739%>">
          <input type="button" class="commonbutton" name="Add2" value="<%=lbl740%>" Title="<%=lbl740%>" onClick="window.location='/clients/clientDnsTemplate.asp'">
        </div></td>
    </tr>
<%
		if(recordType="A") then
%>
<tr><td align="center"><font face="verdana" size="1" color="Blue">* </font><font face="verdana" size="1" color="red"><%=lbl738%></font></td></tr></center>		<tr>
<%
		end if
%>
    <tr> 
      <td colspan="2"><hr></td>
    </tr>
  </table>
<input type="hidden" name="recordtype" value="<%=recordType%>">
</form>
<br>
<!-- #INCLUDE FILE = "../inc/footer.asp" -->