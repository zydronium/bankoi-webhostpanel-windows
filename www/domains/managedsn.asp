<%@ Language=VBScript %>
<%
	accessLevel = 1
%>
<!-- #INCLUDE FILE = "../inc/params.asp" -->
<!-- #INCLUDE FILE = "../inc/security.asp" -->
<!-- #INCLUDE FILE = "../inc/db.asp" -->
<html>
<head>
<title><%=lbl581%></title>

<link rel="stylesheet" type="text/css" href="/skins/default/css/general.css">
<link rel="stylesheet" type="text/css" href="/skins/default/css/custom.css">
<link rel="stylesheet" type="text/css" href="/skins/default/css/layout.css">
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=ISO-8859-1">
<META HTTP-EQUIV="EXPIRES" CONTENT="0">

<script>
function submit_form(f)
{
//alert("Submit form called");
f.action='/domains/removedsn.asp';
f.submit();
return true;
}

function chk_db_name(db)
{
	re = /^[a-zA-Z]{1}[A-Za-z0-9-_]{0,31}$/;
	return db.search(re) != -1;
}

function validate(f)
{
    
	if(f.dsn.value=="")
	   {
			alert("<%=msg49%>");
			f.dsn.focus();
			return false;
	   }
	if(f.databasename.value=="")
	   {
			alert("<%=msg50%>");
			f.databasename.focus();
			return false;
	   }

	/*if(f.servername.value=="")
	   {
			alert("Server name can not be blank");
			f.servername.focus();
			return false;
	   }  */


	 if(f.username.value=="")
	   {
			alert("<%=msg51%>");
			f.username.focus();
			return false;
	   }  
	if(f.password.value=="")
	   {
			alert("<%=msg48%>");
			f.password.focus();
			return false;
	   }

	return true
}
</script>

</head>
<%
    id=session("id")
	query="select username from(tbldomain inner join tblloginmaster on tbldomain.resellerid=tblloginmaster.id) where tbldomain.domainid='" & id & "'"
	set rsseller=server.createobject("ADODB.Recordset")
	rsseller.open query,con
	client=rsseller("username")
	'---------------------------------------------------------------------------------------------
	dbtype=request("database")
	'response.write "the db type is " & dbtype
    '---------------------------------------------------------------------------------------------
	'Here we are extracting the name of the reseller according to the id stored in the session
	query="select contactname from tblcontactinfo where id='" & id & "'"
	'response.write query
	set rs=server.createobject("ADODB.Recordset")
	rs.open query,con
	username=rs("contactname")
	rs.close
	'---------------------------------------------------------------------------------------------
%>

<!-- #INCLUDE FILE = "../inc/header.asp" -->

<!------------------------------------------------------------------------------------------------>
<!--Here the menu for Client is created-->
<!-- #INCLUDE FILE = "../server/subheader.asp" -->

<!---------------------------------------------------------------------------

<!-- #INCLUDE FILE = "../domains/domainheader.asp" -->

<body>
<form action="/domains/managedsn1.asp" method="post" name="mainform" onSubmit="return validate(document.mainform)">
  <table width=562 border=0 cellpadding=0 cellspacing=0 align="center" height="1">
    <tr> 
      <td colspan="3" height="33"><%=lbl509%> <font name="verdana" color="red"><strong><%=" "&ucase(session("contactname"))%></strong></font><img src="/skins/Standard_7/elements/white.gif" width="100%" height=1 alt="" border=0><img src="/skins/Standard_7/elements/white.gif" alt="" width="8" height="8" border="0"></td>
    </tr>
<%
	query="select dsnname,databasename,username,password,dbtype from tbldsn where id='" & id & "' order by dsnname"
	dim rsdsn
	set rsdsn=server.createobject("ADODB.Recordset")
	rsdsn.open query,con
	if(not rsdsn.EOF) then
