<%@ Language=VBScript %>
<%
	accessLevel = 1
%>
<% 
dim sRoot, sDir, sParent, objFSO, objFolder, objFile, objSubFolder, sSize ,dir
%> 
<!-- #INCLUDE FILE = "../inc/params.asp" -->
<!-- #INCLUDE FILE = "../inc/security.asp" -->
<!-- #INCLUDE FILE = "../inc/db.asp" -->
<html>
<head>
<title><%=lbl712%></title>
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/general.css">
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/custom.css">
<link rel="stylesheet" type="text/css" href="/skins/<%=session("skin")%>/css/layout.css">
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=ISO-8859-1">
<META HTTP-EQUIV="EXPIRES" CONTENT="0">

<script language="Javascript">
	function validate(f)
	{
		if(f.folder.value=="")
			{
				alert("<%=lbl613%>");
				f.folder.focus();
				return false;
			}
		return true;	
	}
</script>
   
</head>
<body>
<%
    id=session("id")
	query="select username from(tbldomain inner join tblloginmaster on tbldomain.resellerid=tblloginmaster.id) where tbldomain.domainid='" & id & "'"
	set rsseller=server.createobject("ADODB.Recordset")
	rsseller.open query,con
	client=rsseller("username")	
%>
<!-- #INCLUDE FILE = "../inc/header.asp" -->

<!------------------------------------------------------------------------------------------------>
<!--Here the menu for Client is created-->
<!-- #INCLUDE FILE = "../server/subheader.asp" -->

<!--------------------------------------------------------------------------->

<!-- #INCLUDE FILE = "../domains/domainheader.asp" -->
<form  method="post" action="/domains/setpermission.asp" name="mainform" onSubmit="return validate(document.mainform)">
  <table width=564 border=0 cellpadding=0 cellspacing=0 align="center">
    <tr> 
      <td><%=lbl509%><font name="verdana" color="red"><strong><%=" "&ucase(session("contactname"))%></strong></font>
  </tr>   
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
<%
domainftp=session("ftpuser")
' This is the root directory that the explorer will browse.  Make sure there is no backslash () 
' at the end.  Also make sure that show.asp has an identical sRoot variable.  
sRoot = sHostingDir & "\" & client & "\" & domainftp & "\" & session("domain") & "\" & "www" 
'response.write sRoot
' Get the directory relative to the root directory 
sDir = Request("Dir") 
' Add a backslash 
sDir = sDir & "\" 
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
sParent = objFSO.GetParentFolderName(objFolder.path) 
sParent = mid(sParent, len(sRoot) + 1) 
%>
<table border="0" bordercolor="#FFFFFF" cellborder="1" cellspacing="0" align="center">
<tr><td colspan=10><font color="#003366" face="verdana"><%=lbl644%>=  \<%=session("domain") & "\" & "www" & sDir %></font></td></tr>
<tr><td colspan=10>
<table border="0"  align="left" width="420" cellspacing="0" cellpadding="0" bordercolor="#FFFFFF">
<tr>
<td bgcolor="#003366"><a href="permexplorer.asp?dir=<%= Server.URLEncode(sParent) %>" style="text-decoration:none">
<font color="white" face="Verdana" size="2"><%=lbl645%></font></a></td>
</tr>
<%
' Now we want to loop through the subfolders in this folder 
For Each objSubFolder In objFolder.SubFolders 
    ' And provide a link to them 
%>
    <tr > 
      <td colspan=2 height="20" bgcolor="#EAFAFD" valign="bottom">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <img src="folder1.gif" width="20" height="14">        
    <a href="permexplorer.asp?dir=<%=Server.URLEncode(sDir & objSubFolder.Name) %>" style=text-decoration:none><%= objSubFolder.Name %></a></td></tr>
	<%
Next 
%>
</table>
<%
arr = Split(sdir,"\")
%>
    </td></tr>
		
    <tr> 
      <td colspan=2><div align="left"></div><td rowspan="5">&nbsp; 
    <tr> 
      <td ><div align="left"><font color="#003366" size="2" face="Verdana"><strong><%=lbl644%> &nbsp;&nbsp;&nbsp;&nbsp;</strong> 
          <input name="folder" type="text" id="folder" value="<%=arr(ubound(arr)-1)%>" readonly>
          </font></div>		 
	<tr> 	
      <td colspan="2">
          <%=lbl722%> <input type="checkbox" name="read" checked disabled>
        </div></td>
    </tr>
	<tr> 	
      <td colspan="2">
          <%=lbl723%> <input type="checkbox" name="write"  value="1">
        </div></td>
    </tr>
	 <tr> 
		<td> <div align="center"><img src="/skins/<%=session("skin")%>/elements/line.gif" width=560 height=1 border=0> </div> 
		</td></tr>
		
		<tr> <td colspan=2><div align="center"> <input type="submit" name="Button35" value="<%=lbl711%>" class="commonButton"> </div> </tr>
 <tr> 
      <td colspan="2"><div align="center"> 
          &nbsp;
        </div></td>
    </tr>
</table>
<input type="hidden" name="path" value="<%="\" & session("domain") & "\" & "www" & sDir%>">
</form>
</table>
<!-- #INCLUDE FILE = "../inc/footer.asp" -->
</body>
</html>