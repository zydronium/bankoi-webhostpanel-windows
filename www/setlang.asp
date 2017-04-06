<%
	if(len(request("lang"))>0) then
		session("lang") = request("lang")
	end if
	response.redirect "login.asp"
%>