%>
    <tr> 
      <th colspan="10" height="20"><font color="#003366"></font> <font color="#003366"><strong>DSN 
        List</strong></font></tr>

	<tr> 
      <td width=22 height="1" align="center"></td>
      <td width=122 align="center" height="1"><div align="left"><strong><%=lbl641%></strong></div></td>
      <td width=128 height="1"  align="center"><div align="center">
          <p align="center"><strong><%=lbl501%></strong></div></td>
      <td width=6  align="center" height="1">&nbsp;</td>
      <td width=121 height="1"  align="center"><div align="left"><strong><%=lbl617%></strong></div></td>
      <td width=107  align="center" height="1"><div align="left"><strong><%=lblPass%></strong></div></td>
      <td width=56 height="1" colspan="5"  align="center"><div align="left" style="width: 52; height: 19"></div>
      </td>
    </tr>
	 
    <%
    while(not rsdsn.EOF)
%>
    <tr> 
      <td height=1 align="center" width="22" valign="top"><div align="center"><font color="#FF0000"><img src="button_icon_add.gif" width=13 height="12"></font></div></td>
      <td height=1  align="center" width="122" valign="top"><div align="left"><font 	color="#FF0000"><%=ucase(rsdsn("dsnname"))%></font></div>
	  </td>
      <td height=1  align="center" width="128" valign="top"><font color="#FF0000">
        <p align="center"><%=rsdsn("databasename")%></font>
	  </td>
      <td width=6 height="1" align="center" valign="top"><div align="left"></div>
	  </td>
      <td align="center" width="121" height="1" valign="top"><div align="left"><font color="#FF0000"><%=rsdsn("username")%></font></div>
	  </td>
      <td align="center" width="107" height="1" valign="top"><div align="left"><font color="#FF0000"><%=rsdsn("password")%> 
      </font></div></td>
      <td colspan=4 align="center" width="56" height="1"><div align="left"><font color="#004080"> 
          <input type="checkbox" name="dsn" value="<%=rsdsn("dsnname") & "--->" & rsdsn("databasename")%>">
          </font></div>
      </td>
    </tr>
    <%
    rsdsn.movenext
    wend
%>
    <tr> 
      <td height="27" colspan="9" align="center"><div align="right"> 
          <input type="button" name="Button352" value="<%=lbl548%>" class="commonButton" onClick="return submit_form(document.mainform)">
        </div></td>
    </tr>
    <%
	end if
%>
 
  </table>
  
<table width=531  height= "1" border=0 cellpadding=0 cellspacing=0 align="center">
  <tr> 
    <th height="21" colspan="3" align="center"><strong><font color="#FF0000" size="2" face="Verdana"><%=lbl642%></font></strong></td>
  </tr>
  <tr>
  <td colspan="7">
<%

'--------------------------------------------EXPLORER MADE HERE--------------------------------------------------- 
'option explicit 
dim sRoot, sDir, sParent, objFSO, objFolder, objFile, objSubFolder, sSize ,dir
%> 


<%
if(ucase(dbtype)=ucase("Access")) then
'-----------------------------------------------------------------------------------------------
'Here we are getting the name of the domainftp and domain name 
query="select ftpusername from tblftpinfo where domainid='" & session("id") & "' and type='D'"
set rs = Server.createobject("ADODB.RecordSet")
rs.open query,con
domainftp=rs("ftpusername")
rs.close


' This is the root directory that the explorer will browse.  Make sure there is no backslash () 
' at the end.  Also make sure that show.asp has an identical sRoot variable. 
 
sRoot = sHostingDir & "\" & client & "\" & domainftp & "\" & session("domain")
sPath=sHostingDir & "\" & client & "\" & domainftp
%>
<input type="hidden" value="<%=sPath%>" name="path">
<%
'response.write sRoot

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
    Response.Write lbl643
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
Response.Write "<tr><td colspan=10><font color=""#003366"" face=""verdana"">" & lbl644 &"=  " & "\" &  session("domain") &  sDir 
%>
    <table border="1"  align="center" width="300" cellspacing="0" cellpadding="0" bordercolor="#FFFFFF">
      <%
