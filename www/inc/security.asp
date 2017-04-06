<!-- #include file="lang.asp" -->
<%
if(len(session("userid")) <=0 ) then
	response.redirect("/logout.asp")
else
	if( (accessLevel > 5 ) ) then
		if (UCASE(Session("type")) <>"A" ) then 
			response.redirect("/logout.asp?noaccessa")
		end if
	elseif (accessLevel > 1 ) then 
			if (UCASE(Session("type"))="D" or UCASE(Session("type"))="M")  then 
				response.redirect("/logout.asp?noaccessb")	
			end if
	else
		if (accessLevel = 1 ) then 
			if (UCASE(Session("type"))="M")  then 
				response.redirect("/logout.asp?noaccessb")	
			end if
		end if
	end if
end if
%>