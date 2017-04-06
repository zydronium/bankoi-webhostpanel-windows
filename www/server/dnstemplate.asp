<%
accessLevel = 10
%>
<!-- #INCLUDE FILE = "../inc/security.asp" -->
<!-- #INCLUDE FILE="../inc/db.asp" -->
<!-- #INCLUDE FILE="../inc/functions.asp" -->

<head>
<title>
Manage DNS Template
</title>
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/general.css">
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/custom.css">
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/layout.css">
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=ISO-8859-1">
<META HTTP-EQUIV="EXPIRES" CONTENT="0">
</head>
<script language="JavaScript">

			function invertChecked()
			{
				f = document.mainform;
				for (i = 0 ; i < f.elements.length; i++) {
					if ((f.elements[i].type == "checkbox") && (f.elements[i].name == "chkEntries")) {
						if (f.elements[i].checked || (f.elements[i].value == "DISABLED") || f.elements[i].disabled) {
							f.elements[i].checked = false;
						} else {
							f.elements[i].checked = true;
						}
					}
				}
			}


function chk_form_data(f)
			{
				var counter;
				counter=0;
				for (i = 0 ; i < f.elements.length; i++) 
					{
					if ((f.elements[i].type == "checkbox") && (f.elements[i].name.indexOf("chkEntries")==0)) 
						{
						if (f.elements[i].checked) 
							{
								counter=counter+1;
							}
						}
					}
				if(counter==0)
				{
					alert("<%=msg113%>");
					return false;
				}
				else
				{
					f.submit();
					return false;
				}
				
			}


</script>
<body>
<!-- #include file="../inc/header.asp" -->
  
<p align="center"><font color="#333333" size="2" face="Verdana, Trebuchet MS"><%=lbl744%></font></p>

<table width="60%" align="center">
  <tr>
    <td><hr></td>
  </tr>
  <tr>
    <td class="clientheading"><form name="form1" action="modifyDnsTemplate.asp" method="post">
        <p> 
        <div class="clientheading"><font color="#666666"><strong><font size="2" face="Verdana, Trebuchet MS"><%=lbl732%></font></strong></font></div>
        </p>
        <table width="86%" border="0" align="center">
          <tr> 
            <td width="43%"><div align="right" class="headings"><font color="#666666" size="2" face="Verdana, Trebuchet MS"><%=lbl733%></font>&nbsp; </div></td>
            <td width="9%">&nbsp;</td>
            <td width="48%"><select name="recordType" id="select"  style="font-family: Verdana; color: #FF0000; font-size: 8pt">
                <!--<option value="NS">NS</option>-->
                <option value="A">A</option>
                <option value="MX">MX</option>
                <option value="CNAME">CNAME</option>
              </select></td>
          </tr>
        </table>
        <p align="right"> 
          <input type="submit" class="commonbutton" name="Submit" value="<%=lbl734%>" title="<%=lbl734%>">
        </p>
        </form>
</table>
<hr width="60%">





<form name="mainform" method="POST" action = "deleteDNSTemplate.asp"  onSubmit="return chk_form_data(mainform)">
<table align="center" width="60%">
<tr bgcolor="#FFFFFF"> 
            <td colspan="4"> <p align="right"> 
                <input name="remove" class="commonbutton" type="submit" id="remove" value="<%=lblRemoveSelected%>" title="<%=lblRemoveSelected%>">
                <font color="#003366" face="Verdana"><strong><font size="2"> </font></strong></font></p></td>
          </tr>

<tr bgcolor="#006699"> 
      <td width="31%"><div align="center" class="headings"><strong><font color="#FFFFFF" size="2" face="Verdana, Trebuchet MS"><%=lbl735%> 
          </font></strong></div></td>
      <td width="34%"><div align="center" class="headings"><strong><font color="#FFFFFF" size="2" face="Verdana, Trebuchet MS"><%=lbl733%></font></strong></div></td>
      <td width="25%"><div align="center" class="headings"><strong><font color="#FFFFFF" size="2" face="Verdana, Trebuchet MS"><%=lbl736%></font></strong></div></td>
      <td width="10%"><div align="center"  class="headings"> <strong><font color="#FFFFFF" size="2" face="Verdana, Trebuchet MS"><a href="javascript:invertChecked()" style="text-decoration:none; color=#FFFFFF;"><%=lbl550%> 
        </div></td>
    </tr>
<%
	set rsDNS = server.CreateObject("ADODB.RecordSet")
	query = "select * from tbldnstemplate where resellerid ='0' order by recordtype"
	rsDNS.open query,con

	if(rsDNS.eof) then
			Response.Write "No DNS Template to show!!!"
	else
			while(not rsDNS.eof)
						host = replace(rsDNS("host"),"<", "&lt;")
						host = replace(host,">", "&gt;")
						recordType = rsDNS("recordtype")
						recordValue = replace(rsDNS("value"),"<", "&lt;")
						recordValue = replace(recordValue,">", "&gt;")
						MXpref = rsDNS("mxpref")
						if(MXpref > 0) then
							recordType = recordType & "         " & MXpref
						end if
					Response.Write "<tr bgcolor='#EBEDF5'><font color='#006699' size='2' face='Verdana, Trebuchet MS'><td><p align='center'>" & host & "</p></td><td><p align='center'>" & recordType & "</p></td><td><p align='center'>" & recordValue & "</p></td><td><p align='center'><input type='checkbox' name='chkEntries' value='" & rsDNS("id") &"'></p></font></td></tr>"
					rsDNS.movenext
			wend
	end if
%>
<tr><td colspan="4" align="right"><input type="button" name="test1" value="<%=lblback%>" onClick="window.location='/server/server.asp'" class="commonbutton" title="<%=lblback%>"></td></tr>
</table>
</form>
<body>
</html>
<br>
<!-- #INCLUDE FILE = "../inc/footer.asp" -->