Response.Write "<tr><td colspan=10 bgcolor=""#003366""><a href=""managedsn.asp?database=" & dbtype & "&dir=" & Server.URLEncode(sParent) & """ style=text-decoration:none><font color=""white"" face=""Verdana"" size=""2"">" & lbl645 & " </a></td></tr></font>" & vbCRLF 


' Now we want to loop through the subfolders in this folder 
For Each objSubFolder In objFolder.SubFolders 
    ' And provide a link to them 
	
%>
      <tr > 
      <td colspan=2 height="20" bgcolor="#EAFAFD" valign="bottom">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="#003366" face="Verdana" size="2"> 
        <img src="folder1.gif" width="20" height="14">  
          <%
    Response.Write "<a href=""managedsn.asp?database=" & dbtype & "&dir=" & Server.URLEncode(sDir & objSubFolder.Name) & """ style=text-decoration:none>" & objSubFolder.Name & "</a></td></tr></font>" & vbCRLF  
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
	 if(ucase(right(objFile.Name,3))="MDB") then
%>
    <tr>
      <td colspan=3 bgcolor="#CCCCCC" align="center">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="#003366" face="Verdana" size="2"> 
 <%
   
    Response.Write "<font" & server.URLEncode(objFile.Name) & "&dir=" & server.URLEncode (sDir) & """ style=text-decoration:none>" & objFile.Name & "</a></td><td  bgcolor=""#CCCCCC"">" & sSize & "</td><td bgcolor=""#CCCCCC"">" & objFile.Type & "</td></tr></font>" & vbCRLF 
	else
	end if
Next
Response.Write "</table>" 
Response.Write "</table>" 
arr = Split(sdir,"\")
end if
'-----------------------------------------------------------------------------------------------------------------
%>

  <tr> 
    <td width="240" height="24"><div align="right"><font size="2" face="Verdana"><strong><%=lbl641%> </strong></font></div></td>    <td width="18" colspan="-3"><div align="left"><font size="2" face="Verdana"></font></div></td>
    <td width="302" colspan="-2"> <div align="left"> 
        <input name="dsn" type="text">
      </div></td>
    <td width="1">&nbsp;</td>
    <td width="1">&nbsp;</td>
  </tr>
  <tr> 
    <td height="22"><div align="right"><font size="2" face="Verdana"><strong><%=lbl501%> </strong></font></div></td>
    <td width="18" colspan="-3"><div align="left"><font size="2" face="Verdana"></font></div></td>
    <td> <div align="left"> 
<%
	if(ucase(dbtype)=ucase("Access")) then
%>
        <input name="databasename" type="text" value="<%="\" &  session("domain") &  sDir%>">
<%
	else
%>
       <input name="databasename" type="text" value="">
<%
	end if
%>

      </div></td>
  </tr>
<%
	if(not ucase(dbtype)=ucase("Access")) then
%>
  <tr> 
    <td height="26"><div align="right"><font size="2" face="Verdana"><strong><%=lbl646%></strong></font></div></td>
    <td colspan="-3"><div align="left"></div></td>
    <td> <div align="left"><input type="text" name="servername"></div></td>
  </tr>
 <%
	else
%>
      
<%
	end if
%>
  <tr> 
  <tr> 
    <td height="26"><div align="right"><font size="2" face="Verdana"><strong><%=lbl617%></strong></font></div></td>
    <td colspan="-3"><div align="left"></div></td>
    <td> <div align="left"><input type="text" name="username"></div></td>
  </tr>
  <tr> 
    <td height="26"><div align="right"><font size="2" face="Verdana"><strong><%=lblPass%></strong></font></div></td>
    <td colspan="-3"><div align="left"></div></td>
    <td> <div align="left"><input type="password" name="password"></div></td>
  </tr>
  <tr> 
    <td colspan="3"><div align="left"><img src="/skins/default/elements/line.gif" width=560 height=1 border=0> 
      </div></td>
  </tr>
  <tr> 
    <td colspan="3"> <div align="center"> 
        <input type="submit" name="Button35" value="Create DSN" class="commonButton">
      
        <input type="button" name="Button36" value="<%=lbl512%>" onClick="window.location='/domains/databasetype.asp'" class="commonButton">
      </div></td>
  </tr> <tr> 
	
      <td colspan="2"><div align="center"> 
          &nbsp;
        </div></td>
    </tr>
</table>
<input type="hidden" name="dbtype" value="<%=dbtype%>">
</form>
</body>
 <!-- #INCLUDE FILE = "../inc/footer.asp" -->