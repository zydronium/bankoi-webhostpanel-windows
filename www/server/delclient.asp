<%
	accessLevel = 10
%>
<!-- #INCLUDE FILE = "../inc/security.asp" -->
<!-- #INCLUDE FILE="../inc/db.asp" -->
<!-- #INCLUDE FILE="../inc/params.asp" -->
<!-- #INCLUDE FILE="../inc/functions.asp" -->
<html>

<%
dim arr
dim count
dim userDir 
count=0
length=len(session("arrclientid"))
'response.write "The array is "& session("arrclientid")

'-------------------------------------
'Extracting the client id's
arr = split(session("arrclientid"),",")

dim rs1
set rs1=Server.createobject("ADODB.RecordSet")
dim rs
set rs=Server.createobject("ADODB.RecordSet")
  for i=0 to ubound(arr)
	query="select count(*) as flag from tbldomain where resellerid='" & trim(arr(i)) & "'"    

	rs.open query,con,3
    'If there are any domains under the selected client then we are not deleting them
	if(cint(rs("flag"))>0)then

	else 
	'Here we are deleting the selected clients from the database
		str="select username from tblloginmaster where id=" & trim(arr(i)) 
		
		rs1.open str,con	
		if(not rs1.eof) then
			userName = rs1("username")

			userDir = sHostingDir & "\" & userName
			rsult = DeleteFTPVirtualDirectory(userName)
			rsult = DeleteNTUser (userName, sComputerName)
			rsult = DeleteDir(userDir)
			'result=DeleteIISWebSite(trim(arr(i)),userName) 

			strcontact="delete from tblcontactinfo where id='" & trim(arr(i)) & "'"
			con.execute(strcontact)
		
			strreseller="delete from tblreseller where resellerid='" & trim(arr(i)) & "'"
			con.execute(strreseller)

			strloginmaster="delete from tblloginmaster where id='" & trim(arr(i)) & "'"
			con.execute(strloginmaster)

			strip="delete from tblresellerip where resellerid='" & trim(arr(i)) & "'"
			con.execute(strip)

			strip="delete from tblftpinfo where domainid='" & trim(arr(i)) & "'"
			con.execute(strip)

			query="delete from tblrights where id='" & trim(arr(i)) & "'"
			con.execute(query)
			query = "delete from tbldnstemplate where resellerid = '" & trim(arr(i)) & "'"
			con.execute(query)

			count=count+1
			
		end if
		rs1.close
    end if       'End of if block
	rs.close	
  next          'End of for loop
  set rs = nothing
  set rs1 = nothing
%>
<script>
  alert(<%=count%>+" <%=msgclientadded%>")
  window.location.replace("/clients/clients.asp");
</script>
</form>
</body>
</html>
<br>
<br>
<!-- #INCLUDE FILE = "../inc/footer.asp" -->

