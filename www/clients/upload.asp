
<%@ Language=VBScript %>
<%
	accessLevel = 5
%>
<!-- #include file="uploadclass.asp" -->
<!-- #INCLUDE FILE = "../inc/security.asp" -->
<!-- #INCLUDE FILE="../inc/db.asp" -->
<!-- #INCLUDE FILE="../inc/params.asp" -->
<!-- #INCLUDE FILE="../inc/functions.asp" -->
<%
' Create the FileUploader
Dim Uploader, File,ispublic
Set Uploader = New FileUploader

' This starts the upload process
Uploader.Upload()
resellername=session("resellername")
dim filedir : filedir=sCpHomeDir & "\www\logos\"


filepath = filedir
title = Uploader.form("title")

if(Uploader.form("ispublic")="1") then
	ispublic=1
else	
	ispublic=0
end if

FileToLoad = Uploader.form("logo")
'response.write FiletoLoad
skinname=Uploader.form("select")
id=session("reselid")

' Check if any files were uploaded

If Uploader.Files.Count = 0 Then
	'Response.Write "File(s) not uploaded."
Else
	' Loop through the uploaded files
 	For Each File In Uploader.Files.Items
		  dim fname
			filename=File.FileName
			if(Ucase(right(filename,3))="GIF" or Ucase(right(filename,4))="JPEG" or Ucase(right(filename,3))="JPG") then
				if(Ucase(right(filename,3))="GIF") then
					ext="gif"
				end if

				if(Ucase(right(filename,4))="JPEG") then
					ext="jpeg"
				end if

				if(Ucase(right(filename,3))="JPG") then
					ext="jpg"
				end if
			else
			%>
			<Script>
				alert("The file is not a valid logo file");
				history.go(-1);
			</Script>
			<%
			end if

			
			'response.write filepath
			File.SaveToDisk filepath & "tmp\"
			filepath2=filepath & resellername & "." & ext
			if(logFSO.FileExists (filepath2)) then
				logFSO.Deletefile(filepath2)
			end if
			if(logFSO.FileExists (filepath & "tmp\" & File.filename)) then 
				logFSO.MoveFile filepath & "tmp\" & File.filename , filepath2
			end if
			
	next

	query="update tblreseller set logo='" & resellername & "." & ext & "',skinname='" & skinname & "' where resellerid=" & id
	con.execute(query)
end if
%>

<Script>
	alert("<%=msgclientpref%>");
	window.location="../server/domains.asp";
</script>