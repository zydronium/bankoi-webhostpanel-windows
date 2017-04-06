<!-- #include file="inc/lang.asp" -->
<!-- #INCLUDE FILE="inc/db.asp" -->
<!-- #INCLUDE FILE="inc/params.asp" -->
<%
	loginname=request("loginname")
	email=request("email")
	
	query="select * from tblloginmaster where username='" & loginname & "'"
	set rs=Server.CreateObject("ADODB.Recordset")
	rs.open query,con

	if(rs.eof) then
%>
<SCRIPT>
	alert("Sorry there is no user with the name <%=loginname%>");
	window.location="get_password.asp";
</SCRIPT>

<%	else
	id=rs("id")
	pass=rs("password")
	query="select email from tblcontactinfo where id='" & id & "' and email='" & email & "'"
	set rs1=Server.CreateObject("ADODB.Recordset")
	rs1.open query,con

	if(rs1.eof) then
%>
<SCRIPT>
	alert("Sorry there is no user with the name <%=loginname%>");
	window.location="get_password.asp";
</SCRIPT>
<%
	else
	'send the mail to the user
	dim body
	body="<font face='verdana' size='2' color='blue'>Dear </font><font face='verdana' size='2' color='red'>" & loginname & ",</font><font face='verdana' size='2' color='blue'><br>" & "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Your username and password are:-<br><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>USERNAME=</b> </font><font face='verdana' size='2' color='red'>" & loginname & "</font><font face='verdana' size='2' color='blue'><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>Password=</b> </font><font face='verdana' size='2' color='red'>" & pass & "<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbspThankyou</font>"
	'response.write body

	set mymail = Server.CreateObject("CDONTS.Newmail")
				mymail.MailFormat = 0
				mymail.BodyFormat = 0
				mymail.to= rs1("email")
				mymail.from = mailfrom
				mymail.subject= "Your password"
				mymail.body =body
				mymail.send			
				set mymail = nothing
	end if
	
	end if
%>
<SCRIPT>
	alert("Your password is send to your mail address <%=email%>");
	window.location="login.asp";
</SCRIPT>