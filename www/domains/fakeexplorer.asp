<%@ Language=VBScript %>
<% 
'option explicit 
dim sRoot, sDir, sParent, objFSO, objFolder, objFile, objSubFolder, sSize ,dir
%> 
<!-- #INCLUDE FILE = "../inc/security.asp" -->
<!-- #INCLUDE FILE = "../inc/db.asp" -->
<!-- #INCLUDE FILE = "../inc/params.asp" -->
<html>
<head>
<title>Domain Information</title>

<link rel="stylesheet" type="text/css" href="/skins/default/css/general.css">
<link rel="stylesheet" type="text/css" href="/skins/default/css/custom.css">
<link rel="stylesheet" type="text/css" href="/skins/default/css/layout.css">
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=ISO-8859-1">
<META HTTP-EQUIV="EXPIRES" CONTENT="0">
</head>


<!-- #INCLUDE FILE = "../inc/header.asp" -->
<!--
----------------------------------------------------------------------------
The header of reseller prepared here
-->
<!-- #INCLUDE FILE = "../domains/domainheader.asp" -->
<!--
----------------------------------------------------------------------------
The header ends here
-->
<body>
<form  method="post" name="mainform" >
  <table width=370 border=0 cellpadding=0 cellspacing=0 align="center">
    <tr> 
      <td colspan="2"><p>Domain Of <font name="verdana" color="red"><strong><%=" "&ucase(session("resellername"))%></strong></font></p>
        <div align="right"></div>
        <div align="center"><img src="/skins/default/elements/line.gif" width=560 height=1 border=0></div>
        <p><img src="/skins/Standard_7/elements/white.gif" width="100%" height=1 alt="" border=0></p></td>
      <td colspan="3"><img src="/skins/Standard_7/elements/white.gif" alt="" width="8" height="8" border="0"></td>
    </tr>
    <tr> </tr>
    <META content="Microsoft Visual Studio 6.0" name=GENERATOR>
    <% 
' This is the root directory that the explorer will browse.  Make sure there is no backslash () 
' at the end.  Also make sure that show.asp has an identical sRoot variable. 
 
sRoot = "c:\webspace"


' Get the directory relative to the root directory 
sDir = Request("Dir") 

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
sParent = objFSO.GetParentFolderName(objFolder.Path) 

' Remove the contents of sRoot from the front.  This gives us the parent 
' path relative to the root folder 
' eg. if parent folder is "c:webfilessubfolder1subfolder2" then we just want "subfolder1subfolder2" 
sParent = mid(sParent, len(sRoot) + 1) 

Response.Write "<table border=""1"" bordercolor=""#FFFFFF"" cellborder=""1"" cellspacing=""0""align=""center"">" 

' Give a link to the parent folder.  This is just a link to this page only pssing in 
' the new folder as a parameter 

Response.Write "<font color=""#003366"" face=""Verdana"" size=""2""><tr><td colspan=3 bgcolor=""#E8AA8C""><a href=""explorer.asp?dir=" & Server.URLEncode(sParent) & """ style=text-decoration:none>Parent folder</a></td></tr></font>" & vbCRLF 

' Now we want to loop through the subfolders in this folder 
For Each objSubFolder In objFolder.SubFolders 
    ' And provide a link to them 
%><body text="#003366" link="#003366" vlink="#003366" alink="#003366">
    <tr> 
      <td colspan=3 >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="#003366" face="Verdana" size="2"> 
        <img src="folder.jpg" width="24" height="24"> 
        <%
    Response.Write "<a href=""explorer.asp?dir=" & Server.URLEncode(sDir & objSubFolder.Name) & """ style=text-decoration:none>" & objSubFolder.Name & "</a></td></tr></font>" & vbCRLF  
Next 

' Now we want to loop through the files in this folder 
For Each objFile In objFolder.Files 
    if Clng(objFile.Size) < 1024 then 
        sSize = objFile.Size & " bytes" 
    else 
        sSize = Clng(objFile.Size / 1024) & " KB" 
    end if 
    ' And provide a link to view them.  This is a link to show.asp passing in the directory and the file 
    ' as parameters 
%>
    <tr>
      <td colspan=3 bgcolor="#CCCCCC">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="#003366" face="Verdana" size="2"> 
        <%
    Response.Write "<a href=""show.asp?file=" & server.URLEncode(objFile.Name) & "&dir=" & server.URLEncode (sDir) & """ style=text-decoration:none>" & objFile.Name & "</a></td><td  bgcolor=""#CCCCCC"">" & sSize & "</td><td bgcolor=""#CCCCCC"">" & objFile.Type & "</td></tr></font>" & vbCRLF 
Next 

Response.Write "</table>" 
%>
    <tr>
      <td colspan=3><div align="center"><img src="/skins/default/elements/line.gif" width=560 height=1 border=0> 
        </div>
    </table>
  </form>
  </body>
  </html>
