<%
	accessLevel = 5
%>
<!-- #INCLUDE FILE = "../inc/security.asp" -->
<!-- #INCLUDE FILE="../inc/db.asp" -->
<!-- #INCLUDE FILE="../inc/params.asp" -->
<!-- #INCLUDE FILE="../inc/functions.asp" -->
<html>
<head>
<title><%=lblClientPreferences%></title>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=ISO-8859-1">
<META HTTP-EQUIV="EXPIRES" CONTENT="0">
<link rel="stylesheet" type="text/css" href="/skins/default/css/general.css">
<link rel="stylesheet" type="text/css" href="/skins/default/css/custom.css">
<link rel="stylesheet" type="text/css" href="/skins/default/css/layout.css">
<script>
function chk_form_data(f)
{  
		f.action = "../clients/upload.asp";
		f.submit();
		return true;
	
}


</script>
</head>
<%
id=session("reselid")
'---------------------------------------------------------------------------------------------
  'Here we are extracting the name of the reseller according to the id stored in the session
  query="select contactname from tblcontactinfo where id='" & session("reselid") & "'"
  'response.write query
  dim rs
  set rs=server.createobject("ADODB.Recordset")
  rs.open query,con
  username=rs("contactname")
  'response.write "amit yadav" &session("reselid")
  '----------------------------------------------------------------------------------------------
 %> 
<body>
<!-- #include file="../inc/header.asp" -->
<form  method='post' enctype="multipart/form-data" name="mainform">
<!-- #include file="../clients/clientheader.asp" -->
      <table width="564" border="0" align="center" cellpadding=0 cellspacing=0>
        <tr > 
          <td colspan=2 height="19" valign="middle"><%=Client%> <font color="#CC0000" face="	vwerdana"><strong><%=" "&username&" "%></strong></font><%=lblPreference%></td>
          <td height="19" valign="middle"><div align="right"> 
<%	
    usertype=session("type")
	if(usertype="a") then
%>		  
              <input name="Button2" type="button" class="commonButton" id="Button" title="<%=lblup1level%>" onClick="window.location='/server/domains.asp';" value="<%=lbluplevel%>" >
<%else%>
			  <input name="Button2" type="button" class="commonButton" id="Button" title="<%=lblup1level%>" onClick="window.location='/domains/clientdomains.asp';" value="<%=lbluplevel%>" >
<%end if%>
            </div></td>
        </tr>
        <br>
        <br>
        <br>
      </table>
	  <table align="center">
        <tr> 
          <td height="20" align="center"> <div align="center"><img src="/skins/<%=session("skin")%>/elements/line.gif" width=560 height=1 border=0> 
            </div></td>
        </tr>
      </table>
      <table width="58%" border="0" align="center">
        <tr> 
          <td width="39%"><div align="center"><strong><%=lblUploadLogo%> </strong></div></td>
          <td width="61%"> <div align="left"> 
              <input type="file" name="logo">
            </div></td>
        </tr>
 <!--       <tr> 
          <td><div align="center"><strong>Support Link</strong></div></td>
          <td> <div align="left"> 
              <input name="supportlink" type="text" id="supportlink">
            </div></td>
        </tr>-->
        <tr> 
          <td><div align="center"><strong><%=Skins%></strong></div></td>
          <td> <div align="left">
<%
	query="select * from tblreseller where resellerid='" & id & "'"
	set rsresel=Server.CreateObject("ADODB.Recordset")
	rsresel.open query,con
	skinname=rsresel("skinname")
	set rsresel=Nothing
	
	'Here we are getting the name of all the available skins
	'--------------------------------------------------------
	Skins=Split(GetSkins(),",")
%>
              <select name="select">
<%
				for i=Lbound(Skins) to Ubound(Skins)	
%>
					<option value="<%=Skins(i)%>" <%if(Ucase(Skins(i))=(Ucase(skinname))) then response.write "Selected"%>><%=Ucase(Skins(i))%></option>
<%
				Next
%>
              </select>
<%  '--------------------------------------------------------
%>
            </div></td>
        </tr>
        <tr> 
          <td colspan="2"> <div align="center"><img src="/skins/<%=session("skin")%>/elements/line.gif" width=560 height=1 border=0> 
            </div></td>
        </tr>
        <tr> 
          <td colspan="2"><div align="center"> 
              <input name="Button22" type="button" class="commonButton" id="Button22" title="<%=lblOk%>" onClick="chk_form_data(document.mainform)" value="<%=lblOk%>" >

<%	
    usertype=session("type")
	'response.write "The type is " & usertype
	if(usertype="a") then
%>
              <input name="Button23" type="button" class="commonButton" id="Button23" title="<%=lblCancel%>" onClick="window.location='/server/domains.asp';" value="<%=lblCancel%>" >
<%else%>
			  <input name="Button23" type="submit" class="commonButton" id="Button23" title="<%=lblCancel%>" value="<%=lblCancel%>" >
<%end if%>
            </div></td>
        </tr>
      </table>
      <p>&nbsp;</p></form>
</body>
</html>
<!-- #INCLUDE FILE = "../inc/footer.asp" -->