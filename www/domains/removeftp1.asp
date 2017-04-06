<%
	accessLevel = 1
%>
<!-- #INCLUDE FILE = "../inc/security.asp" -->
<!-- #INCLUDE FILE = "../inc/db.asp" -->
<!-- #INCLUDE FILE = "../inc/params.asp" -->
<!-- #INCLUDE FILE = "../inc/functions.asp" -->
<%
dim ftp,count
count=0
ftp=split(request("ftp"),",")
for i=lbound(ftp) to ubound(ftp)
	'-----------------------------------------------------------------------------------
	dim clientName
	ftpuser=session("ftpuser")
	clientName=session("resellername")	
	
	'The virtual directory is created on the name of the FTP user
	result=DeleteFTPVirtualDirectory(trim(ftp(i)))

	'Deleting the email av\ccounts from the table tblemail
	query="delete from tblftpinfo where ftpusername='" & trim(ftp(i)) & "'"
	con.execute(query)

	'----------------------------------------------------------------------------------------------------------
	'Updating the status of the user in the manageuser table so that the user is visible
	query="update manageusers set type='F' where username='" & trim(ftp(i)) & "'"
	con.execute(query)
	count=count+1
next 
%>
<script>
	alert("Total <%=count & msg65%>")
	window.location="/domains/ftpusers.asp"
</script>