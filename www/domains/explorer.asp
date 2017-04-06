
<%@ Language=VBScript %>
<%
	accessLevel = 1
%>
<% 
'option explicit 
dim sRoot, sDir, sParent, objFSO, objFolder, objFile, objSubFolder, sSize ,dir
%> 
<!-- #INCLUDE FILE = "../inc/params.asp" -->
<!-- #INCLUDE FILE = "../inc/security.asp" -->
<!-- #INCLUDE FILE = "../inc/db.asp" -->
<html>
<head>
<title><%=lbl612%></title>

<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/general.css">
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/custom.css">
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/layout.css">
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=ISO-8859-1">
<META HTTP-EQUIV="EXPIRES" CONTENT="0">

<script language="Javascript">
function submit_form(f)
{
 f.action='/domains/removedirpass.asp';
 f.submit();

}

	function validate(f)
	{
		if(f.folder.value=="")
			{
				alert("<%=lbl613%>");
				f.folder.focus();
				return false;
			}

		if(f.username.value=="")
			{
				alert("<%=lbl614%>");
				f.username.focus();
				return false;
			}
	}
</script>
   
</head>



<%
    id=session("id")

	usertype=session("type")
	if(usertype="d") then
	query = "select pwdprotectdir from tblrights where id='" & id & "'"
	'response.write query
	set Chk = Server.CreateObject("ADODb.Recordset")
	Chk.open query,con
	if(ucase(chk("pwdprotectdir")) = Ucase("n")) then
%>
		<script>
			alert("<%=msg112%>");
			window.location = "/domains/edit_domain.asp";
		</script>
<%
		response.end
	end if
	end if


	query="select username from(tbldomain inner join tblloginmaster on tbldomain.resellerid=tblloginmaster.id) where tbldomain.domainid='" & id & "'"
	set rsseller=server.createobject("ADODB.Recordset")
	rsseller.open query,con
	client=rsseller("username")
	'resellername=rsseller("username")
%>



<!-- #INCLUDE FILE = "../inc/header.asp" -->

<!------------------------------------------------------------------------------------------------>
<!--Here the menu for Client is created-->
<!-- #INCLUDE FILE = "../server/subheader.asp" -->

<!---------------------------------------------------------------------------

<!-- #INCLUDE FILE = "../domains/domainheader.asp" -->

<body>
<form  method="post" action="/domains/setpassword.asp" name="mainform" onSubmit="return validate(document.mainform)">
  <table width=370 border=0 cellpadding=0 cellspacing=0 align="center">
    <tr> 
      <td><%=lbl509%><font name="verdana" color="red"><strong><%=" "&ucase(session("contactname"))%></strong></font>
  </tr>
  <%
    

	query="select * from tbldirpass where id='" & id & "' order by dirname"
	'response.write query

	set rsname=server.createobject("ADODB.Recordset")
	rsname.open query,con
	
	if(not rsname.EOF) then
%>
  <table width="59%" border="0" align="center">
    <tr> 
    <th colspan="5"><div align="center"><strong><font color="#004080" size="2" face="Verdana"><%=lbl615%></font><font color="#FF0000" size="2" face="Verdana"><%=username%></font></strong></div></td>
  </tr>
	<tr>
      <td width="41%"><div align="right"><strong><%=lbl616%></strong></div></td>
      <td width="8%"><div align="center"></div></td>
      <td width="26%"><div align="left"><strong><%=lbl617%></strong></div></td>
      <td><div align="left"><strong><%=lblPass%></strong></div>
        <div align="center"></div></td>
      <td>&nbsp;</td>
    </tr>
<%
	dim count
	count=0
    while(not rsname.EOF)
	      query="select password from manageusers where domainid='" & id & "' and username='" & rsname("username") & "'"
	      'response.write query
          set rspass=server.createobject("ADODB.Recordset")
	      rspass.open query,con
%>
    <tr> 
      <td><div align="right"><font color="#004080"><%=rsname("dirname")%></font></div></td>
      <td><div align="center"></div>
        <div align="center"><font color="#FF0000">---</font></div></td>
      <td><div align="left"></div>
        <div align="left"><font color="#004080"><%=rsname("username")%></font></div></td>
      <td width="21%"><div align="left"></div>
        <div align="left"><font color="#004080"><%=rspass("password")%></font></div></td>
      <td width="4%"><div align="center"></div>
        <div align="left"> 
          <input type="checkbox" name="dirname" value="<%=rsname("dirname")%>">
        </div></td>
    </tr>
<%
    rsname.movenext
	count=count+1
    wend
	end if

	if(not count=0) then
%>
    
	<tr> 
      <td height="21" colspan="6" align="center"><div align="right"> 
          <input type="button" name="Button352" value="<%=lbl548%>" class="commonButton" onClick="return submit_form(document.mainform)">
        </div></td>
    </tr>
<%
	end if
%>
   
    <tr> 
      <th colspan="5" align="center"><font color="#003366"><strong><%=lbl618%></strong></font>
    </tr>

  </table>
<%
	query="select * from manageusers where type='F' and domainid='" & id & "' order by name"
	dim rsuser
	set rsuser=server.createobject("ADODB.Recordset")
	rsuser.open query,con
%>
<tr>&nbsp;</tr>
<%  if(rsuser.eof) then%>
		<td><div align="center"><font color="red" size="2" face="Verdana"> <div align="center"><strong><%=lbl619%><a href="/domains/manageusers.asp">Click here</a></strong> </td>
<%	else %>
<%
domainftp=session("ftpuser")

' This is the root directory that the explorer will browse.  Make sure there is no backslash () 
' at the end.  Also make sure that show.asp has an identical sRoot variable. 
 
sRoot = sHostingDir & "\" & client & "\" & domainftp & "\" & session("domain") & "\" & "www" 
'response.write sRoot

' Get the directory relative to the root directory 
sDir = Request("Dir") 

%>
<input type="hidden" name="DirPath" value="<%=sDir%>">
<%
' Add a backslash 
sDir = sDir & "\" 

'Response.Write "<h1>" & sDir & "</h1>" & vbCRLF 

' Create a copy of FileSystemObject 
Set objFSO = CreateObject("Scripting.FileSystemObject") 
on error resume next 
' Get a handle on the folder 
Set objFolder = objFSO.GetFolder(sRoot & sDir) 
if err.number <> 0 then 
    Response.Write "Could not open folder" 
    Response.End 
end if 
on error goto 0 


' We want a link to the parent folder also 
' Get the full path of the parent folder 
sParent = objFSO.GetParentFolderName(objFolder.path) 

' Remove the contents of sRoot from the front.  This gives us the parent 
' path relative to the root folder 
' eg. if parent folder is "c:webfilessubfolder1subfolder2" then we just want "subfolder1subfolder2" 
sParent = mid(sParent, len(sRoot) + 1) 

Response.Write "<table border=""1"" bordercolor=""#FFFFFF"" cellborder=""1"" cellspacing=""0""align=""center"">" 


' Give a link to the parent folder.  This is just a link to this page only pssing in 
' the new folder as a parameter 
Response.Write "<tr><td colspan=10><font color=""#003366"" face=""verdana"">" & lbl644 &"=  " & "\" & session("domain") & "\" & "www" & sDir & "</font></td></tr>"
%>
<table border="1"  align="center" width="420" cellspacing="0" cellpadding="0" bordercolor="#FFFFFF">
<%
Response.Write "<tr><td colspan=10 bgcolor=""#003366""><a href=""explorer.asp?dir=" & Server.URLEncode(sParent) & """ style=text-decoration:none><font color=""white"" face=""Verdana"" size=""2"">" & lbl645 & "</a></td></tr></font>" & vbCRLF 


' Now we want to loop through the subfolders in this folder 
For Each objSubFolder In objFolder.SubFolders 
    ' And provide a link to them 
	
%>
    <tr > 
      <td colspan=2 height="20" bgcolor="#EAFAFD" valign="bottom">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="#003366" face="Verdana" size="2"> 
        <img src="folder1.gif" width="20" height="14"> 
        <%
    Response.Write "<a href=""explorer.asp?dir=" & Server.URLEncode(sDir & objSubFolder.Name) & """ style=text-decoration:none>" & objSubFolder.Name & "</a></td></tr></font>" & vbCRLF  
Next 

Response.Write "</table>" 
Response.Write "</table>" 

arr = Split(sdir,"\")
%>
        </font>
    <tr> 
      <td><div align="center"></div>
      <td rowspan="5">&nbsp; 
    <tr> 
      <td ><div align="center"><font color="#003366" size="2" face="Verdana"><strong><%=lbl644%> &nbsp;&nbsp;&nbsp;&nbsp;</strong> 
          <input name="folder" type="text" id="folder" value="<%=arr(ubound(arr)-1)%>" readonly>
          </font></div>
    <tr>
      

		<td><div align="center"><font color="#003366" size="2" face="Verdana"> <div align="center"><strong><%=lbl617%></strong> </td>
		<td><select name="username" id="username" style='font-family: Verdana; color: #003366' Verdana > 

<%	while(not rsuser.eof)
%>
        </div>
        <option value="<%=rsuser("username")%>"><%=rsuser("name")%> [<%=rsuser("username")%>]</option> 
<%
	rsuser.movenext
	wend
%>
</select>

</tr>
      <tr> 
		<td> <div align="center"><img src="/skins/<%=session("skin")%>/elements/line.gif" width=560 height=1 border=0> </div> <tr> <td colspan=2><div align="center"> <input type="submit" name="Button35" value="<%=lbl620%>" class="commonButton"> </div> </tr>
<%	end if%>
 <tr> 
	
      <td colspan="2"><div align="center"> 
          &nbsp;
        </div></td>
    </tr>
</table>
<input type="hidden" name="path" value="<%="\" & session("domain") & "\" & "www" & sDir%>">

</form>
</table>
</body>
</html>
<!-- #INCLUDE FILE = "../inc/footer.asp" -->